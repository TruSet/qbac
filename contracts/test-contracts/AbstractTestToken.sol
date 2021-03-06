pragma solidity 0.5.10;

contract AbstractTestToken {
  //function approve(address _spender, uint256 _value) public returns (bool success);
  function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
  function balanceOf(address _owner) view external returns (uint256 balance);
  function transfer(address _to, uint256 _value) external returns (bool success);
}
