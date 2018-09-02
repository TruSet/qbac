pragma solidity ^0.4.24;

contract AbstractRBAC {
  function newUser(address _addr, string _display, string _role) external;
  function checkRole(address _operator, string _role) view public;
  function makeAdmin(address _address) public;
  function makeUser(address _address) public;
}
