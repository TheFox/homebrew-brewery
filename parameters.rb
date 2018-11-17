
class Parameters < Formula
  desc "Automatic replace variables in configuration file templates from environment variables."
  homepage "https://github.com/TheFox/parameters"
  url "https://github.com/TheFox/parameters/archive/v1.0.0-rc.1.tar.gz"
  sha256 "5e97f3db82ccbbd48d46ce598c9597595d26c396eee0c5912f9c1bcb2f4f3a09"

  depends_on "cmake" => :build

  def install
    system "./bin/build.sh"

    bin.install "build_release/bin/parameters"
  end

  test do
    system "which", "-a", "parameters"
  end
end
