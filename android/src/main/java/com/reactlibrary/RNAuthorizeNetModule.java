
package com.reactlibrary;

import android.app.Activity;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.Toast;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

import net.authorize.acceptsdk.AcceptSDKApiClient;
import net.authorize.acceptsdk.datamodel.merchant.ClientKeyBasedMerchantAuthentication;
import net.authorize.acceptsdk.datamodel.transaction.CardData;
import net.authorize.acceptsdk.datamodel.transaction.EncryptTransactionObject;
import net.authorize.acceptsdk.datamodel.transaction.TransactionObject;
import net.authorize.acceptsdk.datamodel.transaction.TransactionType;
import net.authorize.acceptsdk.datamodel.transaction.callbacks.EncryptTransactionCallback;
import net.authorize.acceptsdk.datamodel.transaction.response.EncryptTransactionResponse;
import net.authorize.acceptsdk.datamodel.transaction.response.ErrorTransactionResponse;

import java.util.HashMap;

public class RNAuthorizeNetModule extends ReactContextBaseJavaModule {

  static String CARD_NUMBER = "CARD_NUMBER";
  static String EXPIRATION_MONTH = "EXPIRATION_MONTH";
  static String EXPIRATION_YEAR = "EXPIRATION_YEAR";
  static String CARD_CVV = "CARD_CVV";
  static String ZIP_CODE = "ZIP_CODE";
  static String CARD_HOLDER_NAME = "CARD_HOLDER_NAME";
  static String LOGIN_ID = "LOGIN_ID";
  static String CLIENT_KEY = "CLIENT_KEY";

  private final ReactApplicationContext reactContext;
  private static Activity mCurrentActivity = null;



  Activity getActivity(){
    return getCurrentActivity();
  }
  AcceptSDKApiClient apiClient = new AcceptSDKApiClient.Builder (getActivity(),
          AcceptSDKApiClient.Environment.SANDBOX)
          .connectionTimeout(5000) // optional connection time out in milliseconds
          .build();


  public CardData prepareCardDataFromFields(HashMap cardValue){
    CardData cardData = new CardData.Builder(cardValue.get(CARD_NUMBER).toString(),
            cardValue.get(EXPIRATION_MONTH).toString(), // MM
            cardValue.get(EXPIRATION_YEAR).toString()) // YYYY
            .cvvCode(cardValue.get(CARD_CVV).toString()) // Optional
            //.zipCode(ZIP_CODE)// Optional
            //.cardHolderName(CARD_HOLDER_NAME)// Optional
            .build();
    return cardData;
  }




  private EncryptTransactionObject prepareTransactionObject(HashMap cardValue) {
    ClientKeyBasedMerchantAuthentication merchantAuthentication =
            ClientKeyBasedMerchantAuthentication.
                    createMerchantAuthentication(cardValue.get(LOGIN_ID).toString(), cardValue.get(CLIENT_KEY).toString());

    // create a transaction object by calling the predefined api for creation
    return TransactionObject.
            createTransactionObject(
                    TransactionType.SDK_TRANSACTION_ENCRYPTION) // type of transaction object
            .cardData(prepareCardDataFromFields(cardValue)) // card data to get Token
            .merchantAuthentication(merchantAuthentication).build();
  }


  public RNAuthorizeNetModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }





  @Override
  public String getName() {
    return "RNAuthorizeNet";
  }

  @ReactMethod
  public void payWithAuthorizeNet(HashMap cardValue, final Callback responseCallBack){
    try {
      EncryptTransactionObject transactionObject = prepareTransactionObject(cardValue);

      apiClient.getTokenWithRequest(transactionObject, new EncryptTransactionCallback() {
        @Override
        public void onErrorReceived(ErrorTransactionResponse error) {
          responseCallBack.invoke(false,"Error while add card.");
        }

        @Override
        public void onEncryptionFinished(EncryptTransactionResponse response) {
          HashMap<String, String> cardResponse = new HashMap<String, String>();
          cardResponse.put("dataDescriptor",response.getDataDescriptor());
          cardResponse.put("dataValue",response.getDataValue());
          responseCallBack.invoke(true,cardResponse);
        }
      });

    } catch (NullPointerException e) {
      // Handle exception transactionObject or callback is null.
      responseCallBack.invoke(false,"Error while add card.");
    }
  }


}