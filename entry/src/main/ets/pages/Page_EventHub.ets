import { common, Want } from '@kit.AbilityKit';
import { promptAction } from '@kit.ArkUI';
import Constants from '../common/Constants';

class EventHubBean {

}

@Entry
@Component
struct Page_EventHub {
  @State message: string = 'Hello World';
  private context = getContext(this) as common.UIAbilityContext

  eventHubFunc(): void {
    // 不带参数触发自定义event1事件
    this.context.eventHub.emit(Constants.EVENT_HUB_1)
    this.context.eventHub.emit(Constants.EVENT_HUB_1, new EventHubBean())
    // 带1个参数触发自定义event1事件
    this.context.eventHub.emit(Constants.EVENT_HUB_1, 1)
    // 带2个参数触发自定义event1事件
    this.context.eventHub.emit(Constants.EVENT_HUB_1, 2, 'test')
    // 开发者可以根据世纪的业务场景设计事件传递的参数
    promptAction.showToast({
      message: '这是一条Toast消息：eventHubFunc',
      showMode: promptAction.ToastShowMode.TOP_MOST
    })
  }

  build() {
    Column() {
      Blank().height(100)
      List({ initialIndex: 0 }) {
        ListItem() {
          Row() {
            Text('hello')
          }
          .width('100%')
          .height('10%')
          .backgroundColor(Color.Green)
          .onClick(() => {
            this.eventHubFunc()
            promptAction.showToast({ message: 'EventHubFuncA'})
          })
        }
        ListItem() {
          Row()
            .height('5%')
        }
        ListItem() {
          Row() {
            Text('结束')
          }
          .width('100%')
          .height('10%')
          .backgroundColor(Color.Blue)
          .onClick(() => {
            this.context.eventHub.off(Constants.EVENT_HUB_1)
            promptAction.showToast({ message: 'EventHubFuncB'})
          })
        }
      }
      .width('100%')
      .height('100%')
    }

  }
}