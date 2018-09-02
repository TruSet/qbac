pragma solidity ^0.4.22;

import "openzeppelin-solidity/contracts/access/rbac/RBAC.sol";

contract TestRBAC is RBAC {
  // this is just for testing purposes and not secure
  function makeAdmin(address _address) public {
    addRole(_address, 'qbac_admin');
  }

  function makeUser(address _address) public {
    addRole(_address, 'user');
  }
}
