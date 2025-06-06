import Logger from '../common/util/Logger';
import { JSON } from '@kit.ArkTS';

@Entry
@Component
struct Parent {
  @State simpleList: Array<string> = ['one', 'two', 'three'];


  build() {
    Column() {
      Button() {
        Text('在第1项后插入新项').fontSize(30)
      }
      .onClick(() => {
        this.simpleList.splice(1, 0, 'new item');
        Logger.info('Parent', `${JSON.stringify(this.simpleList)}`)
      })


      ForEach(this.simpleList, (item: string) => {
        ChildItem({ item: item })
      }, (item: string, index: number) => index.toString())
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
    .backgroundColor(0xF1F3F5)
  }
}


@Component
struct ChildItem {
  @Prop item: string;


  build() {
    Text(this.item)
      .fontSize(30)
  }
}