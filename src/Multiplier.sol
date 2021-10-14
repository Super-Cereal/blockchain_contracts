pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Multiplier {
  uint public product;
  
  constructor() public checkKeys {
      product = 1;
  }

  function multiply(uint n) public checkKeys {
    require(1 < n && n < 10, 103);
    product *= n;
  }

  modifier checkKeys() {
    require(tvm.pubkey() != 0, 101);
    require(msg.pubkey() == tvm.pubkey(), 102);
  
    tvm.accept();
    _;
  }
}
