import { common, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import Constants from '../common/Constants';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct Page_UIAbilityComponentsInteractive {
  private context = getContext(this) as common.UIAbilityContext;

  build() {
    Column() {
      //...
      List({ initialIndex: 0 }) {
        ListItem() {
          Row() {
            Text('Hello')
          }
          .onClick(() => {
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
            // context为调用方UIAbility的UIAbilityContext
            this.context.startAbility(wantInfo).then(() => {
              hilog.info(Constants.DOMAIN_NUMBER, Constants.TAG, 'startAbility success.');
            }).catch((error: BusinessError) => {
              hilog.error(Constants.DOMAIN_NUMBER, Constants.TAG, `startAbility failed.  error=${error.stack}`);
            });
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