//
//  CAAAppDelegate.m
//  CrashAddressAnalyzer
//
//  Created by jz on 13-10-25.
//  Copyright (c) 2013年 sogou. All rights reserved.
//

#import "CAAAppDelegate.h"

@implementation CAAAppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    self.is_ARM64 = NO;
}

- (NSString *)getNewString
{
    NSString *resultFile = @"/tmp/crashanalyzer.tmp";
    
    NSString *path = [self.textSymboleFilePath stringValue];
    NSString *filePath = path;
    if ([path.pathExtension caseInsensitiveCompare:@"dSYM"] == NSOrderedSame)
    {
        NSString *detailedDir = [path stringByAppendingPathComponent:@"/Contents/Resources/DWARF/"];
        NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:detailedDir error:nil];
        filePath = [detailedDir stringByAppendingPathComponent:(NSString *)[contents objectAtIndex:0]];
    }
    
    NSString *cmd = [NSString stringWithFormat:@"/usr/bin/xcrun atos -arch %@ -o %@ -l %@ %@ > %@", self.is_ARM64?@"arm64":@"armv7", filePath, self.textBaseAddress.stringValue, self.textCrashAddress.stringValue, resultFile];
    
    if (system([cmd cStringUsingEncoding:NSUTF8StringEncoding]) == 127)
        return @"failed";
    
    return [NSString stringWithContentsOfFile:resultFile encoding:NSUTF8StringEncoding error:nil];
}

- (IBAction)compute:(NSButton *)sender
{
    NSString *newString = [self getNewString];
    [[[self.textResult textStorage] mutableString] appendFormat:@"%@",newString];
}

- (IBAction)clear:(NSButton *)sender
{
    [[self textResult] setString:@""];
}

- (IBAction)browse:(NSButton *)sender
{
    // Create the File Open Dialog class.
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Enable the selection of files in the dialog.
    [openDlg setCanChooseFiles:YES];
    
    // Disable the selection of directories in the dialog.
    [openDlg setCanChooseDirectories:NO];
    
    // Display the dialog.  If the OK button was pressed,
    // process the files.
    if ( [openDlg runModal] == NSOKButton )
    {
        // Get an array containing the full filenames of all
        // files and directories selected.
        NSURL* url = [openDlg URL];
 
        self.textSymboleFilePath.stringValue = url.path;
    }

}

- (IBAction)SetArchState:(id)sender
{
    NSInteger checkState = [self.checkBoxArm64 state];
    self.is_ARM64 = checkState == 1;
}
@end
