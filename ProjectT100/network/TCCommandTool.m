//
//  TCCommandTool.m
//  VCTCSEnterpriseEdition
//
//  Created by Brince.S.J on 15/8/31.
//  Copyright (c) 2015年 linkcare. All rights reserved.
//

#import "TCCommandTool.h"

#import "SocketObj.h"
#import "SenCmdObj.h"
#import "TCSocketUDPTool.h"

static NSInteger gSocketProtocol = -1;

@implementation TCCommandTool

+ (void)sendCommand:(NSString *)cmd
{
	NSLog(@"Send Command:%@",cmd);
	
	if (gSocketProtocol < 0 || gSocketProtocol > 1) {
		[[self class] changeProtocol];
	}

	if (gSocketProtocol == kTCSocketProtocolTCP) {
#if	kTCCommandUsingLongConnection
		SocketObj *obj = [SocketObj shared];
		if (![obj ifConnectSocket]) {
			[obj connectSocket];
		}
		[obj sendCmd:cmd];
#else
	 [[SenCmdObj shared] releaseSocket:SecondCmd];
#endif
	}
	else {
		[[TCSocketUDPTool shared] sendCmd:cmd];
	}
}

+ (void)changeServer
{
	if (gSocketProtocol < 0 || gSocketProtocol > 1) {
		[[self class] changeProtocol];
	}
	
	if (gSocketProtocol == kTCSocketProtocolTCP) {
#if	kTCCommandUsingLongConnection

		SocketObj *obj = [SocketObj shared];
		if ([obj ifConnectSocket]) {
			[obj disConnectSocket];
		}
		[obj performSelector:@selector(connectSocket)
				  withObject:nil
				  afterDelay:1];
#endif
	}
	else {
		[[TCSocketUDPTool shared] syncHostConfig];
	}
}

+ (void)changeProtocol
{
//	gSocketProtocol = GetSocketProtocol();
}

@end
