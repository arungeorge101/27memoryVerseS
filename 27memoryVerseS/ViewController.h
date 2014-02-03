//
//  ViewController.h
//  27memoryVerseS
//
//  Created by Arun George on 12/21/13.
//  Copyright (c) 2013 Pages.Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate,NSXMLParserDelegate>{
    UIScrollView* scrollView;
    UIPageControl* pageControl;
    NSMutableArray *arrayPages;
    UIScrollView* scrollView_iPad;
    BOOL* iPadBool;
}

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView_iPad;

@end

