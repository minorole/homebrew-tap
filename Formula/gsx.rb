class Gsx < Formula
  desc "Ghostty Session Manager - launch AI-ready dev environments"
  homepage "https://github.com/minorole/gsx"
  url "https://github.com/minorole/gsx/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0edbdad8bdfd03879d20d3d195661215148da907f5b6f82e0320f3e9fb9835ed"
  license "MIT"

  depends_on :macos

  def install
    # Install main script
    bin.install "bin/gsx"

    # Install library files
    (share/"gsx/lib").install Dir["lib/*.zsh"]

    # Install AppleScript layouts
    (share/"gsx/scripts").install Dir["scripts/*.applescript"]

    # Patch the script to use installed paths
    inreplace bin/"gsx", 'GSX_ROOT="${0:A:h:h}"', "GSX_ROOT=\"#{share}/gsx\""
  end

  def caveats
    <<~EOS
      gsx requires Accessibility permission to control Ghostty windows.

      Grant permission in:
        System Settings → Privacy & Security → Accessibility

      Add your terminal app to the list and ensure it's enabled.

      Run 'gsx setup' to configure your first session.
    EOS
  end

  test do
    assert_match "gsx v#{version}", shell_output("#{bin}/gsx version")
  end
end
