
import Foundation
import web3swift
import BigInt

class Moeking: NSObject {
    
    let abi:String = "[{\"constant\":true,\"inputs\":[{\"name\":\"_itemId\",\"type\":\"uint256\"}],\"name\":\"tokenExists\",\"outputs\":[{\"name\":\"_exists\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_amount\",\"type\":\"uint256\"}],\"name\":\"withdrawAmount\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"name\",\"outputs\":[{\"name\":\"name\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_to\",\"type\":\"address\"},{\"name\":\"_itemId\",\"type\":\"uint256\"}],\"name\":\"approve\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\"}],\"name\":\"setOwner\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_admin\",\"type\":\"address\"}],\"name\":\"removeAdmin\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"name\":\"_totalSupply\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_itemRegistry\",\"type\":\"address\"}],\"name\":\"setItemRegistry\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"l\",\"type\":\"uint256\"},{\"name\":\"r\",\"type\":\"uint256\"},{\"name\":\"price\",\"type\":\"uint256\"},{\"name\":\"frozen\",\"type\":\"uint256\"}],\"name\":\"issueCard\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_from\",\"type\":\"address\"},{\"name\":\"_to\",\"type\":\"address\"},{\"name\":\"_itemId\",\"type\":\"uint256\"}],\"name\":\"transferFrom\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_admin\",\"type\":\"address\"}],\"name\":\"isAdmin\",\"outputs\":[{\"name\":\"_isAdmin\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_itemId\",\"type\":\"uint256\"}],\"name\":\"approvedFor\",\"outputs\":[{\"name\":\"_approved\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_itemId\",\"type\":\"uint256\"}],\"name\":\"allOf\",\"outputs\":[{\"name\":\"_owner\",\"type\":\"address\"},{\"name\":\"_price\",\"type\":\"uint256\"},{\"name\":\"_nextPrice\",\"type\":\"uint256\"},{\"name\":\"_free\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_itemId\",\"type\":\"uint256\"}],\"name\":\"listItemFromRegistry\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_itemId\",\"type\":\"uint256\"},{\"name\":\"_price\",\"type\":\"uint256\"},{\"name\":\"_owner\",\"type\":\"address\"}],\"name\":\"listItem\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_itemId\",\"type\":\"uint256\"}],\"name\":\"freeOf\",\"outputs\":[{\"name\":\"_free\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_from\",\"type\":\"uint256\"},{\"name\":\"_take\",\"type\":\"uint256\"}],\"name\":\"itemsForSaleLimit\",\"outputs\":[{\"name\":\"_items\",\"type\":\"uint256[]\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\"}],\"name\":\"tokensOf\",\"outputs\":[{\"name\":\"_tokenIds\",\"type\":\"uint256[]\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_itemId\",\"type\":\"uint256\"}],\"name\":\"nextPriceOf\",\"outputs\":[{\"name\":\"_nextPrice\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_itemId\",\"type\":\"uint256\"}],\"name\":\"ownerOf\",\"outputs\":[{\"name\":\"_owner\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_price\",\"type\":\"uint256\"}],\"name\":\"calculateDevCut\",\"outputs\":[{\"name\":\"_devCut\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_admin\",\"type\":\"address\"}],\"name\":\"addAdmin\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"name\":\"_balance\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[],\"name\":\"withdrawAll\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_itemIds\",\"type\":\"uint256[]\"}],\"name\":\"populateFromItemRegistry\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"symbol\",\"outputs\":[{\"name\":\"symbol\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_to\",\"type\":\"address\"},{\"name\":\"_itemId\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_itemId\",\"type\":\"uint256\"},{\"name\":\"_price\",\"type\":\"uint256\"}],\"name\":\"changePrice\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_itemId\",\"type\":\"uint256\"}],\"name\":\"priceOf\",\"outputs\":[{\"name\":\"_price\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_itemIds\",\"type\":\"uint256[]\"},{\"name\":\"_price\",\"type\":\"uint256\"},{\"name\":\"_owner\",\"type\":\"address\"}],\"name\":\"listMultipleItems\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_itemId\",\"type\":\"uint256\"}],\"name\":\"buy\",\"outputs\":[],\"payable\":true,\"stateMutability\":\"payable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_price\",\"type\":\"uint256\"}],\"name\":\"calculateNextPrice\",\"outputs\":[{\"name\":\"_nextPrice\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"_itemId\",\"type\":\"uint256\"},{\"indexed\":true,\"name\":\"_owner\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"_price\",\"type\":\"uint256\"}],\"name\":\"Bought\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"_itemId\",\"type\":\"uint256\"},{\"indexed\":true,\"name\":\"_owner\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"_price\",\"type\":\"uint256\"}],\"name\":\"Sold\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"_from\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"_to\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"_tokenId\",\"type\":\"uint256\"}],\"name\":\"Transfer\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"_owner\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"_approved\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"_tokenId\",\"type\":\"uint256\"}],\"name\":\"Approval\",\"type\":\"event\"}]"
    
