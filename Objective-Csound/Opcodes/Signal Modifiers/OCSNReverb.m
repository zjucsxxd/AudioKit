//
//  OCSNReverb.m
//
//  Created by Adam Boulanger on 6/22/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//

#import "OCSNReverb.h"

@interface OCSNReverb () {
    OCSParam *output;
    OCSParam *input;
    OCSParamControl *dur;
    OCSParamControl *hfdif;
    
    BOOL isInitSkipped;
    
    NSArray *combTimes;
    NSArray *combGains;
    
    NSArray *allPassTimes;
    NSArray *allPassGains;
}
@end


@implementation OCSNReverb
@synthesize output;

- (id)initWithInput:(OCSParam *)inputSignal
     reverbDuration:(OCSParamControl *)reverbDuration 
highFreqDiffusivity:(OCSParamControl *)highFreqDiffusivity;
{
    self = [super init];
    if(self) {
        output = [OCSParam paramWithString:[self opcodeName]];
        input = inputSignal;
        dur = reverbDuration;
        hfdif = highFreqDiffusivity;
    }
    return self;
}

- (id)initWithInput:(OCSParam *)inputSignal
     reverbDuration:(OCSParamControl *)reverbDuration
highFreqDiffusivity:(OCSParamControl *)highFreqDiffusivity
    combFilterTimes:(NSArray *)combFilterTimes
    combFilterGains:(NSArray *)combFilterGains
 allPassFilterTimes:(NSArray *)allPassFilterTimes
 allPassFilterGains:(NSArray *)allPassFilterGains;
{
    self = [super init];
    if(self) {
        output = [OCSParam paramWithString:[self opcodeName]];
        input = inputSignal;
        dur = reverbDuration;
        hfdif = highFreqDiffusivity;
        
        combTimes = combFilterTimes;
        combGains = combFilterGains;
        allPassTimes = allPassFilterTimes;
        allPassGains = allPassFilterGains;
    }
    return self;
}

- (NSString *)stringForCSD
{
    //iSine ftgentmp 0, 0, 4096, 10, 1
    
    //Check if optional parameters have been set before constructing CSD

    if (combGains) {
        return [NSString stringWithFormat:@"%@ %@ nreverb %@, %@, %@, %@, %@, %@, %@",
                [self functionTableCSDFromFilterParams],
                output, dur, hfdif, combTimes, combGains, allPassTimes, allPassGains];
    } else {
        return [NSString stringWithFormat:@"%@ nreverb %@, %@, %@", 
                output, input, dur, hfdif];
    }
}

- (NSString *)functionTableCSDFromFilterParams
{
    NSString *combTable = [NSString stringWithFormat:@"%i%@CombValues ftgentmp 0, 0, %i, %@ %@",
                           [self opcodeName], [combGains count], -2, combTimes, combGains]; 
    NSString *allPassTable = [NSString stringWithFormat:@"%i%@CombValues ftgentmp 0, 0, %i, %@ %@",
                              [self opcodeName], [allPassGains count], -2, allPassTimes, allPassGains]; 
    NSString *s = [NSString stringWithFormat:@"%@ %@", combTable, allPassTable];
    return s;
}

/// Gives the CSD string for the output parameter.  
- (NSString *)description {
    return [output parameterString];
}

@end