//
//  RCTAppleHealthKit+TypesAndPermissions.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+TypesAndPermissions.h"

@implementation RCTAppleHealthKit (TypesAndPermissions)


#pragma mark - HealthKit Permissions

- (NSDictionary *)readPermsDict {
    NSMutableDictionary *readPerms = [[NSMutableDictionary alloc] initWithDictionary:@{
        // Characteristic Identifiers
        @"DateOfBirth" : [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth],
        @"BiologicalSex" : [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex],
        // Body Measurements
        @"Height" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],
        @"Weight" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
        @"BodyMass" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
        @"BodyFatPercentage" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage],
        @"BodyMassIndex" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex],
        @"LeanBodyMass" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierLeanBodyMass],
        // Fitness Identifiers
        @"Steps" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
        @"StepCount" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
        @"DistanceWalkingRunning" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning],
        @"DistanceCycling" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling],
        @"BasalEnergyBurned" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned],
        @"ActiveEnergyBurned" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned],
        @"FlightsClimbed" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed],
        @"NikeFuel" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierNikeFuel],
//        @"AppleExerciseTime" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleExerciseTime],
        // Nutrition Identifiers
        @"DietaryEnergy" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed],
        // Vital Signs Identifiers
        @"HeartRate" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate],
        @"BodyTemperature" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature],
        @"BloodPressureSystolic" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic],
        @"BloodPressureDiastolic" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic],
        @"RespiratoryRate" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRespiratoryRate],
        // Results Identifiers
        @"BloodGlucose" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose],
        // Sleep
        @"SleepAnalysis" : [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis],
    }];
    
    if (@available(iOS 10, *)) {
        [readPerms addEntriesFromDictionary:@{
            // Mindfulness
            @"MindfulSession" : [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMindfulSession],
        }];
    }
    
    return readPerms;
}


- (NSDictionary *)writePermsDict {
    NSMutableDictionary *writePerms = [[NSMutableDictionary alloc] initWithDictionary:@{
        // Body Measurements
        @"Height" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],
        @"Weight" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
        @"BodyMass" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
        @"BodyFatPercentage" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage],
        @"BodyMassIndex" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex],
        @"LeanBodyMass" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierLeanBodyMass],
        // Fitness Identifiers
        @"Steps" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
        @"StepCount" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
        @"DistanceWalkingRunning" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning],
        @"DistanceCycling" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling],
        @"BasalEnergyBurned" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned],
        @"ActiveEnergyBurned" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned],
        @"FlightsClimbed" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed],
        @"WorkoutType" : [HKWorkoutType workoutType],
        // Nutrition Identifiers
        @"DietaryEnergy" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed],
        @"DietaryProtein" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryProtein],
        @"DietaryFatTotal" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatTotal],
        @"DietaryCarbohydrates" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCarbohydrates],
        // Sleep
        @"SleepAnalysis" : [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis],
    }];
    
    if (@available(iOS 10, *)) {
        [writePerms addEntriesFromDictionary:@{
            // Mindfulness
            @"MindfulSession" : [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMindfulSession],
        }];
    }
    
    return writePerms;
}


// Returns HealthKit read permissions from options array
- (NSSet *)getReadPermsFromOptions:(NSArray *)options {
    NSDictionary *readPermDict = [self readPermsDict];
    NSMutableSet *readPermSet = [NSMutableSet setWithCapacity:1];

    for(int i=0; i<[options count]; i++) {
        NSString *optionKey = options[i];
        HKObjectType *val = [readPermDict objectForKey:optionKey];
        if(val != nil) {
            [readPermSet addObject:val];
        }
    }
    return readPermSet;
}


// Returns HealthKit write permissions from options array
- (NSSet *)getWritePermsFromOptions:(NSArray *)options {
    NSDictionary *writePermDict = [self writePermsDict];
    NSMutableSet *writePermSet = [NSMutableSet setWithCapacity:1];

    for(int i=0; i<[options count]; i++) {
        NSString *optionKey = options[i];
        HKObjectType *val = [writePermDict objectForKey:optionKey];
        if(val != nil) {
            [writePermSet addObject:val];
        }
    }
    return writePermSet;
}

@end
