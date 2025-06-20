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

import preferenceUtilsObject from '../../common/database/PreferencesUtil';
import Home from '../../view/Home';
import Setting from '../../view/Setting';

@Builder
export function MainPageBuilder() {
  MainPage()
}

/**
 * Main page
 */
@Component
export struct MainPage {
  @StorageLink('fontSizeOffset') fontSizeOffset: number = 0;
  @State currentIndex: number = 0;
  @State pathStack: NavPathStack = new NavPathStack();
  private tabsController: TabsController = new TabsController();

  aboutToAppear() {
    this.fontSizeOffset = preferenceUtilsObject.getChangeFontSize();
  }

  @Builder
  TabBuilder(title: Resource, index: number, selectedImg: Resource) {
    Column() {
      SymbolGlyph(selectedImg)
        .fontSize('24fp')
        .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_OPACITY)
        .symbolEffect(new BounceSymbolEffect(EffectScope.WHOLE, EffectDirection.UP),
          this.currentIndex === index ? true : false)
        .fontColor(this.currentIndex === index ? ['#0a59f7'] : ['#66000000'])
      Text(title)
        .margin({ top: '4vp' })
        .fontSize(10 + this.fontSizeOffset)
        .fontWeight(500)
        .fontColor(this.currentIndex === index ? '#0a59f7' : '#66000000')
    }
    .backgroundColor('#F1F3F5')
    .justifyContent(FlexAlign.Center)
    .height('56vp')
    .width('100%')
    .onClick(() => {
      this.currentIndex = index;
      this.tabsController.changeIndex(this.currentIndex);
    })
  }

  build() {
    NavDestination() {
      Tabs({
        barPosition: BarPosition.End,
        controller: this.tabsController
      }) {
        TabContent() {
          Home({ pathStack: this.pathStack })
        }
        .padding({
          left: '12vp',
          right: '12vp'
        })
        .backgroundColor('#F1F3F5')
        .tabBar(this.TabBuilder($r('app.string.Tab_Bar_One'), 0, $r('sys.symbol.house_fill')))

        TabContent() {
          Setting()
        }
        .padding({
          left: '12vp',
          right: '12vp'
        })
        .backgroundColor('#F1F3F5')
        .tabBar(this.TabBuilder($r('app.string.Tab_Bar_Two'), 1, $r('sys.symbol.person_crop_circle_fill_1')))
      }
      .margin({ bottom: '64vp' })
      .width('100%')
      .height('100%')
      .barHeight('80vp')
      .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
    }
    .height('100%')
    .hideTitleBar(true)
    .backgroundColor('#F1F3F5')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}