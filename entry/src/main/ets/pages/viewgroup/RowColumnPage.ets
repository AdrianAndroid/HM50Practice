import Constants from '../../common/Constants';

@Entry
@Component
struct RowColumnPage {
  @State message: string = 'Hello World';
  scroller: Scroller = new Scroller();
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  build() {
    // this.normalViewGroup()
    // this.layoutWeightExample()
    Column() {
      //this.widthExample()
      // this.scrollExample()
      this.horizontalScrollExample()
    }.width(Constants.FULL_PERCENT).height(Constants.FULL_PERCENT).backgroundColor(Color.Gray)
  }

  @Builder
  horizontalScrollExample() {
    Scroll(this.scroller) {
      Row() {
        ForEach(this.arr, (item?:number|undefined) => {
          if(item){
            Text(item.toString())
              .height('90%')
              .width(150)
              .backgroundColor(0xFFFFFF)
              .borderRadius(15)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .margin({ left: 10 })
          }
        })
      }.height('100%')
    }
    .backgroundColor(0xDCDCDC)
    .scrollable(ScrollDirection.Horizontal) // 滚动方向为水平方向
    .scrollBar(BarState.On) // 滚动条常驻显示
    .scrollBarColor(Color.Gray) // 滚动条颜色
    .scrollBarWidth(10) // 滚动条宽度
    .edgeEffect(EdgeEffect.Spring) // 滚动到边沿后回弹
  }

  @Builder
  verticalScrollExample() {
    Scroll(this.scroller) {
      Column() {
        ForEach(this.arr, (item?: number | undefined) => {
          if (item) {
            Text(item.toString())
              .width('90%')
              .height(150)
              .backgroundColor(0xFFFFFF)
              .borderRadius(15)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
          }
        }, (item: number) => item.toString())
      }.width('100%')
    }
    .backgroundColor(Color.Red)
    .scrollable(ScrollDirection.Vertical) // 滚动方向为垂直方向
    .scrollBar(BarState.On) // 滚动条常驻显示
    .scrollBarColor(Color.Gray) // 滚动条颜色
    .scrollBarWidth(10) // 滚动条宽度
    .edgeEffect(EdgeEffect.Spring) // 滚动到边沿后回弹
  }

  @Builder
  normalViewGroup() {
    // Column({ space: 20 }) {
    //   Text('space: 20').fontSize(15).fontColor(Color.Gray).width('90%')
    //   Row().width('90%').height(50).backgroundColor(0xF5DEB3)
    //   Row().width('90%').height(50).backgroundColor(0xD2B48C)
    //   Row().width('90%').height(50).backgroundColor(0xF5DEB3)
    // }.width('100%')
    // .height('100%')

    // Row({ space: 35 }) {
    //   Text('space: 35').fontSize(15).fontColor(Color.Gray)
    //   Row().width('10%').height(150).backgroundColor(0xF5DEB3)
    //   Row().width('10%').height(150).backgroundColor(0xD2B48C)
    //   Row().width('10%').height(150).backgroundColor(0xF5DEB3)
    // }.width('90%')

    // Column({}) {
    //   Column() {}.width('80%').height(50).backgroundColor(0xF5DEB3)
    //   Column() {}.width('80%').height(50).backgroundColor(0xD2B48C)
    //   Column() {}.width('80%').height(50).backgroundColor(0xF5DEB3)
    // }.width('100%').alignItems(HorizontalAlign.End).backgroundColor('rgb(242,242,242)')

    // Row({}) {
    //   Column() {}.width('20%').height(30).backgroundColor(0xF5DEB3)
    //   Column() {}.width('20%').height(30).backgroundColor(0xD2B48C)
    //   Column() {}.width('20%').height(30).backgroundColor(0xF5DEB3)
    // }.width('100%').height(200).alignItems(VerticalAlign.Bottom).backgroundColor('rgb(242,242,242)')

    // Column({}) {
    //   Column() {}.width('80%').height(50).backgroundColor(0xF5DEB3)
    //   Column() {}.width('80%').height(50).backgroundColor(0xD2B48C)
    //   Column() {}.width('80%').height(50).backgroundColor(0xF5DEB3)
    // }.width('100%').height(300).backgroundColor('rgb(242,242,242)').justifyContent(FlexAlign.SpaceEvenly)

    // Row({}) {
    //   Column() {}.width('20%').height(30).backgroundColor(0xF5DEB3)
    //   Column() {}.width('20%').height(30).backgroundColor(0xD2B48C)
    //   Column() {}.width('20%').height(30).backgroundColor(0xF5DEB3)
    // }.width('100%').height(200).backgroundColor('rgb(242,242,242)').justifyContent(FlexAlign.SpaceEvenly)

    // Column() {
    //   Row() {
    //     Text('Bluetooth').fontSize(18)
    //     Blank()
    //     Toggle({ type: ToggleType.Switch, isOn: true })
    //   }.backgroundColor(0xFFFFFF).borderRadius(15).padding({ left: 12 }).width('100%')
    // }.backgroundColor(0xEFEFEF).padding(20).width('100%')
  }

  @Builder
  widthExample() {
    Column() {
      Row() {
        Column() {
          Text('left width 20%')
            .textAlign(TextAlign.Center)
        }.width('20%').backgroundColor(0xF5DEB3).height('100%')

        Column() {
          Text('center width 50%')
            .textAlign(TextAlign.Center)
        }.width('50%').backgroundColor(0xD2B48C).height('100%')

        Column() {
          Text('right width 30%')
            .textAlign(TextAlign.Center)
        }.width('30%').backgroundColor(0xF5DEB3).height('100%')
      }.backgroundColor(0xffd306).height('30%')
    }
  }

  @Builder
  layoutWeightExample() {
    Column() {
      Text('1:2:3').width('100%')
      Row() {
        Column() {
          Text('layoutWeight(1)').textAlign(TextAlign.Center)
        }.layoutWeight(1).backgroundColor(0xF5DEB3).height('100%')

        Column() {
          Text('layoutWeight(2)').textAlign(TextAlign.Center)
        }.layoutWeight(2).backgroundColor(0xD2B48C).height('100%')

        Column() {
          Text('layoutWeight(3)').textAlign(TextAlign.Center)
        }.layoutWeight(3).backgroundColor(0xF5DEB3).height('100%')

      }.backgroundColor(0xffd306).height('30%')

      Text('2:5:3').width('100%')
      Row() {
        Column() {
          Text('layoutWeight(2)').textAlign(TextAlign.Center)
        }.layoutWeight(2).backgroundColor(0xF5DEB3).height('100%')

        Column() {
          Text('layoutWeight(5)').textAlign(TextAlign.Center)
        }.layoutWeight(5).backgroundColor(0xD2B48C).height('100%')

        Column() {
          Text('layoutWeight(3)').textAlign(TextAlign.Center)
        }.layoutWeight(3).backgroundColor(0xF5DEB3).height('100%')
      }.backgroundColor(0xffd306).height('30%')
    }
  }
}