cask "phonon" do
  version "1.0.2"
  sha256 "cf3369f26216bf31538a2e3ce6fccd395a3b9d296cdcceac44c562d7bc1b383d"

  url "https://github.com/Infatoshi/phonon/releases/download/v#{version}/Phonon.dmg"
  name "Phonon"
  desc "Fast, local, open-source voice typing"
  homepage "https://phonon.sh/"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Phonon.app"
  binary "#{appdir}/Phonon.app/Contents/Helpers/phonon"
end
