import Constants from '../../common/Constants';
import { JSON, util } from '@kit.ArkTS';

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
      new Contact('艾佳', $r('app.media.ic_user_portrait')),
      new Contact('安安', $r('app.media.ic_user_portrait')),
      new Contact('Angela', $r('app.media.ic_user_portrait')),
      new Contact('Angela', $r('app.media.ic_user_portrait')),
      new Contact('Angela1', $r('app.media.ic_user_portrait')),
      new Contact('Angela2', $r('app.media.ic_user_portrait')),
      new Contact('Angela3', $r('app.media.ic_user_portrait')),
      new Contact('Angela4', $r('app.media.ic_user_portrait')),
      new Contact('Angela5', $r('app.media.ic_user_portrait')),
    ],
    key: util.generateRandomUUID(true)
  } as ContactsGroup,
  {
    title: 'B',
    contacts: [
      new Contact('白叶', $r('app.media.ic_user_portrait')),
      new Contact('伯明', $r('app.media.ic_user_portrait')),
      new Contact('伯明1', $r('app.media.ic_user_portrait')),
      new Contact('伯明2', $r('app.media.ic_user_portrait')),
      new Contact('伯明3', $r('app.media.ic_user_portrait')),
      new Contact('伯明4', $r('app.media.ic_user_portrait')),
      new Contact('伯明5', $r('app.media.ic_user_portrait')),
      new Contact('伯明6', $r('app.media.ic_user_portrait')),
      new Contact('伯明7', $r('app.media.ic_user_portrait')),
      new Contact('伯明8', $r('app.media.ic_user_portrait')),
      new Contact('伯明9', $r('app.media.ic_user_portrait')),
    ],
    key: util.generateRandomUUID(true)
  } as ContactsGroup,
// ...
]

class DividerTmp {
  strokeWidth: Length = 1
  startMargin: Length = 60
  endMargin: Length = 10
  color: ResourceColor = '#ffe9f0f0'

  constructor(strokeWidth: Length, startMargin: Length, endMargin: Length, color: ResourceColor) {
    this.strokeWidth = strokeWidth
    this.startMargin = startMargin
    this.endMargin = endMargin
    this.color = color
  }
}

const alphabets = ['#', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];


@Entry
@Component
struct ListExamplePage {
  @State message: string = 'Hello World';
  // 设置交叉轴布局
  @State egLanes: LengthConstrain = { minLength: 200, maxLength: 300 }
  // 添加分割线
  @State egDivider: DividerTmp = new DividerTmp(1, 60, 10, '#ffe9f0f0')
  private contacts: Array<object> = [
    new Contact('小明', $r("app.media.ic_user_portrait")),
    new Contact('小红', $r("app.media.ic_user_portrait")),
  ]

  build() {
    Stack() {
      this.example10()
    }
    .backgroundColor(Color.Gray)
    .height('100%')
    .width('100%')
  }

  // 下拉刷新与上拉加载


  // 给列表添加标记
  @Builder
  example14() {
    ListItem() {
      Badge({
        count: 1,
        position: BadgePosition.RightTop,
        style: { badgeSize: 16, badgeColor: '#FA2A2D' }
      }) {
        // Image组件实现消息联系人头像
        // ...
      }
    }
  }

  // 响应列表想侧滑
  @State messages: Array<number> = [];
  @Builder
  itemEnd(index: number) {
    // 构建尾端滑出组件
    Button({ type: ButtonType.Circle }) {
      Image($r('app.media.ic_public_delete_filled'))
        .width(20)
        .height(20)
    }
    .onClick(() => {
      // this.messages为列表数据源，可根据实际场景构造。点击后从数据源删除指定数据项。
      this.messages.splice(index, 1);
    })
  }

  @Builder
  example13() {
    List() {
      // 构建List时，通过ForEach基于数据源this.messages循环渲染ListItem。
      ListItem() {
        // ...
      }
      .swipeAction({
        end: {
          // index为该ListItem在List中的索引值。
          builder: () => { this.itemEnd(0) },
        }
      }) // 设置侧滑属性.
    }
  }

