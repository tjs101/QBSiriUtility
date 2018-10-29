//
//  QBSiriUtility.m
//  QBFramework
//
//  Created by quentin on 2018/10/19.
//  Copyright © 2018 Quentin. All rights reserved.
//

#import "QBSiriUtility.h"

@implementation QBSiriConfig


@end

@implementation QBSiriUtility

+ (QBSiriUtility *)sharedInstance
{
    static QBSiriUtility    *_instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[QBSiriUtility alloc] init];
    });
    
    return _instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.siriConfig = [[QBSiriConfig alloc] init];
    }
    return self;
}

- (void)showVoiceShortcutFromViewCtrl:(UIViewController *)viewCtrl
{
    if (@available(iOS 12.0, *)) {
        INShortcut *shortCuts = [[INShortcut alloc] initWithUserActivity:[self donateActivity]];
        
        INUIAddVoiceShortcutViewController *shortCutViewCtrl = [[INUIAddVoiceShortcutViewController alloc] initWithShortcut:shortCuts];
        shortCutViewCtrl.delegate = self;
        [viewCtrl presentViewController:shortCutViewCtrl animated:YES completion:NULL];
    }
}

- (NSUserActivity *)donateActivity
{
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:self.siriConfig.activityType];
    if (@available(iOS 9.0, *)) {
        userActivity.eligibleForSearch = YES;
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 12.0, *)) {
        userActivity.eligibleForPrediction = YES;
    }
    
    userActivity.title = self.siriConfig.activityTitle;
    
    if (@available(iOS 12.0, *)) {
        userActivity.suggestedInvocationPhrase = self.siriConfig.suggestedInvocationPhrase;
    }
    
    if (@available(iOS 9.0, *)) {
        CSSearchableItemAttributeSet * attributes = [[CSSearchableItemAttributeSet alloc] init];
        attributes.thumbnailData = self.siriConfig.thumbnailData;
        attributes.contentDescription = self.siriConfig.contentDescription;
        userActivity.contentAttributeSet = attributes;
    } else {
        // Fallback on earlier versions
    }
    
    
    return userActivity;
}

#pragma mark - INUIAddVoiceShortcutViewControllerDelegate

- (void)addVoiceShortcutViewControllerDidCancel:(INUIAddVoiceShortcutViewController *)controller
API_AVAILABLE(ios(12.0)){
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

- (void)addVoiceShortcutViewController:(INUIAddVoiceShortcutViewController *)controller didFinishWithVoiceShortcut:(INVoiceShortcut *)voiceShortcut error:(NSError *)error
API_AVAILABLE(ios(12.0)){
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

@end
