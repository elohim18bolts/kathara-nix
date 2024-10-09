{ pkgs ? import <nixpkgs> { }
, fetchPypi ? pkgs.fetchPypi
, python3Packages ? pkgs.python311Packages
}:
python3Packages.buildPythonPackage rec{
  pname = "appscript";
  version = "1.2.5";
  format = "setuptools";
  src = fetchPypi {
    inherit pname version;
    sha256 = "54b77b0fa5b40482b32413f3634b7a5125a21495d19c7867174fb293cbb50d0d";
  };
  nativeBuildInputs = with python3Packages; [ setuptools wheel ];
  buildInputs = [
    pkgs.darwin.apple_sdk.frameworks.Carbon
    pkgs.darwin.apple_sdk.frameworks.CoreServices
    pkgs.darwin.apple_sdk.frameworks.CoreFoundation
  ];
  propagatedBuildInputs = [
    python3Packages.lxml

  ];

  nativeCheckInputs = with python3Packages;
    [ unittestCheckHook ];
}
