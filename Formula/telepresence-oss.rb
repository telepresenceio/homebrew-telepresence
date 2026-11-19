# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.33.3"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "1ead96d4d15dbfb29c5ec8d3870126638676a71c2349dc5c68dd8c0fbe58b5be" if OS.mac? && Hardware::CPU.intel?
  sha256 "b23f39c5e95b9aabb5797e990ee01988739f393545b1afe555dfeca6b746835f" if OS.mac? && Hardware::CPU.arm?
  sha256 "a2929ecbcb229830e324deef8ff55d3b48d0f230a83730e18fa895e1ada3f04e" if OS.linux? && Hardware::CPU.intel?
  sha256 "7d3a6a8aade4c5333fbf111f2f7836134ca38a3ccc2548126b281759f67ff019" if OS.linux? && Hardware::CPU.arm?

  conflicts_with "telepresence"

  def install
      bin.install "#{PACKAGE_NAME}" => "telepresence"
  end

  test do
      system "#{bin}/telepresence", "--help"
  end
end
