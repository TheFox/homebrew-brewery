
# File type: production
# Version: v2.0.0

class CmusControl < Formula
  desc "Control cmus with Media Keys << > >> under macOS"
  homepage "https://github.com/TheFox/cmus-control"
  url "https://github.com/TheFox/cmus-control/archive/v2.0.0.tar.gz"
  sha256 "066fdbc1f9875e48346e0f56ac785ef07152b75fde2f3331b0d48b4f117bdf36"

  depends_on "zig" => :build

  service do
    run [opt_bin/"cmuscontrold"]
    run_type :immediate
    process_type :background
    keep_alive true
  end

  def install
    system "zig build --release"

    bin.install "zig-out/bin/cmuscontrold"
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
