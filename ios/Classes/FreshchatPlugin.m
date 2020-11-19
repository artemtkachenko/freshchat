#import "FreshchatPlugin.h"
#import "FreshchatSDK/FreshchatSDK.h"

@implementation FreshchatPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"freshchat_plugin"
            binaryMessenger:[registrar messenger]];
  FreshchatPlugin* instance = [[FreshchatPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

NSString *const METHOD_INIT = @"init";
NSString *const METHOD_IDENTIFY_USER = @"identifyUser";
NSString *const METHOD_UPDATE_USER_INFO = @"updateUserInfo";
NSString *const METHOD_RESET_USER = @"reset";
NSString *const METHOD_SHOW_CONVERSATIONS = @"showConversations";
NSString *const METHOD_SHOW_FAQS = @"showFAQs";
NSString *const METHOD_GET_UNREAD_MESSAGE_COUNT = @"getUnreadMsgCount";
NSString *const METHOD_SETUP_PUSH_NOTIFICATIONS = @"setupPushNotifications";
NSString *const METHOD_SEND_MESSAGE = @"send";

- (UIViewController *)rootViewController {
  return [[[UIApplication sharedApplication] keyWindow] rootViewController];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSString *callMethod = call.method;
  NSDictionary *arguments = call.arguments;

  if ([callMethod isEqualToString:METHOD_INIT]) {
    FreshchatConfig *config = [[FreshchatConfig alloc] initWithAppID:[[arguments objectForKey:@"appID"] stringValue]
                                                           andAppKey:[[arguments objectForKey:@"appKey"] stringValue]];
    config.gallerySelectionEnabled = [[arguments objectForKey:@"gallerySelectionEnabled"] boolValue];
    config.cameraCaptureEnabled = [[arguments objectForKey:@"cameraEnabled"] boolValue];
    config.teamMemberInfoVisible = [[arguments objectForKey:@"teamMemberInfoVisible"] boolValue];
    config.showNotificationBanner = [[arguments objectForKey:@"showNotificationBanner"] boolValue];
    config.responseExpectationVisible = [[arguments objectForKey:@"responseExpectationEnabled"] boolValue];
    config.notificationSoundEnabled = [[arguments objectForKey:@"notificationSoundEnabled"] boolValue];
    config.domain = [[arguments objectForKey:@"domain"] stringValue];

    [[Freshchat sharedInstance] initWithConfig:config];
    result(@"success");

  } else if ([callMethod isEqualToString:METHOD_IDENTIFY_USER]) {
    result(@"not implemented");
  } else if ([callMethod isEqualToString:METHOD_UPDATE_USER_INFO]) {
    result(@"not implemented");
  } else if ([callMethod isEqualToString:METHOD_RESET_USER]) {
    result(@"not implemented");
  } else if ([callMethod isEqualToString:METHOD_SHOW_CONVERSATIONS]) {
    [[Freshchat sharedInstance] showConversations:[self rootViewController]];
    result(@"success");
  } else if ([callMethod isEqualToString:METHOD_SHOW_FAQS]) {
    FAQOptions *options = [[FAQOptions alloc] init];
    options.showFaqCategoriesAsGrid = [[arguments objectForKey:@"showFaqCategoriesAsGrid"] boolValue];
    options.showContactUsOnAppBar = [[arguments objectForKey:@"showContactUsOnAppBar"] boolValue];
    options.showContactUsOnFaqScreens = [[arguments objectForKey:@"showContactUsOnFaqScreens"] boolValue];

    [[Freshchat sharedInstance] showFAQs:[self rootViewController] withOptions:options];
    result(@"success");
  } else if ([callMethod isEqualToString:METHOD_GET_UNREAD_MESSAGE_COUNT]) {
    result(@"not implemented");
  } else if ([callMethod isEqualToString:METHOD_SETUP_PUSH_NOTIFICATIONS]) {
    result(@"not implemented");
  } else if ([callMethod isEqualToString:METHOD_SEND_MESSAGE]) {
    result(@"not implemented");
  } else {
    result(@"not implemented");
  }
}

@end
