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

export class CommonConstants {
  static readonly SPACE: string = '20vp';
  static readonly CONTENT_WIDTH: string = '18%';
  static readonly CONTENT_ROW_WIDTH: string = '75%';
  static readonly SCROLL_WIDTH: string = '115%';
  static readonly LAYOUT_WEIGHT: number = 1;
  static readonly LOOP_COUNT: number = 3;
  static readonly MAX_DATA_LENGTH: number = 18;
  static readonly FULL_PERCENT: string = '100%';
  static readonly ONE_FOURTH: string = '25%';
  static readonly FONT_WEIGHT_500: number = 500;
  static readonly FONT_WEIGHT_700: number = 700;
  static readonly ITEM_COUNT: number = 4;

  static readonly TABLE_GRID_NEST_LIST_URI: string = 'pages/GridNestListIndex';
  static readonly TABLE_GRID_NEST_SWIPER_URI: string = 'pages/GridNestSwiperIndex';
  static readonly WATER_FLOW_LAYOUT_WEIGHT: number = 1;
  static readonly DIVIDER_STROKE_WIDTH: number = 2;
  static readonly LIST_SPACE_SIZE: number = 16;
  static readonly SWIPER_HEIGHT_SIZE1: number = 175;
  static readonly SWIPER_HEIGHT_SIZE2: number = 100;
  static readonly WATER_FLOW_GROUP_BOTTOM_MARGIN: number = 12;
  static readonly WATER_FLOW_ITEM_HEIGHT: number = 159;
  static readonly SWIPER_DURATION: number = 700;
  static readonly NINETY_PERCENT: string = '90%';
  static readonly LIST_HEIGHT: string = 'calc(100% - 40vp)';
  static readonly GRID_COLUMNS_TEMPLATE: string = '1fr 1fr 1fr 1fr';
}

export enum ScrollPosition {
  start = 0,
  center = 1,
  end = 2
}