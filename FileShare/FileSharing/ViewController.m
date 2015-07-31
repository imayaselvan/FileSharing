//
//  ViewController.m
//  FileSharing
//
//  Created by Imayaselvan on 31/07/15.
//  Copyright (c) 2015 Imayaselvan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<MCBrowserViewControllerDelegate,MCSessionDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpConnection];
    [self MakeMeDiscover];

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)MakeMeDiscover{
    
    [self.advertiserAssistant start];
    
}
- (IBAction)SearchUsers:(id)sender {
    [self presentViewController:self.browserViewController animated:YES completion:nil];
    
}
#pragma BrowserView Delegate Methods

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    [self.browserViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [self.browserViewController dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController shouldPresentNearbyPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info{
    NSLog(@"%@",peerID);
    self.testPeerID = peerID;
    return YES;
}

-(void) setUpConnection {
    //Set our display name to be the name of the device
    self.peerID = [[MCPeerID alloc] initWithDisplayName:[UIDevice currentDevice].name];
    
    //Create a new session with our peerID
    self.session = [[MCSession alloc] initWithPeer:self.peerID];
    
    //Create a browser view with our service type and session
    self.browserViewController = [[MCBrowserViewController alloc] initWithServiceType:@"wifiApp" session:self.session];
    
    self.browserViewController.delegate = self;
    
    //Create an advertiser assistant to make our device discoverable
    self.advertiserAssistant = [[MCAdvertiserAssistant alloc] initWithServiceType:@"wifiApp" discoveryInfo:Nil session:self.session];
}
- (IBAction)SendFile:(id)sender {
    NSString *path   =[[NSBundle mainBundle] pathForResource:@"ITSBONJOVI" ofType:@"mp3"];
    //
    //    [self.session sendResourceAtURL:[NSURL URLWithString:path] withName:@"Sonf" toPeer:self.testPeerID withCompletionHandler:^(NSError *err){
    //        NSLog(@"%@",err);
    //    }];
    
    [self.session sendData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]] toPeers:[NSArray arrayWithObject:self.testPeerID] withMode:MCSessionSendDataReliable error:nil];
    
    
}
#pragma Session Delegate Methods

//Called when a peer connects to the user, or the users device connects to a peer.
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    
}

// Called when the users device recieves data from a peer
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
    NSLog(@"%@",data);
}

// Called when the users device recieves a byte stream from a peer
- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
    
}

// Called when the users device recieves a resource from a peer
- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress{
    
}

// Called when the users device has finished recieving data from a peer.
- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
