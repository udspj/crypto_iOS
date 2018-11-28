
import UIKit
import BigInt
import web3swift
import Foundation
import BlockiesSwift

class MeMainViewController: UIViewController {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var addrLabel: UILabel!
    @IBOutlet var balLabel: UILabel!
    
    var userDir : String?
    var keystoreManager : KeystoreManager?
    var bip32keystoreManager : KeystoreManager?
//    var bigint:Double = 100000000000000000
    var usermanager:UserManager = UserManager()
    var linkidol:Linkidol = Linkidol()
    
    var web3Main : Web3?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addr = usermanager.getUserAddress()
        addrLabel.text = addr!.address
        generateUserAvatar(address: addr!.address)
        let web3Main = Web3(infura: .kovan)
        let queue = OperationQueue()
        queue.addOperation { () -> Void in
            let balance: BigUInt = try! web3Main.eth.getBalance(address: addr!)
            OperationQueue.main.addOperation({[unowned self] () -> Void in
//                print(Double(balance.words[0])/self.bigint)
                self.balLabel.text = "余额："+String(Utils.convertWeiToETH(wei: Double(balance.words[0])))+" eth"
            })
        }
        
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
        
//        linkidol.drawCard(password: "11111111")
        
//        do {
//            let ethContractAddress = Address("0xc6d6d2c0eb7d64467ad02efc54496cdfc2fe55d6")
//            let infura = Web3(infura: .kovan)
//            let keystoreManager = usermanager.bip32keystoreManager
//            infura.addKeystoreManager(keystoreManager)
//            // 1
//            let contract = try infura.contract(drawabi, at: ethContractAddress)
//            // 2
//            var options = Web3Options.default
//            options.from = Address(addr!.address)
//            options.gasLimit = BigUInt(21000)
//            options.value = BigUInt(1000000000000000)
//            // 3
//            let estimatedGas = try contract.method("buy", parameters:[Address("0x0c279cf1b8585a14b432f89af8d23564e8dbd7d5")] as [AnyObject], options: options).estimateGas(options: nil)
//            print(estimatedGas)
//            options.gasLimit = estimatedGas
//            let transactionIntermediate = try contract.method("buy", parameters:[Address("0x0c279cf1b8585a14b432f89af8d23564e8dbd7d5")] as [AnyObject], options: options)
//            print(estimatedGas)
//            // 4
//            let result = try transactionIntermediate.send(password: "11111111")
//
//            print(result)
//        } catch let error{
//            print("UserNotFound")
//            print(error)
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
    
    func generateUserAvatar(address: String)  {
        let blockies = Blockies(
            seed: address,
            size: 8,  // 8x8 = 64 blocks.
            scale: 3 // size of each block
        )
        // 8*3 * 10 = 240 x 240 image
        let img = blockies.createImage(customScale: 10)
        
        avatarImageView.image = img
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
