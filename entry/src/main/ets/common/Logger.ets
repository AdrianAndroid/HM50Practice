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

import { hilog } from '@kit.PerformanceAnalysisKit';

class Logger {
  private domain: number;
  private prefix: string;
  private format: string = '%{public}s, %{public}s';

  /**
   * constructor.
   *
   * @param Prefix Identifies the log tag.
   * @param domain Domain Indicates the service domain, which is a hexadecimal integer ranging from 0x0 to 0xFFFFF.
   */
  constructor(prefix: string = 'MyApp', domain: number = 0xFF00) {
    this.prefix = prefix;
    this.domain = domain;
  }

  debug(...args: string[]): void {
    hilog.debug(this.domain, this.prefix, this.format, args);
  }

  info(...args: string[]): void { // 处理每个参数，对应字符
    const processedArgs = args.map(arg => {
      if (typeof arg === 'string') {
        return this.wrapStringAtNumChars(arg);
      }
      return arg;
    });
    const combinedMessage = processedArgs.join('\n');
    hilog.info(this.domain, this.prefix, this.format, [combinedMessage]);
  }

  log(...args: string[]): void {
    hilog.info(this.domain, this.prefix, this.format, args);
  }

  warn(...args: string[]): void {
    hilog.warn(this.domain, this.prefix, this.format, args);
  }

  error(...args: string[]): void {
    hilog.error(this.domain, this.prefix, this.format, args);
  }

  // 严格按每50个字符换行的处理函数
  private wrapStringAtNumChars(str: string): string {
    let BL = 100
    if (!str) {
      return str;
    }

    let result = '';
    for (let i = 0; i < str.length; i += BL) {
      result += str.substring(i, i + BL); // 不是最后一段才添加换行符
      if (i + BL < str.length) {
        result += '\n';
      }
    }
    return result;
  }
}

export default new Logger('UIAbilityLifeCycle', 0xFF00)