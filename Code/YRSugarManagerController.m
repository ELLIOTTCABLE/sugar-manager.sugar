//
//  YRSugarManagerController.m
//  SugarManager
//

#import "YRSugarManagerController.h"

@implementation YRSugarManagerController

- (id)init {
  [super init];
  sugars = [[NSMutableSet setWithCapacity:25] retain];
  
  YRSugarRepresentation *sugar;
  sugar = [YRSugarRepresentation sugarFromURL:[NSURL fileURLWithPath:[@"~/Desktop/ruby.sugar/Languages.xml" stringByExpandingTildeInPath]]];
  if(sugar && ![self sugarByIdentifier:[sugar identifier]]) [sugars addObject:sugar];
  sugar = [YRSugarRepresentation sugarFromURL:[NSURL fileURLWithPath:[@"~/Desktop/regex.sugar/Languages.xml" stringByExpandingTildeInPath]]];
  if(sugar && ![self sugarByIdentifier:[sugar identifier]]) [sugars addObject:sugar];
  sugar = [YRSugarRepresentation sugarFromURL:[NSURL fileURLWithPath:[@"~/Desktop/sugar-manager.sugar/Languages.xml" stringByExpandingTildeInPath]]];
  if(sugar && ![self sugarByIdentifier:[sugar identifier]]) [sugars addObject:sugar];
  sugar = nil;
  
  [self updateSugars:NULL];
  
  return self;
}

- (id)sugarByIdentifier:(id)identifier {
  NSEnumerator *enumerator = [sugars objectEnumerator];
  YRSugarRepresentation *aSugar = nil;
  while (aSugar = [enumerator nextObject]) {
    if([aSugar identifier] == identifier)
      return aSugar;
  }
  return nil;
}

- (IBAction)updateSugars:(id)sender {
  [progressIndicator startAnimation:self];
  [self updateSugarsFromApplicationSupport];
  [self updateSugarsFromCoffeeHouse];
  [self updateSugarsFromGitHub];
  [self updateSugarsFromGoogleCode];
  [progressIndicator stopAnimation:self];
}

- (void)updateSugarsFromApplicationSupport {
  NSLog(@"- updateSugarsFromApplicationSupport:");
  NSString *applicationSupportPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/Espresso/Sugars"];
  NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:applicationSupportPath];
  NSString *sugarDir;
  while (sugarDir = [enumerator nextObject]) {
    [enumerator skipDescendents];
    if ([[sugarDir pathExtension] isEqualToString:@"sugar"]) {
      NSLog(@"- updateSugarsFromApplicationSupport: ... enumerating %@", sugarDir);
      NSString *languagesXMLPlain = [[applicationSupportPath stringByAppendingPathComponent:sugarDir] stringByAppendingPathComponent:@"Languages.xml"];
      NSString *languagesXMLCompiled = [[applicationSupportPath stringByAppendingPathComponent:sugarDir] stringByAppendingPathComponent:@"Contents/Resources/Languages.xml"];
      BOOL plainExists = [[NSFileManager defaultManager] fileExistsAtPath:languagesXMLPlain];
      BOOL compiledExists = [[NSFileManager defaultManager] fileExistsAtPath:languagesXMLCompiled];
      YRSugarRepresentation *sugar = nil;
      if(plainExists) {
        sugar = [YRSugarRepresentation sugarFromURL:[NSURL fileURLWithPath:languagesXMLPlain]];
      } else if(compiledExists) {
        sugar = [YRSugarRepresentation sugarFromURL:[NSURL fileURLWithPath:languagesXMLCompiled]];
      }
      if(sugar && ![self sugarByIdentifier:[sugar identifier]]) { [sugar setInstalled:YES]; [sugars addObject:sugar]; }
    }
  }
}

- (void)updateSugarsFromCoffeeHouse {
  NSLog(@"- updateSugarsFromCoffeeHouse:");
}

- (void)updateSugarsFromGitHub {
  NSLog(@"- updateSugarsFromGitHub:");
}

- (void)updateSugarsFromGoogleCode {
  NSLog(@"- updateSugarsFromGoogleCode:");
}

- (IBAction)installSugarAction:(id)sender {
  [progressIndicator startAnimation:self];
  YRSugarRepresentation *sugar = [[sugarsController arrangedObjects] objectAtIndex:[sender clickedRow]];
  [self installSugar:sugar];
  [progressIndicator stopAnimation:self];
}

- (BOOL)installSugar:(YRSugarRepresentation *)sugar {
  NSLog(@"- installSugar:%@", sugar);
  BOOL result = NO;
  
  NSEnumerator *dependencyEnumerator = [[sugar dependencies] objectEnumerator];
  YRSugarRepresentation *dependency = nil;
  NSString *dependencyIdentifier = nil;
  while (dependencyIdentifier = [dependencyEnumerator nextObject]) {
    dependency = [self sugarByIdentifier:dependencyIdentifier];
    if(!dependency) return NO;
    result = [self installSugar:dependency];
    if(!result) return NO;
  }
  NSLog(@"- installSugar:%@ ... dependencies installed successfully", sugar);
  
  SEL selector = NSSelectorFromString([NSString stringWithFormat:@"installSugarFrom%@:", [[sugar downloadFormat] capitalizedString]]);
  if(result) result = [self performSelector:selector withObject:sugar];
  return result;
}

- (BOOL)installSugarFromRaw:(id)sugar {
  NSLog(@"- installSugarFromRaw:%@", sugar);
  NSFileManager *fileSystem = [NSFileManager defaultManager];
  NSString *from = [[sugar downloadURL] path];
  NSString *to = [[@"~/Library/Application Support/Espresso/Sugars/" stringByExpandingTildeInPath] stringByAppendingPathComponent:[from lastPathComponent]];
  NSLog(@"- installSugarFromRaw:%@ ... copying from %@ to %@", sugar, from, to);
  [fileSystem copyPath:from toPath:to handler:NULL];
  return YES;
}

- (BOOL)installSugarFromTgz:(id)sugar {
  NSLog(@"- installSugarFromTgz:%@", sugar);
  return NO;
}

- (BOOL)installSugarFromZip:(id)sugar {
  NSLog(@"- installSugarFromZip:%@", sugar);
  return NO;
}

- (BOOL)installSugarFromSvn:(id)sugar {
  NSLog(@"- installSugarFromSvn:%@", sugar);
  return NO;
}

- (BOOL)installSugarFromGit:(id)sugar {
  NSLog(@"- installSugarFromGit:%@", sugar);
  return NO;
}

- (void)dealloc {
  [sugars dealloc];
  sugars = nil;
  [super dealloc];
}

@end
