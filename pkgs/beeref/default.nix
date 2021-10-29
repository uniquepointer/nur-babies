{ stdenv, autoPatchelfHook, fetchurl, lib }:

stdenv.mkDerivation rec {
  pname = "beeref";
  version = "0.2.0";

  src = fetchurl {
    url = "https://github.com/rbreu/beeref/releases/download/v${version}/BeeRef-${version}-linux";
    sha256 = "sha256-jpjf07l4NkmAXgZyOLP03wDB2iSwErlS5EdXUQzyQdI=";
  };
  nativeBuildInputs = [
    autoPatchelfHook
  ];

  phases = ["installPhase" "patchPhase" "postFixup"];

  installPhase = ''
    cp $src beeref
    install -m755 -D "beeref" "$out/bin/beeref"
  '';

  postFixup = ''
    patchelf "$out/bin/beeref"
  '';

  meta = with lib; {
    description = "A Simple Reference Image Viewer.";
    homepage = "https://beeref.org/";
    maintainers = with maintainers; [ uniquepointer ];
    platforms = platforms.linux;
    broken = true;
  };
}
