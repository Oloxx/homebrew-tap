# Generado por scripts/update.mjs a partir del SHA256SUMS firmado de v0.13.0.
# No lo edites a mano: el siguiente update lo pisa.
class Drop < Formula
  desc "Peer-to-peer file transfer, end-to-end encrypted, with a code you can say aloud"
  homepage "https://drop.oloxx.dev"
  version "0.13.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.13.0/drop-v0.13.0-macos-arm64.tar.gz"
      sha256 "985d9df34ea7fcea8062a763a38cb8c1fd2ce12100e5c3c2064cfe84669e33c9"
    end
    on_intel do
      url "https://github.com/Oloxx/drop/releases/download/v0.13.0/drop-v0.13.0-macos-x64.tar.gz"
      sha256 "2ba32b5b8237d862b217d8b95c6893c2c93d48feb1c19885f6e1e62a7cd5342f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.13.0/drop-v0.13.0-linux-arm64.tar.gz"
      sha256 "fe57350c2da3f18f57fadab0b555b33126bb090508ac9fab78ddb2303910cb40"
    end
    on_intel do
      url "https://github.com/Oloxx/drop/releases/download/v0.13.0/drop-v0.13.0-linux-x64.tar.gz"
      sha256 "0c5eb3d430373d1b076bee782da914d8c7c767ad5404bbc6591e993b68eb43b7"
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
