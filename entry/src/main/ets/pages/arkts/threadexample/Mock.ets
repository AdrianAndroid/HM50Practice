// Mock.ets
import { taskpool } from '@kit.ArkTS';
import { fillImg } from './WaterFlowTaskPoolPage';


@Concurrent
function query() {
  console.info("TaskPoolTest-this is query");
  let result = new Array<string>(33);
  for (let i = 0; i < 33; i++) {
    result[i] = 'Image' + i;
  }
  taskpool.Task.sendData(result);
}




export function getImgFromDB() {
  //此处模拟查询数据库，并返回数据
  let task = new taskpool.Task(query);
  task.onReceiveData(fillImg);
  taskpool.execute(task);
}