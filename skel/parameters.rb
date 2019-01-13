
# File type: skel

class Parameters < Formula
  desc "Automatic replace variables in configuration file templates from environment variables."
  homepage "https://github.com/TheFox/parameters"
  url "https://github.com/TheFox/parameters/archive/%VERSION%.tar.gz"
  sha256 "%SHA256%"

  depends_on "cmake" => :build

  def install
    system "./bin/build.sh"

    bin.install "build_release/bin/parameters"
  end

  test do
    system "which", "-a", "parameters"
  end
end
