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

- (IBAction)installSugar:(id)sender {
  YRSugarRepresentation *sugar = [[sugarsController arrangedObjects] objectAtIndex:[sender clickedRow]];
  NSLog(@"- installSugar:%@", sugar);
}

- (void)dealloc {
  [sugars dealloc];
  sugars = nil;
  [super dealloc];
}

@end
