import { common, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import Constants from '../common/Constants';
import { BusinessError } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI';
import { JSON } from '@kit.ArkTS';

@Entry
@Component
struct Page_UIAbilityComponentsInteractive {

  build() {
    Column() {
      //...
      List({ initialIndex: 0 }) {
        ListItem() {
          Row() {
            Text('Hello')
          }
          .onClick(() => {
            let  context = getContext(this) as common.UIAbilityContext;
            const RESULT_CODE : number = 1001;
            // context为Ability对象的成员，在非Ability对象内部调用需要
            // 将Context对象传递过去
            let wantInfo: Want = {
              deviceId: '', // deviceId为空表示本设备
              bundleName: 'com.example.myapplication',
              moduleName: 'entry', // moduleName非必选
              abilityName: 'FuncAbilityA',
              parameters: {
                // 自定义信息
                info: '来自EntryAbility Page_UIAbilityComponentsInteractive页面'
              },
            };
            context.startAbilityForResult(wantInfo)
              .then((data) => {
                if (data?.resultCode === RESULT_CODE) {
                  let info: object | undefined = data.want?.parameters?.info
                  hilog.info(Constants.DOMAIN_NUMBER, Constants.TAG, JSON.stringify(info) ?? '');
                  if (info !== null) {
                    promptAction.showToast({ message: JSON.stringify(info) })
                  }
                }
                hilog.info(Constants.DOMAIN_NUMBER, Constants.TAG, JSON.stringify(data.resultCode) ?? '');
              })
              .catch((err: BusinessError) => {
                hilog.error(Constants.DOMAIN_NUMBER, Constants.TAG, `Failed to start ability for result. Code is ${err.code}, message is ${err.message}`);
              })
          })
          .width('100%')
          .height('100%')
        }
        .width('100%')
        .height('50%')
        .backgroundColor(Color.Green)
        //...
      }
      .width('100%')
      .height('100%')
      //...
    }
    //...
  }
}