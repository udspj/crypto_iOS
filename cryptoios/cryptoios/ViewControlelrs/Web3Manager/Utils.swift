
import Foundation

class Utils {
    
    static func convertWeiToETH(wei: Double) -> Double {
        let bigint:Double = 100000000000000000
        return wei/bigint
    }
    
}
