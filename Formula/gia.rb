class Gia < Formula
  desc "GIA - General Intelligence Assistant"
  homepage "https://github.com/mschnecke/gia"
  version "0.1.223"
  license "MIT"

  if Hardware::CPU.intel?
    url "https://github.com/mschnecke/gia/releases/download/v0.1.223/gia-macos-x86_64-v0.1.223.tar.gz"
    sha256 "b4b7dd383e946bd91a72d2e3026ff1253c089c12c936e19ffcfb81aacc819a38"
  else
    url "https://github.com/mschnecke/gia/releases/download/v0.1.223/gia-macos-aarch64-v0.1.223.tar.gz"
    sha256 "7e6f4aeae8f0b01281412888ded3d929de8ac6ef86256433cfeb0cfa2de5b76d"
  end

  def install
    # Binaries installieren
    bin.install "gia"
    bin.install "giagui"
  end

  def post_install
    # Ausführbar machen (normalerweise nicht nötig, da bin.install das macht)
    chmod 0755, bin/"gia"
    chmod 0755, bin/"giagui"

    # Aus Gatekeeper-Quarantäne entfernen
    system "xattr", "-d", "com.apple.quarantine", bin/"gia" rescue nil
    system "xattr", "-d", "com.apple.quarantine", bin/"giagui" rescue nil
  end

  test do
    # Einfacher Test, ob die Binaries ausführbar sind
    assert_match version.to_s, shell_output("#{bin}/gia --version")
  end
end
