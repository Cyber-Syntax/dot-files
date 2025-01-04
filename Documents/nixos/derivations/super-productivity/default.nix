{
  stdenv,
  lib,
  fetchurl,
  appimageTools,
  makeWrapper,
  electron,
}:

stdenv.mkDerivation rec {
  pname = "super-productivity";
  version = "11.0.0";

  src = fetchurl {

    # 11.0.0
    # "name": "superProductivity-x86_64.AppImage",
    #"browser_download_url": "https://github.com/johannesjo/super-productivity/releases/download/v11.0.0/superProductivity-x86_64.AppImage"
    #https://github.com/johannesjo/super-productivity/releases/download/v11.0.0/superProductivity-x86_64.AppImage

    ## OLD
    #"name": "superProductivity-10.0.11.AppImage",
    # "browser_download_url": "https://github.com/johannesjo/super-productivity/releases/download/v10.0.11/superProductivity-10.0.11.AppImage"
    url = "https://github.com/johannesjo/super-productivity/releases/download/v${version}/superproductivity-x86_64.appimage";
    sha256 = "";
    name = "${pname}-x86_64.AppImage";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/${pname} $out/share/applications

    cp -a ${appimageContents}/{locales,resources} $out/share/${pname}
    cp -a ${appimageContents}/superproductivity.desktop $out/share/applications/${pname}.desktop
    cp -a ${appimageContents}/usr/share/icons $out/share

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'

    runHook postInstall
  '';

  postFixup = ''
    makeWrapper ${electron}/bin/electron $out/bin/${pname} \
      --add-flags $out/share/${pname}/resources/app.asar
  '';

  meta = with lib; {
    description = "To Do List / Time Tracker with Jira Integration";
    homepage = "https://super-productivity.com";
    license = licenses.mit;
    platforms = [ "x86_64" ];
    maintainers = with maintainers; [ offline ];
    mainProgram = "super-productivity";
  };
}
