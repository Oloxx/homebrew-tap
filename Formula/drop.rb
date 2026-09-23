# Generado por scripts/update.mjs a partir del SHA256SUMS firmado de v0.9.0.
# No lo edites a mano: el siguiente update lo pisa.
class Drop < Formula
  desc "Peer-to-peer file transfer, end-to-end encrypted, with a code you can say aloud"
  homepage "https://drop.oloxx.dev"
  version "0.9.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.9.0/drop-v0.9.0-macos-arm64.tar.gz"
      sha256 "50c135ab45efe03a4c49f13c6dd937027e12d93f9d7bd0629b54e2a860179cc0"
    end
    on_intel do
      url "https://github.com/Oloxx/drop/releases/download/v0.9.0/drop-v0.9.0-macos-x64.tar.gz"
      sha256 "9851233e5646037588883266e54c83da28bc979a39f11e54c73bbfcba7915c02"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.9.0/drop-v0.9.0-linux-arm64.tar.gz"
      sha256 "cd00c53f7a3125f63b2b484335c4a2b1783e45db86eaf52d5b5145a70e9fb0e3"
    end
    on_intel do
      url "https://github.com/Oloxx/drop/releases/download/v0.9.0/drop-v0.9.0-linux-x64.tar.gz"
      sha256 "38b2fb61af5dd20f305c41f38b45af37db6eb466c6f96b057b2e7455e92d8e0a"
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
