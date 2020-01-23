class Kubeconnect < Formula
  # How to upgrade:
  # 1) Determine new sha256 hash:
  #   $ wget https://github.com/marijnkoesen/kubeconnect/archive/v0.1.3.tar.gz
  #   $ shasum -a 256 v0.1.3.tar.gz
  # 2) Modify this file, replace old version with new and shasum
  # 3) Commit this file, push to github, tag new version
  desc "Easily connect to any pod running in kubernetes"
  homepage "https://github.com/marijnkoesen/kubeconnect"
  url "https://github.com/marijnkoesen/kubeconnect/archive/v0.1.3.tar.gz"
  sha256 "f6b4d50c7b2be2caed7cac6bb0bff046925eaaced36bf55ebeb9db687e882718" 
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
    assert_match "kubeconnect version 0.1.3", shell_output("#{bin}/kubeconnect --version")
  end
end
