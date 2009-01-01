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
  
  YRSugarRepresentation *sugar;
  sugar = [YRSugarRepresentation sugarFromURL:[NSURL URLWithString:@"file:///Users/elliottcable/Code/sugar-manager.sugar/Languages.xml"]];
  if(sugar) [sugars addObject:sugar];
  sugar = [YRSugarRepresentation sugarFromURL:[NSURL URLWithString:@"file:///Users/elliottcable/Code/ruby.sugar/Languages.xml"]];
  if(sugar) [sugars addObject:sugar];
  sugar = [YRSugarRepresentation sugarFromURL:[NSURL URLWithString:@"file:///Users/elliottcable/Code/regex.sugar/Languages.xml"]];
  if(sugar) [sugars addObject:sugar];
  sugar = nil;
  
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
