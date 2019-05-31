
# File type: production
# Version: v1.0.0-rc.6
# Version Short: 1.0.0-rc.6

class Parameters < Formula
  desc "Automatic replace variables in configuration file templates from environment variables."
  homepage "https://github.com/TheFox/parameters"
  head "https://github.com/TheFox/parameters.git"
  url "https://github.com/TheFox/parameters/archive/v1.0.0-rc.6.tar.gz"
  sha256 "7202fa87682d6950ea33fa38fb61826575861f3f75944ac538655cb60b1026c5"

  depends_on "cmake" => :build

  option "with-debug", "Build a debug version"

  def install
    # Build Options
    build_type = build.with?('debug') ? 'debug' : 'release'
    sha256_short = "7202fa87682d6950ea33fa38fb61826575861f3f75944ac538655cb60b1026c5"[0..7]

    args = %W[
      -DCMAKE_BUILD_TYPE=#{build_type}
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DPROJECT_VERSION_FULL=1.0.0-rc.6
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
