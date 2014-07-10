//
//  hamburgerViewController.m
//  Week 4 - Thursday YT Menu
//
//  Created by Josh Sassoon on 7/10/14.
//  Copyright (c) 2014 youtubeux. All rights reserved.
//

#import "hamburgerViewController.h"
#import "menuViewController.h"
#import "feedViewController.h"

@interface hamburgerViewController ()

@property (nonatomic, strong) menuViewController *menuVC;
@property (nonatomic, strong) feedViewController *feedVC;

@end

@implementation hamburgerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.menuVC = [[menuViewController alloc] init];
        self.feedVC = [[feedViewController alloc] init];
    }
    return self;
}


- (void)onCustomPan:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint point = [panGestureRecognizer locationInView:self.feedVC.view];
    CGPoint velocity = [panGestureRecognizer velocityInView:self.feedVC.view];
    CGPoint translation = [panGestureRecognizer translationInView:self.feedVC.view];
    
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Gesture began at: %@", NSStringFromCGPoint(point));
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"Gesture changed: %@", NSStringFromCGPoint(point));
        if (velocity.x <= 0) {
            self.feedVC.view.center = CGPointMake(self.feedVC.view.center.x  + (translation.x * .1), self.feedVC.view.center.y);
            float scale = self.feedVC.view.frame.origin.x * ((1 - .9)/(310 - 0)) + .9;
            self.menuVC.view.transform = CGAffineTransformMakeScale(scale, scale);
        } else {
            self.feedVC.view.center = CGPointMake(self.feedVC.view.center.x  + (translation.x * .1), self.feedVC.view.center.y);
            float scale = self.feedVC.view.frame.origin.x * ((1 - .9)/(310 - 0)) + .9;
            self.menuVC.view.transform = CGAffineTransformMakeScale(scale, scale);
        }

    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"Gesture ended: %@", NSStringFromCGPoint(point));
        if (velocity.x >= 0) {
            [UIView animateWithDuration:.5 animations:^{
                self.feedVC.view.frame = CGRectMake(310,0,320, 640);
            }];
            
            [UIView animateWithDuration:.5 animations:^{
               // self.menuVC.view.frame = CGRectMake (0,0, slef.menuVC.frame.origin., 500);
                self.menuVC.view.transform = CGAffineTransformMakeScale(1, 1);
            }];
             
            
        } else {
            [UIView animateWithDuration:.1 animations:^{
                self.feedVC.view.frame = CGRectMake (0,0, 320, 640);
            }];
            
            [UIView animateWithDuration:.5 animations:^{
                //self.menuVC.view.frame = CGRectMake (0,0, 320, 640);
                self.menuVC.view.transform = CGAffineTransformMakeScale(.9, .9);
            }];
            
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:self.menuVC.view];
    [self.view addSubview:self.feedVC.view];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onCustomPan:)];
    
    // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    self.menuVC.view.transform = CGAffineTransformMakeScale(.9, .9);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
