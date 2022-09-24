//
//  Hash.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 24/09/2022.
//

import Foundation

import Foundation
import CommonCrypto

class Hash {
    static func MD5(string: String) -> String {
        if let strData = string.data(using: String.Encoding.utf8) {
            /// #define CC_MD5_DIGEST_LENGTH    16          /* digest length in bytes */
            /// Creates an array of unsigned 8 bit integers that contains 16 zeros
            var digest = [UInt8](repeating: 0, count:Int(CC_MD5_DIGEST_LENGTH))
            
            /// CC_MD5 performs digest calculation and places the result in the caller-supplied buffer for digest (md)
            /// Calls  the given closure with a pointer to the underlying unsafe bytes of the strData’s contiguous storage.
            strData.withUnsafeBytes {
                // CommonCrypto
                // extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md) --|
                // OpenSSL                                                                          |
                // unsigned char *MD5(const unsigned char *d, size_t n, unsigned char *md)        <-|
                CC_MD5($0.baseAddress, UInt32(strData.count), &digest)
            }
            
            
            var md5String = ""
            /// Unpack each byte in the digest array and add them to the md5String
            for byte in digest {
                md5String += String(format:"%02x", UInt8(byte))
            }
            
            // MD5 hash check (This is just done for example)
            if md5String.uppercased() == "8D84E6C45CE9044CAE90C064997ACFF1" {
                print("Matching MD5 hash: 8D84E6C45CE9044CAE90C064997ACFF1")
            } else {
                print("MD5 hash does not match: \(md5String)")
            }
            return md5String
            
        }
        return ""
    }
}
