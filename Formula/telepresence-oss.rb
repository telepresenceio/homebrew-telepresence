# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.27.3"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "510a352bdbeeefcc755b6928cc31418f0d5978f3b0ab69d4fb410ea9e4d5ce6c" if OS.mac? && Hardware::CPU.intel?
  sha256 "a239f8efbcd6407610317b5759c1d0abbd5d342144ee821fa10534490eb078a6" if OS.mac? && Hardware::CPU.arm?
  sha256 "2d7f35e51db57f62b2ea41254f58181244b42650d2559ad44b37d9aaa90abfae" if OS.linux? && Hardware::CPU.intel?
  # TODO support linux arm64
  #sha256 "__TARBALL_HASH_LINUX_ARM64__" if OS.linux? && Hardware::CPU.arm?

  def install
      bin.install "#{PACKAGE_NAME}" => "telepresence"
  end

  test do
      system "#{bin}/telepresence", "--help"
  end
end
