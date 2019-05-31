
# File type: skel
# Version: %VERSION%
# Version Short: %VERSION_SHORT%

class Parameters < Formula
  desc "Automatic replace variables in configuration file templates from environment variables."
  homepage "https://github.com/TheFox/parameters"
  head "https://github.com/TheFox/parameters.git"
  url "https://github.com/TheFox/parameters/archive/%VERSION%.tar.gz"
  sha256 "%SHA256%"

  depends_on "cmake" => :build

  option "with-debug", "Build a debug version"

  def install
    # Build Options
    build_type = build.with?('debug') ? 'debug' : 'release'
    sha256_short = "%SHA256%"[0..7]

    args = %W[
      -DCMAKE_BUILD_TYPE=#{build_type}
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DPROJECT_VERSION_FULL=%VERSION_SHORT%
      -DPROJECT_VERSION_HASH=brew-#{sha256_short}
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
