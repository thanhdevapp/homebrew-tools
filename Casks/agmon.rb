cask "agmon" do
  version "0.0.1"
  sha256 "8d36932ca9830655ea39d971ee791fc8401ef27544b8dcede7380d5167961b17"

  url "https://github.com/thanhdevapp/agent-factory/releases/download/v#{version}/AGMon-#{version}-arm64.dmg"
  name "AGMon"
  desc "Realtime AI Agent Office, Multi-Terminal Grid & Agentic Development Environment"
  homepage "https://github.com/thanhdevapp/agent-factory"

  depends_on macos: :ventura
  depends_on arch: :arm64

  app "AGMon.app"
  binary "#{appdir}/AGMon.app/Contents/Resources/app.asar.unpacked/bin/macos-agmon", target: "agmon"
  binary "#{appdir}/AGMon.app/Contents/Resources/app.asar.unpacked/bin/macos-agmon-driver", target: "agmon-driver"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/AGMon.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/agmon",
    "~/Library/Preferences/com.agmon.desktop.plist",
    "~/Library/Saved Application State/com.agmon.desktop.savedState",
  ]
end
