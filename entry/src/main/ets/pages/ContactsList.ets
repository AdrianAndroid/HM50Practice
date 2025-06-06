import { JSON, util } from '@kit.ArkTS'
import Constants from '../common/constants/Constants';
import { DividerTmp } from '../common/DividerTmp';
import Logger from '../common/util/Logger';

class Contact {
  key: string = util.generateRandomUUID(true);
  name: string;
  icon: Resource;

  constructor(name: string, icon: Resource) {
    this.name = name;
    this.icon = icon;
  }
}

class ContactsGroup {
  title: string = ''
  contacts: Array<object> | null = null
  key: string = ""
}

export let contactsGroups: object[] = [
  {
    title: 'A',
    contacts: [
      new Contact('艾佳', $r('app.media.icon')),
      new Contact('安安', $r('app.media.icon')),
      new Contact('Angela', $r('app.media.icon')),
    ],
    key: util.generateRandomUUID(true)
  } as ContactsGroup,
  {
    title: 'B',
    contacts: [
      new Contact('白叶', $r('app.media.icon')),
      new Contact('伯明', $r('app.media.icon')),
    ],
    key: util.generateRandomUUID(true)
  } as ContactsGroup,
// ...
]

const alphabets =
  ['#', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
    'W', 'X', 'Y', 'Z'];

@Entry
@Component
struct ContactsList {
  @State egDivider: DividerTmp = new DividerTmp(1, 60, 10, '#ffe9f0f0')
  @State selectedIndex: number = 0;
  private listScroller: Scroller = new Scroller();
  private contacts: Array<object> = [
    new Contact('小明', $r("app.media.icon")),
    new Contact('小明1', $r("app.media.icon")),
    new Contact('小明2', $r("app.media.icon")),
    new Contact('小明3', $r("app.media.icon")),
    new Contact('小明4', $r("app.media.icon")),
    new Contact('小红', $r("app.media.icon")),
    new Contact('小红1', $r("app.media.icon")),
    new Contact('小红2', $r("app.media.icon")),
    new Contact('小红3', $r("app.media.icon")),
    new Contact('小红4', $r("app.media.icon"))
  ]

  @Builder
  itemHead(text: string) {
    // 列表分组的头部组件，对应联系人分组A、B等位置的组件
    Text(text)
      .fontSize(20)
      .backgroundColor('#fff1f3f5')
      .width('100%')
      .padding(5)
  }

  @Builder
  item(item: Contact) {
    ListItem() {
      Row() {
        Badge(
          {
            count: 1,
            position: BadgePosition.RightTop,
            style: { badgeSize: 16, badgeColor: '#FA2A2D' }
          }
        ) {
          Image(item.icon)
            .width(40)
            .height(40)
            .margin(10)
        }
        Text(item.name).fontSize(20)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .onClick(() => {
        Logger.info('SimpleContacts', JSON.stringify(item))
      })
    }
    .swipeAction({
      end: {
        builder: () => {this.itemEnd(0)}
      }
    })
  }

  // build() {
  //   List() {
  //     ListItemGroup({ header: this.itemHead('A') }) {
  //       ForEach(this.contacts, (item: Contact) => {
  //         this.item(item)
  //       }, (item: Contact) => JSON.stringify(item))
  //     }
  //
  //     ListItemGroup({ header: this.itemHead('B') }) {
  //       ForEach(this.contacts, (item: Contact) => {
  //         this.item(item)
  //       }, (item: Contact) => JSON.stringify(item))
  //     }
  //   }
  //   .width('100%')
  //   .height(Constants.FULL_HEIGHT)
  //   .divider(this.egDivider)
  //   .scrollBar(BarState.On)
  // }

  @Builder itemEnd(index: number) {
    // 构建尾端滑出组件
    Button({ type: ButtonType.Circle }) {
      Image($r('app.media.ic_public_delete_filled'))
        .width(20)
        .height(20)
    }
    .onClick(() => {
      // this.messages为列表数据源，可根据实际场景构造。点击后从数据源删除指定数据项。
      this.contacts.splice(index, 1);
    })
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      List() {
        // 循环渲染ListItemGroup，contactsGroups为多个分组联系人contacts和标题title的数据集合
        ForEach(contactsGroups, (itemGroup: ContactsGroup) => {
          ListItemGroup({ header: this.itemHead(itemGroup.title) }) {
            // 循环渲染ListItem
            if (itemGroup.contacts) {
              ForEach(itemGroup.contacts, (item: Contact) => {
                ForEach(this.contacts, (item: Contact) => {
                  this.item(item)
                }, (item: Contact) => JSON.stringify(item))
              }, (item: Contact) => JSON.stringify(item))
            }
          }
        }, (itemGroup: ContactsGroup) => JSON.stringify(itemGroup))
      }
      .sticky(StickyStyle.Header)
      .width(Constants.FULL_WIDTH)
      .height(Constants.FULL_HEIGHT)


      AlphabetIndexer({ arrayValue: alphabets, selected: 0 })
        .selected(this.selectedIndex)

      Button(){
        Image($r('app.media.ic_public_add'))
          .width(60)
          .height(60)
      }
      .align(Alignment.TopEnd)
      .onClick(() => {
        Logger.info('ContactsList', 'add')
      })
    }
  }
}