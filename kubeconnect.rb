class Kubeconnect < Formula
  desc "Easily connect to any pod running in kubernetes"
  homepage "https://github.com/marijnkoesen/kubeconnect"
  url "https://github.com/marijnkoesen/kubeconnect/archive/v0.1.1.tar.gz"
  sha256 "3a634f3e4bb498674c83c321a635baadf6eec65e42ef52eecfcec0ca0cd4682d"
  depends_on "golang" => "1.11"

  def install
    ENV["GOPATH"] = buildpath

    bin_path = buildpath/"src/github.com/marijnkoesen/kubeconnect"
    # Copy all files from their current location (GOPATH root)
    # to $GOPATH/src/github.com/marijnkoesen/kubeconnect
    bin_path.install Dir["*"]
    cd bin_path do
      # Install the compiled binary into Homebrew's `bin` - a pre-existing
      # global variable
      system "go", "build", "-o", bin/"kubeconnect", "."
    end
  end

  # Homebrew requires tests.
  test do
    # "2>&1" redirects standard error to stdout. The "2" at the end means "the
    # exit code should be 2".
    assert_match "kubeconnect -h", shell_output("#{bin}/kubeconnect -h")
  end
end
