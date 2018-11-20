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
    var userDir : String?
    var keystoreManager : KeystoreManager?
    var bip32keystoreManager : KeystoreManager?
    var bigint:BigUInt = 100000000000000000
    var usermanager:UserManager = UserManager()
    
    var web3Main : Web3?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addr = usermanager.getUserAddress()
        print(addr)
        print(addr?.isValid)
        print(type(of: addr!.address))
        
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let keystoreManager = KeystoreManager.managerForPath(userDir + "/keystore")
        
        //create BIP32 keystore
        let bip32keystoreManager = KeystoreManager.managerForPath(userDir + "/bip32_keystore", scanForHDwallets: true)
        var bip32ks: BIP32Keystore?
        if (bip32keystoreManager?.addresses.count == 0) {
            let mnemonics = try! Mnemonics("region accuse kidney buddy habit soccer budget boat end poem record tag")
            bip32ks = try! BIP32Keystore(mnemonics: mnemonics, password: "11111111")
            let keydata = try! JSONEncoder().encode(bip32ks!.keystoreParams)
            FileManager.default.createFile(atPath: userDir + "/bip32_keystore"+"/key.json", contents: keydata, attributes: nil)
        } else {
            bip32ks = bip32keystoreManager?.walletForAddress((bip32keystoreManager?.addresses[0])!) as? BIP32Keystore
        }
        guard let bip32sender = bip32ks?.addresses.first else {return}
        print(bip32sender)
        
        let address: Address = "0xaada27b678B00aD0acDc1e7bB391f5c0a8590724"
        let web3Main = Web3(infura: .mainnet)
        let balance: BigUInt = try! web3Main.eth.getBalance(address: address)
        print(balance)
        
//        userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//
//        let queue = OperationQueue()
//        queue.addOperation {
//            self.createNormalKeystore()
//            try? self.createBIP32Keystore()
//            try? self.SetupMainAccount()
//        }
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
