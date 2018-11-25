//
//  MeMainViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit
import BigInt
import web3swift
import Foundation

class MeMainViewController: UIViewController {
    
    @IBOutlet var addrLabel: UILabel!
    @IBOutlet var balLabel: UILabel!
    
    var userDir : String?
    var keystoreManager : KeystoreManager?
    var bip32keystoreManager : KeystoreManager?
    var bigint:Double = 100000000000000000
    var usermanager:UserManager = UserManager()
    
    var web3Main : Web3?
    let abi:String = "[{\"constant\":false,\"inputs\":[{\"name\":\"_amount\",\"type\":\"uint256\"}],\"name\":\"withdrawAmount\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"name\",\"outputs\":[{\"name\":\"_name\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_to\",\"type\":\"address\"},{\"name\":\"_tokenId\",\"type\":\"uint256\"}],\"name\":\"approve\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\"}],\"name\":\"setOwner\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_admin\",\"type\":\"address\"}],\"name\":\"removeAdmin\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"name\":\"_totalSupply\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_from\",\"type\":\"address\"},{\"name\":\"_to\",\"type\":\"address\"},{\"name\":\"_tokenId\",\"type\":\"uint256\"}],\"name\":\"transferFrom\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_admin\",\"type\":\"address\"}],\"name\":\"isAdmin\",\"outputs\":[{\"name\":\"_isAdmin\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_tokenId\",\"type\":\"uint256\"}],\"name\":\"approvedFor\",\"outputs\":[{\"name\":\"_approved\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\"}],\"name\":\"tokensOf\",\"outputs\":[{\"name\":\"_tokenIds\",\"type\":\"uint256[]\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_tokenId\",\"type\":\"uint256\"}],\"name\":\"ownerOf\",\"outputs\":[{\"name\":\"_owner\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_admin\",\"type\":\"address\"}],\"name\":\"addAdmin\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"name\":\"_balance\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[],\"name\":\"withdrawAll\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"symbol\",\"outputs\":[{\"name\":\"_symbol\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"to\",\"type\":\"address\"}],\"name\":\"issueTokenAndApprove\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[],\"name\":\"issueToken\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_to\",\"type\":\"address\"},{\"name\":\"_tokenId\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"to\",\"type\":\"address\"}],\"name\":\"issueTokenAndTransfer\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"_tokenId\",\"type\":\"uint256\"},{\"indexed\":true,\"name\":\"_owner\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"_price\",\"type\":\"uint256\"}],\"name\":\"Bought\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"_tokenId\",\"type\":\"uint256\"},{\"indexed\":true,\"name\":\"_owner\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"_price\",\"type\":\"uint256\"}],\"name\":\"Sold\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"_from\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"_to\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"_tokenId\",\"type\":\"uint256\"}],\"name\":\"Transfer\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"_owner\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"_approved\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"_tokenId\",\"type\":\"uint256\"}],\"name\":\"Approval\",\"type\":\"event\"}]"
    let drawabi:String = "[{\"constant\":false,\"inputs\":[{\"name\":\"_amount\",\"type\":\"uint256\"}],\"name\":\"withdrawAmount\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\"}],\"name\":\"setOwner\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_admin\",\"type\":\"address\"}],\"name\":\"removeAdmin\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_admin\",\"type\":\"address\"}],\"name\":\"isAdmin\",\"outputs\":[{\"name\":\"_isAdmin\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_addr\",\"type\":\"address\"}],\"name\":\"setContractAddr\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"to\",\"type\":\"address\"},{\"name\":\"count\",\"type\":\"uint256\"},{\"name\":\"_type\",\"type\":\"uint256\"}],\"name\":\"bonusIssue\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_admin\",\"type\":\"address\"}],\"name\":\"addAdmin\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"rollDice\",\"outputs\":[{\"name\":\"_result\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[],\"name\":\"withdrawAll\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_tokenId\",\"type\":\"uint256\"}],\"name\":\"typesOf\",\"outputs\":[{\"name\":\"_type\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"mainContractAddr\",\"outputs\":[{\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"name\":\"types\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_referrer\",\"type\":\"address\"}],\"name\":\"buy\",\"outputs\":[],\"payable\":true,\"stateMutability\":\"payable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"sigmaType\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"buyerAddr\",\"type\":\"address\"}],\"name\":\"Buy\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"playerAddr\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"prizeIssuer\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"prizeId\",\"type\":\"uint256\"}],\"name\":\"RollDice\",\"type\":\"event\"}]"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addr = usermanager.getUserAddress()
        addrLabel.text = addr!.address
        let web3Main = Web3(infura: .kovan)
        let balance: BigUInt = try! web3Main.eth.getBalance(address: addr!)
        print(Double(balance.words[0])/bigint)
        balLabel.text = "余额："+String(Double(balance.words[0])/bigint)+" eth"
        
