import { router } from '@kit.ArkUI';
import { FULL_PERCENT } from '../../model/ConstantsData';

@Builder
function PageBuilder() {
  AnimateMainPage()
}

/**
 * https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-explicit-animation#%E7%A4%BA%E4%BE%8B1%E5%9C%A8%E7%BB%84%E4%BB%B6%E5%87%BA%E7%8E%B0%E6%97%B6%E5%88%9B%E5%BB%BA%E5%8A%A8%E7%94%BB
 */
@ComponentV2
struct AnimateMainPage {
  build() {
    NavDestination() {
      Scroll() {
        Column() {
          Blank().height(100)
          Button('示例1（在组件出现时创建动画）')
            .onClick(() => {
              router.pushUrl({ url: 'pages/animate/AnimateToExample' });
            })
            .margin({ bottom: 12 })
          Button('示例2（动画执行结束后组件消失）')
            .onClick(() => {
              router.pushUrl({ url: 'pages/animate/AttrAnimationExample' });
            })
        }
      }
      .width(FULL_PERCENT)
      .height(FULL_PERCENT)
    }
  }
}