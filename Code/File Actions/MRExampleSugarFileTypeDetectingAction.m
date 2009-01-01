//
//  MRExampleSugarFileTypeDetectingAction.m
//  ExampleSugar
//

#import "MRExampleSugarFileTypeDetectingAction.h"
#import <EspressoFileActions.h>
#import <NSString+MRFoundation.h>


@implementation MRExampleSugarFileTypeDetectingAction

- (id)initWithDictionary:(NSDictionary *)dictionary bundlePath:(NSString *)bundlePath
{
	self = [super init];
	if (self == nil)
		return nil;
	
	extensions = [[dictionary objectForKey:@"extensions"] retain];
	
	return self;
}

- (void)dealloc
{
	[extensions release];
	extensions = nil;
	
	[super dealloc];
}

- (BOOL)canPerformActionWithContext:(id)context
{
	if (extensions.count == 0)
		return YES;
	else if ([context URLs].count == 0)
		return NO;
	
	BOOL canPerform = YES;
	for (NSURL *fileURL in [context URLs])
		canPerform &= [fileURL.path.pathExtension isEqualToAnyOfStrings:extensions];
	
	return canPerform;
}

- (BOOL)performActionWithContext:(id)context error:(NSError **)outError
{
	//NSAlert *sheet = [NSAlert alertWithMessageText:@"Selected Files" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"The following files were selected: %@", [context URLs]];
	//[sheet beginSheetModalForWindow:[context windowForSheet] modalDelegate:nil didEndSelector:nil contextInfo:nil];
    [NSBundle loadNibNamed:@"TestWindow" owner:self];
    
	return YES;
}

@end
