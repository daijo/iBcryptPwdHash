//
//  DHBookmarksPickerDelegate.h
//  iBcryptPwdHash
//
//  Created by Daniel Hjort on 5/4/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DHBookmarksPickerDelegate <NSObject>

- (void)selectedBookmark:(NSString*)bookmark;

@end
