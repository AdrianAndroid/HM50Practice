import {
  AbilityConstant,
  AbilityLifecycleCallback,
  Configuration,
  contextConstant,
  startupManager,
  UIAbility,
  Want
} from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import Constants from '../common/Constants';
import ConnectionUtils from '../common/network/ConnectionUtils';
import RDBStoreUtil from '../common/database/RDBStoreUtil';
import preferenceUtilsObject from '../common/database/PreferencesUtil';
import { BusinessError } from '@kit.BasicServicesKit';
import Logger from '../common/Logger';

const TAG: string = '[EntryAbility]';
const DOMAIN_NUMBER: number = 0xFF00;

let systemLanguage: string | undefined; // 系统当前语言

export default class EntryAbility extends UIAbility {
  para: Record<string, number> = { 'PropA': 47 }
  storage: LocalStorage = new LocalStorage(this.para)
  // 定义生命周期ID
  lifecycleId: number = -1;

  eventFunc(argOne: Context, argTwo: Context): void {
    hilog.info(DOMAIN_NUMBER, TAG, '%{public}s',
      `eventeventevent ${Constants.EVENT_HUB_1} eventFunc argOne=${argOne} ${typeof argOne} argTwo=${argTwo} ${typeof argTwo}`)
    return
  }

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // 获取UIAbilityContext
    let context = this.context
    // 获取ApplicationContext（应用级别的Context
    let applicationContext = this.context.getApplicationContext()

    preferenceUtilsObject.getFontPreferences(this.context);
    ConnectionUtils.openRegister();

    this.switchArea()
    this.registerLifecycle()
    this.startupInit()

    let eventhub = this.context.eventHub
    eventhub.on(Constants.EVENT_HUB_1, this.eventFunc)
    eventhub.on(Constants.EVENT_HUB_1, (data: Object, data2: Object) => {
      // 触发事件，完成相应的业务操作
      hilog.info(DOMAIN_NUMBER, TAG, '%{public}s',
        `eventeventevent ${Constants.EVENT_HUB_1} data=${data} ${typeof data} data2=${data2} ${typeof data2}`)
    })

