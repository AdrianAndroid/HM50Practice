import { hilog } from '@kit.PerformanceAnalysisKit';
import { workScheduler, WorkSchedulerExtensionAbility } from '@kit.BackgroundTasksKit';

const DOMAIN = 0x0000;

export default class WorkSchedulerExtension extends WorkSchedulerExtensionAbility {
  onWorkStart(workInfo: workScheduler.WorkInfo) {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'WorkSchedulerExtensionAbility onWorkStart, workInfo = ' + JSON.stringify(workInfo));
  }

  onWorkStop(workInfo: workScheduler.WorkInfo) {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'WorkSchedulerExtensionAbility onWorkStop, workInfo = ' + JSON.stringify(workInfo));
  }
}