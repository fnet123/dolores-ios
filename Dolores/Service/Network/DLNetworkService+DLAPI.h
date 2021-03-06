//
//  DLNetworkService+DLAPI.h
//  Dolores
//
//  Created by Heath on 16/05/2017.
//  Copyright © 2017 Dolores. All rights reserved.
//

#import "DLNetworkService.h"

@interface DLNetworkService (DLAPI)

+ (RACSignal *)login:(NSString *)mobile password:(NSString *)password;
+ (RACSignal *)myProfile;
+ (RACSignal *)refreshToken;
+ (RACSignal *)getQiniuToken;
+ (RACSignal *)updateUserAvatar:(NSString *)urlString;
+ (RACSignal *)myOrganization;
+ (RACSignal *)syncOrganization:(NSString *)version;
+ (RACSignal *)getUserInfoWithIds:(NSArray<NSString *> *)ids;

+ (RACSignal *)updateMyProfile:(NSDictionary *)param;
+ (RACSignal *)changePassword:(NSString *)newPassword origin:(NSString *)originPassword;

@end
