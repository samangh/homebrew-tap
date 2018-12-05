class Otx < Formula
  homepage "https://github.com/samangh/otx"
  head "https://github.com/samangh/otx.git"

  depends_on :xcode => :build

  def install
    xcodebuild "SYMROOT=build"
    bin.install "build/Release/otx"
    prefix.install "build/Release/otx.app"
  end
end