        let constractAddress = Address("0x39f8a3ff4e5097e57c777857697836079a51dc1d")
        let contract = ERC721(constractAddress)
        let gasPrice = contract.gasPrice
        print(gasPrice)
        
//        let queue = OperationQueue()
//        queue.addOperation {
//            do {
//                let res = try contract.address.call("tokensOf(address)", Address(addr!.address)).wait().array(){ try $0.uint256()}
//                print(res)
//            } catch let error{
//                print("UserNotFound")
//                print(error)
//            }
//        }
        
        
        
//        do {
//            let ethContractAddress = Address("0x39f8a3ff4e5097e57c777857697836079a51dc1d")
//        let infura = Web3(infura: .kovan)
//        // 1
//        let contract = try infura.contract(abi, at: ethContractAddress)
//        // 2
//        var options = Web3Options.defaultOptions()
//        options.from = Address(addr!.address)
//        // 3
//            let transactionIntermediate = try contract.method("tokensOf", parameters:[Address(addr!.address)] as [AnyObject], options: options)
//        // 4
//            let result = try transactionIntermediate.call(options: options)
//
//            print(result["0"])
//                        } catch let error{
//                            print("UserNotFound")
//                            print(error)
//                        }
        
        do {
            let ethContractAddress = Address("0xc6d6d2c0eb7d64467ad02efc54496cdfc2fe55d6")
            let infura = Web3(infura: .kovan)
            let keystoreManager = usermanager.bip32keystoreManager
            infura.addKeystoreManager(keystoreManager)
            // 1
            let contract = try infura.contract(drawabi, at: ethContractAddress)
            // 2
            var options = Web3Options.default
            options.from = Address(addr!.address)
            options.gasLimit = BigUInt(21000)
            options.value = BigUInt(1000000000000000)
            // 3
            let estimatedGas = try contract.method("buy", parameters:[Address("0x0c279cf1b8585a14b432f89af8d23564e8dbd7d5")] as [AnyObject], options: options).estimateGas(options: nil)
            print(estimatedGas)
            options.gasLimit = estimatedGas
            let transactionIntermediate = try contract.method("buy", parameters:[Address("0x0c279cf1b8585a14b432f89af8d23564e8dbd7d5")] as [AnyObject], options: options)
            print(estimatedGas)
            // 4
            let result = try transactionIntermediate.send(password: "11111111")
            
            print(result)
        } catch let error{
            print("UserNotFound")
            print(error)
        }
        
    }
    
    func createNormalKeystore()  {
        keystoreManager = KeystoreManager.managerForPath(userDir! + "/keystore")
        var ks: EthereumKeystoreV3?
        if (keystoreManager?.addresses.count == 0) {
            ks = try! EthereumKeystoreV3(password: "BANKEXFOUNDATION")
            let keydata = try! JSONEncoder().encode(ks!.keystoreParams)
            FileManager.default.createFile(atPath: userDir! + "/keystore"+"/key.json", contents: keydata, attributes: nil)
        } else {
            ks = keystoreManager?.walletForAddress((keystoreManager?.addresses[0])!) as? EthereumKeystoreV3
        }
        guard let sender = ks?.addresses.first else {return}
        print(sender)
    }
    
    func createBIP32Keystore() throws {
        //create BIP32 keystore
        bip32keystoreManager = KeystoreManager.managerForPath(userDir! + "/bip32_keystore", scanForHDwallets: true)
        var bip32ks: BIP32Keystore?
        if (bip32keystoreManager?.addresses.count == 0) {
            let mnemonics = try Mnemonics("normal dune pole key case cradle unfold require tornado mercy hospital buyer")
            bip32ks = try BIP32Keystore(mnemonics: mnemonics, password: "BANKEXFOUNDATION")
            let keydata = try! JSONEncoder().encode(bip32ks!.keystoreParams)
            FileManager.default.createFile(atPath: userDir! + "/bip32_keystore"+"/key.json", contents: keydata, attributes: nil)
        } else {
            bip32ks = bip32keystoreManager?.walletForAddress((bip32keystoreManager?.addresses[0])!) as? BIP32Keystore
        }
        guard let bip32sender = bip32ks?.addresses.first else {return}
        print(bip32sender)
    }
    
    func SetupMainAccount() throws {
        // BKX TOKEN
        web3Main = Web3(infura: .mainnet)
        let coldWalletAddress = Address("0x6394b37Cf80A7358b38068f0CA4760ad49983a1B")
        let constractAddress = Address("0x45245bc59219eeaaf6cd3f382e078a461ff9de7b")
        let gasPrice = try web3Main!.eth.getGasPrice()
        var options = Web3Options.default
        options.gasPrice = gasPrice
        options.from = Address("0xE6877A4d8806e9A9F12eB2e8561EA6c1db19978d")
        
        web3Main!.addKeystoreManager(keystoreManager)
        
        let contract = ERC20(constractAddress)
        let tokenName = try contract.name()
        print("BKX token name = \(tokenName)")
        let balance = try contract.balance(of: coldWalletAddress)
        print("BKX token balance = \(balance)")
        
        getBlance(address: coldWalletAddress)
    }
    
    func getBlance(address: Address) {
        let balance :BigUInt = try! (web3Main?.eth.getBalance(address: address))!;
        print("balance: \(balance)")
    }


    @IBAction func tapTrans(_ sender: Any) {
        let vc = TransactionViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapAsset(_ sender: Any) {
        let vc = AssetsViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
}
