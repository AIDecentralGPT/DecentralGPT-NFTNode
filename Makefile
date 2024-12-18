compile:
	npx hardhat compile

deploy-dbc-testnet:
	npx hardhat run scripts/deploy.ts --network dbcTestnet

upgrade-dbc-testnet:
	DEBUG='@openzeppelin:*' npx hardhat run scripts/upgrade.ts --network dbcTestnet

verify-dbc-testnet:
	source .env && npx hardhat verify --network dbcTestnet  $PROXY_CONTRACT

deploy-dbc-mainnet:
	npx hardhat run scripts/deploy.ts --network dbcMainnet

upgrade-dbc-mainnet:
	DEBUG='@openzeppelin:*' npx hardhat run scripts/upgrade.ts --network dbcMainnet

verify-dbc-mainnet:
	source .env && npx hardhat verify --network dbcMainnet  $PROXY_CONTRACT

deploy-dbc-testnet:
	npx hardhat run scripts/deploy.ts --network dbcTestnet

upgrade-dbc-testnet:
	DEBUG='@openzeppelin:*' npx hardhat run scripts/upgrade.ts --network dbcTestnet

verify-dbc-testnet:
	source .env && npx hardhat verify --network dbcTestnet  $PROXY_CONTRACT












