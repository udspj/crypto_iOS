//
//  W3Personal.swift
//  web3swift
//
//  Created by Dmitry on 10/11/2018.
//  Copyright © 2018 Bankex Foundation. All rights reserved.
//

import Foundation

@objc public class W3Personal: NSObject {
    public var swift: Web3Personal {
        return web3.swift.personal
    }
    unowned var web3: W3Web3
    @objc public init(web3: W3Web3) {
        self.web3 = web3
    }
    /**
     *Locally or remotely sign a message (arbitrary data) with the private key. To avoid potential signing of a transaction the message is first prepended by a special header and then hashed.*
     
     - parameter message: Message Data
     - parameter from: Use a private key that corresponds to this account
     - parameter password: Password for account if signing locally
     - returns: signed message data
     - important: This call is synchronous
     
     */
    @objc public func signPersonalMessage(message: Data, from: W3Address, password: String = "BANKEXFOUNDATION") throws -> Data {
        return try swift.signPersonalMessage(message: message, from: from.swift, password: password)
    }
    
    /**
     *Unlock an account on the remote node to be able to send transactions and sign messages.*
     
     - parameter account: W3Address of the account to unlock
     - parameter password: Password to use for the account
     - parameter seconds: Time inteval before automatic account lock by Ethereum node
     - returns: isUnlocked
     - important: This call is synchronous. Does nothing if private keys are stored locally.
     
     */
    @objc public func unlockAccount(account: W3Address, password: String = "BANKEXFOUNDATION", seconds: UInt64 = 300, error pointer: ErrorPointer) -> Bool {
        do {
            return try swift.unlockAccount(account: account.swift, password: password, seconds: seconds)
        } catch {
            pointer?.pointee = error as NSError
            return false
        }
    }
    
    /**
     *Recovers a signer of some message. Message is first prepended by special prefix (check the "signPersonalMessage" method description) and then hashed.*
     
     - parameter personalMessage: Message Data
     - parameter signature: Serialized signature, 65 bytes
     - returns: signer address
     
     */
    @objc public func ecrecover(personalMessage: Data, signature: Data) throws -> W3Address {
        return try swift.ecrecover(personalMessage: personalMessage, signature: signature).objc
    }
    
    /**
     *Recovers a signer of some hash. Checking what is under this hash is on behalf of the user.*
     
     - parameter hash: Signed hash
     - parameter signature: Serialized signature, 65 bytes
     - returns: signer address
     
     */
    @objc public func ecrecover(hash: Data, signature: Data) throws -> W3Address {
        return try swift.ecrecover(hash: hash, signature: signature).objc
    }
}
