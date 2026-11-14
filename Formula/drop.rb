# Generado por scripts/update.mjs a partir del SHA256SUMS firmado de v0.12.0.
# No lo edites a mano: el siguiente update lo pisa.
class Drop < Formula
  desc "Peer-to-peer file transfer, end-to-end encrypted, with a code you can say aloud"
  homepage "https://drop.oloxx.dev"
  version "0.12.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.12.0/drop-v0.12.0-macos-arm64.tar.gz"
      sha256 "2f8db7ea1ad602af7ad3b024efe7427016b76d4fe8c74920b4d9e6f1890bc96d"
    end
    on_intel do
      url "https://github.com/Oloxx/drop/releases/download/v0.12.0/drop-v0.12.0-macos-x64.tar.gz"
      sha256 "1ee9943f0e5fd265983d6db425451c087a9fe34d1af76d392797d19acd7c46ac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Oloxx/drop/releases/download/v0.12.0/drop-v0.12.0-linux-arm64.tar.gz"
      sha256 "997ed7c73ba1d2f57a1f58828c7fc9e465515a4ebfe67c95caa7dc2ea732ba74"
    end
    on_intel do
      url "https://github.com/Oloxx/drop/releases/download/v0.12.0/drop-v0.12.0-linux-x64.tar.gz"
      sha256 "8874a5a9924bc2df5a9957f2772f64f0f95799865c8665576e8306b8319e02a0"
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
