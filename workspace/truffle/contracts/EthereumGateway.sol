
/*
   Ethereum Gateway
   MiguelSBat
*/



pragma solidity ^0.4.2;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";


contract EthereumGateway is usingOraclize {

    uint public lastCallback;
    uint public maxTimeResponse;
    string public IPFSline;
    string public header;
    string public params;
    address private owner;
    mapping(uint => string) public SLAViolations;

    event newCallBackTest(string _result);
    event newIPFSHash(string value);
    event newMaxTimeResponse(uint value);
    event newSLAViolation(string _message,uint _responseTime, uint _timeStamp);

    //Example: "json(QmaJc7XHX8Ckfg4qJMWCnMFRuLuXtwTzEjTVWCgMtMKQKW).response-time", 200
    function EthereumGateway(string _IPFSline,uint _maxTimeResponse) {
        oraclize_setProof(proofType_TLSNotary | proofStorage_IPFS);
        maxTimeResponse = _maxTimeResponse;
        owner = msg.sender;
        IPFSline = _IPFSline;
        header ='';
        params='';

        request("GET","https://maps.googleapis.com/maps/api/geocode/json?address=Florence","none","none");
    }

    function setIPFSline(string _IPFSline){
        if (msg.sender != owner) throw;

        IPFSline = _IPFSline;
        newIPFSHash(_IPFSline);
    }
    function setHeader(string _header) private{
        header = _header;
    }
    function setParams(string _params) private{
        params = _params;
    }

    function setMaxTimeResponse(string _maxTimeResponse){
        if (msg.sender != owner) throw;

        maxTimeResponse = parseInt(_maxTimeResponse);
        newMaxTimeResponse(maxTimeResponse);
    }

    function __callback(bytes32 myid, string _result, bytes proof) {
        if (msg.sender != oraclize_cbAddress()) throw;
        lastCallback = parseInt(_result);
        newCallBackTest(_result);
        if(lastCallback>maxTimeResponse){
            SLAViolations[block.number] = "Max time response exceeded!";
            newSLAViolation("Max time response exceeded!",lastCallback,now);
        }

    }

    function  request(string _method,string _url,string _header,string _params) payable {
        setHeader(_header);
        setParams(_params);

        oraclize_query("computation",[IPFSline,_method,_url,header,params]);
    }


}
