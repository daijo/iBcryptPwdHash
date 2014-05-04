//
//  DHBookmarksPickerHandler.h
//  iBcryptPwdHash
//
//  Created by Daniel Hjort on 5/4/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DHBookmarksPickerDelegate;

@interface DHBookmarksPickerHandler : NSObject <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSMutableArray *bookmarks;
@property (weak, nonatomic) id<DHBookmarksPickerDelegate> delegate;

- (DHBookmarksPickerHandler*)initWithPicker:(UIPickerView*)picker AndDelegate:(id<DHBookmarksPickerDelegate>)delegate;

- (void)saveBookmark:(NSString*)bookmark;

@end
