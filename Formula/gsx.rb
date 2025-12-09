# gsx has been renamed to gpane (to avoid conflict with Ghostscript)
# This formula redirects to gpane for backwards compatibility

class Gsx < Formula
  desc "Ghostty Session Manager (renamed to gpane)"
  homepage "https://github.com/minorole/gsx"

  deprecate! date: "2025-12-08", because: "has been renamed to gpane"

  # Point to the same release as gpane
  url "https://github.com/minorole/gsx/archive/refs/tags/v0.2.5.tar.gz"
  sha256 "8bd41929c41f80c4bc8b81fb2e820f349888fd6af2903ffe715671526169afeb"
  license "MIT"

  depends_on :macos

  def install
    # Install main script (gpane)
    bin.install "bin/gpane"

    # Install compatibility wrapper (gsx)
    bin.install "bin/gsx"

    # Install version file
    (share/"gpane").install "VERSION"

    # Install library files
    (share/"gpane/lib").install Dir["lib/*.zsh"]

    # Install AppleScript layouts
    (share/"gpane/scripts").install Dir["scripts/*.applescript"]

    # Patch gpane to use installed paths
    inreplace bin/"gpane", 'GPANE_ROOT="${0:A:h:h}"', "GPANE_ROOT=\"#{share}/gpane\""
  end

  def caveats
    <<~EOS
      gsx has been RENAMED to gpane (to avoid conflict with Ghostscript).

      Please use 'gpane' instead of 'gsx':
        brew uninstall gsx
        brew install gpane

      Both commands work, but 'gsx' shows a daily reminder.

      Run 'gpane setup' to configure your first session.
    EOS
  end

  test do
    assert_match "gpane v#{version}", shell_output("#{bin}/gpane version")
  end
end
