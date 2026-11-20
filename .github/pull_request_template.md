## Change

<!-- What changes and why. Link the issue / ticket. -->

Ticket:

## Type

- [ ] Feature
- [ ] Bug fix
- [ ] Security fix
- [ ] Dependency update
- [ ] Configuration / infrastructure
- [ ] Pipeline

## Risk and rollback

- Risk (low / medium / high), and what could break:
- Rollback: re-point the environment tag to the previous digest, or revert this PR.
- Database migration included: yes / no. If yes, is it backward compatible with the running version?

## Evidence

- [ ] Pipeline green (secret scan, SAST, tests, coverage, SCA, image scan)
- [ ] New or changed behaviour covered by tests
- [ ] Contract change (REST, Avro, gRPC) is backward compatible, or versioned
- [ ] No secrets, tokens or personal data in code, config, logs or test data
