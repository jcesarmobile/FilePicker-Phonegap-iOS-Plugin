//
//  FilePicker.m
//
//  Created by @jcesarmobile
//
//

#import "FilePicker.h"

@implementation FilePicker

- (void)isAvailable:(CDVInvokedUrlCommand*)command {
    BOOL supported = NSClassFromString(@"UIDocumentPickerViewController");
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:supported] callbackId:command.callbackId];
}

- (void)pickFile:(CDVInvokedUrlCommand*)command {

    self.command = command;
    id UTIs = [command.arguments objectAtIndex:0];
    BOOL supported = YES;
    NSArray * UTIsArray = nil;
    CGRect frame = CGRectZero;
    //default values
    NSInteger x = 280;
    NSInteger y = 360;
    NSInteger width = 55;
    NSInteger height = 20;

    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if(command.arguments.count > 1) {
            NSArray *frameValues = [command.arguments objectAtIndex:1];
            frameValues = [frameValues isEqual:[NSNull null]]?nil:frameValues;
            if (frameValues.count == 4 ) {
                frame.origin.x   = [frameValues[0] integerValue];
                frame.origin.y   = [frameValues[1] integerValue];
                frame.size.width = [frameValues[2] integerValue];
                frame.size.height= [frameValues[3] integerValue];
            } else {
                // default values for iPad
                frame.origin.x = x;
                frame.origin.y = y;
                frame.size.width = width;
                frame.size.height = height;
            }
        } else {
            // default values for iPad
            frame.origin.x = x;
            frame.origin.y = y;
            frame.size.width = width;
            frame.size.height = height;
        }
    }

    if ([UTIs isEqual:[NSNull null]]) {
        UTIsArray =  @[@"public.data"];
    } else if ([UTIs isKindOfClass:[NSString class]]){
        UTIsArray = @[UTIs];
    } else if ([UTIs isKindOfClass:[NSArray class]]){
        UTIsArray = UTIs;
    } else {
        supported = NO;
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"not supported"] callbackId:self.command.callbackId];
    }
    
    if (!NSClassFromString(@"UIDocumentPickerViewController")) {
        supported = NO;
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"your device can't show the file picker"] callbackId:self.command.callbackId];
    }

    if (supported) {
        self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
        [self.pluginResult setKeepCallbackAsBool:YES];
        [self displayDocumentPicker:UTIsArray withSenderRect:frame];
    }
    
}

#pragma mark - UIDocumentMenuDelegate
-(void)documentMenu:(UIDocumentMenuViewController *)documentMenu didPickDocumentPicker:(UIDocumentPickerViewController *)documentPicker {
    
    documentPicker.delegate = self;
    documentPicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.viewController presentViewController:documentPicker animated:YES completion:nil];
    
}

-(void)documentMenuWasCancelled:(UIDocumentMenuViewController *)documentMenu {
    
    self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"canceled"];
    [self.pluginResult setKeepCallbackAsBool:NO];
    [self.commandDelegate sendPluginResult:self.pluginResult callbackId:self.command.callbackId];
    
}

#pragma mark - UIDocumentPickerDelegate
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    
    self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[url path]];
    [self.pluginResult setKeepCallbackAsBool:NO];
    [self.commandDelegate sendPluginResult:self.pluginResult callbackId:self.command.callbackId];
    
}
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    
    self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"canceled"];
    [self.pluginResult setKeepCallbackAsBool:NO];
    [self.commandDelegate sendPluginResult:self.pluginResult callbackId:self.command.callbackId];
    
}

- (void)displayDocumentPicker:(NSArray *)UTIs withSenderRect:(CGRect)senderFrame{
    
    UIDocumentMenuViewController *importMenu = [[UIDocumentMenuViewController alloc] initWithDocumentTypes:UTIs inMode:UIDocumentPickerModeImport];
    importMenu.delegate = self;
    importMenu.popoverPresentationController.sourceView = self.viewController.view;
    if (!CGRectEqualToRect(senderFrame, CGRectZero)) {
        importMenu.popoverPresentationController.sourceRect = senderFrame;
    }
    importMenu.popoverPresentationController.permittedArrowDirections = 4;
    [self.viewController presentViewController:importMenu animated:YES completion:nil];
    
}

@end