  // 响应滚动位置
  @State selectedIndex: number = 0;
  @Builder
  example12() {
    Stack({ alignContent: Alignment.End }) {
      List({ scroller: this.listScroller }) {

      }
      .width(Constants.FULL_PERCENT)
      .height(Constants.FULL_PERCENT)
      .onScrollIndex((firstIndex: number) => {
        // 根据列表滚动到的索引值，重新计算对应联系人索引栏的位置this.selectedIndex
      })

      // 字母表索引组件
      AlphabetIndexer({ arrayValue: alphabets, selected: 0 })
        .selected(this.selectedIndex)
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
  }

  // 控制滚动位置
  private listScroller: Scroller = new Scroller();
  @Builder
  example11() {
    Stack({ alignContent: Alignment.Bottom }) {
      // 将listScroller用于初始化List组件的scroller参数，完成listScroller与列表的绑定。
      List({ space: 20, scroller: this.listScroller }) {
        // ...
      }

      Button() {
        // ...
      }
      .onClick(() => {
        // 点击按钮时，指定跳转位置，返回列表顶部
        this.listScroller.scrollToIndex(0)
      })
    }
  }

  // 添加粘性标题
  @Builder
  example10() {
    List() {
      ForEach(contactsGroups, (itemGroup: ContactsGroup) => {
        ListItemGroup({header: this.itemHead(itemGroup.title)}) {
          // 循环渲染ListItem
          if (itemGroup.contacts) {
            ForEach(itemGroup.contacts, (item: Contact) => {
                ListItem() {
                  Text(item.name)
                }
            }, (item: Contact) => JSON.stringify(item))
          }
        }
      }, (itemGroup: ContactsGroup) => JSON.stringify(itemGroup))
    }.width(Constants.FULL_PERCENT)
    .height(200)
    .margin({top: 100})
    .backgroundColor(Color.Green)
    .sticky(StickyStyle.Header) // 设置吸顶，实现粘性标题效果
  }

  // 支持分组列表
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
  example9() {
    List() {
      ListItemGroup({ header: this.itemHead('A') }) {
        // 循环渲染分组A的ListItem
      }

      ListItemGroup({ header: this.itemHead('B') }) {

      }
    }
  }

  // 添加滚动条
  @Builder
  example8() {
    List().scrollBar(BarState.Auto)
  }

  @Builder
  example7() {
    List().divider(this.egDivider)
  }

  // 自定义列表样式
  @Builder
  example6() {
    List({ space: 10 }) {
    }
  }

  // 迭代列表内容
  @Builder
  example5() {
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
          .backgroundColor(Color.Red)
          .width(Constants.FULL_PERCENT)
          .justifyContent(FlexAlign.Center)
        }
      })
    }.width(Constants.FULL_PERCENT)
  }

  @Builder
  example4() {
    List() {
      ListItem() {
        Row() {
          Image($r('app.media.ic_user_portrait'))
            .width(40)
            .height(40)
            .margin(10)


          Text('小明')
            .fontSize(20)
        }
      }


      ListItem() {
        Row() {
          Image($r('app.media.ic_user_portrait'))
            .width(40)
            .height(40)
            .margin(10)


          Text('小红')
            .fontSize(20)
        }
      }
    }
  }

  // 在列表中显示数据
  @Builder
  example3() {
    List() {
      ListItem() {
        Text('北京').fontSize(24)
      }

      ListItem() {
        Text('杭州').fontSize(24)
      }

      ListItem() {
        Text('上海').fontSize(24)
      }
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
    .backgroundColor('#FFF1F3F5')
    .alignListItem(ListItemAlign.Center)
  }

  @Builder
  example2() {
    List().lanes(2)
    List().lanes(this.egLanes)
    List().alignListItem(ListItemAlign.Center)
  }

  // 设置主轴方向
  @Builder
  example1() {
    List() {

    }
    .listDirection(Axis.Horizontal)
  }
}