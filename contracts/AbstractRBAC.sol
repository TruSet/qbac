pragma solidity 0.5.10;

contract AbstractRBAC {
  function newUser(address _addr, string calldata _display, uint _roles) external;
  function checkRole(address _operator, string memory _role) view public;
  function hasRole(address _operator, string memory _role) view public returns (bool);
}
