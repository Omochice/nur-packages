# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  disable-checkout-persist-credentials = {
    pname = "disable-checkout-persist-credentials";
    version = "v0.1.2";
    src = fetchFromGitHub {
      owner = "suzuki-shunsuke";
      repo = "disable-checkout-persist-credentials";
      rev = "v0.1.2";
      fetchSubmodules = false;
      sha256 = "sha256-X1qsOhp7L8jNxuJE/MxowkhUZ0YvVjoljvVlG0JaTQg=";
    };
  };
  duckgo = {
    pname = "duckgo";
    version = "v0.1.1";
    src = fetchFromGitHub {
      owner = "sheepla";
      repo = "duckgo";
      rev = "v0.1.1";
      fetchSubmodules = false;
      sha256 = "sha256-+wJexVAKTqEOTyV+PcNcUe5r9Q4MpGx9EnuxiQHq0G0=";
    };
  };
  firge = {
    pname = "firge";
    version = "v0.3.0";
    src = fetchurl {
      url = "https://github.com/yuru7/Firge/releases/download/v0.3.0/Firge_v0.3.0.zip";
      sha256 = "sha256-yYb2IQAKZZgGTH4geDIu0CBAr094BNJYAz35SbNbBSc=";
    };
  };
  firge-nerd = {
    pname = "firge-nerd";
    version = "v0.3.0";
    src = fetchurl {
      url = "https://github.com/yuru7/Firge/releases/download/v0.3.0/FirgeNerd_v0.3.0.zip";
      sha256 = "sha256-VM12N4+8UCX0LUQdlcpuwdPsxCcOYQdViED+18BM/k8=";
    };
  };
  ghalint = {
    pname = "ghalint";
    version = "v1.2.3";
    src = fetchFromGitHub {
      owner = "suzuki-shunsuke";
      repo = "ghalint";
      rev = "v1.2.3";
      fetchSubmodules = false;
      sha256 = "sha256-bwHKbuITR+5DvuK1XLFyD/JMbW/OvUbgSyhiKSxqiAs=";
    };
  };
  ghatm = {
    pname = "ghatm";
    version = "v0.3.4";
    src = fetchFromGitHub {
      owner = "suzuki-shunsuke";
      repo = "ghatm";
      rev = "v0.3.4";
      fetchSubmodules = false;
      sha256 = "sha256-0zHpiZXogea0bCEub0soSsnFYSVJCGDM5nJhfUPsAqk=";
    };
  };
  gitlab-ci-verify = {
    pname = "gitlab-ci-verify";
    version = "v1.2.10";
    src = fetchFromGitHub {
      owner = "timo-reymann";
      repo = "gitlab-ci-verify";
      rev = "v1.2.10";
      fetchSubmodules = false;
      sha256 = "sha256-2kCkoIWYrlyRVvJQ6LA+n33CZXVKG60n0gym2ijpq9o=";
    };
  };
  octocov = {
    pname = "octocov";
    version = "v0.64.0";
    src = fetchFromGitHub {
      owner = "k1LoW";
      repo = "octocov";
      rev = "v0.64.0";
      fetchSubmodules = false;
      sha256 = "sha256-JxScV5ihYRBMtbBaAvTE7OzpvynyK5IkaidbnQvhmRg=";
    };
  };
  pinact = {
    pname = "pinact";
    version = "v1.2.2";
    src = fetchFromGitHub {
      owner = "suzuki-shunsuke";
      repo = "pinact";
      rev = "v1.2.2";
      fetchSubmodules = false;
      sha256 = "sha256-p2kixWkJgQYanbsShMtDWoY6AT0WrTVLI+Borzm8XLA=";
    };
  };
  sort-package-json = {
    pname = "sort-package-json";
    version = "v3.0.0";
    src = fetchFromGitHub {
      owner = "keithamus";
      repo = "sort-package-json";
      rev = "v3.0.0";
      fetchSubmodules = false;
      sha256 = "sha256-mEavws9itWkV2uF2w3bZRGHgR/AGvTfdhSUKAdcgfWs=";
    };
  };
}
