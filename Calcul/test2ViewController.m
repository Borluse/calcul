//
//  test2ViewController.m
//  Calcul
//
//  Created by Fan ZHAO on 11-5-18.
//  Copyright 2011年 Personne. All rights reserved.
//

#import "test2ViewController.h"
#import <math.h>

@implementation test2ViewController
@synthesize resultat;
@synthesize soitEntre;

#pragma mark - calculs

- (double) normInv {
    double x, p, c0, c1, c2, d1, d2, d3, t, q;
    double result;
    
    q = (1.0 - prob/100) / 2;
    
    
    if (q == 0.5) {
        result = 0;
    }else{
        q = 1.0 - q;
        
        if ( (q>0) && (q<0.5) ){
            p = q;
        }
        else {
            if (q == 1) {
                p = 1-0.999999;
            }
            else{
                p = 1.0 - q;
            }
        }
        
        t = sqrt( log(1.0/(p*p)));
        
        c0 = 2.515517;
        c1 = 0.802853;
        c2 = 0.010328;
        
        d1 = 1.432788;
        d2 = 0.189269;
        d3 = 0.001308;
        x = t - (c0 + c1 * t + c2 * (t * t)) / (1.0 + d1 * t + d2 * (t * t) + d3 * (t * t * t));
        
        if (q>0.5) x = -1.0 * x;
    }
    
    return (x * 1) + 0;
}

- (void) calcule{
    double norme = [self normInv];
    norme = norme * norme;

    double results = sqrt(norme*(pourcentage/100*(1.0-pourcentage/100))/(effect));
    [resultat setText:[NSString stringWithFormat:@"%2.1f%%", results*100]];
    [soitEntre setText:[NSString stringWithFormat:@"%2.1f%% -- %2.1f%%", (pourcentage/100 - results)*100, (pourcentage/100 + results)*100]];

}

#pragma mark - inits

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [niveauConf release];
    [intervalleConf release];
    [taillePop release];
    [resultat release];
    [soitEntre release];
    [clearButton release];
    [clearButton release];
    [resultat release];
    [soitEntre release];
    [niveauConf release];
    [intervalleConf release];
    [taillePop release];
    [clearButton release];
    [clearButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
#pragma mark - create number pad

-(void) createNumberPad{
    //    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Set", nil];
    //    
    //    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    //    [actionSheet setTag:0];
    //    [actionSheet showFromTabBar:self.view];
    
    
}



#pragma mark - uipickerview


// return the picker frame based on its size, positioned at the bottom of the page
- (CGRect)pickerFrameWithSize:(CGSize)size
{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect pickerRect = CGRectMake(	0.0,
                                   screenRect.size.height - 84.0 - size.height,
                                   size.width,
                                   size.height);
	return pickerRect;
}


- (void) createPickerWithId:(NSInteger)tag{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Set", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet setTag:0];
    [actionSheet showFromTabBar:self.view];
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 80, 100, 0)];
    
    picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    picker.showsSelectionIndicator = YES;
    
    picker.delegate = self;
    picker.dataSource = self;
    
    switch (tag) {
        case 0:
            pickerArray = [[NSArray arrayWithObjects:@"80",@"85",@"90",@"95",@"99",nil]retain];
            picker.tag = 100;
            [picker selectRow:3 inComponent:0 animated:YES];
            break;
        case 1:
            picker.tag = 101;
            [picker selectRow:5 inComponent:0 animated:YES];
            [picker selectRow:0 inComponent:1 animated:YES];
            break;
        default:
            break;
    }
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 400)];
    //    [actionSheet addSubview:picker];
    [actionSheet addSubview:picker];
    [picker release];
    
}

#pragma mark - delegate for actionsheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
}


#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *returnStr;
    switch (pickerView.tag) {
        case 101:
            if (component == 0){
                returnStr = [NSString stringWithFormat:@"%d", row];
            }
            else{
                returnStr = [NSString stringWithFormat:@"%d", row];
            }
            break;
        default:
            returnStr = [[pickerArray objectAtIndex:row] stringByAppendingString:@"%"];
            break;
    }
	
	return returnStr;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	switch (pickerView.tag) {
        case 101:
            if (component == 0)
                return 101;
            else return 10;
            break;
        default:
            return [pickerArray count];
            break;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView.tag == 101){
        return 2;
    }
    else return 1;
}

#pragma mark - delegates for uipickerview
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 100:
            NSLog(@"niveau de conf");
            niveauConf.text = [pickerArray objectAtIndex:row];
            prob = [niveauConf.text intValue];
            [self calcule];
            break;
        case 101:
            NSLog(@"intervalle de conf");
            if (component == 0){
                integerPart = row;
                
            }
            else {
                demicalPart = row;
            }
            intervalleConf.text = [NSString stringWithFormat:@"%d.%d%%", integerPart, demicalPart];
            pourcentage = [[NSString stringWithFormat:@"%d.%d", integerPart, demicalPart] floatValue];
            [self calcule];
            break;
        default:
            break;
    }
}


#pragma mark - delegates of textfield
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            NSLog(@"niveauConf");
            [self createPickerWithId:0];
            break;
        case 1:
            NSLog(@"intervalleConf");
            [self createPickerWithId:1];
            break;
        case 2:
            NSLog(@"Taille de la population");
            [self createNumberPad];
            return YES;
            break;
        default:
            break;
    }
    return NO;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
    NSLog(@"shouldReturn");
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"didbegin");
}

#pragma mark - Display the selectors called
/*
 This function can display the Selector called.
 */
- (BOOL)respondsToSelector:(SEL)aSelector {
	NSString *methodName = NSStringFromSelector(aSelector);
	NSLog(@"respondsToSelector:%@", methodName); 
	return [super respondsToSelector:aSelector];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	for (UITouch *touch in touches){
		if ([taillePop isFirstResponder]){
            [taillePop resignFirstResponder];
            effect = [taillePop.text intValue];
            [self calcule];
        }
	}
    
    
}
#pragma mark - uibarbuttonitem actions
- (IBAction)clearBtnClicked : (id) sender{
    [niveauConf setText:@"95%"];
    [intervalleConf setText:@"5.0%"];
    [taillePop setText:@"150"];
    [resultat setText:@""];
    [soitEntre setText:@""];
    [self initTexts];
    
}


#pragma mark - View lifecycle


- (void) initTexts{
    prob = 95;
    pourcentage = 5;
    effect = 150;
    [self calcule];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [clearButton setTarget:self];
    [clearButton setAction:@selector(clearBtnClicked)];
    [intervalleConf setKeyboardType:UIKeyboardTypeDecimalPad];
    [taillePop setKeyboardType:UIKeyboardTypeDecimalPad];
    
    [self initTexts];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [niveauConf release];
    niveauConf = nil;
    [intervalleConf release];
    intervalleConf = nil;
    [taillePop release];
    taillePop = nil;
    [resultat release];
    resultat = nil;
    [soitEntre release];
    soitEntre = nil;
    [clearButton release];
    clearButton = nil;
    [self setResultat:nil];
    [self setSoitEntre:nil];
    [niveauConf release];
    niveauConf = nil;
    [intervalleConf release];
    intervalleConf = nil;
    [taillePop release];
    taillePop = nil;
    [clearButton release];
    clearButton = nil;
    [clearButton release];
    clearButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
