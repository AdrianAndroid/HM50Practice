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
import { NavDestinationItem } from './ACNavDestinationItem';

/**
 * 首页轮播图信息
 */
export class SwiperData {
  imageSrc: Resource;
  name: string;
  routerInfo: NavDestinationItem;
  param: string;

  constructor(imageSrc: Resource, name: string, routerInfo: NavDestinationItem, param?: string) {
    this.imageSrc = imageSrc;
    this.name = name;
    this.routerInfo = routerInfo;
    this.param = param === undefined ? '' : param;
  }
}