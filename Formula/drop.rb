# Generado por scripts/update.mjs a partir del SHA256SUMS firmado de v0.11.0.
# No lo edites a mano: el siguiente update lo pisa.
class Drop < Formula
  desc "Peer-to-peer file transfer, end-to-end encrypted, with a code you can say aloud"
  homepage "https://drop.oloxx.dev"
  version "0.11.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.11.0/drop-v0.11.0-macos-arm64.tar.gz"
      sha256 "460eaae148bc3e734209fc518a220e77689733235a1a3f6cbe435f91d0f51acd"
    end
    on_intel do
      url "https://github.com/Oloxx/drop/releases/download/v0.11.0/drop-v0.11.0-macos-x64.tar.gz"
      sha256 "ddfbf8accbc8b6c1cd8963160f07ff96823cf988947c62890967c3adb440ea00"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.11.0/drop-v0.11.0-linux-arm64.tar.gz"
      sha256 "e4f51e16dbff2959e3cb706f1b768090ef412649d7eefa73a071141b3058fbce"
    end
    on_intel do
      url "https://github.com/Oloxx/drop/releases/download/v0.11.0/drop-v0.11.0-linux-x64.tar.gz"
      sha256 "98b65e0138b6b962c15a6abd92f5a99dfe97fd7abdc2a8ca2f1401448bf50c28"
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