    systemLanguage = this.context.config.language; // UIAbility实例首次加载时，获取系统当前语言

    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    hilog.info(0x0000, 'testTag', '%{public}s', 'want param:' + JSON.stringify(want) ?? '');
    hilog.info(0x0000, 'testTag', '%{public}s', 'launchParam:' + JSON.stringify(launchParam) ?? '');
  }

  registerLifecycle() {
    let TAG = 'registerLifecycle'
    // 定义生命周期回调对象
    let abilityLifecycleCallback: AbilityLifecycleCallback = {
      // 当UIAbility创建时被调用
      onAbilityCreate(uiAbility) {
        hilog.info(DOMAIN_NUMBER, TAG, `onAbilityCreate uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
      },
      // 当窗口创建时被调用
      onWindowStageCreate(uiAbility, windowStage: window.WindowStage) {
        hilog.info(DOMAIN_NUMBER, TAG, `onWindowStageCreate uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
        hilog.info(DOMAIN_NUMBER, TAG, `onWindowStageCreate windowStage: ${JSON.stringify(windowStage)}`);
      },
      // 当窗口处于活动状态时被调用
      onWindowStageActive(uiAbility, windowStage: window.WindowStage) {
        hilog.info(DOMAIN_NUMBER, TAG, `onWindowStageActive uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
        hilog.info(DOMAIN_NUMBER, TAG, `onWindowStageActive windowStage: ${JSON.stringify(windowStage)}`);
      },
      // 当窗口处于非活动状态时被调用
      onWindowStageInactive(uiAbility, windowStage: window.WindowStage) {
        hilog.info(DOMAIN_NUMBER, TAG, `onWindowStageInactive uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
        hilog.info(DOMAIN_NUMBER, TAG, `onWindowStageInactive windowStage: ${JSON.stringify(windowStage)}`);
      },
      // 当窗口被销毁时被调用
      onWindowStageDestroy(uiAbility, windowStage: window.WindowStage) {
        hilog.info(DOMAIN_NUMBER, TAG, `onWindowStageDestroy uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
        hilog.info(DOMAIN_NUMBER, TAG, `onWindowStageDestroy windowStage: ${JSON.stringify(windowStage)}`);
      },
      // 当UIAbility被销毁时被调用
      onAbilityDestroy(uiAbility) {
        hilog.info(DOMAIN_NUMBER, TAG, `onAbilityDestroy uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
      },
      // 当UIAbility从后台转到前台时触发回调
      onAbilityForeground(uiAbility) {
        hilog.info(DOMAIN_NUMBER, TAG, `onAbilityForeground uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
      },
      // 当UIAbility从前台转到后台时触发回调
      onAbilityBackground(uiAbility) {
        hilog.info(DOMAIN_NUMBER, TAG, `onAbilityBackground uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
      },
      // 当UIAbility迁移时被调用
      onAbilityContinue(uiAbility) {
        hilog.info(DOMAIN_NUMBER, TAG, `onAbilityContinue uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
      }
    }
    let applicationContext = this.context.getApplicationContext()
    try {
      // 注册应用内生命周期回调
      this.lifecycleId = applicationContext.on('abilityLifecycle', abilityLifecycleCallback);
    } catch (err) {
      let code = (err as BusinessError).code;
      let message = (err as BusinessError).message;
      hilog.error(DOMAIN_NUMBER, TAG, `Failed to register applicationContext. Code is ${code}, message is ${message}`);
    }

    hilog.info(DOMAIN_NUMBER, TAG, `register callback number: ${this.lifecycleId}`);
  }

  startupInit() {
    let startParams = ["StartupTask_005", "StartupTask_006"];
    try {
      startupManager.run(startParams).then(() => {
        Logger.debug(Constants.TAG_STARTUP_TASK, 'StartupTest startupManager run then, startParams = ');
      }).catch((error: BusinessError) => {
        Logger.debug(Constants.TAG_STARTUP_TASK, 'StartupTest promise catch error, error = ' + JSON.stringify(error));
        Logger.debug(Constants.TAG_STARTUP_TASK, 'StartupTest promise catch error, startParams = ' + JSON.stringify(startParams));
      })
    } catch (error) {
      let errMsg = JSON.stringify(error);
      let errCode: number = error.code;
      Logger.debug(Constants.TAG_STARTUP_TASK, 'Startup catch error , errCode= ' + errCode);
      Logger.debug(Constants.TAG_STARTUP_TASK, 'Startup catch error ,error= ' + errMsg);
    }
  }

  switchArea() {
    // // 存储普通信息前，切换到EL1设备级加密
    // this.context.area = contextConstant.AreaMode.EL1; // 切换area
    // // 存储普通信息
    // // 存储敏感信息前，切换到EL2用户级加密
    // this.context.area = contextConstant.AreaMode.EL2; // 切换area
    // // 存储敏感信息
    // // 存储敏感信息前，切换到EL3用户级加密
    // this.context.area = contextConstant.AreaMode.EL3; // 切换area
    // // 存储敏感信息
    // // 存储敏感信息前，切换到EL4用户级加密
    // this.context.area = contextConstant.AreaMode.EL4; // 切换area
    // // 存储敏感信息
    // // 存储敏感信息前，切换到EL5应用级加密
    // this.context.area = contextConstant.AreaMode.EL5; // 切换area
    // // 存储敏感信息
  }

  onDestroy(): void | Promise<void> {
    this.context.eventHub.off(Constants.EVENT_HUB_1)
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    windowStage.getMainWindow().then((data: window.Window) => {
      // Window immersive.
      data.setWindowLayoutFullScreen(true);
    })
    RDBStoreUtil.createObjectiveRDB(this.context);

    windowStage.loadContent(Constants.PAGES_PageStartup, this.storage, (err, data) => {
      if (err.code) {
        hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.ERROR);
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      ConnectionUtils.registerNetworkAvailableStatus();
      hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
      PersistentStorage.persistProp('aProp', 47)
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
    ConnectionUtils.closeRegister();
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s',
      `Ability onNewWant -> want=${JSON.stringify(want)}, launchParam=${JSON.stringify(launchParam)}`);
  }

  onDump(params: string[]): string[] {
    return params
  }

  onWindowStageWillDestroy(windowStage: window.WindowStage): void {
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', `Ability onWindowStageWillDestroy windowStage`);
  }

  onWindowStageRestore(windowStage: window.WindowStage): void {
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', `Ability onWindowStageRestore onWindowStageRestore`);
  }

  onShare(wantParam: Record<string, Object>): void {
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', `Ability onShare`);
  }

  onPrepareToTerminate(): boolean {
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', `Ability onPrepareToTerminate`);
    return false
  }

  // onPrepareToTerminateAsync(): Promise<boolean> {
  //   return new Promise<false>();
  // }

  onBackPressed(): boolean {
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', `Ability onPrepareToTerminate`);
    return false
  }

  onConfigurationUpdate(newConfig: Configuration): void {
    if (systemLanguage !== newConfig.language) {
      hilog.info(DOMAIN_NUMBER, TAG, `systemLanguage from ${systemLanguage} changed to ${newConfig.language}`);
      systemLanguage = newConfig.language; // 将变化之后的系统语言保存，作为下一次变化前的系统语言
    }
  }
}