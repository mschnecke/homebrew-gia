class Gia < Formula
  desc "GIA - General Intelligence Assistant"
  homepage "https://github.com/mschnecke/gia"
  version "1.0.0"
  license "MIT" # Passe die Lizenz an

  if Hardware::CPU.intel?
    url "https://github.com/mschnecke/gia/releases/download/v#{version}/gia-macos-x86_64-v#{version}.tar.gz"
    sha256 "INTEL_SHA256_HIER" # Mit `shasum -a 256 datei.tar.gz` berechnen
  else
    url "https://github.com/mschnecke/gia/releases/download/v#{version}/gia-macos-aarch64-v#{version}.tar.gz"
    sha256 "ARM_SHA256_HIER"
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
