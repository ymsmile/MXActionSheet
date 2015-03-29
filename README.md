## How to use?
UIActionSheet usage is the same as
```objective-c
#import "MXActionSheet.h"

MXActionSheet *sheet = [[MXActionSheet alloc] initWithTitle:@"This is the main title"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@[@"WeChat", @"Weibo", @"Twitter", @"QQ"]];
[sheet showInView:self.view];
```
then

```objective-c
#pragma mark - MXActionSheetDelegate

- (void)actionSheet:(MXActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%@",@(buttonIndex));
}
```