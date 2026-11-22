cask "hum" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.1.2"
  sha256 arm:   "3e02b8f3260715050582a35b07b0749733dc26e716fc027cf7c9a6223483b597",
         intel: "59f30c6b31d0313a37c3380362dce00818efe2fcfff7c1636176eee55b6a2f40"

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
