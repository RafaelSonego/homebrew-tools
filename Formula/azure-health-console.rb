class AzureHealthConsole < Formula
  desc "Read-only Azure health console: triage, dependencies, cost and security in a local page"
  homepage "https://github.com/RafaelSonego/azure-health-console"
  url "https://files.pythonhosted.org/packages/source/a/azure-health-console/azure_health_console-1.1.2.tar.gz"
  sha256 "ce6314df9d8db0390fbf040a5373cf9268ee0d4389f5d1b05ef399530581b00b"
  license "MIT"

  depends_on "python@3.13"

  def install
    # Its own virtual environment; the Python dependencies come from PyPI when it's installed.
    system Formula["python@3.13"].opt_bin/"python3.13", "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--no-cache-dir", buildpath
    bin.install_symlink libexec/"bin/azure-health-console"
  end

  def caveats
    <<~EOS
      Needs the Azure CLI: `brew install --cask azure-cli`.
      Sign in with `az login`, then run `azure-health-console` to open the console on 127.0.0.1.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/azure-health-console --version")
  end
end
