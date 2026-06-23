class AegisRs < Formula
  desc "Aegis compatible OTP generator for the CLI"
  homepage "https://github.com/Granddave/aegis-rs"
  version "0.5.0"
  license "GPL-3.0-only"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/Granddave/aegis-rs/releases/download/v#{version}/aegis-aarch64-apple-darwin-v#{version}.tgz"
      sha256 "ca236225d6a86706d7c8eadf0f6d3690dabc5a9e6386064afb261f98f9adb135"
    end
    on_intel do
      url "https://github.com/Granddave/aegis-rs/releases/download/v#{version}/aegis-x86_64-apple-darwin-v#{version}.tgz"
      sha256 "8442cc6a5828b94fea5e94545c503525ad9c1405a2d1dd7c3305392484cf1d66"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Granddave/aegis-rs/releases/download/v#{version}/aegis-aarch64-unknown-linux-gnu-v#{version}.tgz"
      sha256 "9cd5fdaa470ba191f1efbb0692e0b32c3db17fb3e2c7bb6f6e97a6b45f3ff8ab"
    end
    on_intel do
      url "https://github.com/Granddave/aegis-rs/releases/download/v#{version}/aegis-x86_64-unknown-linux-gnu-v#{version}.tgz"
      sha256 "93844980dd7650f45db073d952e59091f7ae8076ba76f4b3c976204ebc9b08d1"
    end
  end

  def install
    bin.install "aegis-rs"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aegis-rs --version")
  end
end
