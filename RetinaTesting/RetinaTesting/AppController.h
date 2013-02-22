//
//  AppController.h
//  RetinaTesting
//
//  Created by Brian Rak on 2/15/13.
//  Copyright (c) 2013 Brak Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface AppController : NSObject

@property (strong) IBOutlet NSWindow *window;
@property (strong) IBOutlet WebView *webView;

- (IBAction) btnLoadSmall_Pressed:(id) sender;
- (IBAction) btnLoadMedium_Pressed:(id) sender;
- (IBAction) btnLoadLarge_Pressed:(id) sender;

@end
