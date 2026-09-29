class Dbm < Formula
  desc "Save, search, read, and annotate your DoubleMemory library"
  homepage "https://doublememory.com"
  url "https://github.com/idealistspace/homebrew-tap/releases/download/dbm-1.0.0/dbm-1.0.0.zip"
  version "1.0.0"
  sha256 "a8589b8bceaff32e03e476ae3b5199bffe8a1a0a6054f3110334a1f5402dd62d"

  depends_on macos: :sonoma

  def install
    # The provisioning profile that authorizes the app group lives in the bundle,
    # so the bundle is installed whole and only the executable is linked.
    (libexec/"dbm.app").install "Contents"
    bin.install_symlink libexec/"dbm.app/Contents/MacOS/dbm"
    # The completion scripts are part of the signed bundle, so they are linked
    # rather than moved: removing them would break the code signature.
    completions = libexec/"dbm.app/Contents/Resources/completions"
    bash_completion.install_symlink completions/"dbm.bash" => "dbm"
    zsh_completion.install_symlink completions/"_dbm"
    fish_completion.install_symlink completions/"dbm.fish"
  end

  def caveats
    <<~EOS
      dbm talks to the DoubleMemory app. Install it from the Mac App Store and
      open it once: https://doublememory.com
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dbm --version")
  end
end
