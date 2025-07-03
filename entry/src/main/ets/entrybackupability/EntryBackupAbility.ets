import { hilog } from '@kit.PerformanceAnalysisKit';
import { BackupExtensionAbility, BundleVersion } from '@kit.CoreFileKit';

interface ErrorInfo {
  type: string,
  errorCode: number,
  errorInfo: string
}

export default class EntryBackupAbility extends BackupExtensionAbility {
  async onBackup() {
    hilog.info(0x0000, 'testTag', 'onBackup ok');
  }

  async onRestore(bundleVersion: BundleVersion) {
    hilog.info(0x0000, 'testTag', 'onRestore ok %{public}s', JSON.stringify(bundleVersion));
  }

  //onBackupEx
  async onBackupEx(backupInfo: string): Promise<string> {
    console.log(`onBackupEx ok`);
    let errorInfo: ErrorInfo = {
      type: "ErrorInfo",
      errorCode: 0,
      errorInfo: "app diy error info"
    }
    return JSON.stringify(errorInfo);
  }

  // onRestoreEx
  async onRestoreEx(bundleVersion : BundleVersion, restoreInfo: string): Promise<string> {
    console.log(`onRestoreEx ok ${JSON.stringify(bundleVersion)}`);
    let errorInfo: ErrorInfo = {
      type: "ErrorInfo",
      errorCode: 0,
      errorInfo: "app diy error info"
    }
    return JSON.stringify(errorInfo);
  }
}