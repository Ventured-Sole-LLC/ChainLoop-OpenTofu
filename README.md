# ChainLoop-Infra

Infrastructure for ChainLoop, an event-driven chain-of-custody platform for time-sensitive medical logistics, provisioned with OpenTofu.

See the [ChainLoop](https://github.com/Ventured-Sole-LLC/ChainLoop) repo for architecture decision records and application source.

## Structure

- `environments/dev/`: dev environment infrastructure
- `modules/`: reusable modules, populated once a real repeated pattern emerges across at least two consumers, not built speculatively
- `docs/architecture/diagrams/`: supporting diagrams referenced from ADRs in the ChainLoop repo