let QBAC = artifacts.require('./QBAC.sol')

contract('QBAC', function (accounts) {
  let qbac;

  before(async function () {
    qbac = await QBAC.deployed()
  })

  it('allows someone to be placed in the qbac', async function () {
    let privateKey = web3.utils.randomHex(16)
    let tempAddress = web3.eth.accounts.privateKeyToAccount(privateKey)
    await qbac.preapprove(tempAddress)

    web3.eth.accounts.add(privateKey)
    await qbac.whitelist(accounts[0], 'Greg', {from: tempAddress})

    assert.equal(supportedRolesCount.toNumber(), 4, 'Add roles to rbac')
  })
})
