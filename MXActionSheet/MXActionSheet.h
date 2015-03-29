//
//  MXActionSheet.h
//  MXActionSheet
//
//  Created by Michael Tianlin on 10/3/15.
//  Copyright (c) 2015 Tianlinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MXActionSheet;

@protocol MXActionSheetDelegate <NSObject>

- (void)actionSheet:(MXActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@optional
- (void)actionSheetCancel:(MXActionSheet *)actionSheet;

@end

@interface MXActionSheet : UIView

@property (weak, nonatomic) id<MXActionSheetDelegate> delegate;

- (id)initWithTitle:(NSString *)title
           delegate:(id<MXActionSheetDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSArray *)titles;

- (void)showInView:(UIView *)mSuperView;

@end
