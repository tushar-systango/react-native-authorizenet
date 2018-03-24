
#import "RNAuthorizeNet.h"

@implementation RNAuthorizeNet

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

//// This method will call to with macAddress param of PBHoney device , it with provide connection status of device
RCT_EXPORT_METHOD(connectWithDevice:(NSDictionary *)paymentValues callBack:(RCTResponseSenderBlock)callback)
{
    AcceptSDKHandler *handler = [[AcceptSDKHandler alloc] initWithEnvironment:AcceptSDKEnvironmentENV_TEST];
    AcceptSDKRequest *request = [[AcceptSDKRequest alloc] init];
    request.merchantAuthentication.name =@"856JtSmF"; //name
    request.merchantAuthentication.clientKey = @"8zbUxYH9tQ385Et28u28nd2xV3HjPX8q6R5jsSp54sUyy4gJf59dH44ELMbfZWXX"; //clientkey
    request.securePaymentContainerRequest.webCheckOutDataType.token.cardNumber = @"370000000000002"; //cardnumber
    request.securePaymentContainerRequest.webCheckOutDataType.token.expirationMonth = @"10";
    request.securePaymentContainerRequest.webCheckOutDataType.token.expirationYear = @"2022";
    request.securePaymentContainerRequest.webCheckOutDataType.token.cardCode = @"5556";
    
    [handler getTokenWithRequest:request successHandler:^(AcceptSDKTokenResponse * _Nonnull token) {
        //NSLog(@"success %@", token.getOpaqueData.getDataValue);
        callback(@[YES,token.getOpaqueData.getDataValue]);
    } failureHandler:^(AcceptSDKErrorResponse * _Nonnull error) {
        callback(@[NO,error]);
    }];
    
}


@end
  
