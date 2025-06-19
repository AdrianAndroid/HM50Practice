import { common, OpenLinkOptions } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';


const TAG: string = '[UIAbilityComponentsOpenLink]';
const DOMAIN_NUMBER: number = 0xFF00;


@Entry
@Component
struct OpenLinkPage {
  build() {
    Button('start link', { type: ButtonType.Capsule, stateEffect: true })
      .width('87%')
      .height('5%')
      .margin({ top: 100, bottom: '12vp' })
      .onClick(() => {
        let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
        let link: string = "link://www.example.com";
        let openLinkOptions: OpenLinkOptions = {
          appLinkingOnly: false
        };


        try {
          context.openLink(link, openLinkOptions)
            .then(() => {
              hilog.info(DOMAIN_NUMBER, TAG, 'open link success.');
            }).catch((err: BusinessError) => {
            hilog.error(DOMAIN_NUMBER, TAG, `open link failed. Code is ${err.code}, message is ${err.message}`);
          });
        } catch (paramError) {
          hilog.error(DOMAIN_NUMBER, TAG, `Failed to start link. Code is ${paramError.code}, message is ${paramError.message}`);
        }
      })
  }
}