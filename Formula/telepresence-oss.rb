# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.32.3"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "415e63dc5d44f8912cfd1d8cb5c0ec00aaa9837801d50ce7b2ab84094271b6a2" if OS.mac? && Hardware::CPU.intel?
  sha256 "502adb9d03800e131380b0bc25566b9dc0698e0462a06a9a17a58a1710b87e33" if OS.mac? && Hardware::CPU.arm?
  sha256 "e9c32ab75c8b0247d11fce0fc15894bf70b2964465217879353a3be0b5fe8ede" if OS.linux? && Hardware::CPU.intel?
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
