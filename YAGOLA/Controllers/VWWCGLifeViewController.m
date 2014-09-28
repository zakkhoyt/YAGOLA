//
//  VWWCGLifeViewController.m
//  GameOfLife
//
//  Created by Zakk Hoyt on 6/16/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWCGLifeViewController.h"
#import "VWWCGLifeView.h"
#import "VWWGOLLife.h"

@interface VWWCGLifeViewController ()

@end


static NSString *kSegueMainToSettings = @"segueMainToSettings";

//#define WIDTH 20
//#define HEIGHT 20

//static NSInteger kGOLWidth = 32;
//static NSInteger kGOLHeight = 46;

//static NSInteger kGOLWidth = 64;
//static NSInteger kGOLHeight = 92;

//static NSInteger kGOLWidth = 128;
//static NSInteger kGOLHeight = 184;

static NSInteger kGOLWidth = 256;
static NSInteger kGOLHeight = 368;



//static NSInteger kGOLWidth = 200;
//static NSInteger kGOLHeight = 200;

//static NSInteger kGOLWidth = 320;
//static NSInteger kGOLHeight = 320;


static float kInitialFrequency = 0.1;

@interface VWWCGLifeViewController ()<VWWGOLLifeDelegate, VWWCGLifeViewDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) VWWGOLLife *life;
@property (strong, nonatomic) IBOutlet VWWCGLifeView *cgLifeView;
//@property (strong, nonatomic) IBOutlet UIButton *startButton;
//@property (strong, nonatomic) IBOutlet UIButton *generateButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *startButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *generateButton;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *clearButton;
@property (strong, nonatomic) IBOutlet UISlider *frequencySlider;
@property (nonatomic) float generateFrequency;
@property (nonatomic) BOOL paused;
@end

@implementation VWWCGLifeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.cgLifeView.delegate = self;
    NSInteger cellsHigh = self.cellsWide * self.view.bounds.size.height / self.view.bounds.size.width;
    self.life = [[VWWGOLLife alloc]initWithWidth:self.cellsWide height:cellsHigh];
    self.life.delegate = self;
    [self renderCells];
    
    self.generateFrequency = kInitialFrequency;
    self.frequencySlider.value = self.generateFrequency;
//    self.startButton.hidden = YES;
    [self.view bringSubviewToFront:self.toolbar];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[[UIAlertView alloc]initWithTitle:@"How to play" message:@"Tap the screen to draw the first generation of life. Tap Evolve to begin the game. The game will pause while you draw more life. Tap the action button to change drawing modes or access help." delegate:nil cancelButtonTitle:@"I got it" otherButtonTitles:nil, nil]show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.life stop];
    self.life = nil;
}


#pragma mark IBActions
- (IBAction)startButtonTouchUpInside:(id)sender {
    if(self.life.running == NO){
        [self.life start];

        [self.startButton  setTitle:@"Stop!"];
//        self.generateButton.hidden = YES;
    }
    else{
        [self.life stop];
        [self.startButton  setTitle:@"Evolve!"];
//        self.generateButton.hidden = NO;
    }
    
}

- (IBAction)helpButtonTouchUpInside:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:
                                  @"Glider",
                                  @"Lightweigh Spaceship",
                                  @"Single Cells",
                                  @"Kill all cells",
                                  @"Random seed",
                                  @"Help",
                                  nil];
    [actionSheet showInView:self.view];
}

- (IBAction)generateButtonTouchUpInside:(id)sender {
//    [self.life killAllCells];
    
    NSInteger t = self.life.width * self.life.height;
    NSInteger requiredCellCount = t * self.generateFrequency;
    
    while(self.life.cells.count < requiredCellCount){
        // generate a cell at random and insert it
        //        NSInteger index = random()%t;
        NSInteger index = arc4random()%t;
        NSInteger y = index / self.life.width;
        NSInteger x = index - self.life.width * y;
        VWWGOLCell *newCell = [[VWWGOLCell alloc]initWithPositionX:x andY:y alive:YES];
        [self.life addCell:newCell];
    }
    
    [self renderCells];
//    self.startButton.hidden = NO;
    NSLog(@"added %ld cells. Actual count:%ld", (long)requiredCellCount, (long)self.life.cells.count);
}

- (IBAction)frequencySliderValueChanged:(UISlider*)sender {
    self.generateFrequency = sender.value;
    //    NSLog(@"changed generate frequency to %f", self.generateFrequency);
}

- (IBAction)oneGenerationButtonTouchUpInside:(id)sender {
    [self.life processTimer];
}


- (IBAction)clearButtonTouchUnInside:(id)sender {
    [self.life stop];
    [self.life killAllCells];
    [self renderCells];
}

- (IBAction)endButtonAction:(id)sender {
    [[[UIAlertView alloc]initWithTitle:@"End Game?" message:@"This will end your Game of Life." delegate:self cancelButtonTitle:@"Nevemind" otherButtonTitles:@"I know it", nil]show];

}


#pragma mark Implements VWWGOLLifeDelegate
-(void)renderCells{
    
    self.cgLifeView.life = self.life;
    [self.cgLifeView setNeedsDisplay];

//    if(self.life.cells.count == 0){
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"DEAD!" message:@"All cells died. Lame." delegate:nil cancelButtonTitle:@"alright" otherButtonTitles:nil, nil];
//        [alert show];
//        [self startButtonTouchUpInside:nil];
////        self.startButton.hidden = YES;
//    }
}


#pragma mark Implements VWWCGLifeViewDelegate
-(void)cgLifeView:(VWWCGLifeView*)sender userTouchedAtX:(NSInteger)x andY:(NSInteger)y{
    VWWGOLCell *cell = [[VWWGOLCell alloc]initWithPositionX:x andY:y alive:YES];
    [self.life addCell:cell];
    [self renderCells];
}
-(void)cgLifeViewTouchesBegan:(VWWCGLifeView*)sender{
    if(self.life.running){
        [self.life stop];
        self.paused = YES;
    }
    
}
-(void)cgLifeViewTouchesEnded:(VWWCGLifeView*)sender{
    if(self.paused){
        self.paused = NO;
        [self.life start];
    }
    
}



#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex){
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        self.cgLifeView.touchType = VWWCGLifeViewTouchTypeGlider;
    } else if(buttonIndex == 1){
        self.cgLifeView.touchType = VWWCGLifeViewTouchTypeSpaceship;
    } else if(buttonIndex == 2){
        self.cgLifeView.touchType = VWWCGLifeViewTouchTypeNormal;
    } else if(buttonIndex == 3){
        [self clearButtonTouchUnInside:nil];
        [self.life killAllCells];
        [self renderCells];
    } else if(buttonIndex == 4){
        [self generateButtonTouchUpInside:nil];
    } else if(buttonIndex == 5){
    }
}

@end
