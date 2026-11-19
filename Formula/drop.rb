# Generado por scripts/update.mjs a partir del SHA256SUMS firmado de v0.14.1.
# No lo edites a mano: el siguiente update lo pisa.
class Drop < Formula
  desc "Peer-to-peer file transfer, end-to-end encrypted, with a code you can say aloud"
  homepage "https://drop.oloxx.dev"
  version "0.14.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.14.1/drop-v0.14.1-macos-arm64.tar.gz"
      sha256 "49117ce9aa07a7adeed5f76a4fab096e400e7bdff1876b408f979a0119682165"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.14.1/drop-v0.14.1-linux-arm64.tar.gz"
      sha256 "cc6d407065acf79914fa384bfd7d606df3ef692a77a28285e8bc934cda3c8cde"
    end
    on_intel do
      url "https://github.com/Oloxx/drop/releases/download/v0.14.1/drop-v0.14.1-linux-x64.tar.gz"
      sha256 "7036394e79baf6ce294fee5e523dfbfa447911318d5e74517c149656c03224d4"
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
