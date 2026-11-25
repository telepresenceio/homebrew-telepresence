# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.34.0"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "f6c2475ebf0e1362ca1e9fc65e617b2008242045085b0f4940b16dce26115370" if OS.mac? && Hardware::CPU.intel?
  sha256 "088556778ae0b30ed0a8e5823f8975099183eb58c30394b268480cd6cbfc52d6" if OS.mac? && Hardware::CPU.arm?
  sha256 "d916000a78772fe0fa097c34b8f1f97c796e3d0a628b4d7bc1192c1dc1a72f21" if OS.linux? && Hardware::CPU.intel?
  sha256 "cef2e1232ab71be9d81898984bc48b3da8c332975568ed7bf6d368098f302c42" if OS.linux? && Hardware::CPU.arm?

  conflicts_with "telepresence"

  def install
      bin.install "#{PACKAGE_NAME}" => "telepresence"
  end

  test do
      system "#{bin}/telepresence", "--help"
  end
end
