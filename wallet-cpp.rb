
# File type: production
# Version: v0.7.5

class WalletCpp < Formula
  desc "A spreadsheet likewise C++17 program to track your finances."
  homepage "https://github.com/TheFox/wallet-cpp"
  url "https://github.com/TheFox/wallet-cpp/archive/v0.7.5.tar.gz"
  sha256 "78ff8c5a85e2513199dac4ad3d125c4f7321d207908fefdc50fe01b6ebda4efb"

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

  bottle do
    # https://docs.brew.sh/Bottles
    #rebuild 0
    root_url "https://dl.bintray.com/thefox/bottle"

    sha256 "53e318471e0abc3877b2cb2d9bb44f0915c155c07f7e86bcf4670fde9fd39425" => :mojave
    sha256 "fd3fbc85bfdc1850023370a5660d6f1d395dd2f0838a288b6cc5a290971e565b" => :high_sierra
  end
end
