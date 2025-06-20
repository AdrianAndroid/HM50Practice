import { common, Configuration, EnvironmentCallback } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';

const TAG: string = '[CollaborateAbility]';
const DOMAIN_NUMBER: number = 0xFF00;

@Entry
@Component
struct PageEnvironmentChange {
  private context = getContext(this) as common.UIAbilityContext;
  private callbackId: number = 0; // 注册订阅系统环境变化的ID

  subscribeConfigurationUpdate(): void {
    let systemLanguage: string | undefined = this.context.config.language; // 获取系统当前语言

    // 1.获取ApplicationContext
    let applicationContext = this.context.getApplicationContext();

    // 2.通过applicationContext订阅环境变量变化
    let environmentCallback: EnvironmentCallback = {
      onConfigurationUpdated(newConfig: Configuration) {
        hilog.info(DOMAIN_NUMBER, TAG, `onConfigurationUpdated systemLanguage is ${systemLanguage}, newConfig: ${JSON.stringify(newConfig)}`);
        if (systemLanguage !== newConfig.language) {
          hilog.info(DOMAIN_NUMBER, TAG, `systemLanguage from ${systemLanguage} changed to ${newConfig.language}`);
          systemLanguage = newConfig.language; // 将变化之后的系统语言保存，作为下一次变化前的系统语言
        }
      },
      onMemoryLevel(level) {
        hilog.info(DOMAIN_NUMBER, TAG, `onMemoryLevel level: ${level}`);
      }
    }
    try {
      this.callbackId = applicationContext.on('environment', environmentCallback);
    } catch (err) {
      let code = (err as BusinessError).code;
      let message = (err as BusinessError).message;
      hilog.error(DOMAIN_NUMBER, TAG, `Failed to register applicationContext. Code is ${code}, message is ${message}`);
    }
  }

  unsubscribeConfigurationUpdate() {
    let applicationContext = this.context.getApplicationContext();
    try {
      applicationContext.off('environment', this.callbackId);
    } catch (err) {
      let code = (err as BusinessError).code;
      let message = (err as BusinessError).message;
      hilog.error(DOMAIN_NUMBER, TAG, `Failed to unregister applicationContext. Code is ${code}, message is ${message}`);
    }
  }

  aboutToAppear(): void {
    this.subscribeConfigurationUpdate()
  }

  aboutToDisappear(): void {
    this.unsubscribeConfigurationUpdate()
  }

  // 页面展示
  build() {
    Column() {
      Blank()
        .height(200)
      Button() {
        Text('Click Here nothing to do!')
      }
    }
  }
}