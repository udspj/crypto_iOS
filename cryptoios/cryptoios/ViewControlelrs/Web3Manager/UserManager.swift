//
//  UserManager.swift
//  cryptoios
//
//  Created by sunpeijia on 2018/11/20.
//  Copyright © 2018年 udspj. All rights reserved.
//

import Foundation
import web3swift

//enum ShowLoadingType : String{
//    case hide = "hide"
//    case show = "show"
//    case showbk = "showbk"
//}
//
//enum NetCompleteStatus : Int {
//    case success = 1
//    case faild = 0
//}
//
//struct BaseNetManagerOptions{
//    let onlyID:String
//    let showLoading:ShowLoadingType
//    let showAlert:Bool
//    let ServerURL:String
//    let canBeCancelled:Bool
//    init(onlyID:String = "",showLoading:ShowLoadingType = .show,showAlert:Bool = true,ServerURL:String = UserInfo.getwebserverurl(),canBeCancelled:Bool = true) {
//        self.onlyID = onlyID
//        self.showLoading = showLoading
//        self.showAlert = showAlert
//        self.ServerURL = ServerURL
//        self.canBeCancelled = canBeCancelled
//    }
//}
//
////定义一个结构体，存储认证相关信息
//struct IdentityAndTrust {
//    var identityRef:SecIdentityRef
//    var trust:SecTrustRef
//    var certArray:AnyObject
//}
//
//enum Result<T> {
//    case Success(T)
//    case Failure(ErrorType)
//}
//extension Result {
//
//    func map<U>(f: T->U) -> Result<U> {
//        switch self {
//        case .Success(let t): return .Success(f(t))
//        case .Failure(let err): return .Failure(err)
//        }
//    }
//    func flatMap<U>(f: T->Result<U>) -> Result<U> {
//        switch self {
//        case .Success(let t): return f(t)
//        case .Failure(let err): return .Failure(err)
//        }
//    }
//}

class UserManager: NSObject {
    
    let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    var bip32keystoreManager:KeystoreManager?
    
    internal func getUserAddress() -> Address? {
        bip32keystoreManager = KeystoreManager.managerForPath(userDir + "/bip32_keystore", scanForHDwallets: true)
        var bip32ks: BIP32Keystore?
        if (bip32keystoreManager?.addresses.count == 0) {
            return ""
        } else {
            bip32ks = bip32keystoreManager?.walletForAddress((bip32keystoreManager?.addresses[0])!) as? BIP32Keystore
        }
        let bip32sender = bip32ks?.addresses.first
        return bip32sender
    }
    
//    internal func getKeystoreManager() -> KeystoreManager? {
//        return bip32keystoreManager
//    }
    
    internal func setUserAddressBy(mnemonics: String, password: String) -> Void {
        var bip32ks: BIP32Keystore?
        do {
            let mnemonics = try Mnemonics(mnemonics)
            bip32ks = try! BIP32Keystore(mnemonics: mnemonics, password: password)
            let keydata = try! JSONEncoder().encode(bip32ks!.keystoreParams)
            FileManager.default.createFile(atPath: userDir + "/bip32_keystore"+"/key.json", contents: keydata, attributes: nil)
            print("keydata")
        } catch {
            print("UserNotFound")
        }
    }
    
    // MARK: result check functions
    
//    func checkError(dic:Dictionary<String,AnyObject?>) -> Result<String> {
//        if dic["error"] is NSError {
//            let error = dic["error"] as! NSError
//            //            if (error.code == -999){
//            return .Failure(error.localizedDescription)
//            //            }
//        }
//        if dic["data"] is NSData {
//            let data = dic["data"] as! NSData
//            if let str:NSString = NSString(data: data, encoding: NSUTF8StringEncoding) {
//                return .Success(str as String)
//            }
//            return .Failure("转换data to string出错")
//        }
//        return .Failure("data is nil")
//    }
    
    
}
