//
//  SenCmdObj.m
//  VCTCSEnterpriseEdition
//
//  Created by houwenfu on 15/8/29.
//  Copyright (c) 2015年 linkcare. All rights reserved.
//

#import "SenCmdObj.h"
#import "AsyncSocket.h"
#import "MBProgressHUD+MJ.h"

@interface SenCmdObj ()
{
    AsyncSocket *socket;
    
//    BOOL ifFlag;
}
@end

@implementation SenCmdObj

+ (instancetype)shared{
    static SenCmdObj *instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[SenCmdObj alloc] init];
    });
    return instance;
}

- (void)releaseSocket:(NSString *)cmd{
/*
 _command = cmd;
 ifFlag = YES;
 socket.delegate = nil;
 [socket disconnect];
 socket = nil;
 */
    _command = cmd;
    [self connect];
}

- (void)connect
{
//	NSString *IP = GetSocketHost();
//	NSInteger PT = GetSocketPort();
    NSString *IP = @"修改";
    NSInteger PT = 0;
    if (!socket)
    {
        socket = [[AsyncSocket alloc] initWithDelegate:self];
    }
    
    if (![socket isConnected])
    {
        NSError *error;
        [socket connectToHost:IP
                       onPort:PT
                  withTimeout:1.0f
                        error:&error];
    }
}

#pragma AsySocketDelegate
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port;
{
    NSLog(@"success for cmd :%@ ",_command);

    NSString *str = _command;
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [socket writeData:data withTimeout:2.0f tag:0];
    
    [self performSelector:@selector(dis) withObject:nil afterDelay:0.5];
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err{
    
    NSLog(@"faluse");
    
    [MBProgressHUD showError:@"连接失败!"];

}

- (void)dis{
    socket.delegate = nil;
    [socket disconnect];
    socket = nil;
}

@end
