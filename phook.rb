
class Phook < Formula
  desc "Runs commands around a parent process"
  homepage "https://github.com/drinchev/phook"
  url "https://github.com/drinchev/phook/archive/v0.0.7.tar.gz"
  sha256 "c182948287c5a8f05cd6b7d1493caade0a0f4f8bb3cbaa82cd9d5527566a2ab0"

  depends_on "make" => :build

  def install
    system "make"

    bin.install "phook"
  end

  test do
    system "which", "-a", "phook"
  end
end
