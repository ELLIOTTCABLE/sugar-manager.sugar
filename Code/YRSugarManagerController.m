//
//  YRSugarManagerController.m
//  SugarManager
//

#import "YRSugarManagerController.h"
@class YRSugarRepresentation;

@implementation YRSugarManagerController

- (id)init {
  [super init];
  sugars = [NSMutableSet setWithCapacity:25];
  
  [sugars addObject:[YRSugarRepresentation sugarWithName:@"Sugar Manager"
                                                  author:@"elliottcable"
                                              identifier:@"name.elliottcable.Sugar.Manager"
                                             downloadURL:@"http://github.com/elliottcable/sugar-manager.sugar/tarball/master"
                                                 homeURL:@"http://github.com/elliottcable/sugar-manager.sugar"]];
  [sugars addObject:[YRSugarRepresentation sugarWithName:@"Ruby"
                                                  author:@"elliottcable"
                                              identifier:@"name.elliottcable.Sugar.Ruby"
                                             downloadURL:@"http://github.com/elliottcable/ruby.sugar/tarball/master"
                                                 homeURL:@"http://github.com/elliottcable/ruby.sugar"]];
  [sugars addObject:[YRSugarRepresentation sugarWithName:@"Regex"
                                                  author:@"elliottcable"
                                              identifier:@"name.elliottcable.Sugar.Regex"
                                             downloadURL:@"http://github.com/elliottcable/regex.sugar/tarball/master"
                                                 homeURL:@"http://github.com/elliottcable/regex.sugar"]];
  
  return self;
}

- (void)updateSugarsFromCoffeeHouse:(id)sender {
  
}

- (IBAction)downloadSugar:(id)sender {
  NSLog(@"- downloadSugar: ... selection == %@", [sugarsController selectedObjects]);
}

- (void)dealloc {
  [sugars dealloc];
  sugars = nil;
  [super dealloc];
}

@end
