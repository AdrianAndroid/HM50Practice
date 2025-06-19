import { hilog } from '@kit.PerformanceAnalysisKit';
import { Configuration, UIExtensionContentSession, Want } from '@kit.AbilityKit';
import EmbeddedUIExtensionAbility from '@ohos.app.ability.EmbeddedUIExtensionAbility';

const DOMAIN = 0x0000;

export default class EmbeddedUIExtAbility extends EmbeddedUIExtensionAbility {
  onCreate() {
    hilog.info(DOMAIN, 'testTag', `onCreate`);
  }

  onForeground() {
    hilog.info(DOMAIN, 'testTag', `onForeground`);
  }

  onBackground() {
    hilog.info(DOMAIN, 'testTag', `onBackground`);
  }

  onDestroy() {
    hilog.info(DOMAIN, 'testTag', `onDestroy`);
  }

  onSessionCreate(want: Want, session: UIExtensionContentSession) {
    let param: Record<string, UIExtensionContentSession> = {
      'session': session
    };
    let storage: LocalStorage = new LocalStorage(param);
    storage.setOrCreate('session', session);
    session.loadContent('embeddeduiextability/pages/EmbeddedUIExtAbilityPage', storage);
    hilog.info(DOMAIN, 'testTag', `onSessionCreate done`);
  }

  onSessionDestroy(session: UIExtensionContentSession) {
    session.terminateSelf().catch(() => {
      // handle error
    });
    hilog.info(DOMAIN, 'testTag', `onSessionDestroy`);
  }

  onConfigurationUpdate(newConfig: Configuration): void {

  }
}
