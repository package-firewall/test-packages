# package-firewall-test

A harmless package from [Package Firewall](https://github.com/package-firewall).
It does nothing when installed or imported.

Every version is on the Package Firewall block list on purpose, so with
Package Firewall running `pip install package-firewall-test` should be
blocked, and should succeed again once you allow it in the local allow list.
