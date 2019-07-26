let TestQBAC = artifacts.require('./test-contracts/TestQBAC.sol')
let QBAC = artifacts.require('./QBAC.sol')
let TestRBAC = artifacts.require('./TestRBAC.sol')
let TestToken = artifacts.require('./TestToken.sol')
const Web3 = require('web3')
const Web3Eth = require('web3-eth')
const web3 = new Web3(Web3Eth.givenProvider)
const { BN } = require('openzeppelin-test-helpers')

contract('QBAC', function([admin, addressToWhitelist]) {
  let rbac
  let qbac
  let token

  before(async function() {
    rbac = await TestRBAC.new()
    await rbac.addUserRole('qbac_admin')
    await rbac.addUserRole('user')
    await rbac.setUserRoles(admin, 2 | 1)
    assert(await rbac.hasRole(admin, 'qbac_admin'))

    token = await TestToken.new()

    qbac = await TestQBAC.new(rbac.address, token.address)
    await rbac.newUser(qbac.address, 'QBAC', 1)
    // allow qbac to send tokens on the owner's behalf
    await token.approve(qbac.address, 100000 * 1000)

    // give qbac ether
    await web3.eth.sendTransaction({
      from: admin,
      to: qbac.address,
      value: web3.utils.toWei('1', 'ether'),
    })

    let balance = await web3.eth.getBalance(qbac.address)

    assert.equal(
      balance,
      web3.utils.toWei('1', 'ether'),
      "qbac wasn't given ether"
    )
  })

  it('allows admins to preapprove a user', async function() {
    let privateKey = web3.utils.randomHex(16)
    let tempAccount = web3.eth.accounts.privateKeyToAccount(privateKey)
    let tempAddress = tempAccount.address

    //web3.eth.accounts.wallet.add(tempAccount);
    //let tempAddress = accounts[4]
    await qbac.preapprove(tempAddress, { from: admin })
    assert.equal(await qbac.approved(tempAddress), true)
  })

  describe('when a user is preapproved', async function() {
    let privateKey = web3.utils.randomHex(16)
    let tempAccount = web3.eth.accounts.privateKeyToAccount(privateKey)
    //let tempAddress = dummyTempAccount
    let tempAddress = tempAccount.address

    //let tempAccount = web3.eth.accounts.privateKeyToAccount(privateKey)

    before(async function() {
      await web3.eth.accounts.wallet.add(tempAccount)
      await qbac.preapprove(tempAddress)
    })

    it('marks them as approved', async function() {
      assert.equal(await qbac.approved(tempAddress), true)
    })

    it('gives them ether to send the whitelist transaction', async function() {
      let balance = await web3.eth.getBalance(tempAddress)

      assert.equal(
        balance,
        web3.utils.toWei('0.02', 'ether'),
        "temp address wasn't given ether"
      )
    })

    describe('when a user is whitelisted', async function() {
      let initialBalance

      before(async function() {
        initialBalance = await web3.eth.getBalance(addressToWhitelist)
        let web3qbac = new web3.eth.Contract(qbac.abi, qbac.address)

        let method = web3qbac.methods.whitelist(addressToWhitelist)
        assert.equal(await qbac.approved(tempAddress), true)
        await method.send({
          from: tempAddress,
          //gasLimit: 1000000,
          gas: web3.utils.toWei('.001', 'gwei'),
        })
      })

      it('it adds them to the rbac', async function() {
        let hasRole = await rbac.hasRole(addressToWhitelist, 'user')
        assert.equal(
          hasRole,
          true,
          'user should have been given a role in the rbac'
        )

        let balance = await web3.eth.getBalance(addressToWhitelist)
      })

      it('it transfers ether to the whitelisted address', async function() {
        let balance = await web3.eth.getBalance(addressToWhitelist)
        let balanceTransfer = new BN(balance).sub(new BN(initialBalance))
        let expectedTransfer = new BN(web3.utils.toWei('0.25', 'ether'))

        assert.equal(
          balanceTransfer.toString(),
          expectedTransfer.toString(),
          `new user ${addressToWhitelist} wasn't given ether`
        )
      })

      it('it transfers tokens to the whitelisted address', async function() {
        let balance = await web3.eth.getBalance(addressToWhitelist)
        let tokenBalanceResult = await token.balanceOf(addressToWhitelist)
        assert.equal(
          tokenBalanceResult.toNumber(),
          50,
          "new user wasn't given tokens"
        )
      })
    })
  })
})
