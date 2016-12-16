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
    return @"Chef";
}

- (NSArray *) parseLintErrors:(NSString *)output {
    output = [output stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceCharacterSet]];
    NSArray *lines = [output componentsSeparatedByString:@"\n"];
    NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:lines.count];

    for (NSString *check in lines) {
        NSArray *entry = [check componentsSeparatedByString:@":"];
        NSString *error = kValidatorTypeWarning;
        if (entry.count == 4) {
            NSDictionary *lintedError = @{kValidatorMessageStringKey: entry[0],
                                          kValidatorExplanationStringKey: [entry[1] stringByTrimmingCharactersInSet:
                                                                           [NSCharacterSet whitespaceCharacterSet]],
                                          kValidatorColumnKey: @0,
                                          kValidatorLineKey: [NSNumber numberWithInteger:[entry[3] integerValue]],
                                          kValidatorErrorTypeKey: error};
            [results addObject:lintedError];
        }
    }
    return results;
}

@end
