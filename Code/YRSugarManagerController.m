//
//  YRSugarManagerController.m
//  SugarManager
//

#import "YRSugarManagerController.h"
@class YRSugarRepresentation;

@implementation YRSugarManagerController

- (id)init
{
  [super init];
  sugars = [NSMutableSet setWithCapacity:25];
  
  YRSugarRepresentation *s1 = [YRSugarRepresentation sugarWithName:@"Sugar Manager"
                                                            author:@"elliottcable"
                                                        identifier:@"name.elliottcable.Sugar.Manager"
                                                       downloadURL:@"http://github.com/elliottcable/sugar-manager.sugar/tarball/master"
                                                           homeURL:@"http://github.com/elliottcable/sugar-manager.sugar"];
  YRSugarRepresentation *s2 = [YRSugarRepresentation sugarWithName:@"Ruby"
                                                            author:@"elliottcable"
                                                        identifier:@"name.elliottcable.Sugar.Ruby"
                                                       downloadURL:@"http://github.com/elliottcable/ruby.sugar/tarball/master"
                                                           homeURL:@"http://github.com/elliottcable/ruby.sugar"];
  YRSugarRepresentation *s3 = [YRSugarRepresentation sugarWithName:@"Regex"
                                                            author:@"elliottcable"
                                                        identifier:@"name.elliottcable.Sugar.Regex"
                                                       downloadURL:@"http://github.com/elliottcable/regex.sugar/tarball/master"
                                                           homeURL:@"http://github.com/elliottcable/regex.sugar"];
  [sugars addObject:s1]; [sugars addObject:s2]; [sugars addObject:s3];
  
  return self;
}

- (void)updateSugarsFromCoffeeHouse:(id)sender {
  
}

- (void)dealloc
{
  [sugars dealloc];
  sugars = nil;
  [super dealloc];
}

@end
