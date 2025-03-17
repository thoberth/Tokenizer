// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract thoberth42 is ERC20 {
    constructor(uint256 initialSupply) ERC20("thoberth42", "T42") {
        _mint(msg.sender, initialSupply * (10 ** uint256(decimals())));
    }
}
