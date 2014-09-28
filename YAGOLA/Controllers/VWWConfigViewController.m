//
//  VWWConfigViewController.m
//  YAGOLA
//
//  Created by Zakk Hoyt on 9/26/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWConfigViewController.h"
#import "VWWCGLifeViewController.h"
#import "VWWGridView.h"

static NSString *VWWSegueConfigToGOL = @"VWWSegueConfigToGOL";

@interface VWWConfigViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cellsLabel;
@property (weak, nonatomic) IBOutlet UISlider *cellsSlider;
@property (weak, nonatomic) IBOutlet VWWGridView *gridView;
@end

@implementation VWWConfigViewController

-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [UIApplication sharedApplication].statusBarHidden = YES;

    self.cellsSlider.value = 32;
    self.gridView.cellsWide = 32;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:VWWSegueConfigToGOL]){
        VWWCGLifeViewController *vc = segue.destinationViewController;
        vc.cellsWide = self.cellsSlider.value;
    }
}

- (IBAction)startButtonTouchUpInside:(id)sender {
    [self performSegueWithIdentifier:VWWSegueConfigToGOL sender:self];
}

- (IBAction)cellsSliderValueChanged:(id)sender {
    self.cellsLabel.text = [NSString stringWithFormat:@"%ld", (long)self.cellsSlider.value];
    self.gridView.cellsWide = self.cellsSlider.value;
    [self.gridView setNeedsDisplay];
}
@end
