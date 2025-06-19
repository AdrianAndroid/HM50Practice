import { StartupTask, common } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import Constants from '../common/Constants';
import Logger from '../common/Logger';

@Sendable
export default class StartupTask_006 extends StartupTask {
  constructor() {
    super();
  }

  async init(context: common.AbilityStageContext) {
    Logger.debug(Constants.TAG_STARTUP_TASK, 'StartupTask_006 init.');
    return 'StartupTask_006';
  }

  onDependencyCompleted(dependence: string, result: Object): void {
    Logger.debug(Constants.TAG_STARTUP_TASK, 'StartupTask_006 onDependencyCompleted, dependence: %{public}s, result: %{public}s' + dependence + JSON.stringify(result));
  }
}