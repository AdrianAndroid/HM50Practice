import { createNWeb, IJavaScriptConfig, IResourceConfig, WebProperties } from '@hw-agconnect/fast-web';
import { webview } from '@kit.ArkWeb';
import { router, window } from '@kit.ArkUI';
import { preLoadUrl } from '@hw-agconnect/fast-web';
// import { router } from '@kit.ArkUI';
@Builder
function PageBuilder() {
  FastWebExamplePage()
}

export const WEB1_ID = 'web1Id'
export function FastWebConfig(windowStage: window.WindowStage) {
  // 包括原生Web组件的WebOptions、属性和事件
  const webProperties = new WebProperties();
  webProperties.defaultFontSize = 30;
  // 预编译的JavaScript资源
  const javaScriptConfigs: IJavaScriptConfig[] = [
    {
      url: 'https://6tail.cn/tyme.min.js',
      localPath: 'tyme.min.js',
    }
  ]
  // 免拦截注入的离线资源如图片、样式表和脚本资源
  const resourceConfigs: IResourceConfig[] = [
    {
      localPath: 'group.jpg',
      urlList: [
        'https://pub.idqqimg.com/wpa/images/group.png',
      ],
      type: webview.OfflineResourceType.IMAGE,
    }
  ];
  // 预先创建一个空的ArkWeb动态组件（需传入UIContext），拉起渲染进程
  createNWeb(WEB1_ID, windowStage.getMainWindowSync().getUIContext(), webProperties, javaScriptConfigs, resourceConfigs);
}

@ComponentV2
struct FastWebExamplePage {
  onPageShow(): void {
    preLoadUrl(WEB1_ID, 'about://blank')
  }

  build() {
    NavDestination() {
      Button('地址1')
        .onClick(() => {
          preLoadUrl(WEB1_ID, 'www.example1.com')
          router.pushUrl({
            url: 'pages/fastweb/FastWebSample2', params: {
              id: WEB1_ID,
              url: 'https://6tail.cn/tyme.html'
            }
          });
        })
        .margin({ bottom: 12 })
      Button('地址2')
        .onClick(() => {
          preLoadUrl(WEB1_ID, 'www.example2.com')
          router.pushUrl({
            url: 'pages/fastweb/FastWebSample2', params: {
              id: WEB1_ID,
              url: 'https://developer.huawei.com/consumer/cn/doc/harmonyos-releases/app-compatibility'
            }
          });
        })
    }
  }
}