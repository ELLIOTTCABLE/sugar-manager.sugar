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
  NSError **errorProxy = nil;
  NSXMLDocument *languagesXML = [[NSXMLDocument alloc] initWithContentsOfURL:languagesXMLURL options:NSXMLDocumentTidyXML error:errorProxy];
  NSXMLElement *meta = [[[languagesXML rootElement] elementsForName:@"meta"] lastObject];
  
  NSLog(@"+ sugarFromURL: ... received XML data: %@", meta);
  
  return [self sugarWithName:[[[meta elementsForName:@"name"] lastObject] stringValue]
                      author:[[[meta elementsForName:@"author"] lastObject] stringValue]
                  identifier:[[[meta elementsForName:@"identifier"] lastObject] stringValue]
                 downloadURL:[[[meta elementsForName:@"download"] lastObject] stringValue]
                     homeURL:[[[meta elementsForName:@"url"] lastObject] stringValue]];
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
