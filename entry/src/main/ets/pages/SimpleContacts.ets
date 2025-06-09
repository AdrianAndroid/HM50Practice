import { JSON, util } from '@kit.ArkTS'
import Constants from '../common/Constants';
import { DividerTmp } from '../common/DividerTmp';
import Logger from '../common/Logger';


class Contact {
  key: string = util.generateRandomUUID(true);
  name: string;
  icon: Resource;


  constructor(name: string, icon: Resource) {
    this.name = name;
    this.icon = icon;
  }
}


@Entry
@Component
struct SimpleContacts {
  @State egDivider: DividerTmp = new DividerTmp(1, 60, 10, '#ffe9f0f0')
  private contacts: Array<object> = [
    new Contact('小明', $r("app.media.icon")),
    new Contact('小明1', $r("app.media.icon")),
    new Contact('小明2', $r("app.media.icon")),
    new Contact('小明3', $r("app.media.icon")),
    new Contact('小明4', $r("app.media.icon")),
    new Contact('小明5', $r("app.media.icon")),
    new Contact('小明6', $r("app.media.icon")),
    new Contact('小明7', $r("app.media.icon")),
    new Contact('小明8', $r("app.media.icon")),
    new Contact('小红', $r("app.media.icon")),
    new Contact('小红1', $r("app.media.icon")),
    new Contact('小红2', $r("app.media.icon")),
    new Contact('小红3', $r("app.media.icon")),
    new Contact('小红4', $r("app.media.icon")),
    new Contact('小红5', $r("app.media.icon")),
    new Contact('小红6', $r("app.media.icon")),
    new Contact('小红7', $r("app.media.icon")),
    new Contact('小红8', $r("app.media.icon")),
  ]


  build() {
    List() {
      ForEach(this.contacts, (item: Contact) => {
        ListItem() {
          Row() {
            Image(item.icon)
              .width(40)
              .height(40)
              .margin(10)
            Text(item.name).fontSize(20)
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .onClick(() => {
            Logger.info('SimpleContacts', JSON.stringify(item))
          })
        }
      }, (item: Contact) => JSON.stringify(item))
    }
    .width('100%')
    .height(Constants.FULL_HEIGHT)
    .divider(this.egDivider)
    .scrollBar(BarState.On)
  }
}