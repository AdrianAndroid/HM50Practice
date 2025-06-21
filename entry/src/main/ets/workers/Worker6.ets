// Worker.ets
import { ErrorEvent, MessageEvents, ThreadWorkerGlobalScope, worker } from '@kit.ArkTS';
const workerPort: ThreadWorkerGlobalScope = worker.workerPort;
let isRunning = false;
workerPort.onmessage = (e: MessageEvents) => {
  const type = e.data.type as string;
  if (type === 'start') {
    if (!isRunning) {
      isRunning = true;
      // 开始常驻任务
      performTask();
    }
  } else if (type === 'stop') {
    isRunning = false;
    workerPort.close();  // 关闭Worker
  }
}
// 模拟常驻任务
function performTask() {
  if (isRunning) {
    // 模拟某个长期运行的任务
    workerPort.postMessage('Worker6 is performing a task');
    // 1秒后再次执行任务
    setTimeout(performTask, 1000);
  }
  workerPort.postMessage('Worker6 is stop performing a task');
}