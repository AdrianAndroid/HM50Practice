import { IconItemSource } from './IconItemSource';
import { taskpool } from '@kit.ArkTS';

// TaskSendDataUsage.ets
export function notice(data: number): void {
  console.info("子线程任务已执行完，共加载图片: ", data);
}

// 通过Task的sendData方法，即时通知宿主线程信息
@Concurrent
export function loadPictureSendData(count: number): IconItemSource[] {
  let iconItemSourceList: IconItemSource[] = [];
  // 遍历添加6*count个IconItem的数据
  for (let index = 0; index < count; index++) {
    const numStart: number = index * 6;
    // 此处循环使用6张图片资源
    iconItemSourceList.push(new IconItemSource('$media:startIcon', `item${numStart + 1}`));
    iconItemSourceList.push(new IconItemSource('$media:background', `item${numStart + 2}`));
    iconItemSourceList.push(new IconItemSource('$media:foreground', `item${numStart + 3}`));
    iconItemSourceList.push(new IconItemSource('$media:startIcon', `item${numStart + 4}`));
    iconItemSourceList.push(new IconItemSource('$media:background', `item${numStart + 5}`));
    iconItemSourceList.push(new IconItemSource('$media:foreground', `item${numStart + 6}`));

    taskpool.Task.sendData(iconItemSourceList.length);
  }
  return iconItemSourceList;
}

@Entry
@Component
struct Com3Page {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            let iconItemSourceList: IconItemSource[];
            let lodePictureTask: taskpool.Task = new taskpool.Task(loadPictureSendData, 30);
            // 设置notice方法接收Task发送的消息
            lodePictureTask.onReceiveData(notice);
            taskpool.execute(lodePictureTask).then((res: object) => {
              iconItemSourceList = res as IconItemSource[];
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}