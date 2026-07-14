# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.30.0"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "d1cbfe9d51ba0d45f522c9f0e8470269436856e0467aed0f8ab682d2b6a930bb" if OS.mac? && Hardware::CPU.intel?
  sha256 "2e96ce90dda8c01007b4baa5c674527ce23bbe82d5be4401d7dab17fec6e1697" if OS.mac? && Hardware::CPU.arm?
  sha256 "16c16ca97130f95b50707f87eed58e0c4718e9803f596a7a2a62c0871e7d40ef" if OS.linux? && Hardware::CPU.intel?
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
