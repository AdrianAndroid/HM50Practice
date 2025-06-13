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

import { http } from '@kit.NetworkKit';
import { fileIo, fileUri } from '@kit.CoreFileKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import ResponseData from '../../viewmodel/ResponseData/ResponseData';
import ListInfo from '../../viewmodel/ResponseData/ListInfo';

const TAG: string = 'HttpUtils';
const IMAGE_URL: string = 'https://developer.huawei.com/system/modules/org.opencms.portal.template.core/' +
  'resources/harmony/img/jiantou_right.svg';
const RESOURCE_URL: string = 'https://svc-drcn.developer.huawei.com/community/servlet/consumer' +
  '/partnerActivityService/v1/developer/activity/terminalActivities/list';

/**
 * The class of header.
 */
class Header {
  contentType: string;

  constructor(contentType: string) {
    this.contentType = contentType;
  }
}

/**
 * The HttpUtils provides the capability of accessing the network through HTTP.
 */
export class HttpUtils {
  httpRequest: http.HttpRequest;

  constructor() {
    this.httpRequest = http.createHttp();
  }

  /**
   * The method of initiating a GET request through HTTP.
   */
  async getHttpRequest(cacheDir: string): Promise<string> {
    let responsePictureUri: string = '';
    await this.httpRequest.request(IMAGE_URL, { method: http.RequestMethod.GET })
      .then((data: http.HttpResponse) => {
        let filePath = cacheDir + '/test.svg';
        let file = fileIo.openSync(filePath, fileIo.OpenMode.CREATE | fileIo.OpenMode.READ_WRITE);
        responsePictureUri = fileUri.getUriFromPath(filePath);
        fileIo.writeSync(file.fd, data.result as ArrayBuffer);
        fileIo.closeSync(file.fd);
      })
    return responsePictureUri;
  }

  /**
   * The method of initiating a POST request through HTTP.
   */
  async postHttpRequest(): Promise<ListInfo[]> {
    let responseData: Array<ListInfo> = [];
    await this.httpRequest.request(RESOURCE_URL,
      {
        method: http.RequestMethod.POST, extraData: {
        'status': '1',
        'belong': '1',
        'language': 'cn',
        'needTop': 1,
        'displayChannel': [1, 3],
        'count': 4,
        'pagestart': 1,
        'type': '1,4,5,6'
      },
        header: new Header('application/json;charset=UTF-8')
      }).then((data: http.HttpResponse) => {
      let result: ResponseData = JSON.parse(data.result as string);
      responseData = result.value.list;
    }).catch((err: Error) => {
      hilog.info(0x0000, TAG, JSON.stringify(err));
    });
    return responseData;
  }

  /**
   * The method of destroying httpRequest.
   */
  destroyHttpRequest() {
    this.httpRequest.destroy();
  }
}