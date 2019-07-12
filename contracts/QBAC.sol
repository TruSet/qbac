pragma solidity 0.5.10;
import "./AbstractRBAC.sol";

contract QBAC {
  AbstractRBAC rbac;
  // the user needs a little ether to sign the transaction that lets them into the whitelist
  uint public constant TEMP_USER_ETHER_ALLOCATION = 20000000000000000; // .02 ether, for calling the whitelist
  
  // Add this role to a user in your rbac
  string public constant ROLE_ADMIN = "qbac_admin";
  uint public constant DEFAULT_ROLE = 5; // PUBLISH | VALIDATE

  mapping(address => bool) public approved; // default false

  // TODO: without setting an RBAC, this contract is unsafe to use because anyone can transfer out all of the ETH using preapprove()
  //       should set one here and pass through in subclasses
  // constructor(address _rbac) public {
  //   rbac = AbstractRBAC(_rbac);
  // }

  modifier onlyAdmin() {
    rbac.checkRole(msg.sender, ROLE_ADMIN);
    _;
  }

  modifier approvedToJoin() {
    require(approved[msg.sender]);
    _;
  }

  function preapprove(address payable _tempAddress) public
  onlyAdmin
  {
    approved[_tempAddress] = true;
    _tempAddress.transfer(TEMP_USER_ETHER_ALLOCATION);
  }

  function revokeApproval(address _tempAddress) public
  onlyAdmin
  {
    approved[_tempAddress] = false;
  }

  // add ether for TEMP_USER_ETHER_ALLOCATION
  function fund() payable public {

  }
  // fallback function so that contract can recieve ether
  function() payable external { }

  // You should create a method like this one
  // that does a function  more specific to your application

  //function whitelist(address _newAddress)
  //approvedToJoin
  //{
    // // and make sure to expire access after the one time method has been used
    // approved[msg.sender] = false;
  //}

}
