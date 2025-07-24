import { router } from '@kit.ArkUI'

@Builder
function PageBuilder() {
  WebMainPage()
}

@ComponentV2
struct WebMainPage {
  build() {
    NavDestination() {
      Column({space: 20}) {
        Button('应用侧调用前端页面函数').onClick(() => {
          router.pushUrl({ url: 'pages/web/Web111Page' });
        })
        Text('前端页面调用应用侧函数')
        Button('javaScriptProxy()接口使用示例如下').onClick(() => {router.pushUrl({ url: 'pages/web/Web222Page' });})
        Button('应用侧使用registerJavaScriptProxy()接口注册').onClick(() => {router.pushUrl({ url: 'pages/web/Web333Page' });})

        Text('前端页面调用应用侧函数')
        Text('应用侧和前端页面之间传递Array')
        Button('应用侧和前端页面之间传递Array').onClick(() => {router.pushUrl({ url: 'pages/web/Web444Page' });})
        Button('非Function等复杂类型使用').onClick(() => {router.pushUrl({ url: 'pages/web/Web555Page' });})
        Button('应用侧调用前端页面的Callback').onClick(() => {router.pushUrl({ url: 'pages/web/Web666Page' });})
        Button('应用侧调用前端页面Object里的Function').onClick(() => {router.pushUrl({ url: 'pages/web/Web666Page' });})

        Button('建立应用侧与前端页面数据通道').onClick(() => {router.pushUrl({ url: 'pages/web/Web777Page' });})
      }
    }
  }
}