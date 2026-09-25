# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.32.1"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "88afa6cffdd378ea8a78a7c3fca46ccf6617487894d4b09b82f7966c6e383e72" if OS.mac? && Hardware::CPU.intel?
  sha256 "353d24a39bba13af5813636cc987a9ed30ca3ad202a0ba50aea8a6e830fbc5a8" if OS.mac? && Hardware::CPU.arm?
  sha256 "cddbe69a37562cbe9ba00c37f9f9ccc4ad37088fd73a8018823ab16979fe1ea7" if OS.linux? && Hardware::CPU.intel?
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
