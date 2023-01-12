// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// Allow user1 and 2 to repeatedly transfer ether off chain

/**
 * Opening A Channel
 1. User A and User B fund a multi-sig wallet.
 2. Precompute payement channel address.
 3. User A and B exchange signatures of initial balance
 4. User A and B creates a transaction that can deploy a payment channel from a multisig wallet


 * Update Channel Balances
 1. Repeat steps 1 - 3 from opening a channel
 2. From multi-sig wallet, create a tx that will
    - send payments to user A and B
    - & then delete the tx that can deploy a payment channel with the new balances.


* Closing a channel when user A and B agree on the final balance
1. From multi-sig wallet, create a tx that will:
    - send payments to user A and B.
    - & then delete the tx that would have created the payment channel.


* Closing a channel when user A and B dont agree on final balances
1. Deploy payment channel for multi-sig
2. call challengeExit() to start the process of closing a channel.
3. User A and B can withdraw funds onces the channel is expired.
 */

import "openzeppelin-contracts//utils/cryptography/ECDSA.sol";

contract BiDirectionalPaymentChannel {
    using ECDSA for bytes32;

    event ChallengeExit(address indexed signer, uint256 nonce);
    event Withdraw(address indexed to, uint256 amount);

    address payable[2] public users;
    mapping(address => bool) public isUser;

    mapping(address => uint256) public balances;

    uint256 public challengePeriod;
    uint256 public expiresAt;
    uint256 public nonce;

    modifier checkBalances(uint256[2] memory _balances) {
        require(
            address(this).balance >= _balances[0] + _balances[1],
            "COONTRACT BALANCE INSUFFICIENT"
        );
        _;
    }
}
