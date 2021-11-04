{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "your-editor";
  version = "1205";

  src = fetchFromGitHub {
    owner = "kammerdienerb";
    repo = "yed";
    rev = "b332b7e122ac156fde253be0fbdc16d2b86cb5c3";
    sha256 = "xSf864BsUoUiii5A1Khv2BwoZX7grBlKCtbAhoqu+jg=";
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
