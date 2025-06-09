/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import Constants from '../common/Constants';
import Logger from '../common/Logger';

@Entry
@Component
struct LifeCyclePage {
  @State textColor: Color = Color.Black;
  @State cnt: number = 0

  submit: () => void = () => {
    this.cnt++;
  }

  aboutToAppear() {
    this.textColor = Color.Blue;
    Logger.info('[LifeCyclePage]  LifeCyclePage aboutToAppear');
  }

  onPageShow() {
    this.textColor = Color.Brown;
    Logger.info('[LifeCyclePage]  LifeCyclePage onPageShow');
  }

  onPageHide() {
    Logger.info('[LifeCyclePage]  LifeCyclePage onPageHide');
  }

  onDidBuild(): void {
    Logger.info('[LifeCyclePage]  LifeCyclePage onDidBuild');
  }

  onBackPress() {
    this.textColor = Color.Red;
    Logger.info('[LifeCyclePage]  LifeCyclePage onBackPress');
    return false;
  }

  aboutToDisappear() {
    Logger.info('[LifeCyclePage]  LifeCyclePage aboutToDisappear');
  }

  build() {
    Column() {
      Text($r('app.string.hello_message'))
        .fontSize(Constants.DEFAULT_FONT_SIZE)
        .fontColor(this.textColor)
        .margin(Constants.DEFAULT_MARGIN)
        .fontWeight(FontWeight.Bold)
      Text(`${this.cnt}`)
      Son({submitArrow: this.submit})
      this.doSomeRender()
      Text(this.calcTextValue())
    }
    .width(Constants.FULL_WIDTH)
  }

  calcTextValue(): string {
    return 'Hello World!!!'
  }

  @Builder doSomeRender() {
    Text('Hello World!')
  }
}

@Component
struct Son {
  submitArrow?: () => void

  build() {
    Row() {
      Button('add')
        .width(80)
        .onClick(() => {
          if (this.submitArrow) {
            this.submitArrow()
          }
        })
    }
    .height(56)
  }
}

