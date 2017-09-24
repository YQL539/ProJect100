//
//  TCSocketUDPTool.m
//  VCTCSEnterpriseEdition
//
//  Created by Brince.S.J on 16/1/20.
//  Copyright © 2016年 linkcare. All rights reserved.
//

#import "TCSocketUDPTool.h"
#import "GCDAsyncUdpSocket.h"

@interface TCSocketUDPTool() <GCDAsyncUdpSocketDelegate>

@property (nonatomic,strong) GCDAsyncUdpSocket *socketUDP;

@end

@implementation TCSocketUDPTool

+ (instancetype)shared
{
	static TCSocketUDPTool *instance;
	static dispatch_once_t token;
	dispatch_once(&token, ^{
		instance = [[TCSocketUDPTool alloc] init];
	});
	return instance;
}

- (instancetype)init
{
	if (self == [super init]) {
		[self syncHostConfig];
		
		if (!_socketUDP) {
			dispatch_queue_t queue = dispatch_queue_create("app.linkcare.tc",
														   DISPATCH_QUEUE_CONCURRENT);
			_socketUDP = [[GCDAsyncUdpSocket alloc] initWithDelegate:self
													   delegateQueue:queue];
		}
	}
	return self;
}

- (void)sendCmd:(NSString *)cmd
{
	NSData *data = [cmd dataUsingEncoding:NSUTF8StringEncoding];
	[_socketUDP sendData:data toHost:_host port:_port withTimeout:-1 tag:0];
}

- (void)syncHostConfig
{
    //修改
//	_host = GetSocketHost();
//	_port = GetSocketPort();
}

@end
