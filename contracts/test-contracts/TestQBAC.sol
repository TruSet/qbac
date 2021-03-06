pragma solidity 0.5.10;
import "../QBAC.sol";
import "./AbstractTestToken.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "../AbstractRBAC.sol";


contract TestQBAC is QBAC, Ownable {
  AbstractTestToken token;

  // give user .25 ether 
  uint public constant NEW_USER_ETHER_ALLOCATION = 250000000000000000;
  uint public constant NEW_USER_TOKEN_ALLOCATION = 50;
  uint public constant DEFAULT_ROLE = 5;

  constructor(address _rbac, address _token) QBAC(_rbac) public {
    token = AbstractTestToken(_token);
  }
  
  function whitelist(address payable _newAddress) public
  approvedToJoin
  {
    // give user ether
    _newAddress.transfer(NEW_USER_ETHER_ALLOCATION);
    // add them as a user to the rbac
    rbac.newUser(_newAddress, "no name", DEFAULT_ROLE);
    // give them tokens to play with
    token.transferFrom(owner(), _newAddress, NEW_USER_TOKEN_ALLOCATION);

    // they are only approved to call this method once
    approved[msg.sender] = false;
  }
}
