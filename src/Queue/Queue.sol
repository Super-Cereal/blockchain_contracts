pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Queue {
  string[] internal queue;
  uint internal firstInQueue;

  constructor() public checkKeys {
    firstInQueue = 0;
  }

  function append(string name) public checkKeys {
    queue.push(name);
  }

  function take() public checkKeys returns (string) {
    require(queue.length > firstInQueue, 103);

    string name = queue[firstInQueue];
    delete queue[firstInQueue];
    firstInQueue++;

    return name;
  }

  modifier checkKeys() {
    require(tvm.pubkey() != 0, 101);
    require(msg.pubkey() == tvm.pubkey(), 102);

    tvm.accept();
    _;
  }
}
