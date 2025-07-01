import { JSON } from '@kit.ArkTS';

@Entry
@Component
struct GSMultiLevelGesturePage {
  @State message: string = 'Hello World';

  build() {
    Scroll() {
      Column() {
        Text('默认多层级手势事件')
        Text('触摸事件')
        this.exampleTouchEvent()

        Text('手势与事件1')
        this.exampleGestureAndEventOne()
        Text('手势与事件2')
        this.exampleGestureAndEventTwo()

        Text('自定义控制的多层级手势事件')
        Text('responseRegion对手势和事件的控制')
        this.exampleResponseRegion()

        Text('hitTestBehavior对手势和事件的控制1')
        this.exampleHitTestBehaviorOne()
        Text('hitTestBehavior对手势和事件的控制2')


        Text('绑定手势方法对手势的控制')
      }
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  exampleHitTestBehaviorOne() {
    Column() {
      Text('父容器');
      Column() {
        Text('容器1').width(60).height(60).margin({bottom: 50});
      }
      .alignItems(HorizontalAlign.Start)
      .width(150)
      .margin({bottom: 50})
      .border({ width: 1 })
      .focusOnTouch(true)
      .onTouch((event: TouchEvent) => {
        this.logTouchEvent('容器1', event);
      })
      .gesture(TapGesture({ count: 1 }).onAction((event: GestureEvent) => {
        console.debug(`GSMultiLevelGesturePage-容器1`, JSON.stringify(event));
      }))

      Column() {
        Text('容器2').margin({bottom: 50});
        Column() {
          Text('容器3').margin({bottom: 50});
        }
        .alignItems(HorizontalAlign.Start)
        .width(150)
        .margin({bottom: 50})
        .border({ width: 1 })
        .focusOnTouch(true)
        .onTouch((event: TouchEvent) => {
          this.logTouchEvent('容器3', event);
        })
        .gesture(TapGesture({ count: 1 }).onAction((event: GestureEvent) => {
          console.debug(`GSMultiLevelGesturePage-容器3`, JSON.stringify(event));
        }))
      }
      .alignItems(HorizontalAlign.Start)
      .width(150)
      .margin({bottom: 50})
      .border({ width: 1 })
      .focusOnTouch(true)
      .onTouch((event: TouchEvent) => {
        this.logTouchEvent('容器2', event);
      })
      .gesture(TapGesture({ count: 1 }).onAction((event: GestureEvent) => {
        console.debug(`GSMultiLevelGesturePage-容器2`, JSON.stringify(event));
      }))
      .hitTestBehavior(HitTestMode.Block)
    }
    .width(200)
    .margin({bottom: 50})
    .border({ width: 1 })
    .focusOnTouch(true)
    .onTouch((event: TouchEvent) => {
      this.logTouchEvent('父容器', event);
    })
    .gesture(TapGesture({ count: 1 }).onAction((event: GestureEvent) => {
      console.debug(`GSMultiLevelGesturePage-容器1`, JSON.stringify(event));
    }))
  }

  @Builder
  exampleResponseRegion() {
    Column() {
      Text('父容器');
      Column() {
        Text('容器1').width(60).height(60).backgroundColor(Color.Black);
      }
      .alignItems(HorizontalAlign.Start)
      .width(150)
      .height(100)
      .border({ width: 1 })
      .focusOnTouch(true)
      .onTouch((event: TouchEvent) => {
        this.logTouchEvent('容器1', event);
      })
      .gesture(TapGesture({ count: 1 }).onAction((event: GestureEvent) => {
        console.debug(`GSMultiLevelGesturePage-容器1`, JSON.stringify(event));
      }))
      .responseRegion({ width: 60, height: 60 });
    }
    .width(200)
    .height(200)
    .border({ width: 1 })
    .focusOnTouch(true)
    .onTouch((event: TouchEvent) => {
      this.logTouchEvent('父容器', event);
    })
  }

  @Builder
  exampleGestureAndEventTwo() {
    Column() {
      Text('容器1');
    }
    .width(150)
    .height(100)
    .border({ width: 1 })
    .gesture(GestureGroup(
      GestureMode.Exclusive,
      TapGesture({ count: 1 }).onAction((event: GestureEvent | undefined) => {
        console.debug(`GSMultiLevelGesturePage-容器1`, JSON.stringify(event));
      }),
      PanGesture({ distance: 5 })
        .onActionStart((event: GestureEvent) => {
          console.debug(`GSMultiLevelGesturePage-onActionStart`, JSON.stringify(event));
        })
        .onActionUpdate((event: GestureEvent) => {
          console.debug(`GSMultiLevelGesturePage-onActionUpdate`, JSON.stringify(event));
        })
        .onActionEnd((event: GestureEvent) => {
          console.debug(`GSMultiLevelGesturePage-onActionEnd`, JSON.stringify(event));
        })
        .onActionCancel(() => {
          console.debug(`GSMultiLevelGesturePage-onActionCancel`);
        })
    ))

    // .gesture(TapGesture({ count: 1 }).onAction((event: GestureEvent | undefined) => {
    //   console.debug(`GSMultiLevelGesturePage-容器1`, JSON.stringify(event));
    // }));
  }

  @Builder
  exampleGestureAndEventOne() {
    Column() {
      Text('父容器');
      Column() {
        Text('容器1');
      }
      .width(150)
      .height(100)
      .border({ width: 1 })
      .gesture(TapGesture({ count: 1 }).onAction((event: GestureEvent | undefined) => {
        console.debug(`GSMultiLevelGesturePage-容器1`, JSON.stringify(event));
      }));
    }
    .width(200)
    .height(200)
    .border({ width: 1 })
    .gesture(TapGesture({ count: 1 }).onAction((event: GestureEvent | undefined) => {
      console.debug(`GSMultiLevelGesturePage-父容器`, JSON.stringify(event));
    }))
  }

  @Builder
  exampleTouchEvent() {
    Column() {
      Text('父容器');
      Column() {
        Text('容器1');
      }
      .width(150)
      .height(100)
      .border({ width: 1 })
      .focusOnTouch(true)
      .onTouch((event: TouchEvent) => {
        this.logTouchEvent('容器1', event);
      });

      Column() {
        Text('容器2');
      }
      .width(150)
      .height(100)
      .border({ width: 1 })
      .focusOnTouch(true)
      .onTouch((event: TouchEvent) => {
        this.logTouchEvent('容器2', event);
      });
    }
    .width(200)
    .height(300)
    .border({ width: 1 })
    .focusOnTouch(true)
    .onTouch((event: TouchEvent) => {
      this.logTouchEvent('父容器', event);
    })
  }

  logTouchEvent(tag: string, event: TouchEvent) {
    // let type = this.getTouchEventType(event)
    // this.getSingleTouchObject(event.touches[0])
    // Logger.debug(tag, `type=${type} `)dfdfd
    for (let touchesElement of event.touches) {
      console.debug(`GSMultiLevelGesturePage${tag}`, this.getSingleTouchObject(touchesElement))
    }
    //Logger.debug(`GSMultiLevelGesturePage${tag}`, JSON.stringify(event))
  }

  getSingleTouchObject(touch: TouchObject) {
    let type = touch.type
    let id = touch.id
    let displayX = touch.displayX
    let displayY = touch.displayY
    let windowX = touch.windowX
    let windowY = touch.windowY
    let x = touch.x
    let y = touch.y
    let hand = touch.hand
    let pressedTime = touch.pressedTime
    let pressure = touch.pressure
    let width = touch.width
    let height = touch.height
    // return `type=${this.getTouchEventType(type), }`
    let jjjj =
      `id=${id},type=${this.getType(type)},displayXY=(${displayX},${displayY}),windowXY=(${windowX}${windowY}),xy=(${x}${y}),widthheight=(${width}${height})pressure=${pressure},pressedTime=${pressedTime},hand=${JSON.stringify(hand)}`
    return JSON.stringify(touch)
  }

  getType(type: TouchType): string {
    if (type === TouchType.Up) {
      return 'Up'
    } else if (type === TouchType.Down) {
      return 'Down'
    } else if (type === TouchType.Cancel) {
      return 'Cancel'
    } else if (type === TouchType.Move) {
      return 'Move'
    } else {
      return 'none'
    }
  }
}