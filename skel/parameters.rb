
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
end
