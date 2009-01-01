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

+ (id)sugarFromURL:(NSURL *)languagesXMLURL {
  NSLog(@"+ sugarFromURL: ... using XML URL: %@", languagesXMLURL);
  NSError **errorProxy = nil;
  NSXMLDocument *languagesXML = [[NSXMLDocument alloc] initWithContentsOfURL:languagesXMLURL options:NSXMLDocumentTidyXML error:errorProxy];
  NSXMLElement *meta = [[[languagesXML rootElement] elementsForName:@"meta"] lastObject];
  
  NSLog(@"+ sugarFromURL: ... received XML data: %@", meta);
  
  NSString *aName = [[[meta elementsForName:@"name"] lastObject] stringValue];
  if(!aName || aName == @"") return nil;
  NSString *anAuthor = [[[meta elementsForName:@"author"] lastObject] stringValue];
  NSString *anIdentifier = [[[meta elementsForName:@"identifier"] lastObject] stringValue];
  if(!anIdentifier || anIdentifier == @"") return nil;
  NSString *aDownloadURL = [[[meta elementsForName:@"download"] lastObject] stringValue];
  if(!aDownloadURL || aDownloadURL == @"") return nil;
  NSString *aHomeURL = [[[meta elementsForName:@"url"] lastObject] stringValue];
  if(!aHomeURL || aHomeURL == @"") aHomeURL = @"http://";
  
  
  YRSugarRepresentation *sugar = [self sugarWithName:aName
                                              author:anAuthor
                                          identifier:anIdentifier
                                         downloadURL:[NSURL URLWithString:aDownloadURL]
                                             homeURL:[NSURL URLWithString:aHomeURL]];
  NSLog(@"+ sugarFromURL: ... created %@", sugar);
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
