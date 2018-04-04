<template>
<div>
  <!-- Módulo de información básica del Token -->
  <h2>Información del Token {{ tokenName }}</h2>

  <p>Total supply: {{ totalSupply }}</p>
  <p>Precio: {{ price }}</p>
  <p>Balance: {{ balance }}</p>

  <!-- Módulo de compra -->
  <h2>Comprar tokens</h2>
  <div>
    <input type="text" placeholder="Cantidad"></input>
  </div>
  <button>Comprar</button>

  <!-- Módulo para comprobar el saldo de una cuenta -->
  <h2>Comprobar saldo</h2>
  <div>
    <input type="text" placeholder="Dirección"></input>
  </div>
  <button>Comprobar</button>

  <!-- Módulo para enviar tokens a otra dirección -->
  <h2>Enviar tokens</h2>
  <div class="">
    <input type="text" placeholder="Dirección"></input>
  </div>
  <div>
    <input type="text" placeholder="Cantidad"></input>
  </div>
  <button>Enviar</button>

</div>
</template>

<script>
import Web3 from 'web3';
const erc20 = require('../../static/BasicToken')
export default {
  name: 'Token',
  data() {
    return {
      totalSupply: 0,
      price: 0,
      balance: 0,
      tokenName: '',
    };
  },

  async mounted(){
    var web3 = new Web3(window.web3.currentProvider);

    var contract = new web3.eth.Contract(erc20.abi, '0xd906b04cd431cc90f51c7739e157fabde5eac90d');

    this.tokenName=await contract.methods.name().call();
    this.totalSupply=await contract.methods.totalSupply().call();
    this.price=await contract.methods.price().call();
    this.balance=await contract.methods.balanceOf('0x801d140DfBeaD0751EAA77Ec285634E3dd0a0C45').call();

  }
};
</script>
