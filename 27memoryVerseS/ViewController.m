//
//  ViewController.m
//  27memoryVerseS
//
//  Created by Arun George on 12/21/13.
//  Copyright (c) 2013 Pages.Co. All rights reserved.
//

#import "ViewController.h"
#import "Page.h"
#import "DDXML.h"
#import "DDXMLElement.h"
#import "DDXMLDocument.h"
#import "DDXMLNode.h"
#import "DDXMLElementAdditions.h"
#import "DDXMLPrivate.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    self.scrollView_iPad.delegate = self;
    
    //initialize the array to hold the Page objects
    arrayPages = [[NSMutableArray alloc]init];
    
}

#pragma mark - find if it is an iPad

- (BOOL) amIAnIPad {
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
    if ([[UIDevice currentDevice] respondsToSelector: @selector(userInterfaceIdiom)])
        return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
#endif
    return NO;
}

#pragma mark - load the pages iPad/iPhone

-(void) createPagesinScrollView
{
    int i = 0;
    CGFloat offset;
    int titleFontSize;
    int verseRefFontSize;
    int verseFontSize;
    int yCoordinateStart;
    int frameWidthforTitle;
    UIScrollView *curr_ScrollView;
    
    if(iPadBool)
    {
        offset = 50.0f;
        titleFontSize = 28;
        verseRefFontSize = 22;
        verseFontSize = 24;
        yCoordinateStart = 300;
        frameWidthforTitle = 500;
        curr_ScrollView = self.scrollView_iPad;
    }
    else
    {
        offset = 25.0f;
        titleFontSize = 19;
        verseRefFontSize = 16;
        verseFontSize = 22;
        yCoordinateStart = 80;
        frameWidthforTitle = 250;
        curr_ScrollView = self.scrollView;
    }
    
    NSArray *viewsToRemove = [curr_ScrollView subviews];
    
    for (UIView *v in viewsToRemove) {
        if ((![v isKindOfClass:[UIImageView class]]) && (v.tag == 123 || v.tag == 124 || v.tag == 125)) {
            [v removeFromSuperview];
            //[view performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
        }
    }

    for(page *myPage in arrayPages)
    {
                
        //Find the width of the text based on the actual font and size
        NSDictionary *attributesTitle = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Copperplate-Light" size:titleFontSize], NSFontAttributeName, nil];
        NSAttributedString *textTitle = [[NSAttributedString alloc] initWithString:myPage.title attributes: attributesTitle];
        CGSize textTitleSize = [textTitle size];
        
        //Difference between the screensize and the actual width
        int diffTitle = curr_ScrollView.frame.size.width - textTitleSize.width;
        
        //the frame and label for the page title
        CGRect titleFrame = CGRectMake((curr_ScrollView.frame.size.width * i)+(diffTitle/2), yCoordinateStart, 20, 50);
        
        UILabel *pageTitle = [[UILabel alloc] initWithFrame:titleFrame];
        
        [pageTitle setTextColor:[UIColor blackColor]];
        [pageTitle setBackgroundColor:[UIColor whiteColor]];
        [pageTitle setFont:[UIFont fontWithName: @"Copperplate-Light" size: titleFontSize]];
        [pageTitle setText:myPage.title];
        [pageTitle sizeToFit];
        pageTitle.textAlignment = NSTextAlignmentCenter;
        pageTitle.numberOfLines = 0;
        pageTitle.lineBreakMode = NSLineBreakByWordWrapping;
        pageTitle.tag = 123;
        [curr_ScrollView addSubview:pageTitle];
        
        //Find the width of the text based on the actual font and size
        NSDictionary *attributesVerseRef = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Copperplate-Light" size:verseRefFontSize], NSFontAttributeName, nil];
        NSAttributedString *textVerseRef = [[NSAttributedString alloc] initWithString:myPage.verseRef attributes: attributesVerseRef];
        CGSize textVerseRefSize = [textVerseRef size];
        
        //Difference between the screensize and the actual width
        int diffVerseRef = curr_ScrollView.frame.size.width - textVerseRefSize.width;
        
        //the frame and label for VerseRef
        CGRect verseRefFrame = CGRectMake((curr_ScrollView.frame.size.width * i)+(diffVerseRef/2),
                                          pageTitle.frame.origin.y + pageTitle.frame.size.height + offset,
                                          200,
                                          50);
        
        UILabel *pageVerseRef = [[UILabel alloc] initWithFrame:verseRefFrame];
        
        [pageVerseRef setTextColor:[UIColor blackColor]];
        [pageVerseRef setBackgroundColor:[UIColor whiteColor]];
        [pageVerseRef setFont:[UIFont fontWithName: @"Copperplate-Light" size: verseRefFontSize]];
        [pageVerseRef setText:myPage.verseRef];
        [pageVerseRef sizeToFit];
        pageVerseRef.numberOfLines=0;
        pageVerseRef.textAlignment = NSTextAlignmentCenter;
        pageVerseRef.tag = 124;
        [curr_ScrollView addSubview:pageVerseRef];
        
        
        //Difference between the screensize and the actual width
        int diffVerse = curr_ScrollView.frame.size.width - frameWidthforTitle;
        
        //the frame and label for Verse
        CGRect verseFrame = CGRectMake((curr_ScrollView.frame.size.width * i++)+(diffVerse/2),
                                       pageVerseRef.frame.origin.y + pageVerseRef.frame.size.height + offset,
                                       frameWidthforTitle,
                                       50);
        
        UILabel *pageVerse = [[UILabel alloc] initWithFrame:verseFrame];
        
        [pageVerse setTextColor:[UIColor blackColor]];
        [pageVerse setBackgroundColor:[UIColor whiteColor]];
        [pageVerse setFont:[UIFont fontWithName: @"Copperplate-Light" size: verseFontSize]];
        [pageVerse setText:myPage.verse];
        pageVerse.numberOfLines = 0;
        pageVerse.textAlignment = NSTextAlignmentCenter;
        [pageVerse sizeToFit];
        pageVerse.tag = 125;
        [curr_ScrollView addSubview:pageVerse];
        
        
    }
    
    curr_ScrollView.contentSize = CGSizeMake(curr_ScrollView.frame.size.width * arrayPages.count, curr_ScrollView.frame.size.height);
    curr_ScrollView.bounces = NO;
}

