import { router } from '@kit.ArkUI';
import Constants from '../../common/Constants';

@Entry()
@Component({ freezeWhenInactive: true })
struct StateV1Page {
  @StorageLink('PropA') @Watch("first") storageLink: number = 47;

  first() {
    console.info("first page " + `${this.storageLink}`)
  }

  build() {
    Column() {
      Text(`From first Page ${this.storageLink}`).fontSize(50)
      Button('first page storageLink + 1').fontSize(30)
        .onClick(() => {
          this.storageLink += 1
        })
      Button('go to next page').fontSize(30)
        .onClick(() => {
          router.pushUrl({ url: Constants.PAGES_statev1_StateV1Page2 })
        })
    }
  }
}