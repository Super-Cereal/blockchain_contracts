
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "../GameObject.sol";
import "../IGameObject.sol";

contract BaseUnit is GameObject {
  uint private power;

  function setPower(uint attackPower) virtual internal {
    if (attackPower >= 0) {
      power = attackPower;
    } else {
      power = 0;
    }
  }

  function getPower() virtual public returns (uint) {
    return power;
  }
  
  function attack(IGameObject opponent) public {
    opponent.underAttack(getPower());
  }
}
