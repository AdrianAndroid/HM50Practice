// WorkerCallGlobalUsage.ets
import worker from '@ohos.worker';
import { IconItemSource } from './IconItemSource';


// 创建Worker对象
const workerInstance: worker.ThreadWorker = new worker.ThreadWorker("entry/ets/pages/workers/Worker1.ts");


class PicData {
  public iconItemSourceList: IconItemSource[] = [];


  public setUp(): string {
    for (let index = 0; index < 20; index++) {
      const numStart: number = index * 6;
      // 此处循环使用6张图片资源
      this.iconItemSourceList.push(new IconItemSource('$media:startIcon', `item${numStart + 1}`));
      this.iconItemSourceList.push(new IconItemSource('$media:background', `item${numStart + 2}`));
      this.iconItemSourceList.push(new IconItemSource('$media:foreground', `item${numStart + 3}`));
      this.iconItemSourceList.push(new IconItemSource('$media:startIcon', `item${numStart + 4}`));
      this.iconItemSourceList.push(new IconItemSource('$media:background', `item${numStart + 5}`));
      this.iconItemSourceList.push(new IconItemSource('$media:foreground', `item${numStart + 6}`));


    }
    return "setUpIconItemSourceList success!";
  }
}


let picData = new PicData();
// 在Worker上注册需要调用的对象
workerInstance.registerGlobalCallObject("picData", picData);
workerInstance.postMessage("run setUp in picData");