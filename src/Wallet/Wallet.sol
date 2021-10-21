pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Wallet {
  constructor() public {
    require(tvm.pubkey() != 0, 101);
    require(msg.pubkey() == tvm.pubkey(), 102);
    tvm.accept();
  }

  modifier checkOwnerAndAccept {
    require(msg.pubkey() == tvm.pubkey(), 100);

		tvm.accept();
		_;
	}

  /// @dev Allows to transfer tons to the destination account.
  /// @param dest Transfer target address.
  /// @param value Nanotons value to transfer.
  /// @param bounce Flag that enables bounce message in case of target contract error.
  function sendTransaction(address dest, uint128 value, bool bounce) public pure checkOwnerAndAccept {
    dest.transfer(value, bounce, 0);
  }
}
