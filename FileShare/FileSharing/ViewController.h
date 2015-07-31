//
//  ViewController.h
//  FileSharing
//
//  Created by Imayaselvan on 31/07/15.
//  Copyright (c) 2015 Imayaselvan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface ViewController : UIViewController
@property (nonatomic, retain) MCBrowserViewController *browserViewController;
@property (nonatomic, retain) MCAdvertiserAssistant *advertiserAssistant;
@property (nonatomic, retain) MCSession *session;
@property (nonatomic, retain) MCPeerID *peerID,*testPeerID;
@property (nonatomic, retain) NSMutableArray *messages;


@end

