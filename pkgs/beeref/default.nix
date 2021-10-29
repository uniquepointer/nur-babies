{ lib, fetchFromGitHub, python3 }:

let
  rectangle-packer = python3.pkgs.buildPythonApplication rec {
    pname = "rectangle-packer";
    version = "2.0.1";
    src = python3.fetchPypi {
      inherit pname version;
      sha256 = "229f81c57791a41d65e399fc06bf0848bab550a9dfd5ed66df18ce5f05e73d5c";
    };
    doCheck = false;
  };
in
python3.pkgs.buildPythonApplication rec {
  pname = "beeref";
  version = "0.3.0-dev";

  src = fetchFromGitHub {
    owner = "rbreu";
    repo = "beeref";
    rev = "cf55d1a5e304da707f2cc9a9ca793ee24503a0bc";
    sha256 = "sha256-Qx1dV5yHK6SxCEh+vXfeeBR8qU7GdFoH9n4dNl4PVbw=";
  };


  propagatedBuildInputs = with python3.pkgs;
    [
      flake8
      yamllint
      coverage
      httpretty
      pytest
      pytest-qt
      pyqt5
      markdown2
      maestral
      exif
    ];
  buildPhase = ''
    python setup.py build
  '';
  installPhase = ''
    mkdir -p $out
    python setup.py install --prefix="$out"
  '';

  meta = with lib; {
    description = "A Simple Reference Image Viewer.";
    homepage = "https://beeref.org/";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ uniquepointer ];
    platforms = platforms.linux;
    broken = true;
  };
}
