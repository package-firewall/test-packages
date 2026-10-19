# @package-firewall/test

A harmless test package for [Package Firewall](https://github.com/package-firewall).
It does nothing and has no install scripts.

Every version is on the Package Firewall block list on purpose, so with
Package Firewall running `npm install @package-firewall/test` should be
blocked, and should succeed again once you allow it in the local allow list.
