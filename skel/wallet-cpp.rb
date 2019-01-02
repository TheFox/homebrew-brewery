
class WalletCpp < Formula
  desc "desc"
  homepage "https://github.com/TheFox/wallet-cpp"
  url "https://github.com/TheFox/wallet-cpp/archive/%VERSION%.tar.gz"
  sha256 "%SHA256%"

  depends_on "cmake" => :build
  depends_on "boost" => "1.62"
  depends_on "yaml-cpp" => "0.6"
  depends_on "mstch" => "1.0"
  depends_on "gnuplot" => "5.0"

  def install
    system "./bin/build.sh"

    bin.install "build_release/bin/wallet"
  end

  test do
    system "which", "-a", "wallet"
  end
end
