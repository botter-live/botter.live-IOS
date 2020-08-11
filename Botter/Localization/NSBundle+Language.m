//
//  NSBundle+Language.m
//  fta
//
//  Created by Dina ElShaer on 9/30/18.
//  Copyright © 2018 Dina ElShaer. All rights reserved.
//

#import "NSBundle+Language.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <Botter/Botter-swift.h>


static const char kBundleKey = 0;


@interface BundleEx : NSBundle
    
    @end

@implementation BundleEx
    
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
    {
        NSBundle *bundle = [NSBundle bundleForClass: BundleEx.class];
//        [NSBundle bundleForClass:Floa]
//        objc_getAssociatedObject(self, &kBundleKey);
        if (bundle) {
            return [bundle localizedStringForKey:key value:value table:tableName];
        }
        else {
            return [super localizedStringForKey:key value:value table:tableName];
            
        }
    }
    
    @end

@implementation NSBundle (Language)
    
+ (void)b_setLanguage:(NSString *)language
    {
        NSBundle *bundle = [NSBundle bundleForClass:self];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            object_setClass(bundle,[BundleEx class]);
        });
        id value = language ? [NSBundle bundleWithPath:[bundle pathForResource:language ofType:@"lproj"]] : nil;
        objc_setAssociatedObject(bundle, &kBundleKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if([language isEqualToString:@"ar"]){
            UIView.appearance.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
        }else{
            UIView.appearance.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
        }
        
    }
    
    @end
