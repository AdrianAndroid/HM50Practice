interface ShowDialogCallback {
  callback(message: string): void
}

class LogicClass {
  private showDialogCallback: ShowDialogCallback | null = null;

  // 设置回调函数
  setShowDialogCallback(callback: ShowDialogCallback) {
    this.showDialogCallback = callback;
  }

  // 模拟业务逻辑，触发显示弹框
  doBusinessLogic() {
    // 模拟一些业务处理
    const message = "这是弹框要显示的消息";
    if (this.showDialogCallback) {
      this.showDialogCallback.callback(message);
    }
  }
}

@Entry
@Component
struct Index {
  private logic: LogicClass = new LogicClass();
  private showDialog: boolean = false;
  private dialogMessage: string = '';

  build() {
    Column({ space: 50 }) {
      Button('触发业务逻辑')
        .onClick(() => {
          this.logic.doBusinessLogic();
        })
    }
    .width('100%')
    .padding({ top: 50, bottom: 50, left: 20, right: 20 })

    // // 显示弹框
    // if (this.showDialog) {
    //   new AlertDialog({
    //     title: '提示',
    //     message: this.dialogMessage,
    //     onOk: () => {
    //       this.showDialog = false;
    //     }
    //   })
    // }
    //
    // // 设置回调函数
    // this.logic.setShowDialogCallback((message) => {
    //   this.dialogMessage = message;
    //   this.showDialog = true;
    // });
  }

  aboutToAppear(): void {

  }
  onDidBuild(): void {

  }
  onPageShow(): void {
    
  }
  aboutToDisappear(): void {

  }
}
