//
//  RCTAppleHealthKit+Methods_Activity.m
//  RCTAppleHealthKit
//
//  Created by Alexander Vallorosi on 4/27/17.
//  Copyright © 2017 Alexander Vallorosi. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_Activity.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Activity)
    
#pragma mark - helpers
    
- (HKWorkoutActivityType)activityTypeFromString:(NSString *)type
{
    if ([type isEqualToString:@"Cycling"]) {
        return HKWorkoutActivityTypeCycling;
    } else if ([type isEqualToString:@"Running"]) {
        return HKWorkoutActivityTypeRunning;
    } else if ([type isEqualToString: @"Walking"]) {
        return HKWorkoutActivityTypeWalking;
    } else if ([type isEqualToString:@"MixedMetabolicCardioTraining"]) {
        return HKWorkoutActivityTypeMixedMetabolicCardioTraining;
    } else if ([type isEqualToString:@"Dance"]) {
        return HKWorkoutActivityTypeDance;
    } else if ([type isEqualToString:@"Yoga"]) {
        return HKWorkoutActivityTypeYoga;
    } else if ([type isEqualToString:@"DanceInspiredTraining"]) {
        return HKWorkoutActivityTypeDanceInspiredTraining;
    } else if ([type isEqualToString:@"Play"]) {
        return HKWorkoutActivityTypePlay;
    } else if ([type isEqualToString:@"WaterSports"]) {
        return HKWorkoutActivityTypeWaterSports;
    } else if ([type isEqualToString:@"Boxing"]) {
        return HKWorkoutActivityTypeBoxing;
    } else if ([type isEqualToString:@"Climbing"]) {
        return HKWorkoutActivityTypeClimbing;
    } else if ([type isEqualToString:@"Golf"]) {
        return HKWorkoutActivityTypeGolf;
    } else if ([type isEqualToString:@"Hiking"]) {
        return HKWorkoutActivityTypeHiking;
    } else if ([type isEqualToString:@"MartialArts"]) {
        return HKWorkoutActivityTypeMartialArts;
    } else if ([type isEqualToString:@"CrossTraining"]) {
        return HKWorkoutActivityTypeCrossTraining;
    } else if ([type isEqualToString:@"SkatingSports"]) {
        return HKWorkoutActivityTypeSkatingSports;
    } else if ([type isEqualToString:@"Squash"]) {
        return HKWorkoutActivityTypeSquash;
    } else if ([type isEqualToString:@"SurfingSports"]) {
        return HKWorkoutActivityTypeSurfingSports;
    } else if ([type isEqualToString:@"Swimming"]) {
        return HKWorkoutActivityTypeSwimming;
    } else if ([type isEqualToString: @"Tennis"]) {
        return HKWorkoutActivityTypeTennis;
    } else if ([type isEqualToString:@"Sailing"]) {
        return HKWorkoutActivityTypeSailing;
    } else if ([type isEqualToString:@"PaddleSports"]) {
        return HKWorkoutActivityTypePaddleSports;
    } else if ([type isEqualToString:@"Elliptical"]) {
        return HKWorkoutActivityTypeElliptical;
    }
    
    return  HKWorkoutActivityTypeOther;
}
    
- (HKQuantityType *)distanceTypeForType:(HKWorkoutActivityType)type
{
    if (type == HKWorkoutActivityTypeCycling) {
        return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
    }
    
    return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
}
    
    
#pragma mark - RN methods
    
- (void)activity_getActiveEnergyBurned:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *activeEnergyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    HKUnit *cal = [HKUnit kilocalorieUnit];
    
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:activeEnergyType
                                unit:cal
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting active energy burned samples: %@", error);
                                  callback(@[RCTMakeError(@"error getting active energy burned samples", nil, nil)]);
                                  return;
                              }
                          }];
}
    
- (void)activity_saveWorkout:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSString *reportId = [RCTAppleHealthKit stringFromOptions:input key:@"id" withDefault:@""];
    NSString *name = [RCTAppleHealthKit stringFromOptions:input key:@"name" withDefault:@"Workout"];
    double calories = [RCTAppleHealthKit doubleFromOptions:input key:@"calories" withDefault:0];
    NSDate *startDate = [RCTAppleHealthKit startDateFromOptions:input];
    NSDate *endDate = [RCTAppleHealthKit endDateFromOptions:input];
    NSNumber *distance = input[@"distance"];
    NSString *type = [RCTAppleHealthKit stringFromOptions:input key:@"type" withDefault:@"MixedMetabolicCardioTraining"];
    
    HKWorkoutActivityType activityType = [self activityTypeFromString:type];
    NSMutableArray *workoutSamples = [NSMutableArray new];
    HKQuantity *workoutDistance = nil;
    
    // create energy burn sample
    HKQuantity *kcalQuantity = [HKQuantity quantityWithUnit:[HKUnit unitFromString:@"kcal"] doubleValue:calories];
    HKQuantityType *kcalType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    HKQuantitySample *kcalSample = [HKQuantitySample quantitySampleWithType:kcalType
                                                                   quantity:kcalQuantity
                                                                  startDate:startDate
                                                                    endDate:endDate
                                                                   metadata:@{@"reportId": reportId}
                                    ];
    
    [workoutSamples addObject:kcalSample];
    
    // create distance covered sample
    if (distance != nil) {
        HKQuantity *distanceQuantity = [HKQuantity quantityWithUnit:[HKUnit unitFromString:@"m"] doubleValue:[distance doubleValue]];
        HKQuantitySample *distanceSample = [HKQuantitySample quantitySampleWithType:[self distanceTypeForType:activityType]
                                                                           quantity:distanceQuantity
                                                                          startDate:startDate
                                                                            endDate:endDate
                                                                           metadata:@{@"reportId": reportId}
                                            ];
        
        [workoutSamples addObject:distanceSample];
    }
    
    // create the workout
    HKWorkout *workout = [HKWorkout workoutWithActivityType:activityType
                                                  startDate:startDate
                                                    endDate:endDate
                                              workoutEvents:nil
                                          totalEnergyBurned:kcalQuantity
                                              totalDistance:workoutDistance
                                                   metadata:@{@"name": name, @"reportId": reportId}
                          ];
    
    // save workout and add any samples necessary
    [self.healthStore saveObject:workout withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"error saving workout: %@", error);
            callback(@[RCTMakeError(@"error saving workout", error, nil)]);
            return;
        }
        
        [self.healthStore addSamples:workoutSamples toWorkout:workout completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"error saving workout: %@", error);
                callback(@[RCTMakeError(@"error saving workout", error, nil)]);
                return;
            }
            
            callback(@[[NSNull null]]);
        }];
    }];
}

@end
