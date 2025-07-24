// xxx.ets
import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';


class Student {
  name: string = '';
  age: string = '';
}


class TestClass {
  constructor() {
  }


  // 传递的基础类型name:"jeck", age:"12"。
  test(): Student {
    let st: Student = { name: "jeck", age: "12" };
    return st;
  }


  toString(param: ESObject): void {
    console.log('Web Component toString' + param["name"]);
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
            this.webviewController.registerJavaScriptProxy(this.testObj, "testObjName", ["test", "toString"]);
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
      Web({ src: $rawfile('index.html'), controller: this.webviewController })
    }
  }
}