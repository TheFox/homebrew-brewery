
class WalletCpp < Formula
  desc "desc"
  homepage "https://github.com/TheFox/wallet-cpp"
  url "https://github.com/TheFox/wallet-cpp/archive/v0.7.2.tar.gz"
  sha256 "6ab0b9952b3bd17775617956d4d997d50333b116fd8bf9740caf338511c98745"

  depends_on "cmake" => :build
  depends_on "boost" => "1.62"
  depends_on "yaml-cpp" => "0.6"
  depends_on "mstch" => "1.0"
  depends_on "gnuplot" => "5.0"

  def install
    system "mkdir build"
    Dir.chdir("build") do
      system "cmake",
        "-DPROJECT_INSTALL_PREFIX=#{prefix}",
        "-DPROJECT_SHARE_PREFIX=#{share}"
        "-DCMAKE_BUILD_TYPE=release",
        "-DWALLETCPP_GNUPLOT_SUPPORT=ON",
        ".."
      system "make wallet"
      bin.install "bin/wallet"
    end

    share.install Dir["resources"]
  end

  test do
    system "which", "-a", "wallet"
  end
end
