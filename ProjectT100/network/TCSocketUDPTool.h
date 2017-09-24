//
//  TCSocketUDPTool.h
//  VCTCSEnterpriseEdition
//
//  Created by Brince.S.J on 16/1/20.
//  Copyright © 2016年 linkcare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCSocketUDPTool : NSObject

+ (instancetype)shared;

@property (nonatomic,strong) NSString *host;

@property (nonatomic) NSInteger port;

- (void)sendCmd:(NSString *)cmd;

- (void)syncHostConfig;

@end
