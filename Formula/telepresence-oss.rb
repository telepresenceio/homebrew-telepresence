# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.30.1"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "a174c349bc28160d5224a445c6fcc99bcba349fda3ec3e5cbbca146463921e08" if OS.mac? && Hardware::CPU.intel?
  sha256 "ce21b7bcec0636f90c70aabd461c2b693fdd4fd12849fbb177a8a6995dbc4b3f" if OS.mac? && Hardware::CPU.arm?
  sha256 "9316fd8d6a589f7b28a33ca5eee2605e6443e8913c23feb8e2be3c81f7beef3c" if OS.linux? && Hardware::CPU.intel?
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
