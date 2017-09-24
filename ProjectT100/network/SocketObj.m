//
//  SocketObj.m
//  YunChuKong
//
//  Created by admin on 15/8/18.
//  Copyright (c) 2015年 linkcare. All rights reserved.
//

#import "SocketObj.h"
#import "AsyncSocket.h"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"

@interface SocketObj()
{
    AsyncSocket *_socket;//第三方库
	NSTimer *_timer;
	BOOL _flag;
	BOOL _isConnecting;
}//为什么这样定义？
@end

@implementation SocketObj
//单例？
+ (instancetype)shared
{
    static SocketObj *instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[SocketObj alloc] init];
        [instance connectSocket];
    });
    return instance;
}

- (BOOL)ifConnectSocket
{
	return _socket && [_socket isConnected];
}

- (void)connectSocket
{
    //这里的 ip 是动态获取的?
//    NSString *IP = GetSocketHost();
//	NSInteger PT = GetSocketPort();

    NSString *IP = @"需要修改";
    NSInteger PT = 0;
    if (IP.length > 0 && PT > 0 && PT < 65536)
	{
        if (!_socket)
            _socket = [[AsyncSocket alloc] initWithDelegate:self];
		
		if (_isConnecting)
		{
			NSLog(@"When connecting,diconnect first!");
			[_socket disconnect];
		}
		
		NSError *err;
		_flag = NO;
		
		_isConnecting = YES;
		
		@try {
			if (![_socket connectToHost:IP onPort:PT withTimeout:3 error:&err])
			{
				NSLog(@"CONNECT FAILED:%@",err.userInfo);
			}
		}
		@catch (NSException *exception) {
			NSLog(@"Exception:%@",exception.reason);
		}
		@finally {
			
		}
    }
}

- (void)disConnectSocket
{
	_flag = YES;
	[_socket disconnectAfterReadingAndWriting];
}

- (void)sendCmd:(NSString *)cmd
{
    if ([_socket isConnected])
	{
        NSData *data = [cmd dataUsingEncoding:NSUTF8StringEncoding];
        [_socket writeData:data withTimeout:0.25f tag:1];
    }
	else [self connectSocket];
}

#pragma mark - AsyncSocketDelegate
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
	_isConnecting = YES;
	NSLog(@"Losing Connection");
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
	_isConnecting = NO;
	[_socket disconnect];
	
	[_timer invalidate];
	_timer = nil;
	
	if (!_flag)
		[self performSelector:@selector(connectSocket)
				   withObject:nil
				   afterDelay:3];
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
	_isConnecting = NO;
	NSLog(@"Connect to server<%@:%d> successful.",host,port);
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	
	///开始“心跳”
	[self startHeartJump];
	
	///发送连接成功通知
//	[[NSNotificationCenter defaultCenter] postNotificationName:KCTDCCConnectSuccessNotify
//														object:nil];
}

- (NSTimeInterval)onSocket:(AsyncSocket *)sock
 shouldTimeoutWriteWithTag:(long)tag
				   elapsed:(NSTimeInterval)elapsed
				 bytesDone:(NSUInteger)length
{
	return 1;
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
	NSString *resp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"READ DATA SUCCESS:%@",resp);
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
	if (tag > 0)
		NSLog(@"WRITE DATA SUCCESS");
}

- (void)startHeartJump
{
	_timer = [NSTimer scheduledTimerWithTimeInterval:1.f
											  target:self
											selector:@selector(doKeepConnection)
											userInfo:nil
											 repeats:YES];
	[_timer fire];
}

- (void)doKeepConnection
{
	NSData *data = [NSData dataWithBytes:"\0" length:1];
	[_socket writeData:data withTimeout:0.1f tag:0];
}

@end
