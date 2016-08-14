class Gptfdisk < Formula
  desc "Text-mode GPT partitioning tools"
  homepage "https://sourceforge.net/projects/gptfdisk/"
  url "https://github.com/samangh/gptfdisk/archive/v1.0.1.tar.gz"
  version "1.0.1"
  sha256 "be9c4ae2c56b5ca7f476aa5f9afcf55c183561629d73dae3c02539dbf08c8b52"

  depends_on "popt"
  depends_on "icu4c"

  def install
    inreplace "Makefile.mac", "/opt/local/lib/libncurses.a", "/usr/lib/libncurses.dylib"

    system "make", "-f", "Makefile.mac"
    sbin.install "gdisk", "cgdisk", "sgdisk", "fixparts"
    man8.install Dir["*.8"]
    doc.install Dir["*.html"]
  end

  test do
    assert_match /GPT fdisk \(gdisk\) version #{Regexp.escape(version)}/,
                 pipe_output("#{sbin}/gdisk", "\n")
  end
end
