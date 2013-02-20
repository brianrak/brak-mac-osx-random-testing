//
//  AppDelegate.h
//  AnimationTesting-MacOS-10-6
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>


@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSView *pnlMainContainer;
@property (assign) IBOutlet NSBox *pnlBox;
@property (assign) IBOutlet NSBox *pnlSmallBox;

- (IBAction) btnMove_Pressed:(id) sender;
- (IBAction) btnFade_Pressed:(id) sender;


@end
