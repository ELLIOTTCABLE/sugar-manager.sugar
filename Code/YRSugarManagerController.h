//
//  YRSugarManagerController.h
//  SugarManager
//

#import <Cocoa/Cocoa.h>

@interface YRSugarManagerController : NSWindowController {
  NSMutableSet *sugars;
  IBOutlet NSArrayController *sugarsController;
}
- (IBAction)updateSugarsFromApplicationSupport:(id)sender;
- (IBAction)updateSugarsFromCoffeeHouse:(id)sender;
- (IBAction)updateSugarsFromGitHub:(id)sender;
- (IBAction)updateSugarsFromGoogleCode:(id)sender;
- (IBAction)installSugar:(id)sender;
@end
