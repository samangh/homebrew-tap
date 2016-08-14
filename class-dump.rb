class ClassDump < Formula
  desc "Utility for examining the Objective-C segment of Mach-O files"
  homepage "http://stevenygard.com/projects/class-dump/"
  url "https://github.com/samangh/class-dump/archive/v3.5-1.tar.gz"

  version "3.5"
  sha256 "8da797d6bc20ad61d610058ee835e6ae3493c62602a3653263f28a23aa76d410"

  depends_on :xcode => :build

  def install
    xcodebuild "-configuration", "Release", "SYMROOT=build", "PREFIX=#{prefix}", "ONLY_ACTIVE_ARCH=YES"
    bin.install "build/Release/class-dump"
    bin.install "build/Release/deprotect"
    bin.install "build/Release/formatType"
  end

  test do
    assert_match /class-dump #{Regexp.escape(version)}/,
                 pipe_output("#{bin}/class-dump --version", "\n")
  end
end
