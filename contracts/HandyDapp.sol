//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.3;

import "hardhat/console.sol";


contract HandyDapp {

  // TODO: add an event, and emit it in sendEncryptedMessage
  // TODO: add a subgraph, add a schema.graphql, add a subgraph.yaml, and add a mapping
  // TODO: write some tests
  // TODO: measure gas costs
  // TODO: make upgradeable (simply so Adam can see what the process for making a contract upgradeable looks like)

  struct MessageData {
    bytes message;
    uint256 timestamp;
  }

  mapping(address => mapping(address => MessageData[])) public messages;
  // we need this so we are able to iterate through all of the user's contacts
  mapping(address => address[]) public contacts;

  function sendEncryptedMessage(bytes calldata _encryptedMessage, address _recipient) external {
    bool isContact = false;
    for (uint256 i = 0; i < contacts[msg.sender].length; i ++) {
      if (contacts[msg.sender][i] == _recipient) {
        isContact = true;
        break;
      }
    }
    if (isContact == false) {
      // add them as a new contact
      contacts[msg.sender].push(_recipient);
    }
    MessageData memory messageData =  MessageData(_encryptedMessage, block.timestamp);

    messages[msg.sender][_recipient].push(messageData);
  }
}
