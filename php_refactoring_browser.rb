
class PhpRefactoringBrowser < Formula
  desc "A command line refactoring tool for PHP"
  homepage "https://github.com/QafooLabs/php-refactoring-browser"
  url "https://github.com/QafooLabs/php-refactoring-browser/releases/download/v0.1/refactor.phar"
  sha256 "8bd91c4173ff4ce00dc71a5c5cf14f86f8863ec401def6b1869c7d784e4d214f"
  version "0.1.0"

  def install
    bin.mkpath
    
    bin_link = Pathname.new("refactor").expand_path(bin)
    bin_link.make_symlink "refactor.phar"
    
    bin.install "refactor.phar"
  end

  test do
    system "which", "-a", "refactor"
  end
end
