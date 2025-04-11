### Commands

`forge test` => test using local testnet (anvil)

`forge test --forl-url $SEPOLIA_RPC_URL` => test while simulating in sepolia testnet

`-vv -vvv` => verbose

`forge coverage` => shows the coverage of tests for each contract (very useful)

`chisel` => code solidity in console

`https://www.evm.codes/` => gas prices per instruction

### Naming Conventions

- Add i\_ for immutable variables: immutable i_owner
- Add s\_ for storage variables: s_funders;
  => The goal is to keep track of where the variables are saved in order to optimize gas
