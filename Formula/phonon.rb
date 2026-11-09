class Phonon < Formula
  desc "Fast, local, open-source voice typing for macOS"
  homepage "https://phonon.sh"
  url "https://github.com/Infatoshi/phonon/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "f90834a7b8a571741a382032309f94bf10790219cbba038e9b302a90147b871e"
  license "GPL-3.0-only"

  depends_on "rust" => :build
  depends_on arch: :arm64
  depends_on macos: :sonoma
  depends_on "uv"

  def install
    ENV["PHONON_CODESIGN_IDENTITY"] = "-"
    system "./scripts/package-bar.sh"
    libexec.install "bar/dist/Phonon.app"

    (bin/"phonon").write <<~SH
      #!/bin/bash
      set -euo pipefail
      app="#{libexec}/Phonon.app"
      if [[ $# -eq 0 || "${1:-}" == "bar" ]]; then
        exec /usr/bin/open "$app"
      fi
      export PHONON_ROOT="$app/Contents/Resources"
      exec "$app/Contents/Helpers/phonon" "$@"
    SH
  end

  def caveats
    <<~EOS
      Run `phonon` to launch the native app. On first launch, Phonon downloads
      its open models (Parakeet and the Phonon refiner, about 4.9 GB) and asks
      for the macOS permissions needed for voice typing.

      This source build corrects on the MLX refiner. The cask's signed app also
      bundles the faster native Metal engine:
        brew install --cask infatoshi/tap/phonon
    EOS
  end

  test do
    assert_predicate libexec/"Phonon.app/Contents/MacOS/PhononBar", :executable?
    assert_predicate libexec/"Phonon.app/Contents/Helpers/phonon", :executable?
    assert_predicate libexec/"Phonon.app/Contents/Resources/sidecar/asr_server.py", :file?
    assert_match "phonon doctor", shell_output("#{bin}/phonon doctor")
  end
end
