//
//  ViewController.h
//  TesseractDemo
//
//  Created by Nguyen Hien on 2/7/17.
//  Copyright © 2017 Nguyen Hien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *ScanImage;
@property (weak, nonatomic) IBOutlet UITextView *ResultTextView;

- (IBAction)StartScan:(id)sender;
- (IBAction)NextImage:(id)sender;
- (IBAction)PreviousImage:(id)sender;

@end

