import { ErrorEvent, MessageEvents, ThreadWorkerGlobalScope, worker } from '@kit.ArkTS';
import { GlobalConfig } from '../pages/arkts/sendable/SendableObjectFreezePage';

const workerPort: ThreadWorkerGlobalScope = worker.workerPort;
workerPort.onmessage = (e: MessageEvents) => {
  let gConfig: GlobalConfig = e.data;
  // 使用gConfig对象
  console.log(`workerPort.onmessage = ${gConfig} e=${e}`);
}