//
//  BloomFilter.swift
//  web3swift
//
//  Created by Alexander Vlasov on 02.03.2018.
//  Copyright © 2018 Bankex Foundation. All rights reserved.
//

import BigInt
import CryptoSwift
import Foundation

public struct EthereumBloomFilter {
    public var bytes = Data(repeatElement(UInt8(0), count: 256))
    public init?(_ biguint: BigUInt) {
        guard let data = biguint.serialize().setLengthLeft(256) else { return nil }
        bytes = data
    }

    public init() {}
    public init(_ data: Data) {
        let padding = Data(repeatElement(UInt8(0), count: 256 - data.count))
        bytes = padding + data
    }
    public func asBigUInt() -> BigUInt {
        return BigUInt(bytes)
    }
}

//
// func (b Bloom) Test(test *big.Int) bool {
//    return BloomLookup(b, test)
// }
//
// func (b Bloom) TestBytes(test []byte) bool {
//    return b.Test(new(big.Int).SetBytes(test))
//
// }
//
//// MarshalText encodes b as a hex string with 0x prefix.
// func (b Bloom) MarshalText() ([]byte, error) {
//    return hexutil.Bytes(b[:]).MarshalText()
// }
//
//// UnmarshalText b as a hex string with 0x prefix.
// func (b *Bloom) UnmarshalText(input []byte) error {
//    return hexutil.UnmarshalFixedText("Bloom", input, b[:])
// }

extension EthereumBloomFilter {
    static func bloom9(_ biguint: BigUInt) -> BigUInt {
        return EthereumBloomFilter.bloom9(biguint.serialize())
    }

    static func bloom9(_ data: Data) -> BigUInt {
        var b = data.sha3(.keccak256)
        var r = BigUInt(0)
        let mask = BigUInt(2047)
        for i in stride(from: 0, to: 6, by: 2) {
            var t = BigUInt(1)
            let num = (BigUInt(b[i + 1]) + (BigUInt(b[i]) << 8)) & mask
//            b = num.serialize().setLengthLeft(8)!
            t = t << num
            r = r | t
        }
        return r
    }

    static func logsToBloom(_ logs: [EventLog]) -> BigUInt {
        var bin = BigUInt(0)
        for log in logs {
            bin = bin | bloom9(log.address.addressData)
            for topic in log.topics {
                bin = bin | bloom9(topic)
            }
        }
        return bin
    }

    public static func createBloom(_ receipts: [TransactionReceipt]) -> EthereumBloomFilter? {
        var bin = BigUInt(0)
        for receipt in receipts {
            bin = bin | EthereumBloomFilter.logsToBloom(receipt.logs)
        }
        return EthereumBloomFilter(bin)
    }

    public func test(topic: Data) -> Bool {
        let bin = asBigUInt()
        let comparison = EthereumBloomFilter.bloom9(topic)
        return bin & comparison == comparison
    }

    public func test(topic: BigUInt) -> Bool {
        return test(topic: topic.serialize())
    }

    public static func bloomLookup(_ bloom: EthereumBloomFilter, topic: Data) -> Bool {
        let bin = bloom.asBigUInt()
        let comparison = bloom9(topic)
        return bin & comparison == comparison
    }

    public static func bloomLookup(_ bloom: EthereumBloomFilter, topic: BigUInt) -> Bool {
        return EthereumBloomFilter.bloomLookup(bloom, topic: topic.serialize())
    }

    public mutating func add(_ biguint: BigUInt) {
        var bin = BigUInt(bytes)
        bin = bin | EthereumBloomFilter.bloom9(biguint)
        setBytes(bin.serialize())
    }

    public mutating func add(_ data: Data) {
        var bin = BigUInt(bytes)
        bin = bin | EthereumBloomFilter.bloom9(data)
        setBytes(bin.serialize())
    }

    public func lookup(_ topic: Data) -> Bool {
        return EthereumBloomFilter.bloomLookup(self, topic: topic)
    }

    mutating func setBytes(_ data: Data) {
        if bytes.count < data.count {
            fatalError("bloom bytes are too big")
        }
        bytes = bytes[0 ..< data.count] + data
    }
}
