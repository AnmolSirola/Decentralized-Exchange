import { useEffect } from "react";
import {ethers} from "ethers";
import TOKEN_ABI from "../abis/Token.json";
import "../App.css"
import config from "../config.json";


function App() {
  
  //Connecting Metamask
 const loadBlockchainData = async()=>{
   const accounts = await window.ethereum.request({method: "eth_requestAccounts"})
   console.log(accounts[0])  

  // Conecting Ethers to blockchain
  const provider = new ethers.providers.Web3Provider(window.ethereum)
  const {chainId} = await provider.getNetwork()
  console.log(chainId) 


 // Token Smart Contract 
 const token = new ethers.Contract(config[chainId].Dapp.address, TOKEN_ABI, Provider)
 console.log(token.address)
 const symbol = await token.symbol()
 console.log (symbol)
}

  useEffect(() =>{
    loadBlockchainData()
  }) 

  return (
    <div>

      {/* Navbar */}

      <main className='exchange grid'>
        <section className='exchange__section--left grid'>

          {/* Markets */}

          {/* Balance */}

          {/* Order */}

        </section>
        <section className='exchange__section--right grid'>

          {/* PriceChart */}

          {/* Transactions */}

          {/* Trades */}

          {/* OrderBook */}

        </section>
      </main>

      {/* Alert */}

    </div>
  );
}

export default App;