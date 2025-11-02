class Gia < Formula
  desc "GIA - General Intelligence Assistant"
  homepage "https://github.com/mschnecke/gia"
  version "0.1.198"
  license "MIT"

  if Hardware::CPU.intel?
    url "https://github.com/mschnecke/gia/releases/download/v0.1.198/gia-macos-x86_64-v0.1.198.tar.gz"
    sha256 "774d4ea2c3531586c4c17faa1a216a19cf7bcb127be6251ef1c5b08a592df5f4"
  else
    url "https://github.com/mschnecke/gia/releases/download/v0.1.198/gia-macos-aarch64-v0.1.198.tar.gz"
    sha256 "0d1d3eb034c5464c63bf1ce2f9b04ba7a17e909e809ec6e4eb68149a065796ac"
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
