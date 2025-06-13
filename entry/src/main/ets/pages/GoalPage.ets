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

import { hilog } from '@kit.PerformanceAnalysisKit';
import RDBStoreUtil from '../common/database/RDBStoreUtil';
import { GoalItem } from '../viewmodel/GoalItem';

const TAG = 'GoalPage';

@Builder
export function GoalPageBuilder() {
  GoalPage()
}

/**
 * Goal page
 */
@Component
export struct GoalPage {
  @State plansSet: Array<GoalItem> = [];
  @State plan: GoalItem = new GoalItem(0, '', '', 0, '');
  @State durationSelectOptions: Array<SelectOption> = [];
  @State durationSet: Array<number> = [];
  @State currentDuration: number | undefined = undefined;
  @State currentStatus: boolean | undefined = undefined;
  @State isUpdateShow: boolean = false;
  @State isInsetShow: boolean = false;
  @State currentNumber: number = 0;
  @State currentPlan: GoalItem = new GoalItem(0, '', '', 0, '');
  @State duration: number = 0;
  @State status: boolean = false;
  @State addSportID: number = 0;
  @State addDuration: number = 0;
  @State addStatus: boolean = false;

  @Builder
  updateBindSheet(planData: GoalItem) {
    Column() {
      Row() {
        Text($r('app.string.sport_name'))
          .font({
            size: '16fp',
            weight: 500
          })
          .opacity(0.9)
        Select([{ value: $r('app.string.Morning_jogging') }, { value: $r('app.string.Yoga') },
          { value: $r('app.string.Swimming') }])
          .value(planData.sportName)
          .focusable(false)
          .width('150vp')
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      .margin({
        top: '15vp',
        bottom: '15vp'
      })

      Row() {
        Text($r('app.string.Exercise_duration'))
          .font({
            size: '16fp',
            weight: 400
          })
          .opacity(0.9)
        TextInput({ text: planData.duration.toString() })
          .onChange((data: string) => {
            this.duration = Number.parseInt(data);
          })
          .width('150vp')
      }
      .width('90%')
      .margin({ bottom: '15vp' })
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        Text($r('app.string.Completion_Status'))
          .font({
            size: '16fp',
            weight: 400
          })
          .opacity(0.9)
        Select([
          { value: $r('app.string.Completed') },
          { value: $r('app.string.Uncompleted') }
        ])
          .width('150vp')
          .value(planData.status)
          .onSelect((index: number) => {
            if (index === 0) {
              this.status = true;
            } else {
              this.status = false;
            }
          })
      }
      .width('90%')
      .margin({ bottom: '15vp' })
      .justifyContent(FlexAlign.SpaceBetween)

      Button($r('app.string.submit'))
        .width('288vp')
        .onClick(async () => {
          await RDBStoreUtil.updatePlan(planData.id, this.duration, this.status);
          await RDBStoreUtil.queryAllPlans().then((value) => {
            this.plansSet = value;
          });
          this.refreshSelectOption();
          this.isUpdateShow = false;
        })
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
  }

  @Builder
  insertBindSheet() {
    Column() {
      Row() {
        Text($r('app.string.sport_name'))
          .font({
            size: '16fp',
            weight: 500
          })
          .opacity(0.9)
        Select([
          { value: $r('app.string.Morning_jogging') },
          { value: $r('app.string.Yoga') },
          { value: $r('app.string.Swimming') }
        ])
          .value($r('app.string.Morning_jogging'))
          .onSelect((index: number) => {
            this.addSportID = index;
          })
          .width('170vp')
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      .margin({
        top: '15vp',
        bottom: '15vp'
      })

      Row() {
        Text($r('app.string.Exercise_duration'))
          .font({
            size: '16fp',
            weight: 400
          })
          .opacity(0.9)
        TextInput({ placeholder: $r('app.string.enter_duration') })
          .onChange((data: string) => {
            this.addDuration = Number.parseInt(data);
          })
          .width('170vp')
      }
      .width('90%')
      .margin({ bottom: '15vp' })
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        Text($r('app.string.Completion_Status'))
          .font({
            size: '16fp',
            weight: 400
          })
          .opacity(0.9)
        Select([
          { value: $r('app.string.Completed') },
          { value: $r('app.string.Uncompleted') }
        ])
          .value($r('app.string.Uncompleted'))
          .onSelect((index: number) => {
            if (index === 0) {
              this.addStatus = true;
            } else {
              this.addStatus = false;
            }
          })
          .width('170vp')
      }
      .width('90%')
      .margin({ bottom: '15vp' })
      .justifyContent(FlexAlign.SpaceBetween)

      Button($r('app.string.submit'))
        .width('288vp')
        .onClick(async () => {
          await RDBStoreUtil.insertPlan(this.addSportID, this.addDuration, this.addStatus);
          await RDBStoreUtil.queryAllPlans().then((value) => {
            this.plansSet = value;
          });
          this.refreshSelectOption();
          this.isInsetShow = false;
        })
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
  }

  async aboutToAppear(): Promise<void> {
    RDBStoreUtil.createSportTable();
    RDBStoreUtil.initSportTable();
    RDBStoreUtil.createPlanTable();
    await RDBStoreUtil.queryAllPlans().then((value) => {
      this.plansSet = value;
    });
    this.refreshSelectOption();
  }

  async refreshSelectOption() {
    await RDBStoreUtil.queryAllPlansDuration().then((value) => {
      this.durationSet = value;
    });
    this.durationSelectOptions = [{ value: $r('app.string.ALL') }];
    for (let i = 0; i < this.durationSet.length; i++) {
      this.durationSelectOptions.push({ value: this.durationSet[i] + 'min' });
    }
  }

  build() {
    NavDestination() {
      Column() {
        Column() {
          Text($r('app.string.my_goal'))
            .width('100%')
            .font({
              size: '30fp',
              weight: 700
            })
            .margin({
              top: '48vp',
              bottom: '32vp'
            })
          Row() {
            Select(this.durationSelectOptions)
              .onSelect((index: number) => {
                if (index === 0) {
                  this.currentDuration = undefined;
                } else {
                  this.currentDuration = this.durationSet[index-1];
                }
              })
              .value($r('app.string.Duration'))
              .margin({ right: '25vp' })
            Select([{ value: $r('app.string.ALL') },
              { value: $r('app.string.Completed') },
              { value: $r('app.string.Uncompleted') }])
              .onSelect((index: number) => {
                if (index === 0) {
                  this.currentStatus = undefined;
                } else if (index === 1) {
                  this.currentStatus = true;
                } else {
                  this.currentStatus = false;
                }
              })
              .value($r('app.string.status'))
              .margin({ right: '25vp' })
            Image($r('app.media.reset'))
              .width(40)
              .onClick(async () => {
                await RDBStoreUtil.queryAllPlans().then((value) => {
                  this.plansSet = value;
                });
              })
              .margin({ right: '16vp' })
            Image($r('app.media.sift'))
              .width(40)
              .onClick(async () => {
                await RDBStoreUtil.conditionalPlansQuery(this.currentDuration, this.currentStatus).then((value) => {
                  this.plansSet = value;
                });
              })
              .margin({ right: '16vp' })
          }
          .width('100%')
          .margin({ bottom: '8vp' })

          List() {
            ForEach(this.plansSet, (item: GoalItem, index: number) => {
              ListItem() {
                Row() {
                  Column() {
                    Text(item.sportName)
                      .font({
                        size: '16fp',
                        weight: 500
                      })
                      .opacity(0.9)
                    Text(item.type)
                      .font({
                        size: '14fp',
                        weight: 400
                      })
                      .opacity(0.6)
                  }
                  .alignItems(HorizontalAlign.Start)
                  .margin({ left: '16vp' })

                  Text(item.duration + 'min')
                    .font({
                      size: '14vp',
                      weight: 400
                    })
                    .opacity(0.6)
                  Text(item.status)
                    .font({
                      size: '14vp',
                      weight: 400
                    })
                    .opacity(0.6)
                  Image($r('app.media.edit'))
                    .width('40vp')
                    .onClick(() => {
                      this.currentNumber = index;
                      this.currentPlan = item;
                      this.isUpdateShow = true;
                    })
                  Image($r('app.media.delete'))
                    .width('40vp')
                    .margin({ right: '16vp' })
                    .onClick(() => {
                      AlertDialog.show(
                        {
                          message: $r('app.string.delete_question'),
                          autoCancel: true,
                          alignment: DialogAlignment.Bottom,
                          gridCount: 4,
                          offset: { dx: 0, dy: -20 },
                          primaryButton: {
                            value: $r('app.string.Cancel'),
                            action: () => {
                              hilog.info(0x0000, TAG, 'Callback when the first button is clicked');
                            }
                          },
                          secondaryButton: {
                            enabled: true,
                            defaultFocus: true,
                            style: DialogButtonStyle.HIGHLIGHT,
                            value: $r('app.string.delete'),
                            action: async () => {
                              await RDBStoreUtil.deletePlan(item.id);
                              this.refreshSelectOption();
                              await RDBStoreUtil.queryAllPlans().then((value) => {
                                this.plansSet = value;
                              });
                            }
                          },
                          cancel: () => {
                            hilog.info(0x0000, TAG, 'Closed callbacks');
                          },
                          onWillDismiss: (dismissDialogAction: DismissDialogAction) => {
                            if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
                              dismissDialogAction.dismiss();
                            }
                            if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
                              dismissDialogAction.dismiss();
                            }
                          }
                        }
                      )

                    })
                }
                .width('100%')
                .height('100%')
                .justifyContent(FlexAlign.SpaceBetween)
              }
              .width('100%')
              .height('60vp')
            }, (item: GoalItem) => JSON.stringify(item))
          }
          .width('100%')
          .divider({
            strokeWidth: 1,
            color: '#1a000000',
            startMargin: 16,
            endMargin: 16
          })
          .bindSheet(this.isUpdateShow, this.updateBindSheet(this.currentPlan), {
            height: '320vp',
            title: { title: $r('app.string.bind_title') },
            onDisappear: () => {
              this.isUpdateShow = false;
            }
          })
        }

        Button($r('app.string.Add_Plans'))
          .width('100%')
          .margin({ bottom: '32vp' })
          .onClick(() => {
            this.isInsetShow = true;
          })
          .bindSheet(this.isInsetShow, this.insertBindSheet(), {
            height: '320vp',
            title: { title: $r('app.string.Add_Plans') },
            onDisappear: () => {
              this.isInsetShow = false;
            }
          })
      }
      .padding({
        left: '12vp',
        right: '12vp'
      })
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .backgroundColor('#F1F3F5')
    .hideTitleBar(true)
  }
}