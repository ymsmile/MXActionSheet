//
//  MXActionSheet.m
//  MXActionSheet
//
//  Created by Michael Tianlin on 10/3/15.
//  Copyright (c) 2015 Tianlinlin. All rights reserved.
//

#import "MXActionSheet.h"

#define MXASButtonHeight   44.0f

@interface MXActionSheet ()
{
    CGFloat offsetY;
    NSInteger index;
}

@property (strong, nonatomic) UIControl *maskView;
@property (strong, nonatomic) UIView    *mainView;

@end

@implementation MXActionSheet

CGFloat GetMXASScreenHeight() {
    return CGRectGetHeight([[UIScreen mainScreen] bounds]);
}

CGFloat GetMXASScreenWidth() {
    return CGRectGetWidth([[UIScreen mainScreen] bounds]);
}

- (id)initWithTitle:(NSString *)title
           delegate:(id<MXActionSheetDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSArray *)titles {
    
    self = [super init];
    if (self) {
        
        [self setFrame:CGRectMake(10, GetMXASScreenHeight(), GetMXASScreenWidth() - 20, 0)];
        [self setBackgroundColor:[UIColor clearColor]];
        self.delegate = delegate;
        
        UIView *view = [[UIView alloc] init];
        [view.layer setCornerRadius:5.0];
        [view setBackgroundColor:[UIColor whiteColor]];
        self.mainView = view;
        [self addSubview:self.mainView];
        
        offsetY = 10;
        if (title) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, offsetY, CGRectGetWidth(self.frame), 20)];
            [titleLabel setBackgroundColor:[UIColor clearColor]];
            [titleLabel setTextAlignment:NSTextAlignmentCenter];
            [titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
            [titleLabel setText:title];
            [titleLabel setTextColor:[[UIColor grayColor] colorWithAlphaComponent:0.8]];
            offsetY = CGRectGetMaxY(titleLabel.frame) + 10;
            [self.mainView addSubview:titleLabel];
        }
        
        index = 0;
        if (titles && titles.count > 0) {
            for (int i = 0 ; i < titles.count; i++) {
                index = i;
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY + (0.5 + MXASButtonHeight) * i,
                                                                        CGRectGetWidth(self.frame), 0.5)];
                [line setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.5]];
                [self.mainView addSubview:line];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setFrame:CGRectMake(0, offsetY + (0.5 + MXASButtonHeight) * i,
                                                 CGRectGetWidth(self.frame), MXASButtonHeight)];
                [button setBackgroundColor:[UIColor clearColor]];
                [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:titles[i] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button setTag:index];
                [self.mainView addSubview:button];
                if (i == titles.count - 1) {
                    offsetY = CGRectGetMaxY(button.frame);
                }
            }
        }
        
        [self.mainView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), offsetY)];
        
        if (cancelButtonTitle) {
            UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [cancelButton setFrame:CGRectMake(0, CGRectGetMaxY(self.mainView.frame) + 10, CGRectGetWidth(self.frame), MXASButtonHeight)];
            [cancelButton setBackgroundColor:[UIColor whiteColor]];
            [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [cancelButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            [cancelButton.layer setCornerRadius:5.0];
            [cancelButton setTag:index + 1];
            [self addSubview:cancelButton];
            offsetY  = CGRectGetMaxY(cancelButton.frame) + 10;
        }
        
        [self setFrame:CGRectMake(10, GetMXASScreenHeight(), GetMXASScreenWidth() - 20, offsetY)];
    }
    return self;
}

- (void)showInView:(UIView *)mSuperView {
    UIControl *view = [[UIControl alloc] initWithFrame:mSuperView.bounds];
    view.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5 animations:^{
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.3f;
    }];
    self.maskView = view;
    [mSuperView addSubview:self.maskView];
    
    [mSuperView addSubview:self];
    CGRect frame = self.frame;
    frame.origin.y = GetMXASScreenHeight() - CGRectGetHeight(self.frame);
    frame.size.height = offsetY;
    [UIView animateWithDuration:0.3 animations:^{
        [self setFrame:frame];
    }];
}

- (void)buttonEvent:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:button.tag];
    }
    if (button.tag == index + 1) {
        if ([self.delegate respondsToSelector:@selector(actionSheetCancel:)]) {
            [self.delegate actionSheetCancel:self];
        }
    }
    [self disMissView];
}

#pragma mark - cycle

- (void)disMissView {
    CGRect frame = self.frame;
    frame.origin.y = GetMXASScreenHeight();
    frame.size.height = 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self setFrame:frame];
        [self.maskView setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}

- (void)dealloc {
    if (self.maskView) {
        self.maskView = nil;
    }
    if (self.mainView) {
        self.mainView = nil;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
