//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

//import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/cryptography/MerkleProofUpgradeable.sol";


contract JToken_V2 is ERC721Upgradeable, OwnableUpgradeable {
      using StringsUpgradeable for uint256;
      using CountersUpgradeable for CountersUpgradeable.Counter;
      
      CountersUpgradeable.Counter private _nextTokenId;

      uint256 public value;
      uint256 public price;
      uint256 public maxSupply;
      uint256 public currentSupply;
      string public baseExtension;
      string public notRevealedUri;
    
      bool public mintActive;
      bool public earlyMintActive;
      bool public revealed;
    
      string public baseURI;
      bytes32 public merkleRoot;

      mapping(uint256 => string) private _tokenURIs;
      mapping(address => uint256) public addressMintedBalance;
      mapping(address => bool) public whitelistClaimed;

    //   constructor(
    //       string memory _initNotRevealedUri
    //   ) ERC721("AppWorks", "AW") {
    //       setNotRevealedURI(_initNotRevealedUri);
    //   }

//   function initialize(string memory _initNotRevealedUri) initializer public {
//     __ERC721_init("AppWorks", "AW");

//       price = 0.01 ether;
//       maxSupply = 100;
//       currentSupply = 0; 
//       baseExtension = ".json";
//       notRevealedUri;
//       value = 111;
    
//       mintActive = false;
//       earlyMintActive = false;
//       revealed = false;
      
//       setNotRevealedURI(_initNotRevealedUri);
//   }

//For upgrade notRevealUri
  function setNotRevealedURI(string memory _notRevealedUri) public {
      notRevealedUri = _notRevealedUri;
  }

  //For testing use
  function retrieve(uint256 _newValue) public view returns (uint256){
    return _newValue;
  }

  // Public mint function - week 8
  function mint(address _to, uint256 _mintAmount) public payable {
    //Please make sure you check the following things:
    //Current state is available for Public Mint
    require(mintActive = true, "not available to mint now");
    //Check how many NFTs are available to be minted
    require(totalSupply() < maxSupply, "not enoght token to mint");
    //Check user has sufficient funds
    require(msg.value >= _mintAmount * price, "the amount of your payment is too low");
    
    for (uint256 i = 0; i < _mintAmount; i++){
      uint256 mintIndex = _nextTokenId.current();
      setMintMaxAmount( _mintAmount);
      _mint(_to, mintIndex);
      _nextTokenId.increment();
    }
  }
  
  // Implement totalSupply() Function to return current total NFT being minted - week 8
  function totalSupply() internal view returns (uint256){
      return currentSupply;
  }

  // Implement withdrawBalance() Function to withdraw funds from the contract - week 8
  function withdrawBalance() external payable onlyOwner(){
      require(address(this).balance > 0);
      payable(owner()).transfer(address(this).balance);
  }

  // Implement setPrice(price) Function to set the mint price - week 8
  function setPrice(uint _newPrice) internal {
      price = _newPrice;
  }
 
  // Implement toggleMint() Function to toggle the public mint available or not - week 8
  function toggleMint() public onlyOwner {
      mintActive = !mintActive;
  }

  // Set mint per user limit to 10 and owner limit to 20 - Week 8
  function setMintMaxAmount(uint256 _mintAmount) view internal {
      if (msg.sender == owner()){
      require(addressMintedBalance[msg.sender] + _mintAmount <= 20, "Owner Max Amount is 20");
    }else {
      require(addressMintedBalance[msg.sender] + _mintAmount <= 10, "User Max Amount is 10");
    }

  }

  // Implement toggleReveal() Function to toggle the blind box is revealed - week 9
  function toggleReveal() public onlyOwner() {
      revealed = true;
  }

  // Implement setBaseURI(newBaseURI) Function to set BaseURI - week 9
  function setBaseURI(string memory _newBaseURI) public onlyOwner() {
      baseURI = _newBaseURI;
  }

  // Function to return the base URI
  function _baseURI(uint _nextTokenIdforBaseUri) 
    public 
    view 
    virtual 
    returns (string memory) 
  {
    if(revealed == false){
        return notRevealedUri;
    }

    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
    ? string(abi.encodePacked(currentBaseURI, _nextTokenIdforBaseUri.toString(), baseExtension)) : "";
  }

  // Early mint function for people on the whitelist - week 9
  function earlyMint(bytes32[] calldata _merkleProof, uint256 _mintAmount) public payable {
    //Please make sure you check the following things:
    //Current state is available for Early Mint
    require(earlyMintActive == true);
    //Check how many NFTs are available to be minted
    setMintMaxAmount( _mintAmount);
    //Check user is in the whitelist - use merkle tree to validate
    require(!whitelistClaimed[msg.sender], "Address already claimed");
    
    bytes32 leaf = keccak256(abi.encodePacked(msg.sender)); //Generate a leaf from the caller of this function
    
    require(
        MerkleProofUpgradeable.verify(_merkleProof, merkleRoot, leaf), 
        "Invalid Merkle Proof.");//Check for an invalid proof
    
    whitelistClaimed[msg.sender] = true;
    
    //Check user has sufficient funds
    require(msg.value >= _mintAmount * price, "the amount of your payment is too low");
    mint(msg.sender, _mintAmount);
  }
  
  // Implement toggleEarlyMint() Function to toggle the early mint available or not - week 9
  function toggleEarlyMint() external {
      earlyMintActive = !earlyMintActive;
  }

  // Implement setMerkleRoot(merkleRoot) Function to set new merkle root - week 9
  function setMarkleRoot(bytes32 _merkleRoot) external {
      merkleRoot = _merkleRoot;
  }

  // Let this contract can be upgradable, using openzepplin proxy library - week 10
  // Try to modify blind box images by using proxy
  
}