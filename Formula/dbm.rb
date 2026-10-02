class Dbm < Formula
  desc "Save, search, annotate, archive, and trash items in your DoubleMemory library"
  homepage "https://doublememory.com"
  url "https://github.com/idealistspace/homebrew-tap/releases/download/dbm-1.1.0/dbm-1.1.0.zip"
  version "1.1.0"
  sha256 "56f2c24750d584159c4e02f9eb93ab7a72a8d204f93ffb817a9959a4178651f5"

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
