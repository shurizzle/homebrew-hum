cask "hum" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.1.3"
  sha256 arm:   "6e8439b5f4595ff2ba9f72a6fbeb4d11d2b74476eea53f964e02f96d1484351c",
         intel: "b254fd14e761de6df3c3831447170e63383bf652a3e60078a74d9c15eb7a1a2e"

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
