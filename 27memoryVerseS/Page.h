//
//  Page.h
//  27memoryVerseS
//
//  Created by Arun George on 12/31/13.
//  Copyright (c) 2013 Pages.Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface page : NSObject {
    
    NSString *title;
    NSString* imageName;
    NSString *verseRef;
    NSString *html;
    NSString *verse;
}

@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *imageName;
@property(nonatomic,retain) NSString *verseRef;
@property(nonatomic,retain) NSString *html;
@property(nonatomic,retain) NSString *verse;

@end

