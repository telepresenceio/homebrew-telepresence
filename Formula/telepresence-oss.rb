# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.29.1"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "66b6e31d21b67fc2c2e99fa5a342d4b179d7eb9e6d69b74c87be883127b73c2d" if OS.mac? && Hardware::CPU.intel?
  sha256 "c94c59f9360cceb34b235960d375c87cee4af725c9c0ab4ef160f57b124f030d" if OS.mac? && Hardware::CPU.arm?
  sha256 "abeb9eccef04a80e435d7bfb045ecfb8eec57a0350a486185b7cc5776ef54b0e" if OS.linux? && Hardware::CPU.intel?
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