    let contract = Address("0xc7069173721f6cd6322ce61f5912b31315c40fc2")
    let infura = Web3(infura: .mainnet)
    let usermanager:UserManager = UserManager()
    
    internal func getTotalSupply() -> Int {
        do {
            let address = usermanager.getUserAddress()
            let contract = try infura.contract(abi, at: self.contract)
            var options = Web3Options.default
            options.from = address
            let transactionIntermediate = try contract.method("totalSupply", options: options)
            let result = try transactionIntermediate.call(options: options)
            let res = result["0"]!
            let strValue:String = "\(res)"
            return Int(strValue)!
        } catch let error{
            print("UserNotFound")
            print(error)
        }
        return 0
    }
    
    internal func getItemIds(limit: Int) -> [Int] {
        do {
            let address = usermanager.getUserAddress()
            let contract = try infura.contract(abi, at: self.contract)
            var options = Web3Options.default
            options.from = address
            let transactionIntermediate = try contract.method("itemsForSaleLimit", parameters:[0,limit] as [AnyObject], options: options)
            let result = try transactionIntermediate.call(options: options)
            let res = result["0"]! as! NSArray
            let types = res.map { token -> Int in
                let strValue:String = "\(token)"
                return Int(strValue)!
            }
            return types
        } catch let error{
            print("UserNotFound")
            print(error)
        }
        return []
    }
    
    internal func getItemInfo(itemid: Int) {
        do {
            let address = usermanager.getUserAddress()
            let contract = try infura.contract(abi, at: self.contract)
            var options = Web3Options.default
            options.from = address
            let transactionIntermediate = try contract.method("allOf", parameters:[itemid] as [AnyObject], options: options)
            let result = try transactionIntermediate.call(options: options)
            print(result["0"])
            print(result["1"])
            print(result["2"])
            print(result["3"])
            var owner = "\(result["0"]!)"
//            owner = String(owner[..<owner.index(owner.startIndex, offsetBy: 8)])
            let start = owner.index(owner.startIndex, offsetBy: 2)
            let end = owner.index(owner.endIndex, offsetBy: -34)
            let range = start..<end
            owner = String(owner[range])
            let nowprice = Double("\(result["1"]!)")
            let nextprice = Double("\(result["2"]!)")
            let freetime = result["3"]!
            print(owner)
            print(Utils.convertWeiToETH(wei: nowprice!))
            print(Utils.convertWeiToETH(wei: nextprice!))
        } catch let error{
            print("UserNotFound")
            print(error)
        }
    }
    
    //    private func getCardsType(cardid:Any) -> Int {
    //        do {
    //            let address = usermanager.getUserAddress()
    //            let contract = try infura.contract(drawabi, at: self.drawContract)
    //            var options = Web3Options.default
    //            options.from = address
    //            let transactionIntermediate = try contract.method("typesOf", parameters:[cardid] as [AnyObject], options: options)
    //            let result = try transactionIntermediate.call(options: options)
    //            let res = result["0"]!
    //            let strValue:String = "\(res)"
    //            return Int(strValue)!
    //        } catch let error{
    //            print("UserNotFound")
    //            print(error)
    //        }
    //        return 999
    //    }
    //
    //    internal func drawCard(password: String) -> String {
    //        do {
    //            let address = usermanager.getUserAddress()
    //            let keystoreManager = usermanager.bip32keystoreManager
    //            infura.addKeystoreManager(keystoreManager)
    //
    //            let contract = try infura.contract(drawabi, at: self.drawContract)
    //            var options = Web3Options.default
    //            options.from = address
    //            options.gasLimit = BigUInt(21000)
    //            options.value = BigUInt(1000000000000000)
    //
    //            let estimatedGas = try contract.method("buy", parameters:[Address("0x0c279cf1b8585a14b432f89af8d23564e8dbd7d5")] as [AnyObject], options: options).estimateGas(options: nil)
    //            options.gasLimit = estimatedGas
    //            let transactionIntermediate = try contract.method("buy", parameters:[Address("0x0c279cf1b8585a14b432f89af8d23564e8dbd7d5")] as [AnyObject], options: options)
    //            let result = try transactionIntermediate.send(password: password)
    //            print(result)
    //            return "success"
    //        } catch let error{
    //            print("UserNotFound")
    //            print(error)
    //            return "\(error)"
    //        }
    //    }
    
    
}
