pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

struct Task {
  uint8 id;
  string title;
  uint32 timestamp;
  bool isClosed;
}

contract TodoList {
  mapping(uint8 => Task) internal tasks;
  uint8 internal nextTaskId;

  constructor() public checkKeys {
    nextTaskId = 0;
  }

  function add(string title) public checkKeys returns (uint8) {
    uint8 id = nextTaskId;
    nextTaskId++;

    tasks[id] = Task(id, title, now, false);

    return id;
  }

  function opened() public checkKeys returns (uint8) {
    uint8 count = 0;

    for (uint8 i = 0; i < nextTaskId; i++) {
      if (isTaskExists(i) && !tasks[i].isClosed) {
        count++;
      }
    }

    return count;
  }

  function getTasks() public checkKeys returns (Task[]) {
    Task[] result;

    for (uint8 i = 0; i < nextTaskId; i++) {
      if (isTaskExists(i)) {
        result.push(tasks[i]);
      }
    }

    return result;
  }

  function getTitle(uint8 id) public checkKeys returns (string) {
    require(isTaskExists(id), 103);

    return tasks[id].title;
  }

  function del(uint8 id) public checkKeys returns (bool){
    if (!isTaskExists(id)) {
      return false;
    }

    delete tasks[id];
    return true;
  }

  function close(uint8 id) public checkKeys returns (bool) {
    if (!isTaskExists(id)) {
      return false;
    }

    tasks[id].isClosed = true;
    return true;
  }

  modifier checkKeys() {
    require(tvm.pubkey() != 0, 101);
    require(msg.pubkey() == tvm.pubkey(), 102);

    tvm.accept();
    _;
  }

  function isTaskExists(uint8 id) internal view returns (bool) {
    if (tasks[id].timestamp == 0) {
      return false;
    }
    return true;
  }
}
