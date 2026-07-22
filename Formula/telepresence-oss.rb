# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.31.0"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "c35039eb83fa39451d5173df3d03fe0d42aeb771d8aae07a79d9a256eb18fb6a" if OS.mac? && Hardware::CPU.intel?
  sha256 "ffd4d2bdbdbb06cbfb6566f73c91b277b5997de3398d905df63f93826ee58f27" if OS.mac? && Hardware::CPU.arm?
  sha256 "ba30ed7392b95d7c3500b2391e90299324e37893cc1f2ff27bafd690c30219a2" if OS.linux? && Hardware::CPU.intel?
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
