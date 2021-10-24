#import "AppCloneCheckerPlugin.h"
#if __has_include(<app_clone_checker/app_clone_checker-Swift.h>)
#import <app_clone_checker/app_clone_checker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "app_clone_checker-Swift.h"
#endif

@implementation AppCloneCheckerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppCloneCheckerPlugin registerWithRegistrar:registrar];
}
@end
