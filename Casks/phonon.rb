cask "phonon" do
  version "1.1.0"
  sha256 "e3df1e819de8ada9a711d96fda435ee86fb3ad44bf92faba327cf5263e58c259"

  url "https://github.com/Infatoshi/phonon/releases/download/v#{version}/Phonon.dmg"
  name "Phonon"
  desc "Fast, local, open-source voice typing"
  homepage "https://phonon.sh/"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Phonon.app"
  binary "#{appdir}/Phonon.app/Contents/Helpers/phonon"
end
