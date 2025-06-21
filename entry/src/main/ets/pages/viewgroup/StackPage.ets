let MTop:Record<string,number> = { 'top': 50 }

@Entry
@Component
struct StackPage {
  @State message: string = 'Hello World';
  private scroller: Scroller = new Scroller();

  private arr: string[] = ['APP1', 'APP2', 'APP3', 'APP4', 'APP5', 'APP6', 'APP7', 'APP8'];


  build() {
    Scroll(this.scroller) {
      Column(){
        this.stackAllExample()
        this.zIndexExample()
        this.alignContentExample()
        this.stackExample()
      }
      .width('100%')
    }
    .scrollable(ScrollDirection.Vertical) // 滚动方向为垂直方向
    .scrollBar(BarState.On) // 滚动条常驻显示
    .scrollBarColor(Color.Gray) // 滚动条颜色
    .scrollBarWidth(10) // 滚动条宽度
    .edgeEffect(EdgeEffect.Spring) // 滚动到边沿后回
  }

  @Builder
  stackAllExample() {
    Stack({ alignContent: Alignment.Bottom }) {
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.arr, (item:string) => {
          Text(item)
            .width(100)
            .height(100)
            .fontSize(16)
            .margin(10)
            .textAlign(TextAlign.Center)
            .borderRadius(10)
            .backgroundColor(0xFFFFFF)
        }, (item:string):string => item)
      }.width('100%').height('100%')

      Flex({ justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
        Text('联系人').fontSize(16)
        Text('设置').fontSize(16)
        Text('短信').fontSize(16)
      }
      .width('50%')
      .height(50)
      .backgroundColor('#16302e2e')
      .margin({ bottom: 15 })
      .borderRadius(15)
    }.width('100%').height(500).backgroundColor('#CFD0CF')
  }

  @Builder
  zIndexExample() {
    Stack({ alignContent: Alignment.BottomStart }) {
      Column() {
        Text('Stack子元素1').textAlign(TextAlign.End).fontSize(20)
      }.width(100).height(100).backgroundColor(Color.Red).zIndex(2)

      Column() {
        Text('Stack子元素2').fontSize(20)
      }.width(150).height(150).backgroundColor(Color.Blue).zIndex(1)

      Column() {
        Text('Stack子元素3').fontSize(20)
      }.width(200).height(200).backgroundColor(Color.Green)
    }.width(350).height(350).backgroundColor(0xe0e0e0)
  }

  @Builder
  alignContentExample() {
    Stack({ alignContent: Alignment.TopStart }) {
      Text('Stack').width('90%').height('100%').backgroundColor('#e1dede').align(Alignment.BottomEnd)
      Text('Item 1').width('70%').height('80%').backgroundColor(0xd2cab3).align(Alignment.BottomEnd)
      Text('Item 2').width('50%').height('60%').backgroundColor(0xc1cbac).align(Alignment.BottomEnd)
    }.width('100%').height(150).margin({ top: 5 })
  }

  @Builder
  stackExample() {
    Stack({ }) {
      Column(){}.width('90%').height('100%').backgroundColor('#ff58b87c')
      Text('text').width('60%').height('60%').backgroundColor('#ffc3f6aa')
      Button('button').width('30%').height('30%').backgroundColor('#ff8ff3eb').fontColor('#000')
    }.width('100%').height(150).margin(MTop)
  }
}