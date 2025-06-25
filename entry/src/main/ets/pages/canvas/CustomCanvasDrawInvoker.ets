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

import { List } from '@kit.ArkTS';
import DrawPath from './CustomCanvasIDraw';

export default class DrawInvoker {
  // Draw list.
  private drawPathList: List<DrawPath> = new List<DrawPath>();
  // Redo list.
  private redoList: Array<DrawPath> = new Array<DrawPath>();

  add(command: DrawPath): void {
    this.drawPathList.add(command);
    this.redoList = [];
  }

  clear(): void {
    if (this.drawPathList.length > 0 || this.redoList.length > 0) {
      this.drawPathList.clear();
      this.redoList = [];
    }
  }

  undo(): void {
    if (this.drawPathList.length > 0) {
      let undo: DrawPath = this.drawPathList.get(this.drawPathList.length - 1);
      this.drawPathList.removeByIndex(this.drawPathList.length - 1);
      this.redoList.push(undo)
    }
  }

  redo(): void {
    if (this.redoList.length > 0) {
      let redoCommand = this.redoList[this.redoList.length - 1];
      this.redoList.pop();
      this.drawPathList.add(redoCommand);
    }
  }

  execute(context: CanvasRenderingContext2D): void {
    if (this.drawPathList !== null) {
      this.drawPathList.forEach((element: DrawPath) => {
        element.draw(context);
      });
    }
  }

  canRedo(): boolean {
    return this.redoList.length > 0;
  }

  canUndo(): boolean {
    return this.drawPathList.length > 0;
  }
}