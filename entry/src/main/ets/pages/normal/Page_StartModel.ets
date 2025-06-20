// 在启动指定实例模式的UIAbility时，给每一个UIAbility实例配置一个独立的Key标识
// 例如在文档使用场景中，可以用文档路径作为Key标识
import { common, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import Constants from '../../common/Constants';


const TAG: string = '[Page_StartModel]';
const DOMAIN_NUMBER: number = 0xFF00;


function getInstance(): string {
  return 'KEY';
}


@Entry
@Component
struct Page_StartModel {
  private KEY_NEW = 'KEY';
  private context = getContext(this) as common.UIAbilityContext

  build() {
    Row() {
      Column() {
        // ...
        Button('AAAAAAAAAA')
          .onClick(() => {
            let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
            // context为调用方UIAbility的UIAbilityContext;
            let want: Want = {
              deviceId: '', // deviceId为空表示本设备
              bundleName: Constants.bundleName,
              abilityName: 'SpecifiedAbility', //SpecifiedFirstAbility',
              moduleName: 'entry', // moduleName非必选
              parameters: {
                // 自定义信息
                instanceKey: this.KEY_NEW
              }
            };
            context.startAbility(want).then(() => {
              hilog.info(DOMAIN_NUMBER, TAG, 'Succeeded in starting SpecifiedAbility.');
            }).catch((err: BusinessError) => {
              hilog.error(DOMAIN_NUMBER, TAG, `Failed to start SpecifiedAbility. Code is ${err.code}, message is ${err.message}`);
            })
            this.KEY_NEW = this.KEY_NEW + 'a';
          })
        // ...
        Button('BBBBBBBBB')
          .onClick(() => {
            let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
            // context为调用方UIAbility的UIAbilityContext;
            let want: Want = {
              deviceId: '', // deviceId为空表示本设备
              bundleName: Constants.bundleName,
              abilityName: 'SpecifiedAbility', //'SpecifiedSecondAbility',
              moduleName: 'entry', // moduleName非必选
              parameters: {
                // 自定义信息
                instanceKey: getInstance()
              }
            };
            context.startAbility(want).then(() => {
              hilog.info(DOMAIN_NUMBER, TAG, 'Succeeded in starting SpecifiedAbility.');
            }).catch((err: BusinessError) => {
              hilog.error(DOMAIN_NUMBER, TAG, `Failed to start SpecifiedAbility. Code is ${err.code}, message is ${err.message}`);
            })
            this.KEY_NEW = this.KEY_NEW + 'a';
          })
        // ...
      }
      .width('100%')
    }
    .height('100%')
  }
}