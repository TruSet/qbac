pragma solidity 0.5.10;
import "./AbstractRBAC.sol";

contract QBAC {

  // An RBAC is required to gate access to QBAC functions.
  //
  // N.B. Any user with the role 'qbac_admin' in the supplied RBAC can
  // withdraw unlimited funds from this contract.
  AbstractRBAC public rbac;

  // the user needs a little ether to sign the transaction that lets them into the whitelist
  uint public constant TEMP_USER_ETHER_ALLOCATION = 0.02 ether; // for calling the whitelist
  
  // Add this role to a user in your rbac
  string public constant ROLE_ADMIN = "qbac_admin";
  mapping(address => bool) public approved; // defaults to false

  constructor(address _rbac) public {
    rbac = AbstractRBAC(_rbac);
  }

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
