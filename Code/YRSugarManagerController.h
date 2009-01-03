//
//  YRSugarManagerController.h
//  SugarManager
//

#import <Cocoa/Cocoa.h>
#import "YRSugarRepresentation.h"

extern const NSString *YRSugarManagerErrorDomain;
enum YRErrors {
  YREUnkDep
};

@interface YRSugarManagerController : NSWindowController {
  NSMutableSet *sugars;
  IBOutlet NSArrayController *sugarsController;
  IBOutlet NSProgressIndicator *progressIndicator;
}
- (id)sugarByIdentifier:(id)identifier;
- (IBAction)updateSugars:(id)sender;
- (void)updateSugarsFromApplicationSupport;
- (void)updateSugarsFromCoffeeHouse;
- (void)updateSugarsFromGitHub;
- (void)updateSugarsFromGoogleCode;
- (IBAction)installSugarAction:(id)sender;
- (BOOL)installSugar:(YRSugarRepresentation *)sugar error:(NSError **)errorProxy;
@end
