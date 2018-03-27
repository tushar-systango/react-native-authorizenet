
#import "RNAuthorizeNet.h"

@implementation RNAuthorizeNet

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

static NSString *const LOGIN_ID = @"LOGIN_ID";
static NSString *const CLIENT_KEY = @"CLIENT_KEY";
static NSString *const CARD_NO = @"CARD_NO";
static NSString *const EXPIRATION_MONTH = @"EXPIRATION_MONTH";
static NSString *const EXPIRATION_YEAR = @"EXPIRATION_YEAR";
static NSString *const CVV_NO = @"CVV_NO";
static NSString *const ZIP_CODE = @"ZIP_CODE";
static NSString *const ACCOUNT_HOLDER_NAME = @"ACCOUNT_HOLDER_NAME";
static NSString *const ACCOUNT_HOLDER_EMAIL = @"ACCOUNT_HOLDER_EMAIL";
static NSString *const DATA_DESCRIPTOR = @"DATA_DESCRIPTOR";
static NSString *const DATA_VALUE = @"DATA_VALUE";



RCT_EXPORT_METHOD(getTokenWithRequestForCard:(NSDictionary *)paymentValues callBack:(RCTResponseSenderBlock)callback)
{
    AcceptSDKHandler *handler = [[AcceptSDKHandler alloc] initWithEnvironment:AcceptSDKEnvironmentENV_TEST];
    AcceptSDKRequest *request = [[AcceptSDKRequest alloc] init];
    request.merchantAuthentication.name =[paymentValues valueForKey:LOGIN_ID];
    request.merchantAuthentication.clientKey =[paymentValues valueForKey:CLIENT_KEY];    request.securePaymentContainerRequest.webCheckOutDataType.token.cardNumber =[paymentValues valueForKey:CARD_NO];    request.securePaymentContainerRequest.webCheckOutDataType.token.expirationMonth = [paymentValues valueForKey:EXPIRATION_MONTH];    request.securePaymentContainerRequest.webCheckOutDataType.token.expirationYear = [paymentValues valueForKey:EXPIRATION_YEAR];    request.securePaymentContainerRequest.webCheckOutDataType.token.cardCode = [paymentValues valueForKey:CVV_NO];
    [handler getTokenWithRequest:request successHandler:^(AcceptSDKTokenResponse * _Nonnull token) {
        //NSLog(@"success %@", token.getOpaqueData.getDataValue);
        NSDictionary *responsDict = @{DATA_DESCRIPTOR:token.getOpaqueData.getDataDescriptor,DATA_VALUE:token.getOpaqueData.getDataValue};
        callback(@[@YES,responsDict]);
    } failureHandler:^(AcceptSDKErrorResponse * _Nonnull error) {
        callback(@[@NO,@"Error while add card."]);
    }];
    
}


@end

