{ lib, fetchFromGitHub, python3, python3Packages }:

let
  rectangle-packer = python3.pkgs.buildPythonPackage rec {
    pname = "rectangle-packer";
    version = "2.0.1";
    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-3Y5wGE0q+KGV1WjgwsPMGX8MlMKkd0dUEeXql4xnsn0=";
    };
    doCheck = false;
  nativeBuildInputs = [ python3Packages.cython ];
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
      pyqt6
      markdown2
      maestral
      exif
      rectangle-packer
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
  };
}
