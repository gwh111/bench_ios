//
//  CC_Math.m
//  bench_ios
//
//  Created by gwh on 2020/1/8.
//

#import "CC_Math.h"

@implementation CC_Math

+ (CC_Math *)math {
    return CC_Math.new;
}

- (int)intWithNumberInt:(int)number1 divideInt:(int)number2 {
    if (number2 == 0) {
        return 0;
    }
    return number1/number2;
}

- (int)intWithNumberFloat:(float)number1 divideFloat:(float)number2 {
    if (number2 == 0) {
        return 0;
    }
    int value = number1/number2;
    return value;
}

- (int)intWithNumberId:(id)number1 divideId:(id)number2 {
    int i2 = [number2 intValue];
    if (i2 == 0) {
        return 0;
    }
    int i1 = [number1 intValue];
    return i1/i2;
}

- (float)floatWithNumberInt:(int)number1 divideInt:(int)number2 {
    if (number2 == 0) {
        return 0;
    }
    float f1 = number1;
    float f2 = number2;
    return f1/f2;
}

- (float)floatWithNumberFloat:(float)number1 divideFloat:(float)number2 {
    if (number2 == 0) {
        return 0;
    }
    return number1/number2;
}

- (float)floatWithNumberId:(id)number1 divideId:(id)number2 {
    float f2 = [number2 floatValue];
    if (f2 == 0) {
        return 0;
    }
    float f1 = [number1 floatValue];
    return f1/f2;
}

#pragma mark du
- (CGFloat)huduWithDu:(CGFloat)du {
    if (du == 0) {
        return 0;
    }
    return M_PI/(180/du);
}

- (CGFloat)duWithHudu:(CGFloat)huDu {
    return huDu*180/M_PI;
}

- (CGFloat)distanceWithPoint:(CC_Point *)point1 point:(CC_Point *)point2 {
    
    float p = sqrt(pow((point1.x - point2.x), 2) + pow((point1.y - point2.y), 2));
    return p;
}

- (CGFloat)duWithPoint:(CC_Point *)point1 point:(CC_Point *)point2 {
    
    point1 = CC_POINT(point1.x, -point1.y);
    point2 = CC_POINT(point2.x, -point2.y);
    if (point1.x - point2.x == 0) {
        if (point1.y - point2.y > 0) {
            return 90;
        }
        return 270;
    }
    if (point1.y - point2.y == 0) {
        if (point1.x - point2.x > 0) {
            return 0;
        }
        return 180;
    }
    float dy = (point1.y - point2.y);
    float dx = (point1.x - point2.x);
    if (dy > 0 && dx > 0) {
        float p_ang = atan(dy/dx);
        return [self duWithHudu:p_ang];
    }else if (dy > 0 && dx < 0){
        float p_ang = atan(dy/-dx);
        return 180 - [self duWithHudu:p_ang];
    }else if (dy < 0 && dx < 0){
        float p_ang = atan(dy/dx);
        return [self duWithHudu:p_ang] + 180;
    }else{
        float p_ang = atan(-dy/dx);
        return 360 - [self duWithHudu:p_ang];
    }
    
}

- (CC_Point *)pointWithR:(CGFloat)r du:(CGFloat)du {
    float cos = cosf([self huduWithDu:du + 1]);
    float sin = sinf([self huduWithDu:du + 1]);
    float x = r*cos;
    float y = r*sin;
    return CC_POINT(x, -y);
}

@end
