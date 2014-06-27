//
//  ViewController.m
//  UIDatePicker
//
//  Created by Suzuki Kenta on 2014/06/26.
//  Copyright (c) 2014年 Kenta Suzuki. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    AVAudioPlayer *audio;

    IBOutlet UILabel *l1;

    NSDate *endDate;

    NSTimer *timer1;
}

-(IBAction)start;
-(IBAction)stop;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _datePicker.minimumDate = [NSDate date];
    _datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:60*60*24*30];
    [_datePicker addTarget:self action:@selector(pickerDidChange:) forControlEvents:UIControlEventValueChanged];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"alerm sound" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    audio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audio.numberOfLoops = 12; //play 12 time
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -start button
-(IBAction)start{
    timer1=[NSTimer scheduledTimerWithTimeInterval:1.0 //interval of start alerms generation
                                            target:self
                                          selector:@selector(start2) //called methods
                                          userInfo:nil
                                           repeats:YES];
}


- (void)pickerDidChange:(UIDatePicker*)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:datePicker.date]; //今の時間から、NSDatePickerで設定した時間を計算

    l1.text=[NSString stringWithFormat:@"%d",datePicker.date];
}
//

-(void)start2{

    [timer1 invalidate];

    [audio play];


    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"alerm"
                                                   message:@"time finished"
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"OK", nil
                          ];
    [alert show];
}

#pragma mark -stop button
-(IBAction)stop{
    [audio stop];
}
@end
