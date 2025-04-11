`forge --init`
`anvil`

### Casting

`cast --to-base 0x0000000000000000000000000000000000000000000000000000000000000309 dec`

### Deploying

`forge script script/DeploySimpleStorage.s.sol --rpc-url $RPC_URL --broadcast --account TestAnvil`

### Transactions

**Send Transaction**

`cast send 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0 "store(uint256)" 123 --rpc-url $RPC-URL --account TestAnvil`

**Call Transaction**

`cast call 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0 "retrieve()" --rpc-url $RPC_URL --account TestAnvil`

`foundryup` => vanilla foundry
`foundryup-zksync` => zksync foundry
