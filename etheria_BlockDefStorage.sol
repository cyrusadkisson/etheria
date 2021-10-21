contract BlockDefStorage
{
	
    Block[18] blocks;
    struct Block
    {
    	int8[24] occupies; // [x0,y0,z0,x1,y1,z1...,x7,y7,z7] 
    	int8[48] attachesto; // [x0,y0,z0,x1,y1,z1...,x15,y15,z15] // first one that is 0,0,0 is the end
    }
    
    address creator;
    function BlockDefStorage()
    {
    	creator = msg.sender;
    }
    
    function getOccupies(uint8 which) public constant returns (int8[24])
    {
    	return blocks[which].occupies;
    }
    
    function getAttachesto(uint8 which) public constant returns (int8[48])
    {
    	return blocks[which].attachesto;
    }

    function initOccupies(uint8 which, int8[24] occupies) public 
    {
    	if(locked) // lockout
    		return;
    	for(uint8 index = 0; index < 24; index++)
    	{
    		blocks[which].occupies[index] = occupies[index];
    	}	
    }
    
    function initAttachesto(uint8 which, int8[48] attachesto) public
    {
    	if(locked) // lockout
    		return;
    	for(uint8 index = 0; index <  48; index++)
    	{
    		blocks[which].attachesto[index] = attachesto[index];
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

/*
Solidity version: 0.1.6-d41f8b7c/.-Emscripten/clang/int linked to libethereum- 
bytecode: 
606060405260368054600160a060020a031916331790556103b6806100246000396000f3606060405236156100615760e060020a60003504630878bc51811461006357806310c1952f146100dc5780631bcf5758146101065780632d49ffcd1461019657806341c0e1b5146101b5578063d87a11661461020e578063e579763b1461025c575b005b6102ab600435610600604051908101604052806030905b600081526020019060019003908161007a57506000905082601281101561000257604080516106008101918290526003929092026001908101805490940b83529192916030919083906020860180841161015b57905050505050509050610191565b6100616036805474ff0000000000000000000000000000000000000000191660a060020a1790555b565b6102c5600435610300604051908101604052806018905b600081526020019060019003908161011d57506000905082601281101561000257604080516103008101918290529260039290920291601891908390855b825461010083900a900460000b81526020600192830181810494850194909303909202910180841161015b579050505050505090505b919050565b60365460a060020a900460ff1660408051918252519081900360200190f35b61006160365460a060020a900460ff161580156101ee575060365473ffffffffffffffffffffffffffffffffffffffff90811633909116145b156101045760365473ffffffffffffffffffffffffffffffffffffffff16ff5b6040805161060081810190925261006191600480359290916106249190602490603090839083908082843750909550505050505060365460009060a060020a900460ff1615610349576102a6565b6040805161030081810190925261006191600480359290916103249190602490601890839083908082843750909550505050505060365460009060a060020a900460ff16156102df575b505050565b60405180826106008083818460006004609ff15093505050f35b604051808261030080838184600060046057f15093505050f35b5060005b60188160ff1610156102a6578181601881101561000257602002015160008460128110156100025760030290508260188110156100025760208082049092019190066101000a81548160ff021916908360f860020a9081020402179055506001016102e3565b5060005b60308160ff1610156102a6578181603081101561000257602002015160008460128110156100025760030290506001018260308110156100025760208082049092019190066101000a81548160ff021916908360f860020a90810204021790555060010161034d56
interface:
[{"constant":true,"inputs":[{"name":"which","type":"uint8"}],"name":"getAttachesto","outputs":[{"name":"","type":"int8[48]"}],"type":"function"},{"constant":false,"inputs":[],"name":"setLocked","outputs":[],"type":"function"},{"constant":true,"inputs":[{"name":"which","type":"uint8"}],"name":"getOccupies","outputs":[{"name":"","type":"int8[24]"}],"type":"function"},{"constant":true,"inputs":[],"name":"getLocked","outputs":[{"name":"","type":"bool"}],"type":"function"},{"constant":false,"inputs":[],"name":"kill","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"which","type":"uint8"},{"name":"attachesto","type":"int8[48]"}],"name":"initAttachesto","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"which","type":"uint8"},{"name":"occupies","type":"int8[24]"}],"name":"initOccupies","outputs":[],"type":"function"},{"inputs":[],"type":"constructor"}]

addr: 0xd4e686a1fbf1bfe058510f07cd3936d3d5a70589
 */

// ETHERIA 1.1

// definitions intialized like this.
//blockdefstorage.initOccupies.sendTransaction(0, [0,0,0,0,0,1,0,0,2,0,0,3,0,0,4,0,0,5,0,0,6,0,0,7],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(0, [0,0,-1,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(1, [0,0,0,1,0,0,2,0,0,3,0,0,4,0,0,5,0,0,6,0,0,7,0,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(1, [0,0,-1,1,0,-1,2,0,-1,3,0,-1,4,0,-1,5,0,-1,6,0,-1,7,0,-1,0,0,1,1,0,1,2,0,1,3,0,1,4,0,1,5,0,1,6,0,1,7,0,1],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(2, [0,0,0,1,0,0,1,1,0,2,1,0,3,2,0,4,2,0,4,3,0,5,3,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(2, [0,0,-1,1,0,-1,1,1,-1,2,1,-1,3,2,-1,4,2,-1,4,3,-1,5,3,-1,0,0,1,1,0,1,1,1,1,2,1,1,3,2,1,4,2,1,4,3,1,5,3,1],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(3, [0,0,0,-1,0,0,-2,1,0,-3,1,0,-3,2,0,-4,2,0,-5,3,0,-6,3,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(3, [0,0,-1,-1,0,-1,-2,1,-1,-3,1,-1,-3,2,-1,-4,2,-1,-5,3,-1,-6,3,-1,0,0,1,-1,0,1,-2,1,1,-3,1,1,-3,2,1,-4,2,1,-5,3,1,-6,3,1],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(4, [0,0,0,1,0,0,0,0,1,1,0,1,0,0,2,1,0,2,0,0,3,1,0,3],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(4, [0,0,-1,1,0,-1,0,0,4,1,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(5, [0,0,0,0,1,0,0,0,1,0,1,1,0,0,2,0,1,2,0,0,3,0,1,3],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(5, [0,0,-1,0,1,-1,0,0,4,0,1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(6, [0,0,0,-1,1,0,0,0,1,-1,1,1,0,0,2,-1,1,2,0,0,3,-1,1,3],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(6, [0,0,-1,-1,1,-1,0,0,4,-1,1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(7, [0,0,0,1,0,0,2,0,0,3,0,0,0,0,1,1,0,1,2,0,1,3,0,1],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(7, [0,0,-1,1,0,-1,2,0,-1,3,0,-1,0,0,2,1,0,2,2,0,2,3,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(8, [0,0,0,1,0,0,1,1,0,2,1,0,0,0,1,1,0,1,1,1,1,2,1,1],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(8, [0,0,-1,1,0,-1,1,1,-1,2,1,-1,0,0,2,1,0,2,1,1,2,2,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(9, [0,0,0,-1,0,0,-2,1,0,-3,1,0,0,0,1,-1,0,1,-2,1,1,-3,1,1],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(9, [0,0,-1,-1,0,-1,-2,1,-1,-3,1,-1,0,0,2,-1,0,2,-2,1,2,-3,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(10, [0,0,0,0,1,0,0,2,0,0,3,0,0,4,0,0,5,0,0,6,0,0,7,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(10, [0,0,-1,0,1,-1,0,2,-1,0,3,-1,0,4,-1,0,5,-1,0,6,-1,0,7,-1,0,0,1,0,1,1,0,2,1,0,3,1,0,4,1,0,5,1,0,6,1,0,7,1],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(11, [0,0,0,-1,1,0,0,2,0,-1,3,0,0,4,0,-1,5,0,0,6,0,-1,7,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(11, [0,0,-1,-1,1,-1,0,2,-1,-1,3,-1,0,4,-1,-1,5,-1,0,6,-1,-1,7,-1,0,0,1,-1,1,1,0,2,1,-1,3,1,0,4,1,-1,5,1,0,6,1,-1,7,1],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(12, [0,0,0,0,1,0,0,2,0,0,3,0,0,0,1,0,1,1,0,2,1,0,3,1],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(12, [0,0,-1,0,1,-1,0,2,-1,0,3,-1,0,0,2,0,1,2,0,2,2,0,3,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(13, [0,0,0,-1,1,0,0,2,0,-1,3,0,0,0,1,-1,1,1,0,2,1,-1,3,1],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(13, [0,0,-1,-1,1,-1,0,2,-1,-1,3,-1,0,0,2,-1,1,2,0,2,2,-1,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(14, [0,0,0,1,0,0,1,0,1,2,0,1,2,0,2,3,0,2,3,0,3,4,0,3],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(14, [0,0,-1,1,0,-1,2,0,0,3,0,1,4,0,2,0,0,1,1,0,2,2,0,3,3,0,4,4,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(15, [0,0,0,-1,0,0,-1,0,1,-2,0,1,-2,0,2,-3,0,2,-3,0,3,-4,0,3],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(15, [0,0,-1,-1,0,-1,-2,0,0,-3,0,1,-4,0,2,0,0,1,-1,0,2,-2,0,3,-3,0,4,-4,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(16, [0,0,0,0,-1,0,0,-1,1,0,-2,1,0,-2,2,0,-3,2,0,-3,3,0,-4,3],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(16, [0,0,-1,0,-1,-1,0,-2,0,0,-3,1,0,-4,2,0,0,1,0,-1,2,0,-2,3,0,-3,4,0,-4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initOccupies.sendTransaction(17, [0,0,0,0,1,0,0,1,1,0,2,1,0,2,2,0,3,2,0,3,3,0,4,3],{from:eth.accounts[1], gas:500000});
//blockdefstorage.initAttachesto.sendTransaction(17, [0,0,-1,0,1,-1,0,2,0,0,3,1,0,4,2,0,0,1,0,1,2,0,2,3,0,3,4,0,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],{from:eth.accounts[1], gas:500000});
