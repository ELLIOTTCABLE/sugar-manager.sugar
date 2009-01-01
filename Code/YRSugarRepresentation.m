//
//  YRSugarRepresentation.m
//  SugarManager
//

#import "YRSugarRepresentation.h"

@implementation YRSugarRepresentation

@synthesize name;
@synthesize author;
@synthesize identifier;
@synthesize downloadURL;
@synthesize homeURL;

+ (id)sugarWithName:(NSString *)aName
             author:(NSString *)anAuthor
         identifier:(NSString *)anIdentifier
        downloadURL:(NSURL *)aDownloadURL
            homeURL:(NSURL *)aHomeURL {
  YRSugarRepresentation *sugar = [[[self alloc] init] retain];
  
  sugar.name = aName;
  sugar.author = anAuthor;
  sugar.identifier = anIdentifier;
  sugar.downloadURL = aDownloadURL;
  sugar.homeURL = aHomeURL;
  
  [sugar autorelease];
  
  return sugar;
}

- (void)dealloc {
  [name release];
  [author release];
  [identifier release];
  [downloadURL release];
  [homeURL release];
  [super dealloc];
}

@end
