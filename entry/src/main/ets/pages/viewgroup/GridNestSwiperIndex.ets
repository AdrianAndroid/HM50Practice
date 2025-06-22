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

import { CommonConstants } from '../../common/CommonConstants';
import { ListDataConstants } from '../../common/ListDataConstants';
import { WaterFlowDataSource } from '../../model/WaterFlowDataSource';
import MenuItemComponent from '../../view/MenuItemComponent';
import { JSON } from '@kit.ArkTS';
import Logger from '../../common/Logger';

@Entry
@Component
struct GridNextSwiperIndex {
  @State swiperDistance: number = CommonConstants.SWIPER_HEIGHT_SIZE1 // swiper控件的高度
  @State sections: WaterFlowSections = new WaterFlowSections()
  oneColumnSection: SectionOptions = {
    itemsCount: 1,
    crossCount: 1,
    margin: { bottom: $r('app.float.water_flow_item_bottom_size') },
    onGetItemMainSizeByIndex: () => {
      return CommonConstants.WATER_FLOW_ITEM_HEIGHT;
    }
  }
  twoColumnSection: SectionOptions = {
    itemsCount: 6,
    crossCount: 2,
    onGetItemMainSizeByIndex: () => {
      return CommonConstants.WATER_FLOW_ITEM_HEIGHT;
    }
  }
  private swiperController: SwiperController = new SwiperController()
  private waterFlowDataSource: WaterFlowDataSource = new WaterFlowDataSource();

  aboutToAppear(): void {
    this.waterFlowDataSource.setDataArray(ListDataConstants.WATER_FLOW_DATA);
    this.sections.push(this.oneColumnSection);
    this.sections.push(this.twoColumnSection);
  }

  build() {
    Column() {
      Row() {
        Search({ placeholder: $r('app.string.default_search_content') })
          .backgroundColor($r('app.color.search_background_color'))
      }
      .padding({ left: $r('app.float.search_left_padding'), right: $r('app.float.search_right_padding') })
      .margin({ top: $r('app.float.search_top_margin'), bottom: $r('app.float.search_bottom_margin') })
      .height($r('app.float.search_height_size'))

      Swiper(this.swiperController) {
        ForEach(ListDataConstants.GRID_COL_LIST, (item: string[], index) => {
          MenuItemComponent({ nameList: item, imageList: ListDataConstants.SWIPER_IMAGE_LIST[index] })
        }, (item: string[], index: number) => index + JSON.stringify(item))
      }
      .onGestureSwipe((index: number, extraInfo: SwiperAnimationEvent) => { // 手指拖动就会调用
        // Logger.debug('GridNextSwiperIndex', `onGestureSwipe index=>${index} extraInfo=>${JSON.stringify(extraInfo)}`)
        this.getUIContext().animateTo(
          {
            duration: CommonConstants.SWIPER_DURATION,
            curve: Curve.Smooth,
            playMode: PlayMode.Normal,
            onFinish: () => {
              // Logger.debug('GridNextSwiperIndex', `onGestureSwipe animateTo onFinish`)
            }
          },
          () => {
            if (index == 0) {
              this.swiperDistance = CommonConstants.SWIPER_HEIGHT_SIZE2; // 100
            } else {
              this.swiperDistance = CommonConstants.SWIPER_HEIGHT_SIZE1; // 175
            }
          })
      })
      .onAnimationStart((index: number, targetIndex: number,) => {
        Logger.debug('GridNextSwiperIndex', `onAnimationStart index=>${index} targetIndex=${targetIndex}`)
        this.getUIContext().animateTo(
          {
            duration: CommonConstants.SWIPER_DURATION,
            curve: Curve.Smooth,
            playMode: PlayMode.Normal,
            onFinish: () => {
              Logger.debug('GridNextSwiperIndex', `onAnimationStart animateTo onFinish`)
            }
          },
          () => {
            if (targetIndex === 0) {
              this.swiperDistance = CommonConstants.SWIPER_HEIGHT_SIZE1;
            } else if (targetIndex === 1) {
              this.swiperDistance = CommonConstants.SWIPER_HEIGHT_SIZE2;
            }
          })
      })
      .height(this.swiperDistance)

      WaterFlow({ sections: this.sections }) {
        LazyForEach(this.waterFlowDataSource, (item: Resource) => {
          FlowItem() {
            Image(item)
              .height(CommonConstants.FULL_PERCENT)
              .width(CommonConstants.FULL_PERCENT)
              .borderRadius($r('app.float.image_border_radius'))
          }

        }, (item: Resource, index: number) => index + JSON.stringify(item))
      }
      .padding({ left: $r('app.float.water_flow_padding'), right: $r('app.float.water_flow_padding') })
      .margin({ top: $r('app.float.water_flow_margin') })
      .layoutWeight(CommonConstants.WATER_FLOW_LAYOUT_WEIGHT)
      .rowsGap($r('app.float.water_flow_gap_size'))
      .columnsGap($r('app.float.water_flow_gap_size'))
    }
    .backgroundColor(Color.White)
    .height(CommonConstants.FULL_PERCENT)
  }
}

