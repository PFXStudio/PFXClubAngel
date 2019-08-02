#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include <Firebase.h>
#import <multi_image_picker/MultiImagePickerPlugin.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    if ([FIRApp defaultApp] == nil) {
        [FIRApp configure];
    }

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
