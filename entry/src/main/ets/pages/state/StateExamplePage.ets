import { router } from "@kit.ArkUI"

@Builder
export function PageBuilder(name: string, param: Object) {
  StateExamplePage()
}

@Entry
@Component
struct StateExamplePage {
  private pathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Flex({wrap: FlexWrap.Wrap}) {
        Text('RepeatExamplePage').fontSize(30).borderWidth(2).onClick(() => {
          this.getUIContext().getRouter().pushUrl({ url: 'pages/state/RepeatExamplePage' });
        })
        Text('AppStorageV2Page').fontSize(30).borderWidth(2).onClick(() => {
          this.getUIContext().getRouter().pushUrl({ url: 'pages/state/AppStorageV2Page' });
        })
        Text('PersistenceV2Page').fontSize(30).borderWidth(2).onClick(() => {
          this.getUIContext().getRouter().pushUrl({ url: 'pages/state/PersistenceV2Page' });
        })
      }
      .height('100%')
      .width('100%')
    }
    .onReady((callback) => {
      this.pathStack = callback.pathStack
    })
  }
}