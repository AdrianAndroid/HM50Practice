import { common, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct Page_UIAbilityComponentsBasicUsage {
  @State message: string = 'Hello World';

  startAbilityTest(): void {
    let context = getContext(this) as common.UIAbilityContext;
    let want: Want = {
      // Want参数信息
    };
    context.startAbility(want);
  }

  build() {
    Button('FuncAbilityB')
      .onClick(() => {
        let context = getContext(this) as common.UIAbilityContext
        try {
          context.terminateSelf((err: BusinessError) => {
            if (err.code) {
              // 处理业务逻辑错误
              console.error(`terminateSelf failed, code is ${err.code}, message is ${err.message}`);
              return;
            }
            // 执行正常业务
            console.info('terminateSelf succeed');
          })
        } catch (err) {
          // 捕获同步的参数错误
          let code = (err as BusinessError).code
          let message = (err as BusinessError).message
          console.error(`terminateSelf failed, code is ${code}, message is ${message}`);
        }
      })
  }
}