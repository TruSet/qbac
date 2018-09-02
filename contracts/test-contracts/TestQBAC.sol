pragma solidity ^0.4.24;
import "../QBAC.sol";
import "./AbstractTestToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "../AbstractRBAC.sol";


contract TestQBAC is QBAC, Ownable {
  AbstractTestToken token;

  // give user .25 ether 
  uint public constant NEW_USER_ETHER_ALLOCATION = 250000000000000000;
  uint public constant NEW_USER_TOKEN_ALLOCATION = 50;

  constructor(address _rbac, address _token) public {
    rbac = AbstractRBAC(_rbac);
    token = AbstractTestToken(_token);
  }
  
  function whitelist(address _newAddress) public
  approvedToJoin
  {
    // give user ether
    _newAddress.transfer(NEW_USER_ETHER_ALLOCATION);
    // add them as a user to the rbac
    rbac.makeUser(_newAddress);
    // give them tokens to play with
    token.transferFrom(owner, _newAddress, NEW_USER_TOKEN_ALLOCATION);

    // they are only approved to call this method once
    approved[msg.sender] = false;
  }
}
