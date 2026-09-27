# Generado por scripts/update.mjs a partir del SHA256SUMS firmado de v0.10.1.
# No lo edites a mano: el siguiente update lo pisa.
class Drop < Formula
  desc "Peer-to-peer file transfer, end-to-end encrypted, with a code you can say aloud"
  homepage "https://drop.oloxx.dev"
  version "0.10.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.10.1/drop-v0.10.1-macos-arm64.tar.gz"
      sha256 "c028c2694f035ad0168002278e31df9368280b878fca1c201948a55f9169fc89"
    end
    on_intel do
      url "https://github.com/Oloxx/drop/releases/download/v0.10.1/drop-v0.10.1-macos-x64.tar.gz"
      sha256 "9af8dc590c0e3ece6c27945ba43fbf0b4fc27d30baa491026c99d04bfc108a69"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.10.1/drop-v0.10.1-linux-arm64.tar.gz"
      sha256 "ae7d29783fc393e2aaac0118c63651f84f79c5462c2f0d04d3654dc0230c8ef5"
    end
    on_intel do
      url "https://github.com/Oloxx/drop/releases/download/v0.10.1/drop-v0.10.1-linux-x64.tar.gz"
      sha256 "728d3b74119bd7f76df366f38fecb35d9415d6329b2f8ef50122772695585634"
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
