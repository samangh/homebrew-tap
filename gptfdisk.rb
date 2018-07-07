class Gptfdisk < Formula
  desc "Text-mode GPT partitioning tools"
  homepage "https://sourceforge.net/projects/gptfdisk/"
  url "https://downloads.sourceforge.net/project/gptfdisk/gptfdisk/1.0.4/gptfdisk-1.0.4.tar.gz"
  sha256 "b663391a6876f19a3cd901d862423a16e2b5ceaa2f4a3b9bb681e64b9c7ba78d"

  option "with-sgdisk", "Compile sgdisk."
  option "without-cgdisk", "Do not compile cgdisk."
  option "without-fixparts", "Do not compile fixparts."

  depends_on "popt" if build.with?("sgdisk")

  def install
    opts = ["gdisk"]
    opts << "sgdisk" if build.with? "sgdisk"
    opts << "cgdisk" if build.with? "cgdisk"
    opts << "fixparts" if build.with? "fixparts"

    system "make", "-f", "Makefile.mac", *opts
    sbin.install "gdisk"
    sbin.install "cgdisk" if build.with? "cgdisk"
    sbin.install "sgdisk" if build.with? "sgdisk"
    sbin.install "fixparts" if build.with? "fixparts"

    man8.install Dir["*.8"]
    doc.install Dir["*.html"]
  end

  test do
    assert_match /GPT fdisk \(gdisk\) version #{Regexp.escape(version)}/,
                 pipe_output("#{sbin}/gdisk", "\n")
    
    output = pipe_output("/usr/bin/hdiutil create -size 128k test.dmg " \
      "&& #{sbin}/gdisk -l test.dmg", nil, 0)
    assert_match /^Found valid GPT with protective MBR/, output    
  end
end
