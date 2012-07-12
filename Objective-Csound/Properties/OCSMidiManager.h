//
//  OCSPropertyManager.h
//  Objective-Csound
//
//  Created by Adam Boulanger on 6/15/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//
//  
//

#import <CoreMIDI/CoreMIDI.h>

#import "OCSManager.h"

@interface OCSMidiManager : NSObject
{
    NSMutableArray *propertyList;
    MIDIClientRef myClient;
}

@property (readonly) NSMutableArray* propertyList;

//- (void)openMidiIn;
//- (void)closeMidiIn;

- (void)addProperty:(OCSProperty *)prop forControllerNumber:(int)controllerNumber;

//- (void)addProperty:(OCSProperty *)prop;
@end