<template>
<div>
  <!-- Módulo de información básica del Contrato -->
  <h2>EthereumGateway Test</h2>

  <p>Last Callback: {{ lastCallback }}</p>
  <p>IPFS Line: {{ IPFSline }}</p>
  <p>Max time response: {{ maxTime }}</p>
  <p>Using Account {{ account }}</p>
  <button v-on:click="load()">Reload last callback time</button>

  <!-- Módulo de configuración -->
  <h2>Change Config</h2>
  <div>
    <input v-model="line" placeholder="IPFS Line">
    <button v-on:click="setIPFSline(line)">Set IPFS Line</button>
    <br/>
    <input v-model="time" placeholder="Max time response">
    <button v-on:click="setMaxTime(time)">Set max time response</button>
  </div>
  <!-- Módulo de compra -->
  <h2>Send Request</h2>
  <div>
  <input v-model="param1" placeholder="Method">
  <input v-model="param2" placeholder="API URL">
  <input v-model="param3" placeholder="Header">
  <input v-model="param4" placeholder="Params">
  <button v-on:click="request(param1,param2,param3,param4)">Request</button>
  </div>
</div>

</template>

<script>
import Web3 from 'web3';
var web3 = new Web3(window.web3.currentProvider);


var contract = new web3.eth.Contract([{"constant":false,"inputs":[{"name":"myid","type":"bytes32"},{"name":"result","type":"string"}],"name":"__callback","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"myid","type":"bytes32"},{"name":"_result","type":"string"},{"name":"proof","type":"bytes"}],"name":"__callback","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_maxTimeResponse","type":"string"}],"name":"setMaxTimeResponse","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"SLAViolations","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"maxTimeResponse","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"IPFSline","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_method","type":"string"},{"name":"_url","type":"string"},{"name":"_params","type":"string"},{"name":"_callbackURI","type":"string"}],"name":"request","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[],"name":"lastCallback","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_IPFSline","type":"string"}],"name":"setIPFSline","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"_IPFSline","type":"string"},{"name":"_maxTimeResponse","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_result","type":"string"}],"name":"newCallBackTest","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"value","type":"string"}],"name":"newIPFSHash","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"value","type":"uint256"}],"name":"newMaxTimeResponse","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_message","type":"string"},{"indexed":false,"name":"_responseTime","type":"uint256"},{"indexed":false,"name":"_timeStamp","type":"uint256"}],"name":"newSLAViolation","type":"event"}], '0x9E987d0126d7cB0B4a3A056c1a14255Bdc6DD1a5');


export default {
  name: 'EthereumGateway',
  data() {
    return {
      lastCallback: 0,
      IPFSline: 0,
      account: 0,
      maxTime: 0,
      line: null,
      time: null,
      param1: null,
      param2: null,
      param3: null,
      param4: null,

    };
  },
  methods: {
    setIPFSline: function (line) {

    contract.methods.setIPFSline(line).send({from:this.account},(err, result) =>{
    console.log(err);
    console.log(result);
    });
    },
    setMaxTime: function (time) {

    contract.methods.setMaxTimeResponse(time).send({from:this.account},(err, result) =>{
    console.log(err);
    console.log(result);
    });
    },
    request: function (method,url,header,params) {
    if(header==null){
    header='none';
    }
    if(params==null){
    params='none';
    }
    if(params!='none'){
    }
    contract.methods.request(method,url,header,params).send({from:this.account},(err, result) =>{
    console.log(err);
    console.log(result);
    });
    },
    load: function () {

    contract.methods.lastCallback().call((err, result) =>{
    console.log(err);
    console.log(result);
    this.lastCallback=result;

    });
    },
  },
  async mounted(){
    this.lastCallback=await contract.methods.lastCallback().call();
    this.IPFSline=await contract.methods.IPFSline().call();
    this.maxTime=await contract.methods.maxTimeResponse().call();
    this.account = window.web3.eth.defaultAccount;
  }
};
</script>
