contract MapElevationStorage
{
    uint8[1089] elevations; // while this is a [a,b,c,d,a1,b1,c1,d1...] array, it should be thought of as
    // [[a,b,c,d], [a1,b1,c1,d1]...] where each subarray is a column.
    // since you'd access the subarray-style 2D array like this: col, row
    // that means that in the 1D array, the first grouping is the first col. The second grouping is the second col, etc
    // As such, element 1 is equivalent to 0,1 -- element 2 = 0,2 -- element 33 = 1,0 -- element 34 = 1,1
    // this is a bit counter intuitive. You might think it would be arranged first row, second row, etc... but you'd be wrong.
    address creator;
    function MapElevationStorage()
    {
    	creator = msg.sender;
    }
    
    function getElevations() constant returns (uint8[1089])
    {
    	return elevations;
    }
    
    function getElevation(uint8 col, uint8 row) constant returns (uint8)
    {
    	//uint index = col * 33 + row;
    	return elevations[uint(col) * 33 + uint(row)];
    }
    
    function initElevations(uint8 col, uint8[33] _elevations) public 
    {
    	if(locked) // lockout
    		return;
    	uint skip = (uint(col) * 33); // e.g. if row 2, start with element 66
    	uint counter = 0;
    	while(counter < 33)
    	{
    		elevations[counter+skip] = _elevations[counter];
    		counter++;
    	}	
    }
    
    /**********
    Standard lock-kill methods 
    **********/
    bool locked;
    function setLocked()
    {
 	   locked = true;
    }
    function getLocked() public constant returns (bool)
    {
 	   return locked;
    }
    function kill()
    { 
        if (!locked && msg.sender == creator)
            suicide(creator);  // kills this contract and sends remaining funds back to creator
    }
}

// address: 0x68549d7dbb7a956f955ec1263f55494f05972a6b 
// transactionHash: 0x48a0c0eb350eba296e43d99a5f3c4394aa2a5da69e5369a58076f40fd32c9c99


