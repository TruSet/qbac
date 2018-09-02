pragma solidity ^0.4.24;

contract AbstractTestToken {
  //function approve(address _spender, uint256 _value) public returns (bool success);
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
  function balanceOf(address _owner) constant public returns (uint256 balance);
  function transfer(address _to, uint256 _value) public returns (bool success);
}
