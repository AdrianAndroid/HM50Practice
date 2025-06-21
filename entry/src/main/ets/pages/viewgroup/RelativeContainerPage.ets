import Constants from '../../common/Constants'

@Entry
@Component
struct RelativeContainerPage {
  @State value: number = 0

  build() {
    Stack() {
      this.example6()
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
  }

  // 组件尺寸
  @Builder
  example6() {
    Row() {
      RelativeContainer() {
        Row() {
          Text('row1')
        }
        .justifyContent(FlexAlign.Center)
        .width(100)
        .height(100)
        .backgroundColor('#a3cf62')
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "__container__", align: HorizontalAlign.Start }
        })
        .id("row1")

        Row() {
          Text('row2')
        }
        .justifyContent(FlexAlign.Center)
        .width(100)
        .backgroundColor('#00ae9d')
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          right: { anchor: "__container__", align: HorizontalAlign.End },
          bottom: { anchor: "row1", align: VerticalAlign.Center },
        })
        .id("row2")

        Row() {
          Text('row3')
        }
        .justifyContent(FlexAlign.Center)
        .height(100)
        .backgroundColor('#0a59f7')
        .alignRules({
          top: { anchor: "row1", align: VerticalAlign.Bottom },
          left: { anchor: "row1", align: HorizontalAlign.End },
          right: { anchor: "row2", align: HorizontalAlign.Start }
        })
        .id("row3")

        Row() {
          Text('row4')
        }.justifyContent(FlexAlign.Center)
        .backgroundColor('#2ca9e0')
        .alignRules({
          top: { anchor: "row3", align: VerticalAlign.Bottom },
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
          left: { anchor: "__container__", align: HorizontalAlign.Start },
          right: { anchor: "row1", align: HorizontalAlign.End }
        })
        .id("row4")

        Row() {
          Text('row5')
        }.justifyContent(FlexAlign.Center)
        .backgroundColor('#30c9f7')
        .alignRules({
          top: { anchor: "row3", align: VerticalAlign.Bottom },
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
          left: { anchor: "row2", align: HorizontalAlign.Start },
          right: { anchor: "row2", align: HorizontalAlign.End }
        })
        .id("row5")

        Row() {
          Text('row6')
        }
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#ff33ffb5')
        .alignRules({
          top: { anchor: "row3", align: VerticalAlign.Bottom },
          bottom: { anchor: "row4", align: VerticalAlign.Bottom },
          left: { anchor: "row3", align: HorizontalAlign.Start },
          right: { anchor: "row3", align: HorizontalAlign.End }
        })
        .id("row6")
        .backgroundImagePosition(Alignment.Bottom)
        .backgroundImageSize(ImageSize.Cover)
      }
      .width(300).height(300)
      .margin({ left: 50 })
      .border({ width: 2, color: "#6699FF" })
    }
    .height('100%')
  }

  // 多种组件的对齐布局
  @Builder
  example5() {
    Row() {

      RelativeContainer() {
        Row()
          .width(100)
          .height(100)
          .backgroundColor('#a3cf62')
          .alignRules({
            top: { anchor: "__container__", align: VerticalAlign.Top },
            left: { anchor: "__container__", align: HorizontalAlign.Start }
          })
          .id("row1")

        Column()
          .width('50%')
          .height(30)
          .backgroundColor('#00ae9d')
          .alignRules({
            top: { anchor: "__container__", align: VerticalAlign.Top },
            left: { anchor: "__container__", align: HorizontalAlign.Center }
          })
          .id("row2")

        Flex({ direction: FlexDirection.Row }) {
          Text('1').width('20%').height(50).backgroundColor('#0a59f7')
          Text('2').width('20%').height(50).backgroundColor('#2ca9e0')
          Text('3').width('20%').height(50).backgroundColor('#0a59f7')
          Text('4').width('40%').height(50).backgroundColor('#2ca9e0')
        }
        .padding(10)
        .backgroundColor('#30c9f7')
        .alignRules({
          top: { anchor: "row2", align: VerticalAlign.Bottom },
          left: { anchor: "__container__", align: HorizontalAlign.Start },
          bottom: { anchor: "__container__", align: VerticalAlign.Center },
          right: { anchor: "row2", align: HorizontalAlign.End }
        })
        .id("row3")

        Stack({ alignContent: Alignment.Bottom }) {
          Text('First child, show in bottom').width('90%').height('100%').backgroundColor('#a3cf62').align(Alignment.Top)
          Text('Second child, show in top').width('70%').height('60%').backgroundColor('#00ae9d').align(Alignment.Top)
        }
        .margin({ top: 5 })
        .alignRules({
          top: { anchor: "row3", align: VerticalAlign.Bottom },
          left: { anchor: "__container__", align: HorizontalAlign.Start },
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
          right: { anchor: "row3", align: HorizontalAlign.End }
        })
        .id("row4")
      }
      .width(300).height(300)
      .margin({ left: 50 })
      .border({ width: 2, color: "#6699FF" })
    }
    .height('100%')
  }


  // 子组件位置偏移
  @Builder
  example4() {
    Row() {
      RelativeContainer() {
        Row() {
          Text('row1')
        }
        .justifyContent(FlexAlign.Center)
        .width(100)
        .height(100)
        .backgroundColor('#a3cf62')
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "__container__", align: HorizontalAlign.Start }
        })
        .id("row1")

        Row() {
          Text('row2')
        }
        .justifyContent(FlexAlign.Center)
        .width(100)
        .backgroundColor('#00ae9d')
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          right: { anchor: "__container__", align: HorizontalAlign.End },
          bottom: { anchor: "row1", align: VerticalAlign.Bottom },
        })
        .offset({
          x: -40,
          y: -20
        })
        .id("row2")

        Row() {
          Text('row3')
        }
        .justifyContent(FlexAlign.Center)
        .height(100)
        .backgroundColor('#0a59f7')
        .alignRules({
          top: { anchor: "row1", align: VerticalAlign.Bottom },
          left: { anchor: "row1", align: HorizontalAlign.End },
          right: { anchor: "row2", align: HorizontalAlign.Start }
        })
        .offset({
          x: -10,
          y: -20
        })
        .id("row3")

        Row() {
          Text('row4')
        }
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#2ca9e0')
        .alignRules({
          top: { anchor: "row3", align: VerticalAlign.Bottom },
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
          left: { anchor: "__container__", align: HorizontalAlign.Start },
          right: { anchor: "row1", align: HorizontalAlign.End }
        })
        .offset({
          x: -10,
          y: -30
        })
        .id("row4")

        Row() {
          Text('row5')
        }
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#30c9f7')
        .alignRules({
          top: { anchor: "row3", align: VerticalAlign.Bottom },
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
          left: { anchor: "row2", align: HorizontalAlign.Start },
          right: { anchor: "row2", align: HorizontalAlign.End }
        })
        .offset({
          x: 10,
          y: 20
        })
        .id("row5")

        Row() {
          Text('row6')
        }
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#ff33ffb5')
        .alignRules({
          top: { anchor: "row3", align: VerticalAlign.Bottom },
          bottom: { anchor: "row4", align: VerticalAlign.Bottom },
          left: { anchor: "row3", align: HorizontalAlign.Start },
          right: { anchor: "row3", align: HorizontalAlign.End }
        })
        .offset({
          x: -15,
          y: 10
        })
        .backgroundImagePosition(Alignment.Bottom)
        .backgroundImageSize(ImageSize.Cover)
        .id("row6")
      }
      .width(300).height(300)
      .margin({ left: 50 })
      .border({ width: 2, color: "#6699FF" })
    }
    .height('100%')
  }

  // 子组件锚点可以任意选择，但需注意不要相互依赖。
  @Builder
  example3() {
    Row() {
      RelativeContainer() {
        Row() {
          Text('row1')
        }
        .justifyContent(FlexAlign.Center)
        .width(100)
        .height(100)
        .backgroundColor('#a3cf62')
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "__container__", align: HorizontalAlign.Start }
        })
        .id("row1")

        Row() {
          Text('row2')
        }
        .justifyContent(FlexAlign.Center)
        .width(100)
        .backgroundColor('#00ae9d')
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          right: { anchor: "__container__", align: HorizontalAlign.End },
          bottom: { anchor: "row1", align: VerticalAlign.Center },
        })
        .id("row2")

        Row() {
          Text('row3')
        }
        .justifyContent(FlexAlign.Center)
        .height(100)
        .backgroundColor('#0a59f7')
        .alignRules({
          top: { anchor: "row1", align: VerticalAlign.Bottom },
          left: { anchor: "row1", align: HorizontalAlign.Start },
          right: { anchor: "row2", align: HorizontalAlign.Start }
        })
        .id("row3")

        Row() {
          Text('row4')
        }.justifyContent(FlexAlign.Center)
        .backgroundColor('#2ca9e0')
        .alignRules({
          top: { anchor: "row3", align: VerticalAlign.Bottom },
          left: { anchor: "row1", align: HorizontalAlign.Center },
          right: { anchor: "row2", align: HorizontalAlign.End },
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom }
        })
        .id("row4")
      }
      .width(300).height(300)
      .margin({ left: 50 })
      .border({ width: 2, color: "#6699FF" })
    }
    .height('100%')
  }

  // 以兄弟元素为锚点。
  @Builder
  example2() {
    RelativeContainer() {
      Row() {
        Text('row1')
      }
      .justifyContent(FlexAlign.Center)
      .width(100)
      .height(100)
      .backgroundColor('#00ae9d')
      .alignRules({
        top: { anchor: Constants.ANCHOR_PARENT, align: VerticalAlign.Top },
        start: { anchor: Constants.ANCHOR_PARENT, align: HorizontalAlign.Start }
      })
      .id("row1")

      Row() {
        Text('row2')
      }
      .justifyContent(FlexAlign.Center)
      .width(100)
      .height(100)
      .backgroundColor('#a3cf62')
      .alignRules({
        top: { anchor: 'row1', align: VerticalAlign.Bottom },
        left: { anchor: 'row1', align: HorizontalAlign.Start }
      })
      .id("row2")
    }.width(300).height(300)
    .margin({ 'left': 20 })
    .border({ 'width': 2, 'color': '#6699FF' })
  }

  // RelativeContainer父组件为锚点，__container__代表父容器的ID。
  @Builder
  example1() {
    RelativeContainer() {
      Row() {
        Text('row1')
      }
      .justifyContent(FlexAlign.Center)
      .width(100)
      .height(100)
      .backgroundColor('#a3cf62')
      .alignRules({
        top: { anchor: '__container__', align: VerticalAlign.Top },
        left: { anchor: '__container__', align: HorizontalAlign.Start }
      })
      .id("row1")

      Row() {
        Text('row2')
      }
      .justifyContent(FlexAlign.Center)
      .width(100)
      .height(100)
      .backgroundColor('#00ae9d')
      .alignRules({
        'top': { anchor: '__container__', align: VerticalAlign.Top },
        'right': { anchor: '__container__', align: HorizontalAlign.End }
      })
      .id("row2")
    }.width(300).height(300)
    .margin({ left: 20, top: 50 })
    .border({ width: 2, color: '#6699FF' })
  }
}