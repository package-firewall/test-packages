# Package Firewall test packages

Harmless packages Package Firewall publishes for itself:

| Registry | Package | Purpose |
| --- | --- | --- |
| npm | [`@package-firewall/test`](https://www.npmjs.com/package/@package-firewall/test) | On the block list at every version |
| PyPI | [`package-firewall-test`](https://pypi.org/project/package-firewall-test/) | On the block list at every version |
| PyPI | [`package-firewall`](https://pypi.org/project/package-firewall/) | Reserves the name; empty placeholder |

None of them do anything, and none have install scripts. The two test
packages are in `entries/test-fixture.json` in
[package-firewall/block-list](https://github.com/package-firewall/block-list),
so every published block list blocks them. That gives a real package to check
blocking end to end and to test local allow rules against:

```sh
npm install @package-firewall/test     # blocked
pip install package-firewall-test      # blocked
# allow it in Package Firewall, then the same commands succeed
```

A newly published version is also held back by the 48-hour new-version rule
until it is two days old.

## Releasing

All three packages share the version in `VERSION`; `scripts/check-versions.sh`
fails CI if any package disagrees. To release, bump `VERSION`,
`npm/package.json` and both `pypi/*/pyproject.toml`, merge, then either push a
`vX.Y.Z` tag or run **Publish** from the Actions tab (it can publish npm and
PyPI separately). Versions already on a registry are skipped.

Publishing uses trusted publishing (OIDC), so the repo holds no tokens. It
needs GitHub-hosted runners, and environments named `npm` and `pypi`.

## One-time setup

1. **npm:** create the `package-firewall` organization on npmjs.com. Trusted
   publishing can only be configured for a package that already exists, so
   publish 0.0.1 once by hand (`cd npm && npm publish --access public`), then
   connect this workflow:
   `npm trust github @package-firewall/test --repo package-firewall/test-packages --file publish.yml --env npm --allow-publish`
   (or Package settings → Trusted publishing on npmjs.com).
2. **PyPI:** on pypi.org → Your account → Publishing, add a pending publisher
   for `package-firewall` and for `package-firewall-test`: owner
   `package-firewall`, repository `test-packages`, workflow `publish.yml`,
   environment `pypi`. The first workflow run creates both projects.
3. **GitHub:** the `npm` and `pypi` environments are created on the first
   run; add required reviewers to them if publishing should need an approval.
