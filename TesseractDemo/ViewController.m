//
//  ViewController.m
//  TesseractDemo
//
//  Created by Nguyen Hien on 2/7/17.
//  Copyright © 2017 Nguyen Hien. All rights reserved.
//

#import "ViewController.h"
#import <TesseractOCR/TesseractOCR.h>

@interface ViewController () <G8TesseractDelegate>
{
    NSMutableArray * imageArray;
    int selectIndex;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    selectIndex = 0;
    imageArray = [[NSMutableArray new] init];
    [imageArray addObject:@"japanese_mandatory.gif"];
    [imageArray addObject:@"image_sample.jpg"];
    [imageArray addObject:@"image_sample_down_mirrored.jpg"];
    [imageArray addObject:@"image_sample_down.jpg"];
    [imageArray addObject:@"image_sample_left_mirrored.jpg"];
    [imageArray addObject:@"image_sample_left.jpg"];
    [imageArray addObject:@"image_sample_right_mirrored.jpg"];
    [imageArray addObject:@"image_sample_right.jpg"];
    [imageArray addObject:@"image_sample_tr.png"];
    [imageArray addObject:@"image_sample_up_mirrored.jpg"];


    
    
    
    self.navigationController.title = @"Tesseract";
    // Do any additional setup after loading the view, typically from a nib.
    
    self.ScanImage.image = [UIImage imageNamed:imageArray[selectIndex]];
    
    
}

- (void)StartScan:(id)sender
{
    
    G8RecognitionOperation * tesseractOp = [[G8RecognitionOperation alloc] initWithLanguage:@"eng+jpn"];
    
    tesseractOp.tesseract.image = [UIImage imageNamed:imageArray[selectIndex]];
    
    
    __weak typeof(self) weakSelf = self;
    tesseractOp.recognitionCompleteBlock = ^(G8Tesseract *recognizedTesseract) {
        // Retrieve the recognized text upon completion
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.ResultTextView.text = [recognizedTesseract recognizedText];
        });
        NSArray *characterBoxes = [recognizedTesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelSymbol];
        //        NSArray *paragraphs = [recognizedTesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelParagraph];
        //        NSArray *characterChoices = recognizedTesseract.characterChoices;
        UIImage *imageWithBlocks = [recognizedTesseract imageWithBlocks:characterBoxes drawText:YES thresholded:NO];
        weakSelf.ScanImage.image = imageWithBlocks;
        
    };
    
    [tesseractOp start];


}

- (IBAction)NextImage:(id)sender {
    if (selectIndex >= 0 && selectIndex < imageArray.count - 1)
    {
        selectIndex++;
    }
    else
    {
        selectIndex = 0;
    }
    self.ScanImage.image = [UIImage imageNamed:imageArray[selectIndex]];
}

- (IBAction)PreviousImage:(id)sender
{
    if (selectIndex == 0 )
    {
        selectIndex = (int)imageArray.count - 1;
    }
    else
    {
        selectIndex--;
    }
    self.ScanImage.image = [UIImage imageNamed:imageArray[selectIndex]];
}

- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract
{
     NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}

-(BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract
{
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
