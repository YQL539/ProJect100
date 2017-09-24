//
//  SenCmdObj.h
//  VCTCSEnterpriseEdition
//
//  Created by houwenfu on 15/8/29.
//  Copyright (c) 2015年 linkcare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SenCmdObj : NSObject

@property (nonatomic,copy) NSString *command;

+ (instancetype)shared;
- (void)releaseSocket:(NSString *)cmd;
- (void)connect;
@end
