
# File type: production
# Version: v0.8.0

class WalletCpp < Formula
  desc "A spreadsheet likewise C++17 program to track your finances."
  homepage "https://github.com/TheFox/wallet-cpp"
  url "https://github.com/TheFox/wallet-cpp/archive/v0.8.0.tar.gz"
  sha256 "82a076a9f3acf6f9adc922260e42b068409f83ee30a3f83d08000759fd3165a3"

  depends_on "cmake" => :build
  depends_on "boost" => ">=1.62"
  depends_on "yaml-cpp" => ">=0.6"
  depends_on "mstch" => ">=1.0"
  depends_on "gnuplot" => ">=5.0"

  def install
    args = %W[
      -DCMAKE_BUILD_TYPE=release
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DPROJECT_SHARE_PREFIX=#{share}
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
