/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

interface IGameObject {
  function underAttack(uint power) external;
  function getHealth() external returns (uint);
  function getArmor() external returns (uint);
}
