# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.29.3"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "ff002394772d3ca6860d24264029ef5fcf6b33bb8c9ad629b9615cd04d755beb" if OS.mac? && Hardware::CPU.intel?
  sha256 "303868b7b1a13a96d68bf43facfa90a5c8263765fa3029c692fbf8c4927f0f87" if OS.mac? && Hardware::CPU.arm?
  sha256 "ce8e04dac9c2b5ac35e20c854ac287f657acc4a616d60c8c51fcb66d8dd7f508" if OS.linux? && Hardware::CPU.intel?
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
