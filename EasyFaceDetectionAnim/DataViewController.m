//
//  DataViewController.m
//  EasyFaceDetectionAnim
//
//  Created by Deen Na on 2/18/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "DataViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>

@interface DataViewController (Private) 
-(void)textAppear; 
-(void)textAppearAgain;
@end

@implementation DataViewController

@synthesize dataLabel = _dataLabel;
@synthesize dataObject = _dataObject;

- (void)dealloc
{
    [image release];
    [_dataLabel release];
    [_dataObject release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self faceDetection];
}

-(void)faceDetection {
    if ([[self.dataObject description] isEqualToString:@"January"]) {
       image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facedetectionpic.jpg"]];
    }else if ([[self.dataObject description] isEqualToString:@"February"]) {
        image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facedetectionpic1.jpg"]];
    }else if ([[self.dataObject description] isEqualToString:@"March"]) {
        image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facedetectionpic2.jpg"]];
    }else if ([[self.dataObject description] isEqualToString:@"April"]) {
        image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facedetectionpic3.jpg"]];
    }else if ([[self.dataObject description] isEqualToString:@"May"]) {
        image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facedetectionpic4.jpg"]];
    }else {
        image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facedetectionpic.jpg"]];
    }
    
    [self.view addSubview:image];
    
    //Jangan lupa panggil markFaces method
    //[self performSelectorInBackground:@selector(markFaces:) withObject:image];
    
    
    //Transform (flip) image on Y-axis to match coordinate system by core image
    [image setTransform:CGAffineTransformMakeScale(1, -1)];
    
    
    //Flip entire view to make everything right side up
    [self.view setTransform:CGAffineTransformMakeScale(1, -1)];
    
    
    if ([[self.dataObject description] isEqualToString:@"January"]) 
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 400.0, self.view.frame.size.width, 40)];
        label.text = @"AFIIKAAAAAA...";
        label.numberOfLines = 1;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor redColor];
        [self.view addSubview:label];
        [label setTransform:CGAffineTransformMakeScale(1, -1)];
        [label release];
        
        [self performSelector:@selector(textAppear) withObject:nil afterDelay:5.0];
    }else if ([[self.dataObject description] isEqualToString:@"February"]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120.0, 400.0, self.view.frame.size.width, 40)];
        label.text = @"Gak mao noleh ke blakang ah!";
        label.numberOfLines = 1;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:13.0f];
        [self.view addSubview:label];
        [label setTransform:CGAffineTransformMakeScale(1, -1)];
        [label release];
        
        [self performSelector:@selector(markFaces:) withObject:image afterDelay:3];
    }else if ([[self.dataObject description] isEqualToString:@"March"]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 400.0, self.view.frame.size.width, 40)];
        label.text = @"Kalo monster gimana tuh monster?";
        label.numberOfLines = 1;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor redColor];
        [self.view addSubview:label];
        [label setTransform:CGAffineTransformMakeScale(1, -1)];
        [label release];
        
        [self performSelector:@selector(markFaces:) withObject:image afterDelay:3];
    }else if ([[self.dataObject description] isEqualToString:@"April"]) {
        [self performSelector:@selector(markFaces:) withObject:image afterDelay:3];

    }else if ([[self.dataObject description] isEqualToString:@"May"]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120.0, 420.0, self.view.frame.size.width, 40)];
        label.text = @"Nah klo yg ini gimana?";
        label.numberOfLines = 1;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor redColor];
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:13.0f];
        [self.view addSubview:label];
        [label setTransform:CGAffineTransformMakeScale(1, -1)];
        [label release];
        
        [self performSelector:@selector(markFaces:) withObject:image afterDelay:3];
    }else {
        [self performSelector:@selector(markFaces:) withObject:image afterDelay:3];
    }
}

