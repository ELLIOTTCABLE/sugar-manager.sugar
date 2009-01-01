//
//  YRSugarManagerController.h
//  SugarManager
//

#import <Cocoa/Cocoa.h>

@interface YRSugarManagerController : NSWindowController {
  NSMutableSet *sugars;
}
- (IBAction)updateSugarsFromCoffeeHouse:(id)sender;
@end
