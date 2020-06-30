//
//  ViewController.m
//  AWMY
//
//  Created by Tomisin Jenrola on 2020-06-30.
//  Copyright © 2020 tojen. All rights reserved.
//

#import "ViewController.h"


@interface TaskResult : NSObject;

@property (nonatomic) NSError *error;
@property (nonatomic) NSString *duration;

//- (NSString *) getDataFrom:(NSString *)url;

@end

@implementation TaskResult

@end


@interface ViewController ()

//@property (weak, nonatomic) IBOutlet UIButton *myButton;
//@property (weak, nonatomic) IBOutlet UILabel *myTextField;

//- (IBAction)runGETFromGo:(id)sender;
//- (IBAction)runGETLoopFromGo:(id)sender;
//- (IBAction)runGETFromiOS:(id)sender;

- (TaskResult*)testGETLoopFromGo: (NSString*)url repeatFor:(long)count;
- (TaskResult*)testGETFromGo: (NSString*)url repeatFor:(long)count;
- (TaskResult*)testGETFromiOS: (NSString*)url repeatFor:(long)count;


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *url = [NSMutableString stringWithString:@"http://www.google.com"];
    long count = 50;
    
    /*
     *
     * testGETLoopFromGo
     *
     */
    UILabel *yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 300, 200)];
    [yourLabel setTextColor:[UIColor brownColor]];
    [yourLabel setBackgroundColor:[UIColor clearColor]];
    [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
    [yourLabel setText:@"Hello"];
    [self.view addSubview:yourLabel];

    TaskResult *result1 = [self testGETLoopFromGo: url repeatFor:count];
    if(result1.error) {
        NSLog(@"error with [testGETLoopFromGo]: %@", result1.error);
        yourLabel.text = [NSString stringWithFormat:@"%@", result1.error];
    }
    yourLabel.text = [NSString stringWithFormat:@"testGETLoopFromGo n:%ld sec:%@", count, result1.duration];
    
    /*
     *
     * testGETFromGo
     *
     */
    UILabel *yourLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 300, 200)];
    [yourLabel2 setTextColor:[UIColor brownColor]];
    [yourLabel2 setBackgroundColor:[UIColor clearColor]];
    [yourLabel2 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
    [yourLabel2 setText:@"Hello"];
    [self.view addSubview:yourLabel2];
    
    TaskResult *result2 = [self testGETFromGo: url repeatFor:count];
    if(result2.error) {
        NSLog(@"error with [testGETFromGo]: %@", result2.error);
        yourLabel2.text = [NSString stringWithFormat:@"%@", result2.error];
    }
    yourLabel2.text = [NSString stringWithFormat:@"testGETFromGo n:%ld sec:%@", count, result2.duration];
    
    /*
     *
     * testGETFromiOS
     *
     */
    UILabel *yourLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 300, 200)];
    [yourLabel3 setTextColor:[UIColor brownColor]];
    [yourLabel3 setBackgroundColor:[UIColor clearColor]];
    [yourLabel3 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
    [yourLabel3 setText:@"Hello"];
    [self.view addSubview:yourLabel3];
    
    TaskResult *result3 = [self testGETFromiOS: url repeatFor:count];
    if(result3.error) {
        NSLog(@"error with [testGETFromiOS]: %@", result3.error);
        yourLabel3.text = [NSString stringWithFormat:@"%@", result3.error];
    }
    yourLabel3.text = [NSString stringWithFormat:@"testGETFromiOS n:%ld sec:%@", count, result3.duration];

    
}

- (TaskResult*)testGETLoopFromGo: (NSString*)url repeatFor:(long)count {
    NSError *error = nil;
    NSDate *start = [NSDate date];
    
    TryhttpGetLoop(url, count, &error);
    
    NSTimeInterval timeInterval = [start timeIntervalSinceNow];
    double timePassed_ms = timeInterval * -1;
    TaskResult *result = [[TaskResult alloc]init];
    result.duration = [NSString stringWithFormat:@"%f", timePassed_ms]; //[self stringFromTimeInterval:timeInterval];
    result.error = error;

    NSString *res = [NSString stringWithFormat:@"[testGETLoopFromGo] url:%@ loops:%ld took:%@",
    url, count, result.duration];
    NSLog(@"res: %@", res);
    
    return result;
}

- (TaskResult*)testGETFromGo: (NSString*)url repeatFor:(long)count {
    NSError *error = nil;

    int a;
    NSDate *start = [NSDate date];

    for( a = 0; a < (int) count; a = a + 1 ) {
        TryhttpGet( url);
    }

    NSTimeInterval timeInterval = [start timeIntervalSinceNow];
    double timePassed_ms = timeInterval * -1;
    TaskResult *result = [[TaskResult alloc]init];
    result.duration = [NSString stringWithFormat:@"%f", timePassed_ms]; //[self stringFromTimeInterval:timeInterval];
    result.error = error;

    NSString *res = [NSString stringWithFormat:@"[testGETFromGo] url:%@ loops:%ld took:%@",
    url, count, result.duration];
    NSLog(@"res: %@", res);
    return result;
}

- (TaskResult*)testGETFromiOS: (NSString*)url repeatFor:(long)count {
    NSError *error = nil;

    int a;
    NSDate *start = [NSDate date];

    for( a = 0; a < (int) count; a = a + 1 ) {
        TryhttpGet(url, &error);
    }

    NSTimeInterval timeInterval = [start timeIntervalSinceNow];
    double timePassed_ms = timeInterval * -1;
    TaskResult *result = [[TaskResult alloc]init];
    result.duration = [NSString stringWithFormat:@"%f", timePassed_ms]; //[self stringFromTimeInterval:timeInterval];
    result.error = error;

    NSString *res = [NSString stringWithFormat:@"[testGETFromiOS] url:%@ loops:%ld took:%@",
    url, count, result.duration];
    NSLog(@"res: %@", res);
    return result;
}

- (NSString *) getDataFrom:(NSString *)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];

    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;

    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];

    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %ld", url, [responseCode statusCode]);
        return nil;
    }

    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

@end
