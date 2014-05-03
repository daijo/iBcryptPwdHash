//
//  iBcryptPwdHashTests.m
//  iBcryptPwdHashTests
//
//  Created by Daniel Hjort on 5/2/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JFBCrypt.h"
#import "DHPwdHashUtil.h"

@interface iBcryptPwdHashTests : XCTestCase

@end

@implementation iBcryptPwdHashTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*
 * 1) Extract the domain.
 */
- (void)testExtractDomain
{
    XCTAssertTrue([[DHPwdHashUtil extractDomain:@"http://example.com"] isEqualToString:@"example.com"], @"Domain extraction failed!");
    XCTAssertTrue([[DHPwdHashUtil extractDomain:@"http://www.example.com"] isEqualToString:@"example.com"], @"Domain extraction failed!");
    XCTAssertTrue([[DHPwdHashUtil extractDomain:@"https://www.example.com"] isEqualToString:@"example.com"], @"Domain extraction failed!");
    XCTAssertTrue([[DHPwdHashUtil extractDomain:@"http://mail.example.com"] isEqualToString:@"example.com"], @"Domain extraction failed!");
    XCTAssertTrue([[DHPwdHashUtil extractDomain:@"https://www.example.com.au"] isEqualToString:@"example.com.au"], @"Domain extraction failed!");
}

/*
 * 2) Generate salt if not supplied.
 */
- (void)testBCryptGenerateSalt
{
    NSString * test =  [JFBCrypt generateSaltWithNumberOfRounds: 12];
    NSRange range = [test rangeOfString:@"$2a$"];
    XCTAssertTrue(range.length == 4 && range.location == 0, @"Not a salt!");
}

/*
 * 4) Hash the appended strings.
 */
- (void)testBCryptHash
{
    // Domain: example.com
    // Password: test
    // Salt: $2a$12$ZG78Pek0VOJ8SRf./2xB5O
    NSString * test = [JFBCrypt hashPassword:@"example.comtest" withSalt:@"$2a$12$ZG78Pek0VOJ8SRf./2xB5O"];

    XCTAssertTrue([test isEqualToString:@"$2a$12$ZG78Pek0VOJ8SRf./2xB5OLvc.LXzMZpm6CSkJC8lAlfD7ZHaIu0C"], @"Hash not correct!");
}

/*
 * 5) Remove the salt from the beginning of the hash result.
 */
- (void)testRemoveSalt
{
    NSString * test = [DHPwdHashUtil removeSalt:@"$2a$12$ZG78Pek0VOJ8SRf./2xB5O" FromHash:@"$2a$12$ZG78Pek0VOJ8SRf./2xB5OLvc.LXzMZpm6CSkJC8lAlfD7ZHaIu0C"];
    
    XCTAssertTrue([test isEqualToString:@"Lvc.LXzMZpm6CSkJC8lAlfD7ZHaIu0C"], @"Hash not correct!");
}

/*
 * 6) Check if the user supplied password was alphanumeric.
 */
- (void)testIsAlphanumeric
{
    XCTAssertTrue([DHPwdHashUtil isAlphaNumeric:@"ab34Bd"], @"Is alphanumeric!");
    XCTAssertFalse([DHPwdHashUtil isAlphaNumeric:@"ab#34Bd!"], @"Isn't alphanumeric!");
}

/*
 * 7) Apply constraints to the remaining string (alphanumerical/non-alhpahnumerical, size)
 */
- (void)testApplyConstraints
{
    XCTAssertTrue([[DHPwdHashUtil applySize:6 AndAlphaNumerical:YES
                                 ToPassword:@"Lvc.LXzMZpm6CSkJC8lAlfD7ZHaIu0C"] isEqualToString:@"8LvcSL"], @"Constraints applied incorrectly!");
    
    XCTAssertTrue([[DHPwdHashUtil applySize:7 AndAlphaNumerical:NO
                                 ToPassword:@"JDvcvjwcwMnzM7w5aPYTnZhLai8jxPK"] isEqualToString:@"Dvcvj9J"], @"Constraints applied incorrectly!");
}

/*
 * Sub tasks
 */

- (void)testMatches
{
    XCTAssertTrue([DHPwdHashUtil string:@"sdfA" ContainsAnyFrom:[NSCharacterSet uppercaseLetterCharacterSet]], @"Should contain!");
    XCTAssertFalse([DHPwdHashUtil string:@"sdf" ContainsAnyFrom:[NSCharacterSet uppercaseLetterCharacterSet]], @"Shouldn't contain!");
    XCTAssertTrue([DHPwdHashUtil string:@"asdA" ContainsAnyFrom:[NSCharacterSet lowercaseLetterCharacterSet]], @"Should contain!");
    XCTAssertFalse([DHPwdHashUtil string:@"ASFA" ContainsAnyFrom:[NSCharacterSet lowercaseLetterCharacterSet]], @"Shouldn't contain!");
    XCTAssertTrue([DHPwdHashUtil string:@"asd3A" ContainsAnyFrom:[NSCharacterSet decimalDigitCharacterSet]], @"Should contain!");
    XCTAssertFalse([DHPwdHashUtil string:@"ASFA" ContainsAnyFrom:[NSCharacterSet decimalDigitCharacterSet]], @"Shouldn't contain!");
}

- (void)testNextExtraChar
{
    NSString* testString = @"ABCDEF";
    NSMutableArray* chars = [NSMutableArray array];
    for (int i = 0; i < [testString length]; i++) {
        [chars addObject:[NSNumber numberWithChar:[testString characterAtIndex:i]]];
    }
    
    XCTAssertTrue('A' == [DHPwdHashUtil nextExtraChar:chars], @"Correct char not picked!");
    XCTAssertTrue(chars.count == 5, @"Picked char not removed!");
    XCTAssertTrue('B' == [DHPwdHashUtil nextExtraChar:chars], @"Correct char not picked!");
    XCTAssertTrue(chars.count == 4, @"Picked char not removed!");
}

- (void)testRotate
{
    NSString* testString = @"ABCDEF";
    NSMutableArray* chars = [NSMutableArray array];
    for (int i = 0; i < [testString length]; i++) {
        [chars addObject:[NSNumber numberWithChar:[testString characterAtIndex:i]]];
    }
    
    [DHPwdHashUtil rotate:chars ByAmount:1];
    XCTAssertTrue('B' == [[chars objectAtIndex:0] charValue], @"Didn't rotate correctly");
    XCTAssertTrue('A' == [[chars objectAtIndex:5] charValue], @"Didn't rotate correctly");
    [DHPwdHashUtil rotate:chars ByAmount:5];
    XCTAssertTrue('A' == [[chars objectAtIndex:0] charValue], @"Didn't rotate correctly");
    XCTAssertTrue('F' == [[chars objectAtIndex:5] charValue], @"Didn't rotate correctly");
}

@end
