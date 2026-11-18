# Security policy

## Supported versions

The published site, the current `main` branch, and the latest release tag are supported. Older tags
receive no fixes.

## Reporting a vulnerability

Do not open a public issue for a security problem. Use GitHub private vulnerability reporting:

<https://github.com/nferdazel/nim-id/security/advisories/new> (the repository's **Security** tab, then
**Report a vulnerability**). That channel is enabled on this repository and is private between you
and the maintainer.

A useful report includes:

- what is affected: the site, a CI workflow, the deploy script under `ops/`, or a repository setting;
- what you did and what happened, with the smallest reproduction;
- the impact you believe it has, and any suggested fix.

Do not include real credentials, personal data or a host dump.

## Scope

In scope:

- a committed secret, token or credential anywhere in the repository or its history;
- a workflow in `.github/workflows` that could be made to execute code from a pull request, a fork,
  or an untrusted input;
- `ops/scripts/deploy-static.sh` and `ops/scripts/setup-vps.sh`, as written here;
- content that is not what the repository claims to ship, such as a PDF built from a different
  source than the site;
- anything that would let a stranger publish to the site.

Out of scope:

- a factual error or a typo in a chapter: that is an errata issue, not a security report;
- the host itself: firewall, podman, systemd, Caddy and TLS;
- the VPS provider and Cloudflare;
- the content of an example program: the examples run on the reader's machine with no privileges, so
  a chapter that teaches something unwise is an editorial problem, not a vulnerability.

## What happens next

Single maintainer, no formal response deadline, no bug bounty. A confirmed report is fixed on `main`;
if the fix changes the site, the next deploy publishes it. A leaked credential is revoked first and
the history is dealt with after the revocation, never before.

## Handling

The repository is public and its whole history is public, so a secret committed once must be treated
as leaked even if the commit is later removed. `gitleaks` runs in CI on every push and pull request to
catch this before it lands.
