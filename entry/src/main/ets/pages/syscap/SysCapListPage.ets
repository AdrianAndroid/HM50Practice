import { bufferToString } from "../../util/BufferUtil";
import { BusinessError } from "@kit.BasicServicesKit";
import { promptAction } from "@kit.ArkUI";

// ListDataSource.ets
export class TimeTableDataSource implements IDataSource {
  private list: TimeTable[] = [];
  private listeners: DataChangeListener[] = [];

  constructor(list: TimeTable[]) {
    this.list = list;
  }

  getAllData(): TimeTable[] {
    return this.list
  }

  totalCount(): number {
    return this.list.length;
  }

  getData(index: number): TimeTable {
    return this.list[index];
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (!this.listeners.includes(listener)) {
      this.listeners.push(listener)
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  // 通知控制器数据变化
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    });
  }

  // 修改第一个元素
  public change1stItem(temp: TimeTable): void {
    this.list[0] = temp;
    this.notifyDataChange(0);
  }
}

export class ProjectsDataSource implements IDataSource {
  private list: string[] = [];
  private listeners: DataChangeListener[] = [];


  constructor(list: string[]) {
    this.list = list;
  }

  totalCount(): number {
    return this.list.length;
  }

  getData(index: number): string {
    return this.list[index];
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if(!this.listeners.includes(listener)) {
      this.listeners.push(listener)
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const index = this.listeners.indexOf(listener);
    if (index !== -1) {
      this.listeners.splice(index, 1);
    }
  }
}


class  TimeTable {
  title: string = ''
  key: string = ''
  isCanIUse: boolean = false
  isExpand: boolean = false
  values: string[] = []

  constructor(title: string, key: string, values: string[]) {
    this.title = title
    this.key = key
    this.values = values
  }

  setCanIUse(canIUse: boolean) {
    this.isCanIUse = canIUse
  }
}

@Entry
@Component
struct SysCapListPage {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  @State itemGroupArray: TimeTableDataSource = new TimeTableDataSource([]);
  private canUseSysCap: string[] = []

  aboutToAppear(): void {
    this.getSysCapsFromJSON()
  }

  // async aboutToAppear(): Promise<void> {
  //   //this.getSysCapsFromJSON()
  //   let value = await getContext(this).resourceManager.getRawFileContent('syscaps.json')
  //   let timeTable = JSON.parse(bufferToString(value)) as TimeTable[];
  //
  //   this.itemGroupArray = new TimeTableDataSource(timeTable);
  // }

  getSysCapsFromJSON() {
    getContext(this).resourceManager.getRawFileContent('syscaps.json')
      .then(value => {
        let timeTable = JSON.parse(bufferToString(value)) as TimeTable[];
        for (let i = 0; i < timeTable.length; i++) {
          timeTable[i].values.forEach((value: string, index, array) => {
            if (canIUse(value)) {
              this.canUseSysCap.push(value)
            }
          })
        }
        this.itemGroupArray = new TimeTableDataSource(timeTable);
      })
      .catch((e: BusinessError) => {
        promptAction.showToast({message: JSON.stringify(e)})
        console.log(JSON.stringify(e));
      })
  }

  @Builder
  itemHead(text: string) {
    Text(text)
      .fontSize(20)
      .backgroundColor(0xAABBCC)
      .width('100%')
      .padding(10)
  }

  @Builder
  itemFoot(num: number) {
    Text('共' + num + '节课')
      .fontSize(16)
      .backgroundColor(0xAABBCC)
      .width('100%')
      .padding(5)
  }

  build() {
    Column() {
      List({ space: 20 }) {
        ListItem() {
          Text('系统能力SystemCapability列表')
            .width('100%')
            .height(100)
            .fontSize(20)
            .textAlign(TextAlign.Center)
            .backgroundColor(0xFFFFFF)
        }

        ForEach(this.itemGroupArray.getAllData(), (item: TimeTable, index) => {
          ListItemGroup({ header: this.itemHead(item.title), footer: this.itemFoot(item.values.length) }) {
            LazyForEach(new ProjectsDataSource(item.values), (ab: string) => {
              ListItem() {
                Row() {
                  Checkbox()
                    .select(this.canUseSysCap.includes(ab))
                    .enabled(false)
                  Text(ab)
                    .width('100%')
                    .fontSize(11)
                    .textAlign(TextAlign.Center)
                    .backgroundColor(0xFFFFFF)
                }
              }
            }, (item: string) => item)
          }
          .divider({ strokeWidth: 1, color: Color.Blue }) // 每行之间的分界线
        })

        // LazyForEach(this.itemGroupArray, (item: TimeTable) => {
        //   ListItemGroup({ header: this.itemHead(item.title), footer: this.itemFoot(item.values.length) }) {
        //     LazyForEach(new ProjectsDataSource(item.values), (project: string) => {
        //       ListItem() {
        //         Text(project)
        //           .width('100%')
        //           .height(100)
        //           .fontSize(20)
        //           .textAlign(TextAlign.Center)
        //           .backgroundColor(0xFFFFFF)
        //       }
        //     }, (item: string) => item)
        //   }
        //   .divider({ strokeWidth: 1, color: Color.Blue }) // 每行之间的分界线
        // })
      }
      .width('100%')
      .height('100%')
      .sticky(StickyStyle.Header | StickyStyle.Footer)
      .scrollBar(BarState.Off)
    }
    .width('100%').height('100%').backgroundColor(0xDCDCDC).padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
  }
}