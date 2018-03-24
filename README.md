
# react-native-authorize-net

## Getting started

`$ npm install react-native-authorize-net --save`

### Mostly automatic installation

`$ react-native link react-native-authorize-net`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-authorize-net` and add `RNAuthorizeNet.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNAuthorizeNet.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNAuthorizeNetPackage;` to the imports at the top of the file
  - Add `new RNAuthorizeNetPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-authorize-net'
  	project(':react-native-authorize-net').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-authorize-net/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-authorize-net')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNAuthorizeNet.sln` in `node_modules/react-native-authorize-net/windows/RNAuthorizeNet.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Authorize.Net.RNAuthorizeNet;` to the usings at the top of the file
  - Add `new RNAuthorizeNetPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNAuthorizeNet from 'react-native-authorize-net';

// TODO: What to do with the module?
RNAuthorizeNet;
```
  