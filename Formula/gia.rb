class Gia < Formula
  desc "GIA - General Intelligence Assistant"
  homepage "https://github.com/mschnecke/gia"
  version "0.1.224"
  license "MIT"

  if Hardware::CPU.intel?
    url "https://github.com/mschnecke/gia/releases/download/v0.1.224/gia-macos-x86_64-v0.1.224.tar.gz"
    sha256 "d75696c41971988764aa752ff469e2939afde2c6d11458ee0af6b5f8eb9abb1b"
  else
    url "https://github.com/mschnecke/gia/releases/download/v0.1.224/gia-macos-aarch64-v0.1.224.tar.gz"
    sha256 "4913f3fdbb2c70225894614c246459fd2563e80f02bcbe7d0adbf259a64ee5d5"
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

  def caveats
    <<~EOS
      Die Programme gia und giagui wurden installiert.

      Falls beim ersten Start eine Gatekeeper-Warnung erscheint,
      kannst du die Programme manuell freigeben mit:

        sudo xattr -d com.apple.quarantine #{bin}/gia
        sudo xattr -d com.apple.quarantine #{bin}/giagui
    EOS
  end

  test do
    # Einfacher Test, ob die Binaries ausführbar sind
    assert_match version.to_s, shell_output("#{bin}/gia --version")
  end
end
