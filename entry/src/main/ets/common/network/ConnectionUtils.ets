/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { connection } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';

const TAG: string = 'ConnectionUtils';

/**
 * The ConnectionUtils provides the network listening capability.
 */
export class ConnectionUtils {
  netConnection = connection.createNetConnection();

  /**
   *The method of checking whether the monitoring network is connected..
   */
  async isNetworkConnected(): Promise<boolean> {
    let result: boolean = false;
    await connection.getDefaultNet().then(async (data: connection.NetHandle) => {
      if (data.netId === 0) {
        hilog.info(0x0000, TAG, 'network error');
        return;
      }
      await connection.getNetCapabilities(data).then(
        (data: connection.NetCapabilities) => {
          let bearerTypes: Set<number> = new Set(data.bearerTypes);
          let bearerTypesNum = Array.from(bearerTypes.values());
          for (let item of bearerTypesNum) {
            if (item === 0) {
              result = true;
              hilog.info(0x0000, TAG, 'BEARER_CELLULAR');
            } else if (item === 1) {
              result = true;
              hilog.info(0x0000, TAG, 'BEARER_WIFI');
            } else if (item === 3) {
              result = true;
              hilog.info(0x0000, TAG, 'BEARER_ETHERNET');
            } else {
              return;
            }
          }
        })
    })
    return result;
  }

  /**
   *The method of opening register.
   */
  openRegister() {
    this.netConnection.register((error: BusinessError) => {
      hilog.info(0x0000, TAG, JSON.stringify(error));
    });
  }

  /**
   *The method of listening to the network status.
   */
  registerNetworkAvailableStatus() {
    this.netConnection.on('netAvailable', () => {
      promptAction.showToast({
        message: $r('app.string.Network_Available'),
        duration: 2000
      });
    });

    this.netConnection.on('netUnavailable', () => {
      promptAction.showToast({
        message: $r('app.string.Network_Unavailable'),
        duration: 2000
      });
    });

    this.netConnection.on('netLost', () => {
      promptAction.showToast({
        message: $r('app.string.Network_Lost'),
        duration: 2000
      });
    });
  }

  /**
   *The method of closing register.
   */
  closeRegister() {
    this.netConnection.unregister((error: BusinessError) => {
      hilog.info(0x0000, TAG, JSON.stringify(error));
    });
  }
}

export default new ConnectionUtils();