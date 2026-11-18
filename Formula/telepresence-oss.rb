# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.33.2"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "9df849cf6d09c5d7c00d1c1b7b33af9d690d5bb16b548f076215647dc4e8302e" if OS.mac? && Hardware::CPU.intel?
  sha256 "16af1f6962ff2b36a79026501b195b9985977cdedbbe805a48b65f54a207b79c" if OS.mac? && Hardware::CPU.arm?
  sha256 "58fc9fb8286390a23a28485aa837557232d47e603cb9701ab62082504172e0d8" if OS.linux? && Hardware::CPU.intel?
  sha256 "128873bf93112adf4c3a5677fb474bea141c8850fe8b5a35d4d11762beadbdf8" if OS.linux? && Hardware::CPU.arm?

  conflicts_with "telepresence"

  def install
      bin.install "#{PACKAGE_NAME}" => "telepresence"
  end

  test do
      system "#{bin}/telepresence", "--help"
  end
end
