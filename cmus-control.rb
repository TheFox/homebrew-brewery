
# File type: production
# Version: v1.2.0

class CmusControl < Formula
  desc "Control cmus with Media Keys << > >> under OS X"
  homepage "https://github.com/TheFox/cmus-control"
  url "https://github.com/TheFox/cmus-control/archive/v1.2.0.tar.gz"
  sha256 "86893293aed440eca0bbeaa46358849d1a072cd10f357476dc3ab1c3501e26db"

  depends_on "cmake" => :build

  def install
    system "./bin/build_release.sh"

    bin.install "build/release/bin/cmuscontrold"
  end

  def caveats; <<-EOS.indent
    Since Cmus Control doesn't have the behavior of changing any foreign processes it's highly recommended to deactivate Apples Remote Control Daemon:

      launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist

    See more details about Remote Control Daemon related to Cmus Control in this blog post:

      https://blog.fox21.at/2015/11/20/control-cmus-with-media-keys.html
    EOS
  end

  plist_options :startup => true, :manual => "cmuscontrold"

  def plist; <<-EOS.indent
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
