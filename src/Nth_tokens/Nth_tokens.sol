pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

// staff nth-tokens
struct Token {
  string name;
  string teamName;
  string position;
  uint salary;
  bool onSale;
  uint salePrice;
}

contract Nth_tokens {
  mapping(uint => uint) tokenToOwner;
  mapping(string => bool) tokenNames;
  Token[] tokensArray;

  function createToken(string name, string teamName, string position, uint salary) public nameNotUsed(name) accept returns(uint tokenId) {
    tokensArray.push(Token(name, teamName, position, salary, false, 0));
    tokenId = tokensArray.length - 1;
    tokenToOwner[tokenId] = msg.pubkey();

    tokenNames[name] = true;
  }

  function getTokenOwner(uint tokenId) public tokenExists(tokenId) accept returns(uint pubkey) {
    pubkey = tokenToOwner[tokenId];
  }

  function getTokenInfo(uint tokenId) public view tokenExists(tokenId) accept returns(string name, string teamName, string position, uint salary, bool onSale, uint salePrice) {
    Token token = tokensArray[tokenId];
    name = token.name;
    teamName = token.teamName;
    position = token.position;
    salary = token.salary;
    onSale = token.onSale;
    salePrice = token.salePrice;
  }

  function putUpForSale(uint tokenId, uint salePrice) public tokenExists(tokenId) withOwnership(tokenId) accept returns(bool success) {
    tokensArray[tokenId].onSale = true;
    tokensArray[tokenId].salePrice = salePrice;

    success = true;
  }
  function takeOffFromSale(uint tokenId) public tokenExists(tokenId) withOwnership(tokenId) accept returns(bool success) {
    tokensArray[tokenId].onSale = false;
    tokensArray[tokenId].salePrice = 0;

    success = true;
  }
  function changeTokenOwner(uint tokenId, uint pubkeyOfNewOwner) public tokenExists(tokenId) withOwnership(tokenId) accept returns(bool success) {
    tokenToOwner[tokenId] = pubkeyOfNewOwner;
    success = true;
  }
  function changeName(uint tokenId, string name) public tokenExists(tokenId) withOwnership(tokenId) nameNotUsed(name) accept returns(bool success) {
    tokenNames[tokensArray[tokenId].name] = false;
    tokensArray[tokenId].name = name;
    success = true;
  }
  function changeTeamName(uint tokenId, string teamName) public tokenExists(tokenId) withOwnership(tokenId) accept returns(bool success) {
    tokensArray[tokenId].teamName = teamName;
    success = true;
  }
  function changePosition(uint tokenId, string position) public tokenExists(tokenId) withOwnership(tokenId) accept returns(bool success) {
    tokensArray[tokenId].position = position;
    success = true;
  }
  function changeSalary(uint tokenId, uint salary) public tokenExists(tokenId) withOwnership(tokenId) accept returns(bool success) {
    tokensArray[tokenId].salary = salary;
    success = true;
  }

  modifier tokenExists(uint tokenId) {
    require(tokensArray.length > tokenId, 104);
    _;
  }

  modifier nameNotUsed(string name) {
    require(!tokenNames.exists(name) || !tokenNames[name], 103);
    _;
  }

  modifier withOwnership(uint tokenId) {
    require(msg.pubkey() == tokenToOwner[tokenId], 101);
    _;
  }

  modifier accept {
    tvm.accept();
    _;
  }
}
