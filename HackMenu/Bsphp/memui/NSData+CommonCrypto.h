/*
 *  NSData+CommonCrypto.h
 *  AQToolkit
 *
 *  Created by Jim Dovey on 31/8/2008.
 *
 *  Copyright (c) 2008-2009, Jim Dovey
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *  Redistributions of source code must retain the above copyright notice,
 *  this list of conditions and the following disclaimer.
 *  
 *  Redistributions in binary form must reproduce the above copyright
 *  notice, this list of conditions and the following disclaimer in the
 *  documentation and/or other materials provided with the distribution.
 *  
 *  Neither the name of this project's author nor the names of its
 *  contributors may be used to endorse or promote products derived from
 *  this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
 *  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

#import <Foundation/NSData.h>
#import <Foundation/NSError.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>

extern NSString * const kCommonCryptoErrorDomain;

@interface NSError (CommonCryptoErrorDomain)
+ (NSError *)__attribute__((optnone)) errorWithCCCryptorStatus: (CCCryptorStatus) status;
@end

@interface NSData (CommonDigest)

- (NSData *) __attribute__((optnone))MD2Sum;
- (NSData *) __attribute__((optnone))MD4Sum;
- (NSData *) __attribute__((optnone))MD5Sum;

- (NSData *) __attribute__((optnone))SHA1Hash;
- (NSData *) __attribute__((optnone))SHA224Hash;
- (NSData *) __attribute__((optnone))SHA256Hash;
- (NSData *)__attribute__((optnone)) SHA384Hash;
- (NSData *)__attribute__((optnone)) SHA512Hash;

@end

@interface NSData (CommonCryptor)

- (NSData *) __attribute__((optnone))AES256EncryptedDataUsingKey: (id) key error: (NSError **) error;
- (NSData *) __attribute__((optnone))decryptedAES256DataUsingKey: (id) key error: (NSError **) error;

- (NSData *) __attribute__((optnone))DESEncryptedDataUsingKey: (id) key error: (NSError **) error;
- (NSData *) __attribute__((optnone))decryptedDESDataUsingKey: (id) key error: (NSError **) error;

- (NSData *) __attribute__((optnone))CASTEncryptedDataUsingKey: (id) key error: (NSError **) error;
- (NSData *) __attribute__((optnone))decryptedCASTDataUsingKey: (id) key error: (NSError **) error;

@end

@interface NSData (LowLevelCommonCryptor)

- (NSData *) __attribute__((optnone))dataEncryptedUsingAlgorithm: (CCAlgorithm) algorithm
                                     key: (id) key		// data or string
                                   error: (CCCryptorStatus *) error;
- (NSData *)__attribute__((optnone)) dataEncryptedUsingAlgorithm: (CCAlgorithm) algorithm
                                     key: (id) key		// data or string
                                 options: (CCOptions) options
                                   error: (CCCryptorStatus *) error;
- (NSData *) __attribute__((optnone))dataEncryptedUsingAlgorithm: (CCAlgorithm) algorithm
                                     key: (id) key		// data or string
                    initializationVector: (id) iv		// data or string
                                 options: (CCOptions) options
                                   error: (CCCryptorStatus *) error;

- (NSData *) __attribute__((optnone))decryptedDataUsingAlgorithm: (CCAlgorithm) algorithm
                                     key: (id) key		// data or string
                                   error: (CCCryptorStatus *) error;
- (NSData *) __attribute__((optnone))decryptedDataUsingAlgorithm: (CCAlgorithm) algorithm
                                     key: (id) key		// data or string
                                 options: (CCOptions) options
                                   error: (CCCryptorStatus *) error;
- (NSData *)__attribute__((optnone)) decryptedDataUsingAlgorithm: (CCAlgorithm) algorithm
                                     key: (id) key		// data or string
                    initializationVector: (id) iv		// data or string
                                 options: (CCOptions) options
                                   error: (CCCryptorStatus *) error;

@end

@interface NSData (CommonHMAC)

- (NSData *)__attribute__((optnone)) HMACWithAlgorithm: (CCHmacAlgorithm) algorithm;
- (NSData *)__attribute__((optnone)) HMACWithAlgorithm: (CCHmacAlgorithm) algorithm key: (id) key;

@end
