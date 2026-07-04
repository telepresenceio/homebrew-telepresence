# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.29.2"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "43bc3e0deeccbf9185d6991e5b4aac36a9b9483badf8162ac1d35cd050c6a2f2" if OS.mac? && Hardware::CPU.intel?
  sha256 "637a4ed6c8f09aa69313059b64617cfbfe2e2f1b5942fe3c62cae4d25d80bc14" if OS.mac? && Hardware::CPU.arm?
  sha256 "7ab30ba6f02da85cee2ff407e4398edc2fefac0469b2ecbd7462829ce5c0ab85" if OS.linux? && Hardware::CPU.intel?
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
