class Gpane < Formula
  desc "Ghostty Session Manager - launch AI-ready dev environments"
  homepage "https://github.com/minorole/gsx"
  url "https://github.com/minorole/gsx/archive/refs/tags/v0.2.6.tar.gz"
  sha256 "f3e5b41e33dcb331a6c0f982c57fe79f563b534e3495b1826c01c2885aca3116"
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
      gpane requires Accessibility permission to control Ghostty windows.

      Grant permission in:
        System Settings → Privacy & Security → Accessibility

      Add your terminal app to the list and ensure it's enabled.

      Run 'gpane setup' to configure your first session.

      Note: gpane was formerly known as 'gsx'. The 'gsx' command still
      works as a compatibility wrapper.
    EOS
  end

  test do
    assert_match "gpane v#{version}", shell_output("#{bin}/gpane version")
  end
end
