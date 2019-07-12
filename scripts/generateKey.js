const Web3 = require('web3')
let web3 = new Web3('http://localhost:7545')

let privateKey = web3.utils.randomHex(16)
console.log(privateKey)

let publicKey = web3.eth.accounts.privateKeyToAccount(privateKey)
console.log(privateKey, publicKey.address)
