#import "bridge.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <Foundation/Foundation.h>
#import <BackgroundTasks/BackgroundTasks.h>

@implementation bridge

- (id) init {
    if(self = [super init]) {
        self.motionManager = [[CMMotionManager alloc] init];
        queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)startAccelerometer {
    
    if ([self.motionManager isAccelerometerAvailable] == YES) {
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            self.ac_x = accelerometerData.acceleration.x;
            self.ac_y = accelerometerData.acceleration.y;
            self.ac_z = accelerometerData.acceleration.z;
        }];
    }
}

- (void)startGyroscope {
    
    if ([self.motionManager isGyroAvailable] == YES) {
        [self.motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData *gyroData, NSError *error) {
            self.gy_x = gyroData.rotationRate.x;
            self.gy_y = gyroData.rotationRate.y;
            self.gy_z = gyroData.rotationRate.z;
        }];
    }
}

- (void)startMagnetometer {
    
    if (self.motionManager.magnetometerAvailable) {
        [self.motionManager startMagnetometerUpdatesToQueue:queue withHandler:^(CMMagnetometerData *magnetometerData, NSError *error) {
            self.mg_x = magnetometerData.magneticField.x;
            self.mg_y = magnetometerData.magneticField.y;
            self.mg_z = magnetometerData.magneticField.z;
        }];
    }
}

- (void) stopAccelerometer {
    [self.motionManager stopAccelerometerUpdates];
}

- (void) stopGyroscope {
    [self.motionManager stopGyroUpdates];
}

- (void) stopMagnetometer {
    [self.motionManager stopMagnetometerUpdates];
}

- (void) dealloc {
    [self.motionManager release];
    [queue release];
    [super dealloc];
}

-(void) Facing{
    LAContext *myContext=[[LAContext alloc] init];
    NSError *authError=nil;
        if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]){
           [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
            localizedReason:@"Use touch id \n or hit \"Cancel\" to enter passcode"
                      reply:^(BOOL success, NSError * _Nullable error) {
               dispatch_async(dispatch_get_main_queue(), ^{
                    });
                        if (success){
                            NSLog(@"success");
                          //  [[UIDevice currentDevice] ]
                        } else {
                            NSLog(@"NOT");
                        }
           }];
        }
}

-(BOOL) Facing1{
    LAContext *myContext=[[LAContext alloc] init];
    NSError *authError=nil;
        if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]){
           [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
            localizedReason:@"Use touch id \n or hit \"Cancel\" to enter passcode"
                      reply:^(BOOL success, NSError * _Nullable error) {
               dispatch_async(dispatch_get_main_queue(), ^{
                 
                    });
                        
                        if (success){
                            self.bool_=true;
                            NSLog(@"success");
                        } else {
                            NSLog(@"NOT");
                            self.bool_=false;
                        }
           }];
            return self.bool_;
        }
    if (self.bool_) {
        NSLog(@"True");
    }
    else NSLog(@"False");
}

-(BOOL) Password{
    self.bool_=false;
    LAContext *myContext=[[LAContext alloc] init];
    NSError *authError=nil;
        if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&authError]){
           [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication
            localizedReason:@"Use touch id \n or hit \"Cancel\" to enter passcode"
                      reply:^(BOOL success, NSError * _Nullable error) {
               dispatch_async(dispatch_get_main_queue(), ^{
                    });
                        self.bool_=success;
                        if (success){
                            NSLog(@"success");
                        } else NSLog(@"NOT");
           }];
        }
        return self.bool_;
}


-(void) ReFacing{
   // if ([[[UIDevice currentDevice] systemVersion]floatValue]>=7.0){
    //    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:600];
    //}
    NSLog(@"Hey");
    self.backgroundTask =[[ UIApplication sharedApplication]beginBackgroundTaskWithExpirationHandler:^ {
        while (true){
            self.Facing1;
            [NSThread sleepForTimeInterval:5.0];
            if (self.bool_){break;}
            else Device
        }
        [self endBackgroundTask];
    }];
      
   // e -l objc --(void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"Facing"]
}

-(void) endBackgroundTask{
    NSLog(@"Background task ended.");
    [[UIApplication sharedApplication]endBackgroundTask:self.backgroundTask];
}
@end
