//
//  SocketObj.h
//  YunChuKong
//
//  Created by admin on 15/8/18.
//  Copyright (c) 2015年 linkcare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocketObj : NSObject

+ (instancetype)shared;

- (BOOL)ifConnectSocket;
- (void)connectSocket;
- (void)sendCmd:(NSString *)cmd;
- (void)disConnectSocket;

@end
