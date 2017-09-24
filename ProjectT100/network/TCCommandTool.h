//
//  TCCommandTool.h
//  VCTCSEnterpriseEdition
//
//  Created by Brince.S.J on 15/8/31.
//  Copyright (c) 2015年 linkcare. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef	kTCCommandUsingLongConnection	
#define	kTCCommandUsingLongConnection	1
#endif

#ifndef	kTCSendCmd
#define	kTCSendCmd(__cmd_)	[TCCommandTool sendCommand:__cmd_]
#endif

#ifndef	kTCChangeServer
#define	kTCChangeServer()		[TCCommandTool changeServer]
#endif

#ifndef	kTCChangeProtocol
#define	kTCChangeProtocol()		[TCCommandTool changeProtocol]
#endif

#ifndef	kTCSocketProtocol
typedef enum
{
	kTCSocketProtocolTCP = 0,
	kTCSocketProtocolUDP
} kTCSocketProtocol;
#endif

@interface TCCommandTool : NSObject
//十进制
+ (void)sendCommand:(NSString *)cmd;

+ (void)changeServer;

+ (void)changeProtocol;

@end
