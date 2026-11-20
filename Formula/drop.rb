# Generado por scripts/update.mjs a partir del SHA256SUMS firmado de v0.15.0.
# No lo edites a mano: el siguiente update lo pisa.
class Drop < Formula
  desc "Peer-to-peer file transfer, end-to-end encrypted, with a code you can say aloud"
  homepage "https://drop.oloxx.dev"
  version "0.15.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.15.0/drop-v0.15.0-macos-arm64.tar.gz"
      sha256 "36510ec7bbdff7a6cb8c49c7b6fb5afb71bc68cf0ac2b9e3c854810f41a0418b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.15.0/drop-v0.15.0-linux-arm64.tar.gz"
      sha256 "251350288b10cb4281a27a038beee00ce96ff0342f1211f4ab2b07c82077c203"
    end
    on_intel do
      url "https://github.com/Oloxx/drop/releases/download/v0.15.0/drop-v0.15.0-linux-x64.tar.gz"
      sha256 "1bf562ff40c353ed64d940d57bd782239d0da2058c2c0f2c43c2efbe2fe8be32"
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
