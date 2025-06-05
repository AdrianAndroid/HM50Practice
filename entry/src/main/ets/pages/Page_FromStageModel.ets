import { common } from '@kit.AbilityKit';
import Constants from '../common/Constants';
import { hilog } from '@kit.PerformanceAnalysisKit';

@Entry
@Component
struct Page_FromStageModel {
  build() {
    Column() {
      //...
      Button('FuncAbilityB')
        .onClick(() => {
          let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext; // UIAbilityContext
          // context为需要停止的UIAbility实例的AbilityContext
          context.terminateSelf((err) => {
            if (err.code) {
              hilog.error(Constants.DOMAIN_NUMBER, Constants.TAG,
                `Failed to terminate self. Code is ${err.code}, message is ${err.message}`);
              return;
            }
          });
        })
    }
  }
}