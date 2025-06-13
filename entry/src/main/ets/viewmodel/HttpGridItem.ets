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

export default class HttpGridItem {
  /**
   * Text of list item.
   */
  title: string;
  /**
   * Image of list item.
   */
  img: string;
  /**
   * Other resource of list item.
   */
  content: string;

  constructor(title: string, img: string, content: string) {
    this.title = title;
    this.img = img;
    this.content = content;
  }
}