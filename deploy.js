const HDWalletProvider = require("truffle-hdwallet-provider")
const Web3 = require("web3")
const { interface, bytecode } = require("./compile")

const provider = new HDWalletProvider(
  'nation fan vessel also record resemble mean liberty ball search zone snap',
  'https://rinkeby.infura.io/v3/0cf245105000419ea764b8cd0cccc513'
)

const web3 = new Web3(provider)

const deploy = async () => {
  const accounts = await web3.eth.getAccounts()
  console.log('Attemp to deply form account', accounts[0]);

  const result = await web3.eth.Contract(JSON.parse(interface))
    .deploy({ data: bytecode, arguments: ['test']})
    .send({ gas: 1000000, from: accounts[0] })

  console.log('Contract deployed to:', result.options.address)
}

deploy()