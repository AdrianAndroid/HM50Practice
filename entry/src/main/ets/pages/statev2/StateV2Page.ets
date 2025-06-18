import { AppStorageV2 } from '@kit.ArkUI';
import Constants from '../../common/Constants';
import { Sample2 } from './Sample2';

@Entry
@ComponentV2
struct StateV2Page {
  @Local dataArr: Array<string> = []; // 数据源

  aboutToAppear(): void {
    for (let i = 0; i < 50; i++) {
      this.dataArr.push(`data_${i}`); // 为数组添加一些数据
    }
  }

  build() {
    Column() {
      List() {
        Repeat<string>(this.dataArr)
          .each((ri: RepeatItem<string>) => { // 默认模板
            ListItem() {
              Text('each_A_' + ri.item).fontSize(30).fontColor(Color.Red) // 文本颜色为红色
            }
          })
          .key((item: string, index: number): string => item) // 键值生成函数
          .virtualScroll({ totalCount: this.dataArr.length }) // 打开virtualScroll模式，totalCount为期望加载的数据长度
          .templateId((item: string, index: number): string => { // 根据返回值寻找对应的模板子组件进行渲染
            return index <= 4 ? 'A' : (index <= 10 ? 'B' : ''); // 前5个节点模板为A，接下来的5个为B，其余为默认模板
          })
          .template('A', (ri: RepeatItem<string>) => { // 'A'模板
            ListItem() {
              Text('ttype_A_' + ri.item).fontSize(30).fontColor(Color.Green) // 文本颜色为绿色
            }
          }, { cachedCount: 3 }) // 'A'模板的缓存列表容量为3
          .template('B', (ri: RepeatItem<string>) => { // 'B'模板
            ListItem() {
              Text('ttype_B_' + ri.item).fontSize(30).fontColor(Color.Blue) // 文本颜色为蓝色
            }
          }, { cachedCount: 4 }) // 'B'模板的缓存列表容量为4
      }
      .cachedCount(2) // 容器组件的预加载区域大小
      .height('70%')
      .width(Constants.FULL_PERCENT)
      .border({ width: 1 }) // 边框
    }
  }
}