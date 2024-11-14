{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools
}:

buildPythonPackage rec {
  pname = "crawl4ai";
  version = "v.3.72";
  pyproject = false;

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

  #pythonImportsCheck = [ "crewai" ];

  meta = {
    description = "Open-source LLM Friendly Web Crawler & Scrapper";
    homepage = "https://github.com/unclecode/crawl4ai";
    changelog = "https://github.com/unclecode/crawl4ai/releases/tag/${src.version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [];
    mainProgram = "crawl4ai";
  };
}
