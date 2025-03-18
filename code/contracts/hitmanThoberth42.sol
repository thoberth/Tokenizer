// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract hitmanThoberth42 is ERC20, Ownable {
    struct ServiceOffer {
        address payable provider;
        uint256 price;
        bool isCompleted;
    }

    ServiceOffer public offer;
    address public customer;
    bool public offerAccepted;
    bool public serviceRefunded;

    event OfferCreated(address indexed provider, uint256 price);
    event OfferAccepted(address indexed customer);
    event ServiceCompleted();
    event ServiceRefunded(address indexed customer, uint256 amount);

    constructor(uint256 initialSupply) Ownable(msg.sender) ERC20("hitmanThoberth42", "HT42") {
        _mint(msg.sender, initialSupply);
    }

    modifier onlyProvider() {
        require(msg.sender == offer.provider, "Only the provider can call this function");
        _;
    }

    modifier onlyCustomer() {
        require(msg.sender == customer, "Only the customer can call this function");
        _;
    }

    function createOffer(uint256 _price) public onlyOwner {
        require(offer.price == 0 || offer.isCompleted, "Active offer already exists");
        
        offer = ServiceOffer({
            provider: payable(msg.sender),
            price: _price,
            isCompleted: false
        });
        
        // Reset state for new offer
        offerAccepted = false;
        serviceRefunded = false;
        customer = address(0);
        
        emit OfferCreated(msg.sender, _price);
    }

    function acceptOffer() public {
        require(offer.price > 0, "No offer available");
        require(!offerAccepted, "Offer already accepted");
        require(!offer.isCompleted, "Service already completed");
        require(balanceOf(msg.sender) >= offer.price, "Insufficient tokens");
        
        customer = msg.sender;
        offerAccepted = true;
        
        // Transfer tokens from customer to provider
        _transfer(msg.sender, offer.provider, offer.price);
        
        emit OfferAccepted(msg.sender);
    }

    function completeService() public onlyProvider {
        require(offerAccepted, "Offer not accepted yet");
        require(!offer.isCompleted, "Service already completed");
        require(!serviceRefunded, "Service was refunded");
        
        offer.isCompleted = true;
        
        emit ServiceCompleted();
    }

    function refund() public onlyCustomer {
        require(offerAccepted, "Offer not accepted yet");
        require(!offer.isCompleted, "Service already completed");
        require(!serviceRefunded, "Already refunded");
        
        serviceRefunded = true;
        
        // Transfer tokens from provider back to customer
        _transfer(offer.provider, msg.sender, offer.price);
        
        emit ServiceRefunded(msg.sender, offer.price);
    }
}