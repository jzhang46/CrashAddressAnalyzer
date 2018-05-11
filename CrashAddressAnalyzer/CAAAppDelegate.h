//
//  CAAAppDelegate.h
//  CrashAddressAnalyzer
//
//  Created by jz on 13-10-25.
//  Copyright (c) 2013年 sogou. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CAAAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSButton *btnCompute;
@property (assign) IBOutlet NSButton *btnClear;
@property (assign) IBOutlet NSTextView *textResult;
@property (assign) IBOutlet NSTextField *textCrashAddress;
@property (assign) IBOutlet NSTextField *textBaseAddress;
@property (assign) IBOutlet NSTextField *textSymboleFilePath;
@property (assign) IBOutlet NSButton *btnBrowse;
@property (assign) IBOutlet NSButton *checkBoxArm64;


@property (assign) BOOL is_ARM64;

- (IBAction)compute:(NSButton *)sender;
- (IBAction)clear:(NSButton *)sender;
- (IBAction)browse:(NSButton *)sender;
- (IBAction)SetArchState:(NSButton *)sender;

@end
