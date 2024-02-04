//
//  CXXModelWrapper.m
//  Polyglot
//
//  Created by Bassist_Zero on 2/4/24.
//

#import "CXXModelWrapper.h"
#import "CXXModel.h"

@implementation CXXModelWrapper

+ (NSString*) getText {
    std::string cppText = CXXModel::getText();
    NSString* wrappedCPPText = [NSString stringWithUTF8String: cppText.c_str()];
    return [wrappedCPPText stringByAppendingString:@"\nfrom Wrapper!"];
}

@end
