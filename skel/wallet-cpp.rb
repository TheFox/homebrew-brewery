
# File type: skel

class WalletCpp < Formula
  desc "A spreadsheet likewise C++17 program to track your finances."
  homepage "https://github.com/TheFox/wallet-cpp"
  url "https://github.com/TheFox/wallet-cpp/archive/%VERSION%.tar.gz"
  sha256 "%SHA256%"

  depends_on "cmake" => :build
  depends_on "boost" => "1.62"
  depends_on "yaml-cpp" => "0.6"
  depends_on "mstch" => "1.0"
  depends_on "gnuplot" => "5.0"

  def install
    system "mkdir build"
    Dir.chdir("build") do
      system "cmake",
        "-DCMAKE_INSTALL_PREFIX=#{prefix}",
        "-DPROJECT_SHARE_PREFIX=#{share}",
        "-DCMAKE_BUILD_TYPE=release",
        "-DWALLETCPP_GNUPLOT_SUPPORT=ON",
        ".."
      system "make"
      bin.install "bin/wallet"
    end

    share.install Dir["resources"]
  end

  test do
    system "which", "-a", "wallet"
  end
end
