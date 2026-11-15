# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.33.1"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "948e94a16efc01fe371abca13e23e7d6f724ed9038a31fe49e1c1b59b03ad258" if OS.mac? && Hardware::CPU.intel?
  sha256 "ccb6c0f4361931bbed51fbd75e6304e3de4a9a1620c491fca1950b776463b766" if OS.mac? && Hardware::CPU.arm?
  sha256 "daf1fbb7499d0e6b34730759504b13fc4170ff1ddcd50d3fa8f17c6c11b3a7bc" if OS.linux? && Hardware::CPU.intel?
  sha256 "31c2063df488ecd135b3ec24be60635d50ea9640ecfea104e4f6d68ee7ca6e7f" if OS.linux? && Hardware::CPU.arm?

  conflicts_with "telepresence"

  def install
      bin.install "#{PACKAGE_NAME}" => "telepresence"
  end

  test do
      system "#{bin}/telepresence", "--help"
  end
end
