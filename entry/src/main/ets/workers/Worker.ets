// import { ErrorEvent, MessageEvents, ThreadWorkerGlobalScope, worker } from '@kit.ArkTS';
//
// const workerPort: ThreadWorkerGlobalScope = worker.workerPort;
//
// /**
//  * Defines the event handler to be called when the worker thread receives a message sent by the host thread.
//  * The event handler is executed in the worker thread.
//  *
//  * @param event message data
//  */
// workerPort.onmessage = (event: MessageEvents) => {
// };
//
// /**
//  * Defines the event handler to be called when the worker receives a message that cannot be deserialized.
//  * The event handler is executed in the worker thread.
//  *
//  * @param event message data
//  */
// workerPort.onmessageerror = (event: MessageEvents) => {
// };
//
// /**
//  * Defines the event handler to be called when an exception occurs during worker execution.
//  * The event handler is executed in the worker thread.
//  *
//  * @param event error message
//  */
// workerPort.onerror = (event: ErrorEvent) => {
// };

// worker.ets
import { ErrorEvent, MessageEvents, ThreadWorkerGlobalScope, worker } from '@kit.ArkTS';

const workerPort: ThreadWorkerGlobalScope = worker.workerPort;

// 注册onmessage回调，当Worker线程收到来自其宿主线程通过postMessage接口发送的消息时被调用，在Worker线程执行
workerPort.onmessage = (e: MessageEvents) => {
  let data: string = e.data;
  console.info('Worker111 workerPort onmessage is: ', data);

  // 向主线程发送消息
  workerPort.postMessage('Worker111 2');
}

// 注册onmessageerror回调，当Worker对象接收到一条无法被序列化的消息时被调用，在Worker线程执行
workerPort.onmessageerror = () => {
  console.info('Worker111 workerPort onmessageerror');
}

// 注册onerror回调，当Worker在执行过程中发生异常被调用，在Worker线程执行
workerPort.onerror = (err: ErrorEvent) => {
  console.info('Worker111 workerPort onerror err is: ', err.message);
}