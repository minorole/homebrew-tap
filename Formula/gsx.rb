# gsx has been renamed to gpane (to avoid conflict with Ghostscript)
# This formula redirects to gpane for backwards compatibility

class Gsx < Formula
  desc "Ghostty Session Manager (renamed to gpane)"
  homepage "https://github.com/minorole/gsx"

  deprecate! date: "2025-12-08", because: "has been renamed to gpane"

  # Point to the same release as gpane
  url "https://github.com/minorole/gsx/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "9f5ef35dcf230789f7f1253779556aedd73ae2f1906b9adcab191ece9367c607"
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
