//
//  MRExampleSugarTagCaseChanger.m
//  ExampleSugar
//

#import "MRExampleSugarTagCaseChanger.h"
#import <EspressoTextActions.h>
#import <MRRangeSet.h>


@implementation MRExampleSugarTagCaseChanger

- (id)initWithDictionary:(NSDictionary *)dictionary bundlePath:(NSString *)bundlePath
{
	self = [super init];
	if (self == nil)
		return nil;
	
	changesToUppercase = [[dictionary objectForKey:@"change-to"] isEqualToString:@"uppercase"];
	
	return self;
}

- (BOOL)canPerformActionWithContext:(id)context
{
	return YES;
}

- (BOOL)performActionWithContext:(id)context error:(NSError **)outError
{
	MRRangeSet *selectedRanges = [[MRRangeSet alloc] initWithRangeValues:[context selectedRanges]];
	CETextRecipe *recipe = [CETextRecipe textRecipe];
	
	// Find all tag name syntax zones
	SXSelectorGroup *tagSelectors = [SXSelectorGroup selectorGroupWithString:@"tag > name"];
	SXZone *syntaxRoot = [context syntaxTree].root;
	for (SXZone *tagZone in [syntaxRoot descendantSelectablesMatchingSelectors:tagSelectors]) {
		
		// Replace if the selection is empty, or if the tag name intersects with the selection
		if ([selectedRanges isEmpty] || [selectedRanges intersectsRange:tagZone.range]) {
			NSString *replacement = changesToUppercase ? [tagZone.text uppercaseString] : [tagZone.text lowercaseString];
			[recipe addReplacementString:replacement forRange:tagZone.range];
		}
	}
	
	// Clean up
	[selectedRanges release];
	
	// Prepare the recipe, or we can't get the number of changes
	[recipe prepare];
	if (recipe.numberOfChanges == 0) {
		NSAlert *sheet = [NSAlert alertWithMessageText:@"Nothing Changed!" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"No tag names were found that could be changed. Select another piece of text and try again."];
		[sheet beginSheetModalForWindow:[context windowForSheet] modalDelegate:nil didEndSelector:nil contextInfo:nil];
	}
	
	return [context applyTextRecipe:recipe];
}

@end
