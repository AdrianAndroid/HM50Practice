import { router } from '@kit.ArkUI'
import { FULL_PERCENT } from '../../model/ConstantsData';

function addTen(x: number) : number {
  let ten = 10;
  return x + ten;
}

@Builder
function PageBuilder() {
  ArkTSMainPage()
}

@ComponentV2
struct ArkTSMainPage {
  build() {
    NavDestination() {
      Scroll() {
        Column({space: 20}) {
          Button('XML的操作').onClick(() => { router.pushUrl({ url: 'pages/arkts/XMLPage' }); })
          Button('ContainerPage').onClick(() => { router.pushUrl({ url: 'pages/arkts/ContainerPage' }); })
          Button('JSONPage').onClick(() => { router.pushUrl({ url: 'pages/arkts/JSONPage' }); })
          Button('RecordPage').onClick(() => { router.pushUrl({ url: 'pages/arkts/RecordPage' }); })
          Button('ComNormalPage').onClick(() => { router.pushUrl({ url: 'pages/arkts/ComNormalPage' }); })
          Button('ComArrayBufferPage').onClick(() => { router.pushUrl({ url: 'pages/arkts/ComArrayBufferPage' }); })
          Button('PromiseAsyncAwaitPage').onClick(() => { router.pushUrl({ url: 'pages/arkts/PromiseAsyncAwaitPage' }); })
          Button('ShareModelAndActorPage').onClick(() => { router.pushUrl({ url: 'pages/arkts/ShareModelAndActorPage' }); })
          Button('ComSharedArrayBufferPage').onClick(() => { router.pushUrl({ url: 'pages/arkts/ComSharedArrayBufferPage' }); })
          Button('TaskPoolPage').onClick(() => { router.pushUrl({ url: 'pages/arkts/TaskPoolPage' }); })
          Button('EventBusPage').onClick(() => { router.pushUrl({ url: 'pages/arkts/EventBusPage' }); })
          Button('SendableClassPage').onClick(() => { router.pushUrl({ url: 'pages/arkts/sendable/SendableClassPage' }); })
          Button('ASONPage').onClick(() => { router.pushUrl({ url: 'pages/arkts/sendable/ASONPage' }); })
        }
      }
      .width(FULL_PERCENT)
      .height(FULL_PERCENT)
    }
  }
}