{ stdenv, lib, fetchurl }:

let

  common = { versionMajor, versionMinor, sha256 } @ args: stdenv.mkDerivation (rec {
    name = "apache-tomcat-${version}";
    version = "${versionMajor}.${versionMinor}";

    src = fetchurl {
      url = "mirror://apache/tomcat/tomcat-${versionMajor}/v${version}/bin/${name}.tar.gz";
      inherit sha256;
    };

    outputs = [ "out" "webapps" ];
    installPhase =
      ''
        mkdir $out
        mv * $out
        mkdir -p $webapps/webapps
        mv $out/webapps $webapps/
      '';

    meta = {
      homepage = https://tomcat.apache.org/;
      description = "An implementation of the Java Servlet and JavaServer Pages technologies";
      platforms = with lib.platforms; all;
      maintainers = with lib.maintainers; [ danbst ];
      license = [ lib.licenses.asl20 ];
    };
  });

in {
  tomcat7 = common {
    versionMajor = "7";
    versionMinor = "0.82";
    sha256 = "0vb7c5i50ral4rr39ss95k7cxnzd7fs21zd7f97d1f3qslzwl69g";
  };

  tomcat8 = common {
    versionMajor = "8";
    versionMinor = "0.47";
    sha256 = "0xv4v3i08rwzfmz7rkhglq5cbjgnfava8dw0i33vsp7dk162a4g4";
  };

  tomcat85 = common {
    versionMajor = "8";
    versionMinor = "5.96";
    sha256 = "11p809mix2rncjpppc8q4r2xagzh07f4niix0cyzz8jqbswcy1q3";
  };

  tomcat9 = common {
    versionMajor = "9";
    versionMinor = "0.2";
    sha256 = "0aaykzi0b2xsdmjp60ihcjzh1m95p0a79kn5l2v7vgbkyg449638";
  };
}
