/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import { unifiedDataChannel, uniformDataStruct, uniformTypeDescriptor } from '@kit.ArkData';
import { TextModifier, SubHeader, LengthUnit } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { Constants } from '../../../../common/DFConstants';
import { BreakpointType } from '../../../../common/DFUtils';
import { BusinessError } from '@kit.BasicServicesKit';

const TAG = '[Sample_DragFramework]';

@Builder
export function PageImageBuilder() {
  ImageDrag();
}

@Entry
@Component
struct ImageDrag {
  @State uri: string = '';
  @State blockArr: string[] = [];
  @State targetImage: string = '';
  @State visible: Visibility = Visibility.Visible;
  @State dragSuccess: Boolean = false;
  @State primaryModifier: TextModifier = new TextModifier().fontColor(Color.Gray).fontSize(18).fontWeight(FontWeight.Medium);
  @StorageProp('topRectHeight') topRectHeight: number = 0;
  @StorageLink('currentBreakpoint') curBp: string = Constants.BREAK_POINT_SM;
  private context: UIContext = this.getUIContext();

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceAround }) {
            Image($r('app.media.mount'))
              .width('100%')
              .height(new BreakpointType('180vp', '224vp', '391vp').getValue(this.curBp))
              .fitOriginalSize(true)
              .borderRadius(16)
              .visibility(this.visible)
              .draggable(true) // 设置可拖拽
              .onFinish(() => {
                hilog.info(0x0000, TAG, `%{public}s`, `onFinish`);
              })
              .onComplete(() => {
                hilog.info(0x0000, TAG, `%{public}s`, `onComplete`);
              })
              .onDragEnter(() => {
                hilog.info(0x0000, TAG, `%{public}s`, `onDragEnter`);
              })
              .onDragStart((event) => {
                hilog.info(0x0000, TAG, `%{public}s`, `onDragStart`);
              })
              .onDragLeave((event) => {
                hilog.info(0x0000, TAG, `%{public}s`, `onDragLeave`);
              })
              .onDragEnd(() => {
                hilog.info(0x0000, TAG, `%{public}s`, `onDragEnd`);
              })
              .onPreDrag(() => {
                hilog.info(0x0000, TAG, `%{public}s`, `onPreDrag`);
              })
              .onDragMove((event) => {
                hilog.info(0x0000, TAG, `%{public}s`, `onDragMove 1111`);
              })
              .onDragEnd((event: DragEvent) => {
                hilog.info(0x0000, TAG, `%{public}s`, `onDragEnd`);
                let ret = event.getResult();
                if (ret === 0) {
                  hilog.info(0x0000, TAG, `%{public}s`, `enter ret === 0`);
                } else {
                  hilog.info(0x0000, TAG, `%{public}s`, `enter ret !== 0`);
                  this.visible = Visibility.Hidden;
                }
              })
          }
          SubHeader({
            primaryTitle: $r('app.string.image_text_title'),
            primaryTitleModifier: this.primaryModifier,
            contentMargin: {
              start: {
                value: 0,
                unit: LengthUnit.VP
              }
            }
          })
          Column() {
            Image(this.targetImage)
              .width('100%')
              .height(new BreakpointType('180vp', '224vp', '391vp').getValue(this.curBp))
              .fitOriginalSize(true)
              .constraintSize({ maxWidth: '100%' })
              .borderRadius(16)
          }
          .constraintSize({ maxWidth: '100%' })
          .backgroundColor($r('sys.color.comp_background_primary'))
          .borderRadius(16)
          .allowDrop([uniformTypeDescriptor.UniformDataType.IMAGE]) // 接收的类型
          .onDragMove((event) => {
            hilog.info(0x0000, TAG, `%{public}s`, `onDragMove 2222`);
          })
          .onDrop((event?: DragEvent) => {
            hilog.info(0x0000, TAG, `%{public}s`, `dragData arr is null`);
            try {
              let dragData: UnifiedData = (event as DragEvent).getData() as UnifiedData;
              if (dragData !== undefined) {
                let records: unifiedDataChannel.UnifiedRecord[] = dragData.getRecords();
                if (records.length > 0) {
                  for (let i = 0; i < records.length; i++) {
                    let types = records[i].getTypes();
                    if (types.includes(uniformTypeDescriptor.UniformDataType.FILE_URI)) {
                      const fileUriUds = records[i].getEntry(uniformTypeDescriptor.UniformDataType.FILE_URI) as uniformDataStruct.FileUri;
                      let typeDescriptor = uniformTypeDescriptor.getTypeDescriptor(fileUriUds.fileType);
                      if (typeDescriptor.belongsTo(uniformTypeDescriptor.UniformDataType.IMAGE)) {
                        this.targetImage = fileUriUds.oriUri;
                      }
                    }
                  }
                } else {
                  hilog.info(0x0000, TAG, `%{public}s`, `dragData arr is null`);
                }
              } else {
                hilog.info(0x0000, TAG, `%{public}s`, `dragData is undefined`);
              }
              this.dragSuccess = true;
            } catch (error) {
              const err = error as BusinessError;
              hilog.error(0x0000, TAG, `startDataLoading errorCode: ${err.code}, errorMessage: ${err.message}`);
            }
          })
        }
        .padding({
          left: 16,
          right: 16,
          top: 8,
          bottom: 16,
        })
        .backgroundColor($r('sys.color.background_secondary'))
      }
    }
    .title(this.context.getHostContext()!.resourceManager.getStringSync($r('app.string.image_title')))
    .backgroundColor($r('sys.color.background_secondary'))
    .padding({ top: this.context.px2vp(this.topRectHeight) })
  }
}