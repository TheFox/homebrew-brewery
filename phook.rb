
class Phook < Formula
  desc "Runs commands around a parent process"
  homepage "https://github.com/drinchev/phook"
  url "https://github.com/drinchev/phook/archive/v0.0.6.tar.gz"
  sha256 "9680cef34894d8d0ca1e5ce499c047e5d64262540c132574b0e6a389cb58606f"

  depends_on "make" => :build

  def install
    system "make"

    bin.install "phook"
  end

  test do
    system "which", "-a", "phook"
  end
end
