<template>
<div id="app">
  <h1>Token ERC20</h1>
  <ethereumGateway></ethereumGateway>
</div>
</template>

<script>
import EthereumGateway from './components/EthereumGateway'
export default {
  name: 'App',
  components: {
    EthereumGateway,
  },
};
</script>
