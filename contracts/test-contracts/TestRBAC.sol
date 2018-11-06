pragma solidity ^0.4.22;

import "bitmask-rbac/contracts/BitmaskRBAC.sol";

contract TestRBAC is BitmaskRBAC {
  // this is just for testing purposes and not secure
  function makeAdmin(address _address) public {
    addRole(_address, 'qbac_admin');
  }

  function makeUser(address _address) public {
    addRole(_address, 'user');
  }
}
