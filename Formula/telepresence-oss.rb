# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.24.1"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "492a252bf131be2431db9506b8a685de2dfd6b22f0ff41897ddd30beb48f2699" if OS.mac? && Hardware::CPU.intel?
  sha256 "bf5ebf57365ba8b943a7fdd5ae49400643b8cd508d85798612206346ba300afc" if OS.mac? && Hardware::CPU.arm?
  sha256 "b7d2d09e30eb85ffb4f6ae0baba377dfa96c8ae028b70ae1cc8b9fdc463e78ba" if OS.linux? && Hardware::CPU.intel?
  # TODO support linux arm64
  #sha256 "__TARBALL_HASH_LINUX_ARM64__" if OS.linux? && Hardware::CPU.arm?

  conflicts_with "telepresence"

  def install
      bin.install "#{PACKAGE_NAME}" => "telepresence"
  end

  test do
      system "#{bin}/telepresence", "--help"
  end
end
