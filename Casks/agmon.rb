cask "agmon" do
  version "1.0.0"
  sha256 "08a114647417c18ed069cccdbb11ead5b76f41986e4f7bcf0402ef9c5c46b669"

  url "https://github.com/thanhdevapp/agent-factory/releases/download/v#{version}/AGMon-#{version}-arm64.dmg"
  name "AGMon"
  desc "Realtime AI Agent Office, Multi-Terminal Grid & Agentic Development Environment"
  homepage "https://github.com/thanhdevapp/agent-factory"

  depends_on macos: ">= :ventura"
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
