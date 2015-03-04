//
//  AppDelegate.m
//  TestCrashMail
//
//  Created by kaxiaoer on 15/3/2.
//  Copyright (c) 2015年 miaogaoliang. All rights reserved.
//

#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>

@interface AppDelegate ()<MFMailComposeViewControllerDelegate>
@end

static AppDelegate *staticApplication = nil;

@implementation AppDelegate

static void uncaughtExceptionHandler(NSException* exception){
//    NSString* name = [exception name];
//    NSString* reason = [ exception reason ];
//    NSArray* symbols = [ exception callStackSymbols ];
//    NSMutableString* strSymbols = [ [ NSMutableString alloc ] init ];
//    for ( NSString* item in symbols )
//    {
//        [ strSymbols appendString: item ];
//        [ strSymbols appendString: @"\r\n" ];
//    }
//    
//    NSString*   errorInfo = [NSString stringWithFormat:@" *** Terminating app due to uncaught exception %@ , reason: %@  \r\n  *** First throw call stack: \r\n(\r\n  %@\r\n)", name, reason, strSymbols];
    
    NSMutableString *mailUrl = [[NSMutableString alloc]init];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"821237868@qq.com"];
    [mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];
    //添加抄送
    //    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //    [mailUrl appendFormat:@"?cc=%@", [ccRecipients componentsJoinedByString:@","]];
    //添加密送
    //    NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
    //    [mailUrl appendFormat:@"&bcc=%@", [bccRecipients componentsJoinedByString:@","]];
    //添加主题
//    [mailUrl appendString:@"&subject=crash report"];
//    //添加邮件内容
//    [mailUrl appendString:@"&body=<b>email</b> "];
//    [mailUrl appendString:errorInfo];
//    NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];

    BOOL canSend = [MFMailComposeViewController canSendMail];
    if(canSend){
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = staticApplication;
        [mc setSubject:@"Hello, World!"];
        
        [mc setToRecipients:[NSArray arrayWithObjects:@"821237868@qq.com", nil]];
        
        [mc setMessageBody:@"Watson!!!\n\nCome here, I need you!" isHTML:NO];
        
        [staticApplication.window.rootViewController presentModalViewController:mc animated:YES];
    }
}

 - (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
     switch (result)
     {
         case MFMailComposeResultCancelled:
             NSLog(@"Mail send canceled...");
             break;
         case MFMailComposeResultSaved:
             NSLog(@"Mail saved...");
             break;
         case MFMailComposeResultSent:
             NSLog(@"Mail sent...");
             break;
         case MFMailComposeResultFailed:
             NSLog(@"Mail send errored: %@...", [error localizedDescription]);
             break;
         default:
             break;
     }

     [controller dismissViewControllerAnimated:YES completion:nil];
 }

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    staticApplication = self;
    // Override point for customization after application launch.
//    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
//    uncaughtExceptionHandler(nil);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
