# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.25.2"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "131d28a44b3c4fb2a2b04339ac7400314da530e5663e7f0e841d12e76f9ba616" if OS.mac? && Hardware::CPU.intel?
  sha256 "79aa444eb9ef05ff64c0e6c04e97bef1460f3ae4800c191798996bdad71c8ec9" if OS.mac? && Hardware::CPU.arm?
  sha256 "1ce2f30c203beb5bb92035dd8e29212080101bfb8956f4856dd52745aa7c0130" if OS.linux? && Hardware::CPU.intel?
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
