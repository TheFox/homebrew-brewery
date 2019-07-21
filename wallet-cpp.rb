
# File type: production
# Version: v0.9.0
# Version Short: 0.9.0

class WalletCpp < Formula
  desc "A spreadsheet likewise C++17 program to track your finances."
  homepage "https://github.com/TheFox/wallet-cpp"
  head "https://github.com/TheFox/wallet-cpp.git"
  url "https://github.com/TheFox/wallet-cpp/archive/v0.9.0.tar.gz"
  sha256 "9e05a13bf281f19857de75bfbc34db31e3bbf3fb4f95dab5bf71c28bcc43d874"

  depends_on "cmake" => :build
  depends_on "boost" => ">=1.62"
  depends_on "yaml-cpp" => ">=0.6"
  depends_on "mstch" => ">=1.0"
  depends_on "gnuplot" => :optional

  option "with-debug", "Build a debug version"

  def install
    # Build Options
    build_type = build.with?('debug') ? 'debug' : 'release'
    sha256_short = "9e05a13bf281f19857de75bfbc34db31e3bbf3fb4f95dab5bf71c28bcc43d874"[0..7]

    args = %W[
      -DCMAKE_BUILD_TYPE=#{build_type}
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DPROJECT_SHARE_PREFIX=#{share}
      -DPROJECT_VERSION_FULL=0.9.0
      -DPROJECT_VERSION_HASH=brew-#{sha256_short}
    ]

    # gnuplot
    if not build.with?('gnuplot')
      args << "-DWALLETCPP_GNUPLOT_SUPPORT=ON"
    end

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
