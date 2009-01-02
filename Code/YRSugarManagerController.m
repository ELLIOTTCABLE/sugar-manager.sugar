//
//  YRSugarManagerController.m
//  SugarManager
//

#import "YRSugarManagerController.h"
#import "YRSugarRepresentation.h";

@implementation YRSugarManagerController

- (id)init {
  [super init];
  sugars = [[NSMutableSet setWithCapacity:25] retain];
  
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
  
  SEL selector = NSSelectorFromString([NSString stringWithFormat:@"installSugarFrom%@:", [[sugar downloadFormat] capitalizedString]]);
  [self performSelector:selector withObject:sugar];
}

- (void)installSugarFromRaw:(id)sugar {
  NSLog(@"- installSugarFromRaw:%@", sugar);
}

- (void)installSugarFromTgz:(id)sugar {
  NSLog(@"- installSugarFromTgz:%@", sugar);
}

- (void)installSugarFromZip:(id)sugar {
  NSLog(@"- installSugarFromZip:%@", sugar);
}

- (void)installSugarFromSvn:(id)sugar {
  NSLog(@"- installSugarFromSvn:%@", sugar);
}

- (void)installSugarFromGit:(id)sugar {
  NSLog(@"- installSugarFromGit:%@", sugar);
}

- (void)dealloc {
  [sugars dealloc];
  sugars = nil;
  [super dealloc];
}

@end
