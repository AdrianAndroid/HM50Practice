// xxx.ets
import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';

class TestClass {
  constructor() {
  }
  test(): string {
    return "ArkUI Web Component";
  }
  toString(): void {
    console.log('Web Component toString');
  }
}

@Entry
@Component
struct Index {
  webviewController: webview.WebviewController = new webview.WebviewController();
  @State testObj: TestClass = new TestClass();

  build() {
    Column() {
      Button('refresh')
        .onClick(() => {
          try {
            this.webviewController.refresh();
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })
      Button('Register JavaScript To Window')
        .onClick(() => {
          try {
            this.webviewController.registerJavaScriptProxy(this.testObj, "testObjName", ["test", "toString"],
              // 可选参数, asyncMethodList
              [],
              // 可选参数, permission
              '{"javascriptProxyPermission":{"urlPermissionList":[{"scheme":"resource","host":"rawfile","port":"","path":""},' +
                '{"scheme":"e","host":"f","port":"g","path":"h"}],"methodList":[{"methodName":"test","urlPermissionList":' +
                '[{"scheme":"https","host":"xxx.com","port":"","path":""},{"scheme":"resource","host":"rawfile","port":"","path":""}]},' +
                '{"methodName":"test11","urlPermissionList":[{"scheme":"q","host":"r","port":"","path":"t"},' +
                '{"scheme":"u","host":"v","port":"","path":""}]}]}}'
            );
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })
      Button('deleteJavaScriptRegister')
        .onClick(() => {
          try {
            this.webviewController.deleteJavaScriptRegister("testObjName");
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })
      Web({ src: $rawfile('index444.html'), controller: this.webviewController })
    }
  }
}