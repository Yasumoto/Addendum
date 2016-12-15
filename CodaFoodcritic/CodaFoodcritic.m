//
//  CodaFoodcritic.m
//  Addendum
//
//  Created by Joseph Mehdi Smith on 12/15/16.
//  Copyright © 2016 Joe Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodaPluginsController.h"

#import "Addendum.h"

@interface CodaFoodcritic : LinterPlugin

@end

@implementation CodaFoodcritic : LinterPlugin

- (NSString *) linterPath {
    return @"/usr/local/bin/foodcritic";
}

- (NSArray *) linterArguments {
    return @[];
}

- (NSArray*)supportedModeIdentifiers {
    return @[@"SEEMode.Chef", @"SEEMode.Ruby", @"SEEMode.rb"];
}

- (NSString *)name {
    return @"CodaFoodcritic";
}

- (NSArray *) parseLintErrors:(NSString *)output {
    NSLog(@"Being called");
    NSArray *lines = [output componentsSeparatedByString:@"\n"];
    NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:lines.count];

    for (NSString *check in lines) {
        NSArray *entry = [check componentsSeparatedByString:@":"];
        NSString *error = kValidatorTypeWarning;

        NSDictionary *lintedError = @{kValidatorMessageStringKey: entry[0],
                                      kValidatorExplanationStringKey: entry[1],
                                      kValidatorColumnKey: @0,
                                      kValidatorLineKey: entry[3],
                                      kValidatorErrorTypeKey: error};
        [results addObject:lintedError];
        
    }
    return results;
}

@end
