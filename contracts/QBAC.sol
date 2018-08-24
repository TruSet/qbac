//import './AbstractBitmaskRBAC';

//contract QBAC is BitmaskRBACPermissionable {
contract QBAC {
  //AbstractBitmaskRBAC public rbac;
  
  uint public constant DEFAULT_ROLE = 5; // PUBLISH | VALIDATE

  mapping(address => bool) public approved; // default false

  function preapprove(address _tempAddress)
  //onlyAdmin
  {
    approved[_tempAddress] = true;
  }

  function revokeApproval(address _tempAddress)
  //onlyAdmin
  {
    approved[_tempAddress] = false;
  }

  function whitelist(address _newAddress, string _display) {
    require(approved[msg.sender]);
    rbac.newUser(_newAddress, _display, DEFAULT_ROLE)
    // send ether
    // send TruTokens
    approved[msg.sender] = false;
  }
}
