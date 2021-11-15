
class Phook < Formula
  desc "Runs commands around a parent process"
  homepage "https://github.com/drinchev/phook"
  url "https://github.com/drinchev/phook/archive/v0.0.8.tar.gz"
  sha256 "918ce5693cccfe25adfc1c8d9e70ec6988955d118aa5a494c350692f369700c4"

  depends_on "make" => :build

  def install
    ENV.O0 # Any optimization breaks the build
    system "make"

    bin.install "phook"
  end

  test do
    system "which", "-a", "phook"
  end
end
