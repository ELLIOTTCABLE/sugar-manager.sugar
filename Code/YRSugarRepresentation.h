//
//  YRSugarRepresentation.h
//  SugarManager
//

#import <Cocoa/Cocoa.h>

@interface YRSugarRepresentation : NSObject {
  NSString *name;
  NSString *author;
  NSString *identifier;
  NSURL *downloadURL;
  NSString *downloadFormat;
  BOOL installed;
  NSURL *homeURL;
  NSArray *dependencies;
}

@property (readwrite, copy) NSString *name;
@property (readwrite, copy) NSString *author;
@property (readwrite, copy) NSString *identifier;
@property (readwrite, copy) NSURL *downloadURL;
@property (readwrite, copy) NSString *downloadFormat;
- (BOOL)installed;
- (void)setInstalled:(BOOL)isInstalled;
@property (readwrite, copy) NSURL *homeURL;
@property (readwrite, copy) NSArray *dependencies;

+ (id)sugarWithName:(NSString *)aName
             author:(NSString *)anAuthor
         identifier:(NSString *)anIdentifier
        downloadURL:(NSURL *)aDownloadURL
     downloadFormat:(NSString *)aDownloadFormat
          installed:(BOOL)isInstalled
            homeURL:(NSURL *)aHomeURL
       dependencies:(NSArray *)someDependencies;
+ (id)sugarFromURL:(NSURL *)languagesXMLURL;

@end
