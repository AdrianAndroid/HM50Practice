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

import ItemData from '../viewmodel/ItemData';
import mainViewModel from '../viewmodel/MainViewModel';

/**
 * Setting tab content
 */
@Component
export default struct Setting {
  @Builder
  settingCell(item: ItemData) {
    Row() {
      Row({}) {
        Image(item.img)
          .height('22vp')
          .margin({
            left: '16vp',
            right: '12vp'
          })
        Text(item.title)
          .fontSize('16fp')
      }

      if (item.others === undefined) {
        Image($r('app.media.right_grey'))
          .width('12vp')
          .height('24vp')
      } else {
        Toggle({ type: ToggleType.Switch, isOn: false })
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .padding({
      left: '8vp',
      right: '22vp'
    })
  }

  build() {
    Scroll() {
      Column({ space: 12 }) {
        Text($r('app.string.mainPage_tabTitles_mine'))
          .width('100%')
          .margin({
            top: '48vp',
            bottom: '12vp'
          })
          .fontWeight(700)
          .fontSize('26fp')

        Row() {
          Image($r('app.media.account'))
            .width('48vp')
            .height('48vp')
          Column() {
            Text($r('app.string.setting_account_name'))
              .fontSize('20fp')
            Text($r('app.string.setting_account_email'))
              .fontSize('12fp')
              .margin({ top: '4vp' })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: '12vp' })
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')

        List({ space: 12 }) {
          ForEach(mainViewModel.getSettingListData(), (item: ItemData[], index: number) => {
            ListItemGroup() {
              ForEach(item, (cell: ItemData, cellIndex) => {
                ListItem() {
                  this.settingCell(cell)
                }
                .height('48vp')
              })
            }
            .divider({
              strokeWidth: '1vp',
              color: '#0d000000',
              startMargin: '42vp',
              endMargin: '24vp'
            })
            .backgroundColor('#ffffff')
            .borderRadius('16vp')

          }, (item: ItemData) => JSON.stringify(item))
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .padding({
          top: '4vp',
          bottom: '4vp'
        })

        Blank()

        Button($r('app.string.setting_button'), { type: ButtonType.Capsule })
          .width('90%')
          .height('40vp')
          .fontSize('16fp')
          .fontColor('#FA2A2D')
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#E5E8EA')
          .margin({ bottom: '16vp' })
      }
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}