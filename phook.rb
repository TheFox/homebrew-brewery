
class Phook < Formula
  desc "Runs commands around a parent process"
  homepage "https://github.com/drinchev/phook"
  url "https://github.com/drinchev/phook/archive/v0.0.3.tar.gz"
  sha256 "8d607601efaedc6c8b802f2c37171f2892500995877ea2d4ce412dccd08530ab"

  depends_on "make" => :build

  def install
    system "make"

    bin.install "phook"
  end

  test do
    system "which", "-a", "phook"
  end
end