/*
 Solidity version: 0.1.6-d41f8b7c/.-Emscripten/clang/int linked to libethereum-

 bytecode:
 
 606060405261020b806100126000396000f3606060405260e060020a6000350463049b7852811461004757806310c1952f146100c45780632d49ffcd146100d65780634166c1fd146100e357806357f10d7114610122575b005b61016b61882060405190810160405280610441905b600081526020019060019003908161005c575050604080516188208101918290529060019061044190826000855b825461010083900a900460ff1681526020600192830181810494850194909303909202910180841161008a579050505050505090506100e0565b6100456000805460ff19166001179055565b61018660005460ff165b90565b6101986004356024356000600160ff84811660210290841601610441811015610002576020808204909201549190066101000a900460ff169392505050565b6040805161042081810190925261004591600480359290916104449190602490602190839083908082843750909550505050505060008054819060ff16156101af575b50505050565b60405180826188208083818460006004610cd2f15093505050f35b60408051918252519081900360200190f35b6040805160ff929092168252519081900360200190f35b505060ff821660210260005b60218110156101655782816021811015610002576020020151600183830161044181101561000257602080820483018054919092066101000a60ff810219909116930292909217909155016101bb56
  
 abi 
 
 [{"constant":true,"inputs":[],"name":"getElevations","outputs":[{"name":"","type":"uint8[1089]"}],"type":"function"},{"constant":false,"inputs":[],"name":"setLocked","outputs":[],"type":"function"},{"constant":true,"inputs":[],"name":"getLocked","outputs":[{"name":"","type":"bool"}],"type":"function"},{"constant":true,"inputs":[{"name":"col","type":"uint8"},{"name":"row","type":"uint8"}],"name":"getElevation","outputs":[{"name":"","type":"uint8"}],"type":"function"},{"constant":false,"inputs":[{"name":"col","type":"uint8"},{"name":"_elevations","type":"uint8[33]"}],"name":"initElevations","outputs":[],"type":"function"}]

web3 deploy 

var mapelevationstorageContract = web3.eth.contract([{"constant":true,"inputs":[],"name":"getElevations","outputs":[{"name":"","type":"uint8[1089]"}],"type":"function"},{"constant":false,"inputs":[],"name":"setLocked","outputs":[],"type":"function"},{"constant":true,"inputs":[],"name":"getLocked","outputs":[{"name":"","type":"bool"}],"type":"function"},{"constant":true,"inputs":[{"name":"col","type":"uint8"},{"name":"row","type":"uint8"}],"name":"getElevation","outputs":[{"name":"","type":"uint8"}],"type":"function"},{"constant":false,"inputs":[{"name":"col","type":"uint8"},{"name":"_elevations","type":"uint8[33]"}],"name":"initElevations","outputs":[],"type":"function"}]);
var mapelevationstorage = mapelevationstorageContract.new(
   {
     from: web3.eth.accounts[0], 
     data: '606060405261020b806100126000396000f3606060405260e060020a6000350463049b7852811461004757806310c1952f146100c45780632d49ffcd146100d65780634166c1fd146100e357806357f10d7114610122575b005b61016b61882060405190810160405280610441905b600081526020019060019003908161005c575050604080516188208101918290529060019061044190826000855b825461010083900a900460ff1681526020600192830181810494850194909303909202910180841161008a579050505050505090506100e0565b6100456000805460ff19166001179055565b61018660005460ff165b90565b6101986004356024356000600160ff84811660210290841601610441811015610002576020808204909201549190066101000a900460ff169392505050565b6040805161042081810190925261004591600480359290916104449190602490602190839083908082843750909550505050505060008054819060ff16156101af575b50505050565b60405180826188208083818460006004610cd2f15093505050f35b60408051918252519081900360200190f35b6040805160ff929092168252519081900360200190f35b505060ff821660210260005b60218110156101655782816021811015610002576020020151600183830161044181101561000257602080820483018054919092066101000a60ff810219909116930292909217909155016101bb56', 
     gas: 3000000
   }, function(e, contract){
    if (typeof contract.address != 'undefined') {
         console.log(e, contract);
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })
 
 uDApp
 
 [{"name":"MapElevationStorage","interface":"[{\"constant\":true,\"inputs\":[],\"name\":\"getElevations\",\"outputs\":[{\"name\":\"\",\"type\":\"uint8[1089]\"}],\"type\":\"function\"},{\"constant\":false,\"inputs\":[],\"name\":\"setLocked\",\"outputs\":[],\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"getLocked\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"col\",\"type\":\"uint8\"},{\"name\":\"row\",\"type\":\"uint8\"}],\"name\":\"getElevation\",\"outputs\":[{\"name\":\"\",\"type\":\"uint8\"}],\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"col\",\"type\":\"uint8\"},{\"name\":\"_elevations\",\"type\":\"uint8[33]\"}],\"name\":\"initElevations\",\"outputs\":[],\"type\":\"function\"}]\n","bytecode":"606060405261020b806100126000396000f3606060405260e060020a6000350463049b7852811461004757806310c1952f146100c45780632d49ffcd146100d65780634166c1fd146100e357806357f10d7114610122575b005b61016b61882060405190810160405280610441905b600081526020019060019003908161005c575050604080516188208101918290529060019061044190826000855b825461010083900a900460ff1681526020600192830181810494850194909303909202910180841161008a579050505050505090506100e0565b6100456000805460ff19166001179055565b61018660005460ff165b90565b6101986004356024356000600160ff84811660210290841601610441811015610002576020808204909201549190066101000a900460ff169392505050565b6040805161042081810190925261004591600480359290916104449190602490602190839083908082843750909550505050505060008054819060ff16156101af575b50505050565b60405180826188208083818460006004610cd2f15093505050f35b60408051918252519081900360200190f35b6040805160ff929092168252519081900360200190f35b505060ff821660210260005b60218110156101655782816021811015610002576020020151600183830161044181101561000257602080820483018054919092066101000a60ff810219909116930292909217909155016101bb56"}]
 
 
 */


