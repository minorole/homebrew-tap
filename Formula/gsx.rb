class Gsx < Formula
  desc "Ghostty Session Manager - launch AI-ready dev environments"
  homepage "https://github.com/minorole/gsx"
  url "https://github.com/minorole/gsx/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "83c3a755f802bb5f8b6cb996eb0088e44709559850d563422cf124e5e69ce6e6"
  license "MIT"

  depends_on :macos

  def install
    # Install main script
    bin.install "bin/gsx"

    # Install version file (single source of truth)
    (share/"gsx").install "VERSION"

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
