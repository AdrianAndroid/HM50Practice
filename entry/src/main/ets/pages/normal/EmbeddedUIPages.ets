import { Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import Constants from '../../common/Constants';

@Entry
@Component
struct EmbeddedUIPages {
  @State message: string = 'Message: '
  private want: Want = {
    bundleName: Constants.bundleName,
    abilityName: "EmbeddedUIExtAbility",
    parameters: {
      'ohos.extension.processMode.hostInstance': 'true',
      // 'ohos.extension.processMode.hostSpecified': 'true'
    }
  }

  build() {
    Row() {
      Column() {
        Blank()
          .height(100)
        Text(this.message).fontSize(30)
        EmbeddedComponent(this.want, EmbeddedType.EMBEDDED_UI_EXTENSION)
          .width('100%')
          .height('100%')
          .onTerminated((info: TerminationInfo) => {
            this.message = 'Terminarion: code = ' + info.code + ', want = ' + JSON.stringify(info.want);
          })
          .onError((error: BusinessError) => {
            this.message = 'Error: code = ' + error.code;
          })
      }
      .width('100%')
      .height(400)
      .backgroundColor(Color.Red)
    }
    .height('100%')
  }
}