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
                                             downloadURL:[NSURL URLWithString:@"http://github.com/elliottcable/sugar-manager.sugar/tarball/master"]
                                                 homeURL:[NSURL URLWithString:@"http://github.com/elliottcable/sugar-manager.sugar"]]];
  [sugars addObject:[YRSugarRepresentation sugarWithName:@"Ruby"
                                                  author:@"elliottcable"
                                              identifier:@"name.elliottcable.Sugar.Ruby"
                                             downloadURL:[NSURL URLWithString:@"http://github.com/elliottcable/ruby.sugar/tarball/master"]
                                                 homeURL:[NSURL URLWithString:@"http://github.com/elliottcable/ruby.sugar"]]];
  [sugars addObject:[YRSugarRepresentation sugarWithName:@"Regex"
                                                  author:@"elliottcable"
                                              identifier:@"name.elliottcable.Sugar.Regex"
                                             downloadURL:[NSURL URLWithString:@"http://github.com/elliottcable/regex.sugar/tarball/master"]
                                                 homeURL:[NSURL URLWithString:@"http://github.com/elliottcable/regex.sugar"]]];
  
  return self;
}

- (void)updateSugarsFromCoffeeHouse:(id)sender {
  
}

- (IBAction)downloadSugar:(id)sender {
  NSURL *url = [[[sugarsController arrangedObjects] objectAtIndex:[sender clickedRow]] downloadURL];
  NSLog(@"- downloadSugar: ... URL == %@", url);
}

- (void)dealloc {
  [sugars dealloc];
  sugars = nil;
  [super dealloc];
}

@end
