
class Phook < Formula
  desc "Runs commands around a parent process"
  homepage "https://github.com/drinchev/phook"
  url "https://github.com/drinchev/phook/archive/v0.0.4.tar.gz"
  sha256 "f2b633721048a2681cb4613b57af08269cdb8e54d70cfa77abb1cdc94cc7b562"

  depends_on "make" => :build

  def install
    system "make"

    bin.install "phook"
  end

  test do
    system "which", "-a", "phook"
  end
end
