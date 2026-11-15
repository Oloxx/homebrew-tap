// Pone Formula/drop.rb en la ultima release de Oloxx/drop.
//
// Solo se fia de un SHA256SUMS con firma minisign valida con la clave del
// proyecto: la misma que comprueba `drop update` y la que publica el README.
// Sin esa comprobacion, quien pudiera tocar la release (o responder por
// api.github.com) metia su binario en el `brew install` de todo el mundo.
//
//   node scripts/update.mjs              # ultima release
//   node scripts/update.mjs v0.9.0       # una concreta
//
// Necesita `minisign` en el PATH. Escribe la version en .version para el
// mensaje del commit.
import { execFileSync } from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';

const REPO = 'Oloxx/drop';
const PUBLIC_KEY = 'RWQqNnfqvCrj+eavJ9njz2vCoHaC8YnLqjsvNBMndz3hBroQLpou7+Kp';
const FORMULA = 'Formula/drop.rb';

const headers = { 'User-Agent': 'drop-homebrew-tap', Accept: 'application/vnd.github+json' };
if (process.env.GITHUB_TOKEN) headers.Authorization = `Bearer ${process.env.GITHUB_TOKEN}`;

const wanted = process.argv[2];
const url = wanted
  ? `https://api.github.com/repos/${REPO}/releases/tags/${wanted}`
  : `https://api.github.com/repos/${REPO}/releases/latest`;
const res = await fetch(url, { headers });
if (!res.ok) throw new Error(`GitHub responde ${res.status} a ${url}`);
const release = await res.json();
const tag = release.tag_name;
const version = tag.replace(/^v/, '');

// Si no se pidio un tag concreto y la formula ya apunta a esta version, salimos
// antes de bajar SHA256SUMS/.minisig para no inflar el download_count en GitHub.
const before = fs.existsSync(FORMULA) ? fs.readFileSync(FORMULA, 'utf8') : '';
const currentVersion = before.match(/^\s*version\s+"([^"]+)"/m)?.[1];
if (!wanted && currentVersion === version) {
  console.log(`Sin cambios: drop ${version}`);
  process.exit(0);
}

async function download(name, dest) {
  const asset = release.assets.find((a) => a.name === name);
  if (!asset) throw new Error(`La release ${tag} no trae ${name}`);
  const r = await fetch(asset.browser_download_url, { headers: { 'User-Agent': headers['User-Agent'] } });
  if (!r.ok) throw new Error(`HTTP ${r.status} al bajar ${name}`);
  fs.writeFileSync(dest, Buffer.from(await r.arrayBuffer()));
}

const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'drop-tap-'));
const sums = path.join(tmp, 'SHA256SUMS');
await download('SHA256SUMS', sums);
await download('SHA256SUMS.minisig', sums + '.minisig');
// Lanza (y el workflow falla) si la firma no es de la clave del proyecto.
// `MINISIGN` cambia el verificador (otro binario, o `node algo.mjs`); por
// defecto el `minisign` del PATH, que es lo que instala el workflow.
const [cmd, ...pre] = (process.env.MINISIGN || 'minisign').split(' ');
execFileSync(cmd, [...pre, '-V', '-m', sums, '-x', sums + '.minisig', '-P', PUBLIC_KEY], { stdio: 'inherit' });

const hashes = new Map();
for (const line of fs.readFileSync(sums, 'utf8').split('\n')) {
  const m = line.trim().match(/^([0-9a-f]{64})\s+\*?(\S+)$/i);
  if (m) hashes.set(m[2], m[1].toLowerCase());
}
const target = (suffix) => {
  const name = `drop-${tag}-${suffix}.tar.gz`;
  const sha = hashes.get(name);
  if (!sha) throw new Error(`El SHA256SUMS firmado no menciona ${name}`);
  return { url: `https://github.com/${REPO}/releases/download/${tag}/${name}`, sha };
};
const t = {
  macArm: target('macos-arm64'),
  linuxArm: target('linux-arm64'),
  linuxIntel: target('linux-x64'),
};

const formula = `# Generado por scripts/update.mjs a partir del SHA256SUMS firmado de ${tag}.
# No lo edites a mano: el siguiente update lo pisa.
class Drop < Formula
  desc "Peer-to-peer file transfer, end-to-end encrypted, with a code you can say aloud"
  homepage "https://drop.oloxx.dev"
  version "${version}"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "${t.macArm.url}"
      sha256 "${t.macArm.sha}"
    end
  end

  on_linux do
    on_arm do
      url "${t.linuxArm.url}"
      sha256 "${t.linuxArm.sha}"
    end
    on_intel do
      url "${t.linuxIntel.url}"
      sha256 "${t.linuxIntel.sha}"
    end
  end

  def install
    # El tarball trae un solo ejecutable, drop-vX.Y.Z-<sistema>-<arquitectura>.
    bin.install Dir["drop-v*"].first => "drop"
  end

  test do
    assert_match "drop v#{version}", shell_output("#{bin}/drop --version")
  end
end
`;

fs.writeFileSync(FORMULA, formula);
fs.writeFileSync('.version', version + '\n');
console.log(before === formula ? `Sin cambios: drop ${version}` : `Formula/drop.rb -> drop ${version}`);
