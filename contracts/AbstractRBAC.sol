pragma solidity ^0.4.24;

contract AbstractRBAC {
  function newUser(address _addr, string _display, uint _roles) external;
  function checkRole(address _operator, string _role) view public;
}
