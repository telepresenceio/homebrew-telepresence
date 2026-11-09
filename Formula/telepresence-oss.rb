# This script is generated automatically by the release automation code in the
# Telepresence repository:
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.33.0"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH = Hardware::CPU.arm? ? "arm64" : "amd64"
  OPERATING_SYSTEM = OS.mac? ? "darwin" : "linux"
  PACKAGE_NAME = "telepresence-#{OPERATING_SYSTEM}-#{ARCH}"

  url "#{BASE_URL}/v#{version}/#{PACKAGE_NAME}"

  sha256 "51510aac1a425a8484bc8ffdcc2c4f29e4ba2e59f43d5a5298e643fed554dcf4" if OS.mac? && Hardware::CPU.intel?
  sha256 "095cfa7cb37830a94bad0cf6c3a8897e292381b917dbc18c3624b4e0d06584c6" if OS.mac? && Hardware::CPU.arm?
  sha256 "39720f28ccb1eedea527b644c54cb8458d2f84bba6a5cf057766a67f18c801d8" if OS.linux? && Hardware::CPU.intel?
  sha256 "ec91abbaeede2f05752c2980211f4e2838ec1baf78575246847fc4bd0cc876b5" if OS.linux? && Hardware::CPU.arm?

  conflicts_with "telepresence"

  def install
      bin.install "#{PACKAGE_NAME}" => "telepresence"
  end

  test do
      system "#{bin}/telepresence", "--help"
  end
end
