# Generado por scripts/update.mjs a partir del SHA256SUMS firmado de v0.10.0.
# No lo edites a mano: el siguiente update lo pisa.
class Drop < Formula
  desc "Peer-to-peer file transfer, end-to-end encrypted, with a code you can say aloud"
  homepage "https://drop.oloxx.dev"
  version "0.10.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.10.0/drop-v0.10.0-macos-arm64.tar.gz"
      sha256 "622745501dc983f2edd7617e034adffd0195ea09978a72d1fe344abca51318c1"
    end
    on_intel do
      url "https://github.com/Oloxx/drop/releases/download/v0.10.0/drop-v0.10.0-macos-x64.tar.gz"
      sha256 "808ab7f6a9535e6f22f8f56f97b81ddaf8f0ab81121618f3094e70967eb870d8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.10.0/drop-v0.10.0-linux-arm64.tar.gz"
      sha256 "872250934d4044cd0e987a53a33394d5f4aafa9999d74a1fbd3605f93bbc4699"
    end
    on_intel do
      url "https://github.com/Oloxx/drop/releases/download/v0.10.0/drop-v0.10.0-linux-x64.tar.gz"
      sha256 "71660b7b1c4413a361d967bdcd358895c9318c00c28c6a17751c0e2b1076b3c6"
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
