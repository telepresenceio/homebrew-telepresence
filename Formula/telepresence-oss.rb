# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.25.1"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "56c06e26a7c5c2b748ea30cb4341ffbc2399dff12d2fc2c77549fd224aea87f9" if OS.mac? && Hardware::CPU.intel?
  sha256 "60bfa0e0d83d9462ae43f6a964d887039336a5fb6f5ecb1d63ebaad8fe865b6d" if OS.mac? && Hardware::CPU.arm?
  sha256 "bfe41d79e7ccb1bb82fb0f30e0b0e123747e52bbc68dd70f4d30380009bdf128" if OS.linux? && Hardware::CPU.intel?
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
