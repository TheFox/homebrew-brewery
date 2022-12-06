
# File type: skel
# Version: %VERSION%

class CmusControl < Formula
  desc "Control cmus with Media Keys << > >> under OS X"
  homepage "https://github.com/TheFox/cmus-control"
  url "https://github.com/TheFox/cmus-control/archive/%VERSION%.tar.gz"
  sha256 "%SHA256%"

  depends_on "cmake" => :build

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

  plist_options :startup => true, :manual => "cmuscontrold"

  def plist; <<-EOS
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key> <string>#{plist_name}</string>

    <key>ProgramArguments</key>
    <array>
      <string>#{opt_bin}/cmuscontrold</string>
    </array>

    <key>EnvironmentVariables</key>
    <dict>
      <key>PATH</key>
      <string>/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin</string>
    </dict>

    <key>ProcessType</key> <string>Background</string>

    <key>RunAtLoad</key> <true />

    <key>KeepAlive</key> <true />

    <key>Disabled</key> <false />
  </dict>
</plist>
EOS
  end

  test do
    system "which", "-a", "cmuscontrold"
  end
end
