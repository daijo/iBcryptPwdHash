//
//  DHPwdHashUtil.h
//  iBcryptPwdHash
//
//  Created by Daniel Hjort on 5/2/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHPwdHashUtil : NSObject

/*
 * BCrypt password hashing have the following steps:
 *
 * 1) Extract the domain.
 * 2) Generate salt if not supplied.
 * 3) Append password after domain.
 * 4) Hash the appended strings.
 * 5) Remove the salt from the beginning of the hash result.
 * 6) Check if the user supplied password was alphanumeric.
 * 7) Apply constraints to the remaining string (alphanumerical/non-alhpahnumerical, size)
 *
 * The size in the web version is the inital password + 2. Might be a bug but we follow that for compability.
 */

/*
 * 1) Extract the domain.
 */
+ (NSString*)extractDomain:(NSString*)url;

/*
 * 5) Remove the salt from the beginning of the hash result.
 */
+ (NSString*)removeSalt:(NSString*)salt FromHash:(NSString*)hash;

/*
 * 6) Check if the user supplied password was alphanumeric.
 */
+ (BOOL)isAlphaNumeric:(NSString*)password;

/*
 * 7) Apply constraints to the remaining string (alphanumerical/non-alhpahnumerical, size)
 */
+ (NSString*)applySize:(int)size
     AndAlphaNumerical:(BOOL)isAlphaNumeric
            ToPassword:(NSString*)password;

/*
 * Sub Tasks
 */

+ (NSString*)replaceFirstNonAlphanumericalIn:(NSString*)string With:(char)alphanumerical;

+ (BOOL) string:(NSString*)string ContainsAnyFrom:(NSCharacterSet*)set;

+ (char) nextExtraChar:(NSMutableArray*)extraChars;

+ (char) nextBetween:(NSMutableArray*)extraChars Base:(char)base AndInterval:(char)interval;

+ (NSMutableArray*)rotate:(NSMutableArray*)array ByAmount:(int)amount;

@end
