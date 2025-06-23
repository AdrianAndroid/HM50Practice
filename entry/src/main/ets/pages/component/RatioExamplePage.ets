import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct RatioExamplePage {
  @State message: string = 'Hello World';
  @State Rst: promptAction.ShowToastOptions = { 'message': 'Ringing mode.' }
  @State Vst: promptAction.ShowToastOptions = { 'message': 'Vibration mode.' }
  @State Sst: promptAction.ShowToastOptions = { 'message': 'Silent mode.' }

  build() {
    Flex({ justifyContent: FlexAlign.Start, wrap: FlexWrap.Wrap, alignContent: FlexAlign.Start }) {
      Radio({ value: 'Radio1', group: 'radioGroup' })
        .checked(false)
      Radio({ value: 'Radio2', group: 'radioGroup' })
        .checked(true)
      Radio({ value: 'Radio1', group: 'radioGroup' })
        .onChange((isChecked: boolean) => {
          if (isChecked) {
            //需要执行的操作
          }
        })
      Radio({ value: 'Radio2', group: 'radioGroup' })
        .onChange((isChecked: boolean) => {
          if (isChecked) {
            //需要执行的操作
          }
        })
      Row() {
        Column() {
          Radio({ value: 'Radio1', group: 'radioGroup' }).checked(true)
            .height(50)
            .width(50)
            .onChange((isChecked: boolean) => {
              if(isChecked) {
                // 切换为响铃模式
                promptAction.showToast(this.Rst)
              }
            })
          Text('Ringing')
        }
        Column() {
          Radio({ value: 'Radio2', group: 'radioGroup' })
            .height(50)
            .width(50)
            .onChange((isChecked: boolean) => {
              if(isChecked) {
                // 切换为振动模式
                promptAction.showToast(this.Vst)
              }
            })
          Text('Vibration')
        }
        Column() {
          Radio({ value: 'Radio3', group: 'radioGroup' })
            .height(50)
            .width(50)
            .onChange((isChecked: boolean) => {
              if(isChecked) {
                // 切换为静音模式
                promptAction.showToast(this.Sst)
              }
            })
          Text('Silent')
        }
      }.width('100%').justifyContent(FlexAlign.Center)
    }
    .height('100%')
    .width('100%')
  }
}