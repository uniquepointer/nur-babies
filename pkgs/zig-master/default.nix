{ stdenv, fetchurl, lib }:

stdenv.mkDerivation rec {
  pname = "zig-master";
  version = "0.9.0-dev.1444+e2a2e6c14";

  src = fetchurl {
    url =
      "https://ziglang.org/builds/zig-linux-x86_64-${version}.tar.xz";
    sha256 =
      "sha256-c9a901c2df0661eede242a0860cddc30bbdb34d33f329ddae3e5cbdaed27306c";
  };

  installPhase = ''
    install -D zig "$out/bin/zig"
    install -D LICENSE "$out/usr/share/licenses/zig/LICENSE"
    cp -r lib "$out/lib"
    install -d "$out/usr/share/doc"
    cp -r docs "$out/usr/share/doc/zig"
  '';

  meta = with lib; {
    description =
      "General-purpose programming language and toolchain for maintaining robust, optimal, and reusable software.";
    homepage = "https://github.com/ziglang/zig";
    maintainers = with maintainers; [ uniquepointer ];
    platforms = platforms.linux;
  };
}
