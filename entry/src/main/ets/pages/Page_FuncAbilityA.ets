import { hilog } from '@kit.PerformanceAnalysisKit'
import Constants from '../common/constants/Constants'
import { common } from '@kit.AbilityKit'

@Entry
@Component
struct Page_FuncAbilityA {
  build() {
    Column() {
      //...
      List({ initialIndex: 0 }) {
        ListItem() {
          Row() {
            Text('Page_FuncAbilityA')
          }
          .width('100%')
          .height('50%')
          .backgroundColor(Color.Green)
          .onClick(() => {
            let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext; // UIAbilityContext
            const RESULT_CODE: number = 1001;
            let abilityResult: common.AbilityResult = {
              resultCode: RESULT_CODE,
              want: {
                bundleName: 'com.example.myapplication',
                moduleName: 'entry', // moduleName非必选
                abilityName: 'FuncAbilityB',
                parameters: {
                  info: '来自FuncAbility Index页面'
                },
              },
            };
            context.terminateSelfWithResult(abilityResult, (err) => {
              if (err.code) {
                hilog.error(Constants.DOMAIN_NUMBER, Constants.TAG, `Failed to terminate self with result. Code is ${err.code}, message is ${err.message}`);
              }
            });
          })
        }
        //...
      }
      .width('100%')
      .height('100%')
    }
    //...
  }
}