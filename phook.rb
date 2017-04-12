
class Phook < Formula
  desc "Runs commands around a parent process"
  homepage "https://github.com/drinchev/phook"
  url "https://github.com/drinchev/phook/archive/v0.0.5.tar.gz"
  sha256 "eb6c81845f7b9f535e1ea36abfde0f9c8f59fe7d342eecf4602c9f6cfd57f0d4"

  depends_on "make" => :build

  def install
    system "make"

    bin.install "phook"
  end

  test do
    system "which", "-a", "phook"
  end
end
