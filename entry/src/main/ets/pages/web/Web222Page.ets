import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';


class TestClass {
  constructor() {
  }
  test(): string {
    return 'ArkTS Hello World!';
  }
}


@Entry
@Component
struct Web222Page {
  webviewController: webview.WebviewController = new webview.WebviewController();
  // 声明需要注册的对象
  @State testObj: TestClass = new TestClass();


  build() {
    Column() {
      Button('deleteJavaScriptRegister')
        .onClick(() => {
          try {
            this.webviewController.deleteJavaScriptRegister("testObjName");
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })
      // Web组件加载本地index.html页面
      Web({ src: $rawfile('index111.html'), controller: this.webviewController})
        // 将对象注入到web端
        .javaScriptProxy({
          object: this.testObj,
          name: "testObjName",
          methodList: ["test"],
          controller: this.webviewController,
          // 可选参数
          asyncMethodList: [],
          permission: '{"javascriptProxyPermission":{"urlPermissionList":[{"scheme":"resource","host":"rawfile","port":"","path":""},' +
            '{"scheme":"e","host":"f","port":"g","path":"h"}],"methodList":[{"methodName":"test","urlPermissionList":' +
            '[{"scheme":"https","host":"xxx.com","port":"","path":""},{"scheme":"resource","host":"rawfile","port":"","path":""}]},' +
            '{"methodName":"test11","urlPermissionList":[{"scheme":"q","host":"r","port":"","path":"t"},' +
            '{"scheme":"u","host":"v","port":"","path":""}]}]}}'
        })
    }
  }
}