-(void)markFaces:(UIImageView *)facePicture {
    
    //Menggambar image dari parameter facePicture
    CIImage     *images = [CIImage imageWithCGImage:facePicture.image.CGImage];
    
    //Membuat detector dengan CIDetector
    CIDetector    *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];
    
    //Menampung semua komponen wajah/muka yang terdeteksi
    NSArray     *features = [detector featuresInImage:images];
    
    
    // we'll iterate through every detected face.  CIFaceFeature provides us
    // with the width for the entire face, and the coordinates of each eye
    // and the mouth if detected.  Also provided are BOOL's for the eye's and
    // mouth so we can check if they already exist.
    
    for (CIFaceFeature  *faceFeature in features) {
        // get the width of the face
        CGFloat faceWidth = faceFeature.bounds.size.width;
        
        // create a UIView using the bounds of the face
        UIView* faceView = [[UIView alloc] initWithFrame:faceFeature.bounds];
        
        // add a border around the newly created UIView
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];
        
        // add the new view to create a box around the face
        [self.view addSubview:faceView];
        
        if(faceFeature.hasLeftEyePosition)
        {
            // create a UIView with a size based on the width of the face
            UIView* leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.leftEyePosition.x-faceWidth*0.15, faceFeature.leftEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            // change the background color of the eye view
            [leftEyeView setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            // set the position of the leftEyeView based on the face
            [leftEyeView setCenter:faceFeature.leftEyePosition];
            // round the corners
            leftEyeView.layer.cornerRadius = faceWidth*0.15;
            // add the view to the window
            [self.view addSubview:leftEyeView];
        }
        
        if(faceFeature.hasRightEyePosition)
        {
            // create a UIView with a size based on the width of the face
            UIView* leftEye = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.rightEyePosition.x-faceWidth*0.15, faceFeature.rightEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            // change the background color of the eye view
            [leftEye setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            // set the position of the rightEyeView based on the face
            [leftEye setCenter:faceFeature.rightEyePosition];
            // round the corners
            leftEye.layer.cornerRadius = faceWidth*0.15;
            // add the new view to the window
            [self.view addSubview:leftEye];
        }
        
        if(faceFeature.hasMouthPosition)
        {
            // create a UIView with a size based on the width of the face
            UIView* mouth = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.mouthPosition.x-faceWidth*0.2, faceFeature.mouthPosition.y-faceWidth*0.2, faceWidth*0.4, faceWidth*0.4)];
            // change the background color for the mouth to green
            [mouth setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.3]];
            // set the position of the mouthView based on the face
            [mouth setCenter:faceFeature.mouthPosition];
            // round the corners
            mouth.layer.cornerRadius = faceWidth*0.2;
            // add the new view to the window
            [self.view addSubview:mouth];
        }
        
    }
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)textAppear 
{
    if ([[self.dataObject description] isEqualToString:@"January"]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 370.0, self.view.frame.size.width, 40)];
        label.text = @"IYAAAAAAAA...";
        label.numberOfLines = 1;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor redColor];
        [self.view addSubview:label];
        [label setTransform:CGAffineTransformMakeScale(1, -1)];
        [self performSelector:@selector(textAppearAgain) withObject:nil afterDelay:3];
    }else if ([[self.dataObject description] isEqualToString:@"February"]) {
        
    }else if ([[self.dataObject description] isEqualToString:@"March"]) {
        
    }else if ([[self.dataObject description] isEqualToString:@"April"]) {
        
    }else if ([[self.dataObject description] isEqualToString:@"May"]) {
        
    }else {
        
    }
}

-(void)textAppearAgain 
{
    if ([[self.dataObject description] isEqualToString:@"January"]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 330.0, self.view.frame.size.width, 40)];
        label.text = @"Mata mana mataaaaa ???";
        label.numberOfLines = 1;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor redColor];
        [self.view addSubview:label];
        [label setTransform:CGAffineTransformMakeScale(1, -1)];
        
        //Jangan lupa panggil markFaces method
        [self performSelector:@selector(markFaces:) withObject:image afterDelay:3.5];
    }else if ([[self.dataObject description] isEqualToString:@"February"]) {
        
    }else if ([[self.dataObject description] isEqualToString:@"March"]) {
        
    }else if ([[self.dataObject description] isEqualToString:@"April"]) {
        
    }else if ([[self.dataObject description] isEqualToString:@"May"]) {
        
    }else {
        
    }
}


@end
