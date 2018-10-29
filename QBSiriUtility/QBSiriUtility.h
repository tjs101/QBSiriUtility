//
//  QBSiriUtility.h
//  QBFramework
//
//  Created by quentin on 2018/10/19.
//  Copyright © 2018 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Intents/Intents.h>
#import <IntentsUI/IntentsUI.h>
#import <CoreSpotlight/CoreSpotlight.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QBSiriConfig : NSObject

@property (nonatomic, copy) NSString *activityType;/**<解释>*/
@property (nonatomic, copy) NSString *activityTitle;/**<解释>*/
@property (nonatomic, copy) NSString *suggestedInvocationPhrase;/**<解释>*/
@property (nonatomic, strong) NSData *thumbnailData;/**<>*/
@property (nonatomic, copy) NSString *contentDescription;/**<解释>*/

@end

@interface QBSiriUtility : NSObject <INUIAddVoiceShortcutViewControllerDelegate>

+ (QBSiriUtility *)sharedInstance;

@property (nonatomic, strong) QBSiriConfig  *siriConfig;/**<>*/

- (void)showVoiceShortcutFromViewCtrl:(UIViewController *)viewCtrl;

@end

NS_ASSUME_NONNULL_END
