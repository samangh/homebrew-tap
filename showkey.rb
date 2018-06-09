class Showkey < Formula
  desc "Program for capturing keystrokes and getting them in recognizable printed form."
  homepage "http://www.catb.org/~esr/showkey"
  url "http://www.catb.org/~esr/showkey/showkey-1.8.tar.gz"
  sha256 "31b6b064976a34d7d8e7a254db0397ba2dc50f1bb6e283038b17c48a358d50d3"

  def install
    system "make"
    sbin.install "showkey"
    man1.install "showkey.1"
  end
end
