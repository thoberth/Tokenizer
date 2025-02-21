// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        _mint(msg.sender, initialSupply * (10 ** uint256(decimals())));
    }
}
// pragma solidity ^0.8.20;

// contract MyToken {
//     struct wallets {
//         uint balance;
//         uint numPayments;
//     }

//     mapping(address => wallets) public Wallets;

//     constructor() {
//         Wallets[msg.sender] = wallets(0, 0); // Initialisation explicite
//     }

//     receive() external payable { 
//         wallets storage wallet = Wallets[msg.sender];
//         wallet.balance += msg.value;
//         wallet.numPayments += 1;
//     }

//     function getTotalBalance() public view returns(uint) {
//         return address(this).balance;
//     }

//     function getBalance() public view returns(uint) {
//         return Wallets[msg.sender].balance;
//     }

//     function withdrawAllMoney(address payable _receiver) public {
//         uint _amount = Wallets[msg.sender].balance;
//         require(_amount > 0, "No funds to withdraw"); // Vérification ajoutée
//         Wallets[msg.sender].balance = 0;
//         _receiver.transfer(_amount);
//     }
// }
