/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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

import { http } from '@kit.NetworkKit';

let httpRequest = http.createHttp();

export function Live() {
  return httpRequest.request(
    'http://123.60.114.86:8090/goods/liveInfo?id=2',
    {
      header: {
        'Content-Type': 'application/json'
      },
      readTimeout: 60000,
      connectTimeout: 60000
    });
}