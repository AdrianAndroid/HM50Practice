//使用页面
import { controllerMap, FastWeb, updateWeb, webOptionMap } from '@hw-agconnect/fast-web';
import { router } from '@kit.ArkUI';

interface IParams {
  id: string,
  url: string | Resource,
}

@Entry
@ComponentV2
struct FastWebSample2 {
  @Local webId: string = ''
  @Local url: string | Resource = ''

  aboutToAppear(): void {
    const params: IParams = router.getParams() as IParams
    this.url = params.url
    this.webId = params.id
    // 更新web的属性和事件
    const webOption = webOptionMap.get(this.webId)
    if (webOption) {
      const webProperties = webOptionMap.get(this.webId)!.config.webProperties
      webProperties.defaultFontSize = 30
      webProperties.onAlert = () => {
        console.log('测试事件变化')
        return true
      }
      updateWeb(this.webId)
    }
  }

  onBackPress() {
    const controller = controllerMap.get(this.webId)
    // 当前页面是否可前进或者后退给定的step步(-1),正数代表前进，负数代表后退
    if (controller && controller.accessStep(-2)) {
      controller.backward(); // 返回上一个web页
      // 执行用户自定义返回逻辑
      return true;
    } else {
      // 执行系统默认返回逻辑，返回上一个page页
      return false;
    }
  }

  build() {
    NavDestination() {
      // url请替换为真实地址
      FastWeb({ webId: this.webId, url: this.url })
    }
  }
}