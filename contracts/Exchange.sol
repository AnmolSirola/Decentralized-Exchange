//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./Token.sol";

contract Exchange {
    address public feeAccount;
    uint256 public feePercent;

    //// first mapping for user address, second address for token address
    mapping(address => mapping(address => uint256)) public tokens;

    //Order Mapping
    mapping(uint256 => _Order) public orders;
    uint public orderCount;

    //Cancel Mapping
    mapping(uint256 => bool) public orderCancelled;

    //Order Mapping 
    mapping(uint256 => bool) public orderFilled;

    event Deposit(address token, address user, uint256 amount, uint256 balance);

    event Withdraw(address token, address user, uint256 amount, uint256 balance);

    event Order(uint256 id, address user, address tokenGet, uint256 amountGet,address tokenGive, uint256 amountGive, uint256 timestamp);

    event Cancel(uint256 id, address user, address tokenGet, uint256 amountGet,address tokenGive, uint256 amountGive, uint256 timestamp);
    
    event Trade(  uint256 id, address user, address tokenGet, uint256 amountGet, address tokenGive, uint256 amountGive, address creator, uint256 timestamp );
    
    // A way to order the model
    struct _Order {
        // Attributes of an order
        uint256 id; // Unique identifier for order
        address user; // User who made order
        address tokenGet; // Address of the token they receive
        uint256 amountGet; // Amount they receive
        address tokenGive; // Address of token they give
        uint256 amountGive; // Amount they give
        uint256 timestamp; // When order was created
    }    

    constructor(address _feeAccount, uint256 _feePercent) {
        feeAccount = _feeAccount;
        feePercent = _feePercent;
    }
    
    //Deposit Token

    function depositToken(address _token, uint256 _amount) public {
    
    // Transfer tokens to exchange
    //Reference of smart contract inside the smart contract using data type "this"
                             //sender, receiver ,amount    
    require(Token(_token).transferFrom(msg.sender, address(this), _amount));

    //Update user balance
    tokens[_token][msg.sender] = tokens[_token][msg.sender] + _amount;

    //Emit an event
     emit Deposit(_token, msg.sender, _amount, tokens[_token][msg.sender]);
    
    }

    //WithDraw Token
    function withdrawToken(address _token, uint256 _amount) public {
         
        // Ensure user has enough tokens to withdraw
        require(tokens[_token][msg.sender] >= _amount);

        // Transfer tokens to user
        Token(_token).transfer(msg.sender, _amount);

        // Update user balance
        tokens[_token][msg.sender] = tokens[_token][msg.sender] - _amount;

        // Emit event
        emit Withdraw(_token, msg.sender, _amount, tokens[_token][msg.sender]);
    }
    
    //Check Balances
    function balanceOf(address _token, address _user) public view returns (uint256) {
        return tokens[_token][_user];
    }

    //Make Orders

    //Token Give (the token they want to spend)- which token, and how much 
    //Token Get (the token they want to receive)- which token and how much





    


  