
# File type: skel
# Version: %VERSION%

class Parameters < Formula
  desc "Automatic replace variables in configuration file templates from environment variables."
  homepage "https://github.com/TheFox/parameters"
  url "https://github.com/TheFox/parameters/archive/%VERSION%.tar.gz"
  sha256 "%SHA256%"

  depends_on "cmake" => :build

  def install
    args = %W[
      -DCMAKE_BUILD_TYPE=release
      -DCMAKE_INSTALL_PREFIX=#{prefix}
    ]

    system "mkdir build"
    Dir.chdir("build") do
      system "cmake", "..", *args
      system "make"
      bin.install "bin/parameters"
    end
  end

  test do
    system "which", "-a", "parameters"
  end

  bottle do
    # https://docs.brew.sh/Bottles
    #rebuild 0
    root_url "https://dl.bintray.com/thefox/bottle"

    sha256 "e863e57ed2c46c3ecbae425475f415766b2b7d487c307b241089401b491d2e5a" => :mojave
    sha256 "6fc07eaba0a2edfcca7dc3eef5b9842948340c94ac816a168f76dbcb2166693e" => :high_sierra
  end
end
