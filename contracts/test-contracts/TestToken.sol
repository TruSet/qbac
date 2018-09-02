// adapted from openzeppelin-solidity/contracts/examples/SimpleToken.sol
pragma solidity ^0.4.24;
import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

contract TestToken is StandardToken {

  string public constant name = "TestToken";
  string public constant symbol = "TST";
  uint8 public constant decimals = 3;

  uint256 public constant INITIAL_SUPPLY = 100000 * (10 ** uint256(decimals));

  constructor() public {
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
    emit Transfer(address(0), msg.sender, INITIAL_SUPPLY);
  }

}
