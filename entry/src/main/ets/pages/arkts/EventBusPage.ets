import { router } from '@kit.ArkUI';
import { EventBus } from '@nutpi/eventbus';

/**
 * @nutpi/eventbus，使用案例
 */
@Entry
@ComponentV2
export struct EventBusPage {
  private scroller: Scroller = new Scroller();
  @Local txtStr: string = "";

  build() {
    Column() {
      Divider()
      Scroll(this.scroller) {
        Column({ space: 5 }) {
          Button("on()")
            .btnStyle()
            .onClick(() => {
              //注册事件监听
              EventBus.on('id', (id: string) => {
                // DialogHelper.showAlertDialog({
                //   autoCancel: false,
                //   backCancel: false,
                //   content: `ID: ${id}`,
                //   primaryButton: '已收到',
                //   onAction: (action, id) => {
                //     DialogHelper.closeDialog(id);
                //   }
                // });
              });
            })
          Button("once()")
            .btnStyle()
            .onClick(() => {
              //注册单次事件监听
              EventBus.once('id', (id: string) => {
                // DialogHelper.showAlertDialog({
                //   autoCancel: false,
                //   backCancel: false,
                //   content: `单次ID: ${id}`,
                //   primaryButton: '已收到',
                //   onAction: (action, id) => {
                //     DialogHelper.closeDialog(id);
                //   }
                // });
              });
              // ToastUtil.showToast(`注册单次事件监听成功！`);
            })
          Button("post()")
            .btnStyle()
            .onClick(() => {
              EventBus.post('id', '100001200');
              // ToastUtil.showToast(`发布普通消息！`);
            })
          Button("postSticky()")
            .btnStyle()
            .onClick(() => {
              EventBus.postSticky('id', '100001201');
              // ToastUtil.showToast(`发布粘性消息！`);
            })
          Button("getSticky()")
            .btnStyle()
            .onClick(() => {
              let sticky = EventBus.getSticky('id');
              // ToastUtil.showToast(`粘性事件数据：${sticky}`);
            })
          Button("removeSticky()")
            .btnStyle()
            .onClick(() => {
              EventBus.removeSticky('id');
              // ToastUtil.showToast(`移除粘性事件成功！`);
            })
          Button("postApp()")
            .btnStyle()
            .onClick(() => {
              EventBus.postApp('id', '100001202');
              // ToastUtil.showToast(`发布跨App消息！`);
            })
          Button("off()")
            .btnStyle()
            .onClick(() => {
              //注销事件监听
              EventBus.off('id');
              // ToastUtil.showToast(`注销事件监听！`);
            })
          Button("offAll()")
            .btnStyle()
            .onClick(() => {
              //注销所有事件监听
              EventBus.offAll();
              // ToastUtil.showToast(`注销所有事件监听！`);
            })

          Blank().layoutWeight(1)
        }
        .margin({ top: 5, bottom: 5 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}


@Styles
function btnStyle() {
  .width('90%')
  .margin({ top: 10, bottom: 5 })
}