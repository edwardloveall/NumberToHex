//
//  NumberToHexPlugIn.m
//  NumberToHex
//
//  Created by Edward Loveall on 6/29/13.
//  Copyright (c) 2013 Edward Loveall. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>

#import "NumberToHexPlugIn.h"

#define	kQCPlugIn_Name				@"Number To Hex"
#define	kQCPlugIn_Description		@"Converts Numbers to their Hex Values. Floating point inputs will round to their nearest integer. Also, a the number of leading zero's is configurable via the Digits input."

@implementation NumberToHexPlugIn

@dynamic inputNumber, inputDigits, outputString;

// Here you need to declare the input / output properties as dynamic as Quartz Composer will handle their implementation
//@dynamic inputFoo, outputBar;

+ (NSDictionary *)attributes
{
	// Return a dictionary of attributes describing the plug-in (QCPlugInAttributeNameKey, QCPlugInAttributeDescriptionKey...).
    return @{QCPlugInAttributeNameKey:kQCPlugIn_Name, QCPlugInAttributeDescriptionKey:kQCPlugIn_Description};
}

+ (NSDictionary *)attributesForPropertyPortWithKey:(NSString *)key
{
	if ([key isEqualToString:@"inputNumber"]) {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                @"Number", QCPortAttributeNameKey,
                nil];
    }

    if ([key isEqualToString:@"inputDigits"]) {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                @"Digits", QCPortAttributeNameKey,
                @"2", QCPortAttributeDefaultValueKey,
                nil];
    }

    if ([key isEqualToString:@"outputString"]) {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                @"String", QCPortAttributeNameKey,
                nil];
    }

	return nil;
}

+ (QCPlugInExecutionMode)executionMode
{
	// Return the execution mode of the plug-in: kQCPlugInExecutionModeProvider, kQCPlugInExecutionModeProcessor, or kQCPlugInExecutionModeConsumer.
	return kQCPlugInExecutionModeProcessor;
}

+ (QCPlugInTimeMode)timeMode
{
	// Return the time dependency mode of the plug-in: kQCPlugInTimeModeNone, kQCPlugInTimeModeIdle or kQCPlugInTimeModeTimeBase.
	return kQCPlugInTimeModeNone;
}

- (id)init
{
	self = [super init];
	if (self) {
		// Allocate any permanent resource required by the plug-in.
	}

	return self;
}


@end

@implementation NumberToHexPlugIn (Execution)

- (BOOL)startExecution:(id <QCPlugInContext>)context
{
	// Called by Quartz Composer when rendering of the composition starts: perform any required setup for the plug-in.
	// Return NO in case of fatal failure (this will prevent rendering of the composition to start).

	return YES;
}

- (void)enableExecution:(id <QCPlugInContext>)context
{
	// Called by Quartz Composer when the plug-in instance starts being used by Quartz Composer.
}

- (BOOL)execute:(id <QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary *)arguments
{
	/*
	Called by Quartz Composer whenever the plug-in instance needs to execute.
	Only read from the plug-in inputs and produce a result (by writing to the plug-in outputs or rendering to the destination OpenGL context) within that method and nowhere else.
	Return NO in case of failure during the execution (this will prevent rendering of the current frame to complete).

	The OpenGL context for rendering can be accessed and defined for CGL macros using:
	CGLContextObj cgl_ctx = [context CGLContextObj];
	*/

    int input = (int)round(self.inputNumber);

    NSString *hexString = [NSString stringWithFormat:@"%x", input];

    while ([hexString length] < self.inputDigits) {
        hexString = [NSString stringWithFormat:@"0%@", hexString];
    }

    hexString = [hexString uppercaseString];

    self.outputString = hexString;

	return YES;
}

- (void)disableExecution:(id <QCPlugInContext>)context
{
	// Called by Quartz Composer when the plug-in instance stops being used by Quartz Composer.
}

- (void)stopExecution:(id <QCPlugInContext>)context
{
	// Called by Quartz Composer when rendering of the composition stops: perform any required cleanup for the plug-in.
}

@end
