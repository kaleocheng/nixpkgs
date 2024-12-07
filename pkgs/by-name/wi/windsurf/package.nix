{ stdenv, lib, fetchurl, dpkg, makeWrapper, fakeroot, patchelf, glib, nss }:

stdenv.mkDerivation rec {
  pname = "windsurf";
  version = "1.0.7";

  src = fetchurl {
    url = "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt/pool/main/w/windsurf/Windsurf-linux-x64-${version}.deb";
    hash = "sha256-Val4aheRehK4UkxfVl9DEx1P2BN54fMzt56OHzzVfwI=";
  };

  nativeBuildInputs = [ dpkg makeWrapper fakeroot patchelf ];
  buildInputs = [ glib nss ];

  installPhase = ''
    mkdir -p $out/bin
    fakeroot dpkg-deb -x $src $out

    # Patch the windsurf executable
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
             --set-rpath $out/usr/share/windsurf/lib:$out/usr/share/windsurf:$out/lib:${glib.out}/lib:${nss.out}/lib \
             $out/usr/share/windsurf/windsurf

    # Create a wrapper for the windsurf executable
    makeWrapper $out/usr/share/windsurf/windsurf $out/bin/windsurf \
      --set PATH $out/usr/share/windsurf/bin:$PATH \
      --set LD_LIBRARY_PATH ${glib.out}/lib:${nss.out}/lib
  '';

  meta = with lib; {
    description = "Windsurf application";
    homepage = "https://windsurf-stable.codeiumdata.com";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
