{pythonPackages, fetchFromGitHub, buildPythonApplication, i3ipc}:

buildPythonApplication rec {
  pname = "swallow";
  version = "1.1.1";

  rev = "7a9faed693b0da7df762a095fed512eca8c6414c";
  src = fetchFromGitHub {
    owner  = "jamesofarrell";
    repo   = "i3-swallow";
    rev    = "7a9faed";
    sha256 = "bUWmH606sGsP+j45nZg60j+eKI1zhcSQ+v7VqONmCbs=";
  };

   propagatedBuildInputs = [
    i3ipc
  ];
   configurePhase = ''
    echo 'nothing to configure'
  '';
   setuptoolsCheckPhase = "echo 'nothing to check'";

  buildPhase = ''
    mv swallow.py swallow
    chmod +x swallow
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv swallow $out/bin
  '';
}
