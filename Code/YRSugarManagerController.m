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
  return self;
}

- (void)dealloc
{
  [sugars dealloc];
  sugars = nil;
  [super dealloc];
}

@end
