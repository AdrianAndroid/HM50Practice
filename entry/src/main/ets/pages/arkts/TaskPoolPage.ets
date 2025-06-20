import { taskpool } from '@kit.ArkTS';
import { MyTestA, MyTestB, testAdd } from './Test';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct TaskPoolPage {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column({ space: 5 }) {
        Blank().height(100)
        Button('并发函数一般使用')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            ConcurrentFunc();
          })
        Button('并发函数返回Promise')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            testConcurrentFunc();
          })
        Button('并发函数中使用自定义类或函数')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            let task = new taskpool.Task(TestFunc);
            taskpool.execute(task).then(() => {
              console.info("taskpool: execute task success!");
            }).catch((e: BusinessError) => {
              console.error(`taskpool: execute: Code: ${e.code}, message: ${e.message}`);
            })
          })
        Button('并发异步函数中使用Promise')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            testConcurrentFunc2();
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}

// 并发函数一般使用

@Concurrent
function add(num1: number, num2: number): number {
  return num1 + num2
}

async function ConcurrentFunc(): Promise<void> {
  try {
    let task: taskpool.Task = new taskpool.Task(add, 1, 2)
    console.info("TaskPoolPage1111 taskpool res is: " + await taskpool.execute(task))
  } catch (e) {
    console.error("TaskPoolPage1111 taskpool execute error is : " + e)
  }
}

// 并发函数返回Promise
@Concurrent
function testPromise(args1: number, args2: number): Promise<number> {
  return new Promise<number>((testFuncA, testFuncB) => {
    testFuncA(args1 + args2);
  });
}

@Concurrent
async function testPromise1(args1: number, args2: number): Promise<number> {
  return new Promise<number>((testFuncA, testFuncB) => {
    testFuncA(args1 + args2);
  });
}

@Concurrent
async function testPromise2(args1: number, args2: number): Promise<number> {
  return await new Promise<number>((testFuncA, testFuncB) => {
    testFuncA(args1 + args2);
  });
}

@Concurrent
function testPromise3() {
  return Promise.resolve(1);
}

@Concurrent
async function testPromise4(): Promise<number> {
  return 1;
}

@Concurrent
async function testPromise5(): Promise<string> {
  return await new Promise((resolve) => {
    setTimeout(() => {
      resolve("Promise setTimeout after resolve");
    }, 1000)
  });
}

async function testConcurrentFunc() {
  let task1: taskpool.Task = new taskpool.Task(testPromise, 1, 2);
  let task2: taskpool.Task = new taskpool.Task(testPromise1, 1, 2);
  let task3: taskpool.Task = new taskpool.Task(testPromise2, 1, 2);
  let task4: taskpool.Task = new taskpool.Task(testPromise3);
  let task5: taskpool.Task = new taskpool.Task(testPromise4);
  let task6: taskpool.Task = new taskpool.Task(testPromise5);

  taskpool.execute(task1).then((d: object) => {
    console.info("TaskPoolPage1111 task1 res is: " + d);
  }).catch((e: object) => {
    console.info("TaskPoolPage1111 task1 catch e: " + e);
  })
  taskpool.execute(task2).then((d: object) => {
    console.info("TaskPoolPage1111 task2 res is: " + d);
  }).catch((e: object) => {
    console.info("TaskPoolPage1111 task2 catch e: " + e);
  })
  taskpool.execute(task3).then((d: object) => {
    console.info("TaskPoolPage1111 task3 res is: " + d);
  }).catch((e: object) => {
    console.info("TaskPoolPage1111 task3 catch e: " + e);
  })
  taskpool.execute(task4).then((d: object) => {
    console.info("TaskPoolPage1111 task4 res is: " + d);
  }).catch((e: object) => {
    console.info("TaskPoolPage1111 task4 catch e: " + e);
  })
  taskpool.execute(task5).then((d: object) => {
    console.info("TaskPoolPage1111 task5 res is: " + d);
  }).catch((e: object) => {
    console.info("TaskPoolPage1111 task5 catch e: " + e);
  })
  taskpool.execute(task6).then((d: object) => {
    console.info("TaskPoolPage1111 task6 res is: " + d);
  }).catch((e: object) => {
    console.info("TaskPoolPage1111 task6 catch e: " + e);
  })
}

// 并发函数中使用自定义类或函数
function add2(arg: number) {
  return ++arg;
}

class TestA {
  constructor(name: string) {
    this.name = name;
  }

  name: string = 'ClassA';
}

class TestB {
  static nameStr: string = 'ClassB';
}

@Concurrent
function TestFunc() {
  // case1：在并发函数中直接调用同文件内定义的类或函数

  // 直接调用同文件定义的函数add()，add飘红报错：Only imported variables and local variables can be used in @Concurrent decorated functions. <ArkTSCheck>
  // add2(1);
  // 直接使用同文件定义的TestA构造，TestA飘红报错：Only imported variables and local variables can be used in @Concurrent decorated functions. <ArkTSCheck>
  // let a = new TestA("aaa");
  // 直接访问同文件定义的TestB的成员nameStr，TestB飘红报错：Only imported variables and local variables can be used in @Concurrent decorated functions. <ArkTSCheck>
  // console.info("TestB name is: " + TestB.nameStr);

  // case2：在并发函数中调用定义在Test.ets文件并导入当前文件的类或函数

  // 输出结果：res1 is: 2
  console.info("res1 is: " + testAdd(1));
  let tmpStr = new MyTestA("TEST A");
  // 输出结果：res2 is: TEST A
  console.info("res2 is: " + tmpStr.name);
  // 输出结果：res3 is: MyTestB
  console.info("res3 is: " + MyTestB.nameStr);
}


// 并发异步函数中使用Promise
@Concurrent
async function testPromiseError() {
  await new Promise<number>((resolve, reject) => {
    resolve(1);
  }).then(()=>{
    throw new Error("testPromise Error");
  })
}

@Concurrent
async function testPromiseError1() {
  await new Promise<string>((resolve, reject) => {
    reject("testPromiseError1 Error msg");
  })
}

@Concurrent
function testPromiseError2() {
  return new Promise<string>((resolve, reject) => {
    reject("testPromiseError2 Error msg");
  })
}

async function testConcurrentFunc2() {
  let task1: taskpool.Task = new taskpool.Task(testPromiseError);
  let task2: taskpool.Task = new taskpool.Task(testPromiseError1);
  let task3: taskpool.Task = new taskpool.Task(testPromiseError2);

  taskpool.execute(task1).then((d:object)=>{
    console.info("TaskPoolPage1111 task1 res is: " + d);
  }).catch((e:object)=>{
    console.info("TaskPoolPage1111 task1 catch e: " + e);
  })
  taskpool.execute(task2).then((d:object)=>{
    console.info("TaskPoolPage1111 task2 res is: " + d);
  }).catch((e:object)=>{
    console.info("TaskPoolPage1111 task2 catch e: " + e);
  })
  taskpool.execute(task3).then((d:object)=>{
    console.info("TaskPoolPage1111 task3 res is: " + d);
  }).catch((e:object)=>{
    console.info("TaskPoolPage1111 task3 catch e: " + e);
  })
}