//
//  AppDelegate.m
//  AnimationTesting-MacOS-10-6
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window;
@synthesize pnlBox;
@synthesize pnlSmallBox;
@synthesize pnlMainContainer;

NSRect boxPosition1;
NSRect boxPosition2;
NSRect smallBoxPosition1;
NSRect smallBoxPosition2;
BOOL boxIsInPosition1;
BOOL boxIsVisible;

- (IBAction) btnMove_Pressed:(id) sender {
    
    // N.B. Animation via the animator proxy
    //      Also see the "fade" animation, which uses the layer more directly
    // Create the animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    
    // Hook it up to the box
    [self.pnlBox setAnimations:[NSDictionary dictionaryWithObject:animation forKey:@"frameOrigin"]];
    
    if (boxIsInPosition1) {
        // Animate via the animator proxy
        [[self.pnlBox animator] setFrame:boxPosition2];
        [[self.pnlSmallBox animator] setFrame:smallBoxPosition2];
    }
    else {
        // Animate via the animator proxy
        [[self.pnlBox animator] setFrame:boxPosition1];
        [[self.pnlSmallBox animator] setFrame:smallBoxPosition1];
    }
    
    boxIsInPosition1 = !boxIsInPosition1;
}

- (IBAction) btnFade_Pressed:(id) sender {
    
    // N.B. Animation via the layer
    //      Also see the "move" animation, which uses the animator proxy
    // Create the animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;

    if (boxIsVisible) {
        // Animate 
        animation.fromValue = [NSNumber numberWithFloat:1.0F];
        animation.toValue = [NSNumber numberWithFloat:0.0F];
        
        // Set the value directly on the box afterward
        self.pnlBox.alphaValue = 0.0;
    }
    else {
        animation.fromValue = [NSNumber numberWithFloat:0.0F];
        animation.toValue = [NSNumber numberWithFloat:1.0F];
        
        self.pnlBox.alphaValue = 1.0;
    }
    
    [[self.pnlBox layer] addAnimation:animation forKey:@"opacity"];
    
    boxIsVisible = !boxIsVisible;
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    // Distinguish between the various animations by inspecting theAnimation
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    boxPosition1 = NSMakeRect(181,76,177,104);
    boxPosition2 = NSMakeRect(181,20,177,104);
    smallBoxPosition1 = NSMakeRect(20,76,141,38);
    smallBoxPosition2 = NSMakeRect(20,20,141,38);
    boxIsInPosition1 = true;
    boxIsVisible = true;
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) theApplication
{
	return TRUE;
}

@end
