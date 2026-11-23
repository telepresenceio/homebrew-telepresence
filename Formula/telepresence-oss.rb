# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.33.4"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "6464c03ba8c07c80b3bc8cf3dc065092b2237f88a6257fcb8f90033f7d630ce3" if OS.mac? && Hardware::CPU.intel?
  sha256 "b4dfe387fa4dd8cbe3f211a07c22328379748c331d80c7fc024a8273d029771b" if OS.mac? && Hardware::CPU.arm?
  sha256 "0e640c20c7e4c2005917d0d927116e622d4a274dc014c557185079968d8a2e29" if OS.linux? && Hardware::CPU.intel?
  sha256 "647d652a656348824ef580d5e3bb0a872e4e3cbcdce620992c9eb7ee75470e9b" if OS.linux? && Hardware::CPU.arm?

  def install
      bin.install "#{PACKAGE_NAME}" => "telepresence"
  end

  test do
      system "#{bin}/telepresence", "--help"
  end
end
