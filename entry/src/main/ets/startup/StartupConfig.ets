import { StartupConfig, StartupConfigEntry, StartupListener } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import Logger from '../common/Logger';
import Constants from '../common/Constants';


export default class MyStartupConfigEntry extends StartupConfigEntry {
  onConfig() {
    Logger.debug(Constants.TAG_STARTUP_TASK, `onConfig`);
    let onCompletedCallback = (error: BusinessError<void>) => {
      Logger.debug(Constants.TAG_STARTUP_TASK,`onCompletedCallback`);
      if (error) {
        Logger.debug(Constants.TAG_STARTUP_TASK,`onCompletedCallback: ${error.code}, message: ${error.message}`);
      } else {
        Logger.debug(Constants.TAG_STARTUP_TASK, `onCompletedCallback: success.`);
      }
    };
    let startupListener: StartupListener = {
      'onCompleted': onCompletedCallback
    };
    let config: StartupConfig = {
      'timeoutMs': 10000,
      'startupListener': startupListener
    };
    return config;
  }
}