//
//  DLDBQueryHelper.m
//  Dolores
//
//  Created by Heath on 12/05/2017.
//  Copyright © 2017 Dolores. All rights reserved.
//

#import "DLDBQueryHelper.h"

@implementation DLDBQueryHelper

+ (void)configDefaultRealmDB:(NSString *)username {
    RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
    uint64_t version = 0;
    configuration.schemaVersion = version;
    configuration.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < version) {

        }
    };
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = paths[0];
    configuration.fileURL = [[NSURL URLWithString:[cacheDirectory stringByAppendingPathComponent:username]] URLByAppendingPathExtension:@"realm"];
    [RLMRealmConfiguration setDefaultConfiguration:configuration];
    [RLMRealm defaultRealm];
    NSLog(@"realm db path: %@", configuration.fileURL);
}


+ (RLMResults<RMDepartment *> *)departmentsInList:(NSArray *)idList {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"departmentId IN %@", idList];
    RLMResults<RMDepartment *> *results = [RMDepartment objectsWithPredicate:predicate];
    return results;
}

+ (RMUser *)currentUser {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isLogin = %@", @(YES)];
    RLMResults<RMUser *> *results = [RMUser objectsWithPredicate:predicate];
    if (results.count > 0) {
        return [results objectAtIndex:0];
    }
    return nil;
}

+ (RLMResults<RMUser *> *)userList {
    RLMResults<RMUser *> *users = [[RMUser allObjects] sortedResultsUsingKeyPath:@"logoutTimestamp" ascending:NO];
    return users;
}

+ (BOOL)isLogin {
    return [self currentUser].isLogin.boolValue;
}

+ (void)saveLoginUser:(NSDictionary *)dict {
    RLMRealm *realm = [RLMRealm defaultRealm];
    RMUser *user = [[RMUser alloc] init];
    RMStaff *staff = [[RMStaff alloc] initWithDict:dict];
    if (dict[@"id"]) {
        user.uid = dict[@"id"];
        staff.uid = dict[@"id"];
    }
    if (dict[@"telephoneNumber"]) {
        user.userName = dict[@"telephoneNumber"];
    }
    user.isLogin = @(YES);
    user.staff = staff;

    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:user];
    }];
}


@end
