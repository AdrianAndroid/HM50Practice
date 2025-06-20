// MyWorker.ts
import { worker, ThreadWorkerGlobalScope, MessageEvents, ErrorEvent } from '@kit.ArkTS';


let workerPort: ThreadWorkerGlobalScope = worker.workerPort;

// MyWorker.ts
// 定义训练模型及结果
let result: Array<number>;
// 定义预测函数
function predict(x: number): number {
  return result[x];
}
// 定义优化器训练过程
function optimize(): void {
  result = [0];
}
// Worker线程的onmessage逻辑
workerPort.onmessage = (e: MessageEvents): void => {
  // 根据传输的数据的type选择进行操作
  switch (e.data.type as number) {
    case 0:
      // 进行训练
      optimize();
      // 训练之后发送宿主线程训练成功的消息
      workerPort.postMessage({ type: 'message', value: 'train success.' });
      break;
    case 1:
      // 执行预测
      const output: number = predict(e.data.value as number);
      // 发送宿主线程预测的结果
      workerPort.postMessage({ type: 'predict', value: output });
      break;
    default:
      workerPort.postMessage({ type: 'message', value: 'send message is invalid' });
      break;
  }
}