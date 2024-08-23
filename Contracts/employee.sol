// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeIdentityNFT {
    address private owner;
    uint256 public NFTCounter;
    mapping (address => uint256) public employeeNFTs;
    mapping (uint256 => address) public NFTOwners;

    event NewNFT(address indexed employee, uint256 NFTId);
    event TransferNFT(address indexed from, address indexed to, uint256 NFTId);

    constructor() {
        owner = msg.sender;
        NFTCounter = 0;
    }

    function createNFT(address employeeAddress) public {
        require(msg.sender == owner, "Only the owner can create NFTs");
        require(employeeNFTs[employeeAddress] == 0, "Employee already has an NFT");
        NFTCounter++;
        employeeNFTs[employeeAddress] = NFTCounter;
        NFTOwners[NFTCounter] = employeeAddress;
        emit NewNFT(employeeAddress, NFTCounter);
    }

    function transferNFT(address from, address to, uint256 NFTId) public {
        require(msg.sender == owner, "Only the owner can transfer NFTs");
        require(NFTOwners[NFTId] == from, "Only the owner of the NFT can transfer it");
        require(employeeNFTs[to] == 0, "Recipient already has an NFT");
        NFTOwners[NFTId] = to;
        employeeNFTs[from] = 0;
        employeeNFTs[to] = NFTId;
        emit TransferNFT(from, to, NFTId);
    }

    function getNFTOwner(uint256 NFTId) public view returns (address) {
        return NFTOwners[NFTId];
    }
}