{
  source,
  lib,
  stdenvNoCC,
  makeWrapper,
  nodejs_latest,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  inherit (source) pname version src;

  nativeBuildInputs = [ makeWrapper ];

  # A patch fails when upstream rewrites these instructions, which is when they need review.
  patches = [ ./patch/skill-without-npx.patch ];

  # A patch cannot hold a store path, and its context in minified bundles would break on every release.
  postPatch = ''
    bin="$out/bin/modern-web-guidance"
    cd skills/modern-web-guidance

    substituteInPlace SKILL.md \
      --replace-fail "npx -y modern-web-guidance@latest" "$bin"
    substituteInPlace modern-web.mjs \
      --replace-fail "npx modern-web-guidance@latest" "$bin"
    substituteInPlace legacy-scan.mjs \
      --replace-fail "npx modern-web-guidance retrieve" "$bin retrieve"
    grep -rlF "npx -y modern-web-guidance@latest" guides | while read -r guide; do
      substituteInPlace "$guide" --replace-fail "npx -y modern-web-guidance@latest" "$bin"
    done

    # Upstream may spell the command differently, which would leave the skill downloading from npm.
    if grep -rn 'npx' SKILL.md guides || grep -n 'npx modern-web-guidance' *.mjs; then
      echo "npx is still referenced after patching" >&2
      exit 1
    fi

    cd -
  '';

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    root=$out/lib/node_modules/modern-web-guidance
    mkdir -p $root/skills
    cp package.json LICENSE THIRD_PARTY_NOTICES $root/
    cp -r skills/modern-web-guidance $root/skills/

    makeWrapper ${lib.getExe nodejs_latest} $out/bin/modern-web-guidance \
      --add-flags $root/skills/modern-web-guidance/modern-web.mjs \
      --set DISABLE_TELEMETRY 1

    install -Dm644 skills/modern-web-guidance/SKILL.md -t $out/share/modern-web-guidance/skill

    runHook postInstall
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    runHook preInstallCheck

    $out/bin/modern-web-guidance search "light dismiss dialog" \
      --skill-version "$(< skills/modern-web-guidance/skill-version.txt)" \
      | grep -q '"id":"light-dismiss-a-dialog"'
    # Unless stdout is a file, a long guide is saved to a temporary file and only its path is printed.
    $out/bin/modern-web-guidance retrieve slider > guide.md
    grep -q "$out/bin/modern-web-guidance retrieve" guide.md
    if grep -n 'npx' guide.md; then
      echo "retrieve still prints npx" >&2
      exit 1
    fi

    runHook postInstallCheck
  '';

  meta = {
    description = "Agent skill and CLI that serve modern web development best practices";
    homepage = "https://developer.chrome.com/docs/modern-web-guidance";
    downloadPage = "https://www.npmjs.com/package/modern-web-guidance/v/${finalAttrs.version}";
    license = lib.licenses.asl20;
    mainProgram = "modern-web-guidance";
    platforms = lib.platforms.all;
  };
})
