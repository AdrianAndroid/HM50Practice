
// Worker.ets
import { ErrorEvent, MessageEvents, ThreadWorkerGlobalScope, worker } from '@kit.ArkTS';
const workerPort: ThreadWorkerGlobalScope = worker.workerPort;
try {
  // 调用方法无入参
  let res: string = workerPort.callGlobalCallObjectMethod("picData", "setUp", 0) as string;
  console.error("worker: ", res);
} catch (error) {
  // 异常处理
  console.error("worker: error code is " + error.code + " error message is " + error.message);
}