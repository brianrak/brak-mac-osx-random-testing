//
//  AppController.m
//  RetinaTesting
//
//  Created by Brian Rak on 2/15/13.
//  Copyright (c) 2013 Brak Software. All rights reserved.
//

#import "AppController.h"

@interface AppController()

- (void) changeScreenSizeToSize:(NSString *) size;
- (void) loadContentForSize:(NSString *) size;

@end

@implementation AppController

@synthesize window;
@synthesize webView;

- (id) init {
    
    if ([super init]) {
 
    }
    return self;
    
}

- (IBAction) btnLoadSmall_Pressed:(id) sender {
    [self changeScreenSizeToSize:@"small"];
    [self loadContentForSize:@"small"];
}

- (IBAction) btnLoadMedium_Pressed:(id) sender {
    [self changeScreenSizeToSize:@"medium"];
    [self loadContentForSize:@"medium"];
}

- (IBAction) btnLoadLarge_Pressed:(id) sender {
    [self changeScreenSizeToSize:@"large"];
    [self loadContentForSize:@"large"];
}

- (void) changeScreenSizeToSize:(NSString *) size {
    
    // Precalculate window size
    NSRect newWindowRect;
    CGPoint currentLocation = self.window.frame.origin;
    
    NSView *contentView = window.contentView;
    NSRect contentRect = contentView.frame;
    int chromeWidth = window.frame.size.width - contentRect.size.width;
    int chromeHeight = window.frame.size.height - contentRect.size.height;

    // New browser location
    NSRect browserRect;    
    
    if ([size isEqualToString:@"small"]) {
        newWindowRect = NSMakeRect(currentLocation.x, currentLocation.y, 741 + chromeWidth, 274 + chromeHeight);
        browserRect = NSMakeRect(221, 20, 500, 175);
    }
    else if ([size isEqualToString:@"medium"]) {
        newWindowRect = NSMakeRect(currentLocation.x, currentLocation.y, 841 + chromeWidth, 354 + chromeHeight);
        browserRect = NSMakeRect(221, 20, 600, 255);
    }
    else {
        newWindowRect = NSMakeRect(currentLocation.x, currentLocation.y, 941 + chromeWidth, 434 + chromeHeight);
        browserRect = NSMakeRect(221, 20, 700, 335);
    }
    
    [self.window setFrame:newWindowRect display:true animate:true];
    [self.webView setFrame:browserRect];
}

- (void) loadContentForSize:(NSString *) size {
    
    // Get the HTML which starts from the same file regardless of size or resolution
    NSMutableString *html = [NSMutableString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"test" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
    
    // Determine the screen resolution suffix
    bool isRetina = false;
    NSString *scaleSuffix = @"";
    if ([[NSScreen mainScreen] respondsToSelector:@selector(backingScaleFactor)]) {
        if ([[NSScreen mainScreen] backingScaleFactor] == 2.0) {
            scaleSuffix = @"-2x";
            isRetina = true;
        }
    }
    
    // Determine the suffix (something like -small or -large)
    NSString *cssSuffix = [NSString stringWithFormat:@"-%@.css", size];
    
    // Replace CSS references
    [html replaceOccurrencesOfString:@".css" withString:cssSuffix options:NSCaseInsensitiveSearch range:NSMakeRange(0, [html length])];
    
    // Determine the PNG and JPG suffixes
    NSString *pngSuffix = [NSString stringWithFormat:@"-%@.png", size];
    //NSString *jpgSuffix = [NSString stringWithFormat:@"-%@.jpg", size];
    
    // Replace
    [html replaceOccurrencesOfString:@".png" withString:pngSuffix options:NSCaseInsensitiveSearch range:NSMakeRange(0, [html length])];
    
    // Load
    NSURL *base = [[NSBundle mainBundle] resourceURL];
    [[self.webView mainFrame] loadHTMLString:html baseURL:base];
}


@end
