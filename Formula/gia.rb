class Gia < Formula
  desc "GIA - General Intelligence Assistant"
  homepage "https://github.com/mschnecke/gia"
  version "0.1.225"
  license "MIT"

  if Hardware::CPU.intel?
    url "https://github.com/mschnecke/gia/releases/download/v0.1.225/gia-macos-x86_64-v0.1.225.tar.gz"
    sha256 "825c17972f3d55fadc03b2f7b03f35cb2d091f85b921d377ff555051109ddca1"
  else
    url "https://github.com/mschnecke/gia/releases/download/v0.1.225/gia-macos-aarch64-v0.1.225.tar.gz"
    sha256 "4b465bd3abb2ddd93f50b61aa6298cee7632082457c913a885260b288a832af3"
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
