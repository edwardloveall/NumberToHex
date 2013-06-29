//
//  NumberToHexPlugIn.h
//  NumberToHex
//
//  Created by Edward Loveall on 6/29/13.
//  Copyright (c) 2013 Edward Loveall. All rights reserved.
//

#import <Quartz/Quartz.h>

@interface NumberToHexPlugIn : QCPlugIn

@property (assign) double inputNumber;
@property (assign) NSUInteger inputDigits;
@property (assign) NSString* outputString;

@end
