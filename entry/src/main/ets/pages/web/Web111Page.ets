import { webview } from '@kit.ArkWeb';

@Entry
@Component
struct Web111Page {
  webviewController: webview.WebviewController = new webview.WebviewController();

  aboutToAppear() {
    // 配置Web开启调试模式
    webview.WebviewController.setWebDebuggingAccess(true);
  }

  build() {
    Column() {
      Button('runJavaScriptParam')
        .onClick(() => {
          // 调用前端页面有参函数。
          this.webviewController.runJavaScript('htmlTestParam(param)');
        })
      Button('runJavaScript')
        .onClick(() => {
          // 调用前端页面无参函数。
          this.webviewController.runJavaScript('htmlTest()');
        })
      Button('runJavaScriptCodePassed')
        .onClick(() => {
          // 传递runJavaScript侧代码方法。
          this.webviewController.runJavaScript(`function changeColor(){document.getElementById('text').style.color = 'red'}`);
        })
      Web({ src: $rawfile('index111.html'), controller: this.webviewController })
    }
  }
}