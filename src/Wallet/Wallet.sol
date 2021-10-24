pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Wallet {
  bool internal defaultBounce = true;

  constructor() public {
    require(tvm.pubkey() != 0, 101);
    require(msg.pubkey() == tvm.pubkey(), 102);
    tvm.accept();
  }

  function setDefaultBounce(bool bounce) public checkOwnerAndAccept returns (bool success) {
    defaultBounce = bounce;
    return true;
  }

  function sendETH(address dest, uint128 value) public checkOwnerAndAccept {
    dest.transfer(value, defaultBounce, 0);
  }

  function sendETH_payCommission(address dest, uint128 value) public checkOwnerAndAccept {
    dest.transfer(value, defaultBounce, 0 + 1);
  }

  function sendAllETHAndDie(address dest) public checkOwnerAndAccept {
    dest.transfer(0, defaultBounce, 128 + 32);
  }

  modifier checkOwnerAndAccept {
    require(msg.pubkey() == tvm.pubkey(), 100);

		tvm.accept();
		_;
	}
}
