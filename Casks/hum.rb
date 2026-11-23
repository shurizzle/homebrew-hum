cask "hum" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.1.4"
  sha256 arm:   "80e4da4dd1b1792f72cc2560a96e0820a0c799f228837d5b53209ad298fa5c5b",
         intel: "cb4196a4a942b998461711900a28a401a8b4bf1e1f4c1bb599438973ab9470c5"

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
