
# File type: production
# Version: v1.2.0

class CmusControl < Formula
  desc "Control cmus with Media Keys << > >> under OS X"
  homepage "https://github.com/TheFox/cmus-control"
  url "https://github.com/TheFox/cmus-control/archive/v1.2.0.tar.gz"
  sha256 "86893293aed440eca0bbeaa46358849d1a072cd10f357476dc3ab1c3501e26db"

  depends_on "cmake" => :build
  service do
    run [opt_bin/"cmuscontrold"]
    run_type :immediate
    process_type :background
    keep_alive true
  end

  def install
    system "./bin/build_release.sh"

    bin.install "build/release/bin/cmuscontrold"
  end

  def caveats; <<-EOS
Since Cmus Control doesn't have the behavior of changing any foreign processes it's highly recommended to deactivate Apples Remote Control Daemon:

  launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist

See more details about Remote Control Daemon related to Cmus Control in this blog post:

  https://blog.fox21.at/2015/11/20/control-cmus-with-media-keys.html
EOS
  end

  test do
    system "which", "-a", "cmuscontrold"
  end
end
