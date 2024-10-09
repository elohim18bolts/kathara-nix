{ pkgs
, lib
, fetchFromGitHub
, python3Packages
}:
let
  appscript = pkgs.callPackage ./appscript.nix { inherit python3Packages; };
in
python3Packages.buildPythonPackage {
  pname = "kathara";
  version = "0.1.0";
  format = "pyproject";
  src = fetchFromGitHub {
    owner = "KatharaFramework";
    repo = "Kathara";
    rev = "027865ac6494624352f58f61949c3b463a66ad39";
    sha256 = "4ZrOawlj27tTCpHsjiYWSBp5LoPCWeX0qcY4xJuKoao=";
  };
  patches = [ ./patch.patch ];
  nativeBuildInputs = with python3Packages; [ setuptools wheel ];

  propagatedBuildInputs = with python3Packages;
    [
      binaryornot
      docker
      kubernetes
      requests
      unicode-slugify
      deepdiff
      pyroute2
      rich
      fs
      chardet
    ] ++ lib.optionals stdenv.isDarwin [ (python3Packages.libtmux) appscript ] #appscript ]
    ++ lib.optionals stdenv.isLinux [ python3Packages.libtmux ];

  nativeCheckInputs = with python3Packages;
    [ pytestCheckHook ];
}
