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
@synthesize downloadFormat;
@synthesize homeURL;
@synthesize dependencies;

+ (id)sugarWithName:(NSString *)aName
             author:(NSString *)anAuthor
         identifier:(NSString *)anIdentifier
        downloadURL:(NSURL *)aDownloadURL
     downloadFormat:(NSString *)aDownloadFormat
            homeURL:(NSURL *)aHomeURL
       dependencies:(NSArray *)someDependencies {
  YRSugarRepresentation *sugar = [[self alloc] init];
  
  sugar.name = [aName retain];
  sugar.author = [anAuthor retain];
  sugar.identifier = [anIdentifier retain];
  sugar.downloadURL = [aDownloadURL retain];
  sugar.downloadFormat = [aDownloadFormat retain];
  sugar.homeURL = [aHomeURL retain];
  sugar.dependencies = [someDependencies retain];
  
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
  NSString *aDownloadFormat = [[[[meta elementsForName:@"download"] lastObject] attributeForName:@"format"] stringValue];
  if(!aDownloadFormat || aDownloadFormat == @"") return nil;
  NSString *aHomeURL = [[[meta elementsForName:@"url"] lastObject] stringValue];
  if(!aHomeURL || aHomeURL == @"") aHomeURL = @"http://";
  
  NSEnumerator *dependencyEnumerator = [[[[meta elementsForName:@"dependencies"] lastObject] elementsForName:@"dependency"] objectEnumerator];
  NSMutableArray *someDependencies = [NSMutableArray arrayWithCapacity:2];
  id aDependency;
  while (aDependency = [dependencyEnumerator nextObject]) {
    [someDependencies addObject:[aDependency stringValue]];
  }
  
  YRSugarRepresentation *sugar = [self sugarWithName:aName
                                              author:anAuthor
                                          identifier:anIdentifier
                                         downloadURL:[NSURL URLWithString:aDownloadURL]
                                      downloadFormat:aDownloadFormat
                                             homeURL:[NSURL URLWithString:aHomeURL]
                                        dependencies:[NSArray arrayWithArray:someDependencies]];
  
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
