//
//  Page.m
//  27memoryVerseS
//
//  Created by Arun George on 12/31/13.
//  Copyright (c) 2013 Pages.Co. All rights reserved.
//

#import "page.h"


@implementation page
@synthesize title,imageName,verseRef,html,verse;

#pragma mark Initialization of the Page object

-(id)init{
    if(self=[super init]){}
    return self;
}

@end
