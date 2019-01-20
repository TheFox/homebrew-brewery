
# File type: production
# Version: v0.8.4
# Version Short: 0.8.4

class WalletCpp < Formula
  desc "A spreadsheet likewise C++17 program to track your finances."
  homepage "https://github.com/TheFox/wallet-cpp"
  url "https://github.com/TheFox/wallet-cpp/archive/v0.8.4.tar.gz"
  sha256 "9db1217dea67fc3b5ac15f8a06667732a3395b6f94aaa08bc715091288fe9c1e"

  depends_on "cmake" => :build
  depends_on "boost" => ">=1.62"
  depends_on "yaml-cpp" => ">=0.6"
  depends_on "mstch" => ">=1.0"
  depends_on "gnuplot" => ">=5.0"

  def install
    sha256_short = "9db1217dea67fc3b5ac15f8a06667732a3395b6f94aaa08bc715091288fe9c1e"[0..7]
    args = %W[
      -DCMAKE_BUILD_TYPE=release
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DPROJECT_SHARE_PREFIX=#{share}
      -DPROJECT_VERSION_FULL=0.8.4
      -DPROJECT_VERSION_HASH=fake-#{sha256_short}
      -DWALLETCPP_GNUPLOT_SUPPORT=ON
    ]

    system "mkdir build"
    Dir.chdir("build") do
      system "cmake", "..", *args
      system "make"
      bin.install "bin/wallet"
    end

    share.install Dir["resources"]
  end

  test do
    system "which", "-a", "wallet"
  end
end
