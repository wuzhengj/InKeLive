//
//  NearCell.m
//  InKeLive
//
//  Created by 1 on 2016/12/26.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "NearCell.h"

@implementation NearCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    [self addSubview:self.iconImageView];
    [self addSubview:self.distanceLabel];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-25);
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self.iconImageView.mas_bottom);
    }];
}


- (void)updateCell:(NearModel *)nearModel{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:nearModel.portrait] placeholderImage:[UIImage imageNamed:@"live_empty_bg"]];
    if (nearModel.distance.length > 0) {
        self.distanceLabel.text = [NSString stringWithFormat:@"%@",nearModel.distance];
    } else {
        //距离远的只显示城市
        if (nearModel.city.length > 0) {
            self.distanceLabel.text = [NSString stringWithFormat:@"%@",nearModel.city];
        } else {
            //没有显示火星
            self.distanceLabel.text = [NSString stringWithFormat:@"火星"];
        }
    }
}

- (void)showAnimation{
    self.iconImageView.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:0.25 animations:^{
        self.iconImageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

#pragma 加载
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}

- (UILabel *)distanceLabel{
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc]init];
        _distanceLabel.textAlignment = NSTextAlignmentLeft;
        _distanceLabel.textColor = [UIColor grayColor];
        _distanceLabel.font = [UIFont systemFontOfSize:15];
    }
    return _distanceLabel;
}

@end
