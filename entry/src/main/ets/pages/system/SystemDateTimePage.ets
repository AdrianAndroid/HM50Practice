import { BusinessError, systemDateTime } from '@kit.BasicServicesKit'

@Builder
export function PageBuilder(name: string, param: Object) {
  SystemDateTimePage()
}

@ComponentV2
struct SystemDateTimePage {
  build() {
    NavDestination() {
      Column() {
        Button('响应').onClick(() => {
          this.test()
        })
      }
    }
  }
  async test () {
    try {
      let time = systemDateTime.getTime(true)
      console.info(`Succeeded in get time : ${time}`);
    } catch(e) {
      let error = e as BusinessError;
      console.error(`Failed to get time. message: ${error.message}, code: ${error.code}`);
    }

    try {
      let time = systemDateTime.getUptime(systemDateTime.TimeType.ACTIVE, false);
      console.info(`Succeeded in get time : ${time}`);
    } catch(e) {
      let error = e as BusinessError;
      console.error(`Failed to get uptime. message: ${error.message}, code: ${error.code}`);
    }

    try {
      const p = await new Promise<string>((resolve, reject) => {
        // 异步代码放在这里
        systemDateTime.getTimezone((error: BusinessError, data: string) => {
          if (error) {
            console.error(`Failed to get timezone. message: ${error.message}, code: ${error.code}`);
            reject(error)
          } else {
            console.info(`Succeeded in get timezone : ${data}`);
            resolve(data)
          }
        });
      });
      console.info(`Succeeded in get timezone : ${p}`);
    } catch(e) {
      let error = e as BusinessError;
      console.error(`Failed to get timezone. message: ${error.message}, code: ${error.code}`);
    }

    try {
      systemDateTime.getTimezone().then((data: string) => {
        console.info(`Succeeded in getting timezone: ${data}`);
      }).catch((error: BusinessError) => {
        console.error(`Failed to get timezone. message: ${error.message}, code: ${error.code}`);
      });
    } catch(e) {
      let error = e as BusinessError;
      console.error(`Failed to get timezone. message: ${error.message}, code: ${error.code}`);
    }

    try {
      let timezone = systemDateTime.getTimezoneSync();
      console.info(`Succeeded in get time : ${timezone}`);
    } catch(e) {
      let error = e as BusinessError;
      console.error(`Failed to get timezone. message: ${error.message}, code: ${error.code}`);
    }
  }
}