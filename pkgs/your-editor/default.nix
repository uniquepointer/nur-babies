{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "your-editor";
  version = "1204";

  src = fetchFromGitHub {
    owner = "kammerdienerb";
    repo = "yed";
    rev = "a5ef45a23dbd88600abe3f52e1cb50fc082f04f2";
    sha256 = "XhZ0J6a1fhTCilsPsrrPbxNOPxmAWFgRbzMAnq81pBs=";
  };

  installPhase = ''
    runHook preInstall
    patchShebangs install.sh
    ./install.sh -p $out
    runHook postInstall
  '';

  meta = with lib; {
    description = "Your-editor (yed) is a small and simple terminal editor core that is meant to be extended through a powerful plugin architecture";
    homepage = "https://your-editor.org/";
    license = with licenses; [ mit ];
    platforms = platforms.linux;
    maintainers = with maintainers; [ uniquepointer ];
    mainProgram = "yed";
  };
}
