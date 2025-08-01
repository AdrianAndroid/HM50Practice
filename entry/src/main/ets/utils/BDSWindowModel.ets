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

import { BusinessError } from '@kit.BasicServicesKit';
import { window, display } from '@kit.ArkUI';
import ArrayUtil from './BDSArrayUtil';
import Logger from './BDSLogger';

/**
 * window management model.
 */
export default class WindowModel {
  // Default top navigation bar height.
  public static readonly STATUS_BAR_HEIGHT = 38.8;
  // Default bottom navigation bar height.
  public static readonly BOTTOM_AVOID_HEIGHT = 10;

  private constructor() {
  }

  // WindowModel Singleton.
  private static instance?: WindowModel;
  // key/value pair.
  private objects = new Map<string, Object>();

  /**
   * Obtains a WindowModel singleton instance.
   *
   * @returns {WindowModel} WindowModel
   */
  static getInstance(): WindowModel {
    if (!WindowModel.instance) {
      WindowModel.instance = new WindowModel();
    }
    return WindowModel.instance;
  }

  // The current WindowStage instance for the cache.
  private windowStage?: window.WindowStage;

  /**
   * Cache windowStage.
   *
   * @param windowStage Current WindowStage Instance.
   * @returns {void}
   */
  setWindowStage(windowStage: window.WindowStage): void {
    this.windowStage = windowStage;
  }

  /**
   * Whether the immersion mode is enabled for the current main window.
   *
   * @param enable Whether to enable.
   * @returns {void}
   */
  setMainWindowImmersive(enable: boolean): void {
    if (this.windowStage === undefined) {
      Logger.error('windowStage is undefined.');
      return;
    }
    this.windowStage.getMainWindow((err, windowClass: window.Window) => {
      if (err.code) {
        Logger.error(`Failed to obtain the main window. Code:${err.code}, message:${err.message}`);
        return;
      }
      let promise = windowClass.setWindowLayoutFullScreen(enable);
      promise.then(() => {
        Logger.info('Succeeded in setting the window layout to full-screen mode.');
      }).catch((err: BusinessError) => {
        Logger.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
      });
    });
  }

  /**
   * Obtains the height of the navigation bar on the top of the main window.
   *
   * @returns {callback((statusBarHeight: number) => void))}
   */
  getStatusBarHeight(callback: ((statusBarHeight: number) => void)): void {
    if (this.windowStage === undefined) {
      Logger.error('windowStage is undefined.');
      return;
    }
    this.windowStage.getMainWindow((err, windowClass: window.Window) => {
      if (err.code) {
        Logger.error(`Failed to obtain the main window. Code:${err.code}, message:${err.message}`);
        return;
      }
      try {
        let type = window.AvoidAreaType.TYPE_SYSTEM;
        let avoidArea = windowClass.getWindowAvoidArea(type);
        let height = avoidArea.topRect.height;
        Logger.info('Successful get statusHeight' + height);
        callback(height);
      } catch (err) {
        callback(WindowModel.STATUS_BAR_HEIGHT);
        Logger.info('Failed to get statusHeight');
      }
    });
  }

  /**
   * Obtains the height of the navigation bar at the bottom of the main window.
   *
   * @returns {callback: ((bottomAvoidHeight: number) => void)}
   */
  getBottomAvoidHeight(callback: ((bottomAvoidHeight: number) => void)): void {
    if (this.windowStage === undefined) {
      Logger.error('windowStage is undefined.');
      return;
    }
    this.windowStage.getMainWindow((err, windowClass: window.Window) => {
      if (err.code) {
        Logger.error(`Failed to obtain the main window. Code:${err.code}, message:${err.message}`);
        return;
      }
      try {
        let type = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR;
        let avoidArea = windowClass.getWindowAvoidArea(type);
        let height = avoidArea.bottomRect.height;
        Logger.info(`Successful get bottomAvoidHeight: ${height}`);
        callback(height);
      } catch (err) {
        callback(WindowModel.BOTTOM_AVOID_HEIGHT);
        Logger.info('Failed to get bottomAvoidHeight');
      }
    });
  }

  /**
   * Obtains the height of the main window.
   *
   * @returns {Promise<number>}
   */
  async getWindowHeight(): Promise<number> {
    let globalDisplays = WindowModel.getInstance().getObject('display') as Array<display.Display>;
    if (ArrayUtil.isNotNullEmpty(globalDisplays)) {
      return globalDisplays[0].height / globalDisplays[0].densityPixels;
    }
    globalDisplays = await display.getAllDisplays();
    WindowModel.getInstance().setObject('display', globalDisplays);
    return globalDisplays[0].height / globalDisplays[0].densityPixels;
  }

  getObject(key: string): Object | undefined {
    return this.objects.get(key);
  }

  setObject(key: string, value: Object): void {
    this.objects.set(key, value);
  }
}