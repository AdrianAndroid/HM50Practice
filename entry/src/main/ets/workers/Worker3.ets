import { ErrorEvent, MessageEvents, ThreadWorkerGlobalScope, worker } from '@kit.ArkTS';

const workerPort: ThreadWorkerGlobalScope = worker.workerPort;
// Worker接收宿主线程的消息，做相应的处理
workerPort.onmessage = (e: MessageEvents): void => {
  if (e.data === 'hello world') {
    workerPort.postMessage('success');
  }
}