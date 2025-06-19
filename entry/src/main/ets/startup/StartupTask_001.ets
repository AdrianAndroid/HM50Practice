import { common, StartupTask } from '@kit.AbilityKit';
import Constants from '../common/Constants';
import Logger from '../common/Logger';

@Sendable
export default class StartupTask_001 extends StartupTask {
  constructor() {
    super();
  }

  async init(context: common.AbilityStageContext) {
    Logger.debug(Constants.TAG_STARTUP_TASK, 'StartupTask_001 init.');
    return 'StartupTask_001';
  }

  onDependencyCompleted(dependence: string, result: Object): void {
    Logger.debug(Constants.TAG_STARTUP_TASK, 'StartupTask_001 onDependencyCompleted, dependence: %{public}s, result: %{public}s' + dependence + JSON.stringify(result));
  }
}