#pragma mark - loadVersefromXML

//Method to read the XML file and read the data
-(void) loadVersesfromXML
{
    NSError *error;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    int row;
    NSString *fileName;
    
    //read the current row value from the NSUserDefaults obect
    if([prefs objectForKey:@"selectedRow"] != nil)
        row = [prefs integerForKey:@"selectedRow"];
    else
        row = 2;
    
    switch (row){
        case 0:
            fileName = @"ESV_verses";
            break;
        case 1:
            fileName = @"NASB_verses";
            break;
        case 2:
            fileName = @"NIV_verses";
            break;
        case 3:
            fileName = @"KJV_verses";
            break;
        case 4:
            fileName = @"NKJV_verses";
            break;
        case 5:
            fileName = @"NLT_verses";
            break;
        case 6:
            fileName = @"NRSV_verses";
            break;
        default:
            fileName = @"NIV_verses";
            break;
    }
    
    //Clear all the arraypages before loading the new XML or else it will have the old pages
    [arrayPages removeAllObjects];
    
    //load the XML file
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    //NSData *xmlData = [NSData dataWithContentsOfFile:@"/Users/arungeorge/Documents/Xcode_Repository/27memoryVerseS/27memoryVerseS/NIV_verses.xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:filePath];
    
    DDXMLDocument *ddDoc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    
    NSArray *xmlItems = [ddDoc nodesForXPath:@"//page" error:&error]; // where ddDoc is your DDXMLDocument
    
    for(DDXMLElement* itemElement in xmlItems)
    {
        // Here you get the item->value attribute value as string...
        NSString *titleValue = [[itemElement attributeForName:@"title"]stringValue];
        
        // And finally the image->value attribute value as string…
        NSString *verseRefValue = [[itemElement attributeForName:@"verseref"]stringValue];
        
        // And finally the image->value attribute value as string…
        NSString *verseValue = [[itemElement attributeForName:@"verse"]stringValue];
        
        [self createPages:titleValue :verseRefValue :verseValue];
    }
}

#pragma mark - Method to create the pages object

//create the page object based on the title and verseRef
- (void)createPages: (NSString*) pageTitle :(NSString*) pageVerseref :(NSString*) pageVerse{
    
    page *newPage =[[page alloc]init];
    newPage.title = pageTitle;
    newPage.verseRef = pageVerseref;
    newPage.verse = pageVerse;
    [arrayPages addObject:newPage];
}

/*- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
    [self loadVersesfromXML];
    
    self->iPadBool = [self amIAnIPad];
    
    [self createPagesinScrollView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
@end
