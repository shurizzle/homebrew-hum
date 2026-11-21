cask "hum" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.1.1"
  sha256 arm:   "8479f3f3dfdd7fe39c7d69876946a0912a2997401d3320423808914660289958",
         intel: "18e883e519e14d8d361cde71b0660cf395a5b3cedfc77ff379f436daa2737832"

  # Soloist has no Intel build; x86_64 hum bundles the ECS engine instead.
  on_arm do
    depends_on cask: "spotify-soloist"
  end

  url "https://github.com/shurizzle/hum/releases/download/v#{version}/hum-#{arch}-apple-darwin.tar.gz"
  name "hum"
  desc "Terminal Spotify client"
  homepage "https://github.com/shurizzle/hum"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  binary "hum"
  generate_completions_from_executable "hum", "completions"

  # Release binaries are not notarized; unquarantine before hum runs to generate completions.
  preflight_steps do
    run "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "{{staged_path}}/hum"], must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/hum",
    "~/Library/Caches/hum",
  ]
end
