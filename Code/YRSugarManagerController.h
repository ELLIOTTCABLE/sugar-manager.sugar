//
//  YRSugarManagerController.h
//  SugarManager
//

#import <Cocoa/Cocoa.h>

@interface YRSugarManagerController : NSWindowController {
  NSMutableSet *sugars;
  IBOutlet NSArrayController *sugarsController;
}
- (IBAction)updateSugars:(id)sender;
- (void)updateSugarsFromApplicationSupport;
- (void)updateSugarsFromCoffeeHouse;
- (void)updateSugarsFromGitHub;
- (void)updateSugarsFromGoogleCode;
- (IBAction)installSugar:(id)sender;
@end
