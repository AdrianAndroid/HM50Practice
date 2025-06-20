  @Sendable
  type SendableFuncType = () => void;


  @Sendable
  class TopLevelSendableClass {
    num: number = 1;

    PrintNum() {
      console.info("Top level sendable class");
    }
  }


  @Sendable
  function TopLevelSendableFunction() {
    console.info("Top level sendable function");
  }


  @Sendable
  function SendableTestFunction() {
    const topClass = new TopLevelSendableClass(); // 顶层sendable class
    topClass.PrintNum();
    TopLevelSendableFunction(); // 顶层sendable function
    console.info("Sendable test function");
  }


  @Sendable
  class SendableTestClass {
    callback: SendableFuncType; // 顶层sendable function

    constructor(func: SendableFuncType) {
      this.callback = func;
    }

    CallSendableFunc() {
      SendableTestFunction(); // 顶层sendable function
    }
  }

  @Sendable
  class SendableTestClass1 {
    desc: string = "sendable: this is SendableTestClass ";
    num: number = 5;

    get getNum(): number {
      return this.num;
    }

    printName() {
      console.info("sendable: SendableTestClass desc is: " + this.desc);
    }
  }


  let sendableClass = new SendableTestClass(SendableTestFunction);
  sendableClass.callback();
  sendableClass.CallSendableFunc();