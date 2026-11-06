cask "agmon" do
  version "0.0.7"
  sha256 "058f8bda8393e331a024f458f68a35e4dea0250ee15839db1594c7880f333020"

  url "https://github.com/thanhdevapp/homebrew-tools/releases/download/agmon-v#{version}/AGMon-#{version}-arm64.dmg"
  name "AGMon"
  desc "Realtime AI Agent Office, Multi-Terminal Grid & Agentic Development Environment"
  homepage "https://github.com/thanhdevapp/agent-factory"

  depends_on macos: :ventura
  depends_on arch: :arm64

  livecheck do
    url "https://api.github.com/repos/thanhdevapp/homebrew-tools/releases?per_page=20"
    strategy :json do |json|
      json.select { |r| !r["draft"] && !r["prerelease"] && r["tag_name"]&.start_with?("agmon-v") }
           .map { |r| r["tag_name"].sub(/^agmon-v/, "") }
           .first
    end
  end

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
