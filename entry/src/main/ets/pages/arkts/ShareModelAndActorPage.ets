import runningLock from '@ohos.runningLock';
import { ArkTSUtils, Queue, taskpool } from '@kit.ArkTS';

@Entry
@Component
struct ShareModelAndActorPage {

  build() {
    Column({space: 10}) {
      Text('内存共享模型')
        .onClick(() => {
          this.testShareModel();
        })
      Text('Actor模型')
        .onClick(() => {
          this.testActor();
        })
      Text('生产者消费者模型')
        .onClick(() => {
          this.testProducerConsumer();
        })
    }
    .height('100%')
    .width('100%')
  }
  private bufferQueue: SyncQueue<number> = new SyncQueue<number>();

  // 生产者消费者模型
  testProducerConsumer() {
    const produceTask = new taskpool.Task(produceSync);
    const consumer = new Consumer<number>();
    for (let i = 0; i < 10; i++) {
      taskpool.execute(produceTask).then((resObj: Object) => {
        let res = resObj as number
        this.bufferQueue.offer(res)
        consumer.consume(res)
      }).catch((e: Error) => {
        console.error(e.message)
      }).finally(() => {
        console.log('finally');
      })
    }
  }

  // 内存共享模型
  testShareModel() {
    let consumer: ConsumerTest1 = new ConsumerTest1();
    let producer: Producer1 = new Producer1();
    let threadNum: number = 10;
    for (let i = 0; i < threadNum; i++) {

    }
  }

  // Actor模型
  testActor() {
    let produceTask: taskpool.Task = new taskpool.Task(produce)
    let consumer: Consumer<number> = new Consumer();
    for (let index: number = 0; index < 10; index++) {
      // 执行生产异步并发任务
      taskpool.execute(produceTask).then((res: Object) => {
        consumer.consume(res as number);
      }).catch((e: Error) => {
        console.error(e.message);
      }).finally(() => {
        console.log('finally');
      })
    }
  }
}

class BufferQueue1 {
  queue: Queue<number> = new Queue<number>();
  lock: ArkTSUtils.locks.AsyncLock = new ArkTSUtils.locks.AsyncLock()

  add(value: number) {
    this.lock.lockAsync(() => {
      this.queue.add(value);
    })
  }

  takeFirst(): Promise<number> {
    return this.lock.lockAsync<number>(() => {
      return this.queue.length === 0 ? 1 : this.queue.getFirst();
    })
  }

  take(): Promise<number> {
    return this.lock.lockAsync<number>(() => {
      return this.queue.length === 0 ? 1 : this.queue.pop()
    })
  }
}

// 构造一段全局共享的内存
let g_bufferQueue = new BufferQueue1();

class Producer1 {
  run() {
    let value = Math.random();
    // 跨线程访问bufferQueue对象
    g_bufferQueue.add(value);
  }
}

class ConsumerTest1 {
  run() {
    // 跨线程访问bufferQueue对象
    let num = 123;
    let res = g_bufferQueue.take();
    if (res != null) {
      // 添加消费逻辑
    }
  }
}

// 跨线程并发任务
@Concurrent
async function produce(): Promise<number> {
  // 添加生产相关逻辑
  console.info('producing...');
  return Math.random();
}

class Consumer<T> {
  public consume(value: T) {
    // 添加消费相关逻辑
    console.info('consuming value: ' + value);
  }
}


////////////////////////////////////////////////////////////////////
// 生产者消费者模型
////////////////////////////////////////////////////////////////////
async function produceSync(): Promise<number> {
  console.info('producing....');
  return Math.random();
}

class ConsumerSync {
  public consume(value: object) {
    console.info('consuming value: ' + value);
  }
}

class SyncQueue<T> {
  private queue: T[] = [];
  private lock = new ArkTSUtils.locks.AsyncLock(); // 使用官方AsyncLock

  // 生产者写入队列（需异步加锁）
  async offer(value: T): Promise<void> {
    await this.lock.lockAsync(() => {
      this.queue.push(value);
    });
  }

  // 消费者读取队列（需异步加锁）
  async poll(): Promise<T | undefined> {
    return await this.lock.lockAsync(() => {
      return this.queue.shift();
    });
  }
}
