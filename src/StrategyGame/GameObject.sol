
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import './IGameObject.sol';

contract GameObject is IGameObject {
  uint private hp;
  uint private armor;

  function setHealth(uint healthPoints) virtual internal {
    if (healthPoints >= 0) {
      hp = healthPoints;
    } else {
      hp = 0;
    }
  }
  function setArmor(uint armorPower)virtual internal {
    if (armorPower >= 0) {
      armor = armorPower;
    } else {
      armor = 0;
    }
  }

  function getHealth()virtual public override returns (uint) {
    return hp;
  }
  function getArmor() virtual public override returns (uint) {
    return armor;
  }


  function dead(address opponent) public {
    opponent.transfer(0, true, 128 + 32);
  }
  function underAttack(uint power) virtual external override {
    uint strike = power - getArmor();
    if (strike > 0) {
      setHealth(getHealth() - strike);
    }
    if (getHealth() == 0) {
      dead(msg.sender);
    }
  }
}
