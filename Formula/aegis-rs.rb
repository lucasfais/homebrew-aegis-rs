class AegisRs < Formula
  desc "Aegis compatible OTP generator for the CLI"
  homepage "https://github.com/Granddave/aegis-rs"
  version "0.5.1"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/Granddave/aegis-rs/releases/download/v#{version}/aegis-aarch64-apple-darwin-v#{version}.tgz"
      sha256 "1731a08d5bc7c6b3f7228249681bb24d306accb36be4bf062f97273a58b61f99"
    end
    on_intel do
      url "https://github.com/Granddave/aegis-rs/releases/download/v#{version}/aegis-x86_64-apple-darwin-v#{version}.tgz"
      sha256 "33de78dd798f0abdde5b39a6d507682aca0eb5efbc930b9d3f63a96d7cbda3b6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Granddave/aegis-rs/releases/download/v#{version}/aegis-aarch64-unknown-linux-gnu-v#{version}.tgz"
      sha256 "359dd29a1abcf8d63e7950c761c9b5cd5c8fe6c58b1977e30ed9ddde385e8237"
    end
    on_intel do
      url "https://github.com/Granddave/aegis-rs/releases/download/v#{version}/aegis-x86_64-unknown-linux-gnu-v#{version}.tgz"
      sha256 "d57a1a23c07f28c1dc4d8299d4724ea5a2a45197c4fcfe3152db3b7fd37a5775"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "aegis-rs"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aegis-rs --version")
  end
end
