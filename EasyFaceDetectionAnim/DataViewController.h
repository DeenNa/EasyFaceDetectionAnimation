//
//  DataViewController.h
//  EasyFaceDetectionAnim
//
//  Created by Deen Na on 2/18/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController {
    UIImageView     *image;
}
@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;

-(void)faceDetection;
-(void)markFaces:(UIImageView *)facePicture;

@end
