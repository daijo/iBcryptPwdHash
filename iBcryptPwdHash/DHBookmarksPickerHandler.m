//
//  DHBookmarksPickerHandler.m
//  iBcryptPwdHash
//
//  Created by Daniel Hjort on 5/4/14.
//  Copyright (c) 2014 Daniel Hjort. All rights reserved.
//

#import "DHBookmarksPickerHandler.h"
#import "DHBookmarksPickerDelegate.h"

@implementation DHBookmarksPickerHandler {
    UIPickerView* mPicker;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.bookmarks = [self restoreBookmarks];
    }
    return self;
}

- (DHBookmarksPickerHandler*)initWithPicker:(UIPickerView*)picker AndDelegate:(id<DHBookmarksPickerDelegate>)delegate
{
    self = [self init];
    if (self) {
        self.delegate = delegate;
        mPicker = picker;
    }
    return self;
}

- (void)saveBookmark:(NSString*)bookmark
{
    if (![self.bookmarks containsObject:bookmark]) {
        [self.bookmarks addObject:bookmark];
        [mPicker reloadAllComponents];
        [self persistBookmarks:self.bookmarks];
    }
}

#pragma mark - Persistance

- (void)persistBookmarks:(NSArray*)bookmarks
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                     NSUserDomainMask, YES);

    if ([paths count] > 0) {
        
        NSString* arrayPath = [[paths objectAtIndex:0]
                 stringByAppendingPathComponent:@"bookmarks.array"];
        [bookmarks writeToFile:arrayPath atomically:YES];
    }
}
                              
- (NSMutableArray*)restoreBookmarks
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    
    NSMutableArray* result = [NSMutableArray array];
    
    if ([paths count] > 0) {
        
        NSString* arrayPath = [[paths objectAtIndex:0]
                               stringByAppendingPathComponent:@"bookmarks.array"];
        [result addObjectsFromArray:[NSArray arrayWithContentsOfFile:arrayPath]];
    }
    
    if (result.count == 0) {
        [result addObjectsFromArray:@[@"http://www.apple.com", @"http://www.google.com", @"http://www.amazon.com"]];
        [self persistBookmarks:result];
    }
    
    return result;
}

#pragma mark - PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return self.bookmarks.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.bookmarks[row];
}

#pragma mark - PickerView Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    [self.delegate selectedBookmark:self.bookmarks[row]];
}

@end
