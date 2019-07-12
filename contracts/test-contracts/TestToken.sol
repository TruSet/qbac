// adapted from openzeppelin-solidity/contracts/examples/SimpleToken.sol
pragma solidity 0.5.10;
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract TestToken is ERC20 {

  string public constant name = "TestToken";
  string public constant symbol = "TST";
  uint8 public constant decimals = 3;

  uint256 public constant INITIAL_SUPPLY = 100000 * (10 ** uint256(decimals));

  constructor() public {
    _mint(msg.sender, INITIAL_SUPPLY);
  }

}
