
class Php7cc < Formula
  desc "PHP 7 Compatibility Checker"
  homepage "https://github.com/sstalle/php7cc"
  url "https://github.com/sstalle/php7cc/releases/download/1.1.0/php7cc.phar"
  sha256 "af1845ee3622630c3a87fe7928c4249e0070beb6392a6a1faac04cae962aee42"

  def install
    bin.mkpath
    
    bin_link = Pathname.new("php7cc").expand_path(bin)
    bin_link.make_symlink "php7cc.phar"
    
    bin.install "php7cc.phar"
  end

  test do
    system "which", "-a", "php7cc"
  end
end
