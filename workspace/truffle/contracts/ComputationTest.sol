/*
   Oraclize computation
*/



pragma solidity ^0.4.2;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";


contract ComputationJson is usingOraclize {
    
    uint public lastCallback;
    uint public maxTimeResponse;
   mapping(uint => string) public SLAViolations;
    
    event newCallBackTest(string _result, uint _blockNumber);
    event newSLAViolation(string _message,uint _responseTime, uint _timeStamp,uint _blockNumber);
    
    function ComputationJson() {
        oraclize_setProof(proofType_TLSNotary | proofStorage_IPFS); 
        maxTimeResponse = 200;
        callingDocker("0");
    }

    function __callback(bytes32 myid, string result, bytes proof) {
        if (msg.sender != oraclize_cbAddress()) throw;
        lastCallback = parseInt(result);
        newCallBackTest(result, block.number);
        if(lastCallback>maxTimeResponse){
            SLAViolations[block.number] = "Max time response exceeded!";
            newSLAViolation("Max time response exceeded!",lastCallback,now,block.number);
        }
        
    }
    
    function  callingDocker(string addedTime) payable {
        /*
        oraclize_query("computation",["json(Qmb7E5ZyaQzhUcqNVTQKJjWQzVGTm6zWQ7FPQuJYMBjCA6).[http-status,response-time]"]); 
        This query return an array-like string, I dont know how to parse it.        EX: '[200, 429]'
        */
        
        oraclize_query("computation",["json(QmTqsxSQgGfg9w8fab5vGuWDNUq7XE5spS7Sw6JifSgxv3).response-time",addedTime]);
    }
    
    
}
