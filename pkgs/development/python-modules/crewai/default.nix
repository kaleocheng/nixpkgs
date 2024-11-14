{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools
}:

buildPythonPackage rec {
  pname = "crewai";
  version = "0.80.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-10iq7c9c832ssl2xrvf62xf7znfvqzax6sq8ppsibq6wpb8dlnj5";
  };

  pythonRelaxDeps = [
  ];

  build-system = [ ];

  dependencies = [
  ];

  nativeCheckInputs = [
    setuptools
  ];

  pythonImportsCheck = [ "crewai" ];

  meta = {
    description = "Framework for orchestrating role-playing, autonomous AI agents";
    homepage = "https://crewai.com";
    changelog = "https://github.com/crewAIInc/crewAI/releases/tag/${src.version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [];
    mainProgram = "crewai";
  };
}
