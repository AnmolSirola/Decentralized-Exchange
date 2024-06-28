//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Token {
    string public name;
    string public symbol;
    uint256 public decimals = 18;
    uint256 public totalSupply;

    // track balances

    mapping(address => uint256) public balanceOf;
    // first mapping for deployer address, second address for exchange address
    mapping(address => mapping(address=>uint256)) public allowance;

    // Send Tokens 

    event Transfer( address indexed from, address indexed to, uint256 value);

    event Approval( address indexed from, address indexed to, uint256 value);

    constructor(string memory _name,string memory _symbol,uint256 _totalSupply ) {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply * (10**decimals);

        //updating balance of owner to the total supply [msg.sender] only called by the owner
        balanceOf[msg.sender] = totalSupply;   
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {

        //Require that sendar has enough tokens to spend  
        require(balanceOf[msg.sender] >= _value);
        // Doesn't allows us to send token to an invaild address
        require(_to != address(0));
         
        // deduct token from the sender 
        balanceOf[msg.sender] = balanceOf[msg.sender] - _value;
        // credit token to the receiver
        balanceOf[_to] = balanceOf[_to] + _value;
        // emit event
        emit Transfer(msg.sender, _to, _value);

        return true;
    }

     function _transfer( address _from,address _to,uint256 _value ) internal {
        require(_to != address(0));

        balanceOf[_from] = balanceOf[_from] - _value;
        balanceOf[_to] = balanceOf[_to] + _value;

        emit Transfer(_from, _to, _value);
    }

    function approve(address _spender, uint256 _value) public returns(bool success){
         
        require(_spender != address(0));

        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        //check approval
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);
        // spend token 
        allowance[_from][msg.sender] = allowance[_from][msg.sender] - _value;

        _transfer(_from, _to, _value);

        return true;
    }

}

    
