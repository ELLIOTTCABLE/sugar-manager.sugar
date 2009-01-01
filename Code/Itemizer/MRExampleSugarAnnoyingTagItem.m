//
//  MRExampleSugarAnnoyingTagItem.m
//  ExampleSugar
//

#import "MRExampleSugarAnnoyingTagItem.h"


//
// Example item; open a HTML file to see it in action
//
@implementation MRExampleSugarAnnoyingTagItem

- (void)initializeWithCapturedZones:(NSDictionary *)captures recipeInfo:(NSDictionary *)recipeInfo
{
	[super initializeWithCapturedZones:captures recipeInfo:recipeInfo];
	
	name = [[[captures objectForKey:@"name"] text] retain];
}

- (void)dealloc
{
	[name release];
	name = nil;
	[super dealloc];
}

- (BOOL)transformIntoItem:(MRExampleSugarAnnoyingTagItem *)otherItem
{
	// Note: the passed argument can actually be any item class, but casting it to this specific class makes it easy to write the transformation code. The default (super) implementation takes care of checking the class, so this is perfectly valid.
	if (![super transformIntoItem:otherItem])
		return NO;
	
	// Clean up our own old values
	[name release];
	name = nil;
	
	// Take over the new values from the other item
	name = [otherItem->name retain];
	
	return YES;
}

- (BOOL)isDecorator
{
	return YES;
}

- (CEItemDecorationType)decorationType
{
	return CEItemDecorationStyle;
}

- (NSColor *)backgroundColor
{
	return [NSColor yellowColor];
}

- (BOOL)isTextualizer
{
	return YES;
}

- (NSString *)title
{
	return [NSString stringWithFormat:@"Example Annoying: %@", name];
}

@end
