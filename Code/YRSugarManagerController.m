//
//  YRSugarManagerController.m
//  SugarManager
//

#import "YRSugarManagerController.h"

const NSString *YRSugarManagerErrorDomain = @"name.elliottcable.Sugar.Manager.ErrorDomain";

@implementation YRSugarManagerController

- (id)init {
  [super init];
  sugars = [[NSMutableSet setWithCapacity:25] retain];
  
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
  [self installSugar:sugar error:NULL];
  [progressIndicator stopAnimation:self];
}

- (BOOL)installSugar:(YRSugarRepresentation *)sugar error:(NSError **)errorProxy {
  NSLog(@"- installSugar:%@", sugar);
  BOOL result = NO;
  
  NSEnumerator *dependencyEnumerator = [[sugar dependencies] objectEnumerator];
  YRSugarRepresentation *dependency = nil;
  NSString *dependencyIdentifier = nil;
  while (dependencyIdentifier = [dependencyEnumerator nextObject]) {
    dependency = [self sugarByIdentifier:dependencyIdentifier];
    if(!dependency) {
      if(errorProxy) *errorProxy = [NSError errorWithDomain:(id)YRSugarManagerErrorDomain code:YREUnkDep userInfo:nil];
      return NO;
    }
    result = [self installSugar:dependency error:NULL];
    if(!result) return NO;
  }
  NSLog(@"- installSugar:%@ ... dependencies installed successfully", sugar);
  
  SEL selector = NSSelectorFromString([NSString stringWithFormat:@"installSugarFrom%@:", [[sugar downloadFormat] capitalizedString]]);
  NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
  if(result && signature != nil) {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selector];
    [invocation setTarget:self];
    [invocation setArgument:&sugar atIndex:2];
    [invocation invoke];
    [invocation getReturnValue:&result];
  }
  return result;
}

- (BOOL)installSugarFromRaw:(id)sugar {
  NSLog(@"- installSugarFromRaw:%@", sugar);
  BOOL result = NO;
  NSFileManager *fileSystem = [NSFileManager defaultManager];
  NSString *from = [[sugar downloadURL] path];
  NSString *to = [[@"~/Library/Application Support/Espresso/Sugars/" stringByExpandingTildeInPath] stringByAppendingPathComponent:[from lastPathComponent]];
  NSLog(@"- installSugarFromRaw:%@ ... copying from %@ to %@", sugar, from, to);
  if(result) result = [fileSystem copyPath:from toPath:to handler:NULL];
  return result;
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
