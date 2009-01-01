//
//  YRSugarManagerOpeningAction.m
//  SugarManager
//

#import "YRSugarManagerOpeningAction.h"
#import <EspressoFileActions.h>
#import <NSString+MRFoundation.h>

@implementation YRSugarManagerOpeningAction

- (BOOL)canPerformActionWithContext:(id)context {
  return YES;
}

- (BOOL)performActionWithContext:(id)context error:(NSError **)outError {
  if(!sugarManagerController) {
    sugarManagerController = [[YRSugarManagerController alloc] init];
  }
  
  [NSBundle loadNibNamed:@"SugarManager" owner:sugarManagerController];
  [sugarManagerController showWindow:self];
  
  return YES;
}

@end
