import Constants from '../../common/Constants';

class CurrTmp {
  currentBp: string = 'unknown';

  set(val: string) {
    this.currentBp = val
  }
}

let BorderWH: Record<string, Color | number> = { 'color': Color.Blue, 'width': 2 }

@Entry
@Component
struct GridRowGridColPage {
  @State message: string = 'Hello World';
  @State currentBp: string = 'unknown';

  build() {
    Stack() {
      this.example10()
      Text(this.currentBp)
        .fontSize(40)
        .fontColor(Color.Red)
        .align(Alignment.Start)
        .offset({ bottom: 100 })
      Text(this.message)
        .fontSize(40)
        .fontColor(Color.Red)
        .align(Alignment.Start)
        .offset({ bottom: 150 })
    }
    .width(Constants.FULL_PERCENT).height(Constants.FULL_PERCENT)
    .backgroundColor(Color.Gray)
  }

  // 栅格组件的嵌套使用
  @Builder
  example10() {
    GridRow() {
      GridCol({ span: { sm: 12 } }) {
        GridRow() {
          GridCol({ span: { sm: 2 } }) {
            Row() {
              Text('left').fontSize(24)
            }
            .justifyContent(FlexAlign.Center)
            .height('90%')
          }.backgroundColor('#ff41dbaa')

          GridCol({ span: { sm: 10 } }) {
            Row() {
              Text('right').fontSize(24)
            }
            .justifyContent(FlexAlign.Center)
            .height('90%')
          }.backgroundColor('#ff4168db')
        }
        .backgroundColor($r('sys.color.comp_outline_color'))
        .onBreakpointChange((breakpoint) => {
          this.message = breakpoint
        })
      }

      GridCol({ span: { sm: 12 } }) {
        Row() {
          Text('footer').width('100%').textAlign(TextAlign.Center)
        }.width('100%').height('10%').backgroundColor(Color.Pink)
      }
    }.width('100%').height(300)
    .onBreakpointChange((breakpoint) => {
      this.currentBp = breakpoint
    })
  }

  // 当类型为GridColColumnOption时，支持六种不同尺寸（xs, sm, md, lg, xl, xxl）设备中子组件排序次序设置。在xs设备中，子组件排列顺序为1234；sm为2341，md为3412，lg为2431。
  @Builder
  example9() {
    GridRow() {
      GridCol({
        order: {
          xs: 1,
          sm: 5,
          md: 3,
          lg: 7
        }
      }) {
        Row() {
          Text('1')
        }.width('100%').height('50vp')
      }.backgroundColor(Color.Red)

      GridCol({
        order: {
          xs: 2,
          sm: 2,
          md: 6,
          lg: 1
        }
      }) {
        Row() {
          Text('2')
        }.width('100%').height('50vp')
      }.backgroundColor(Color.Orange)

      GridCol({
        order: {
          xs: 3,
          sm: 3,
          md: 1,
          lg: 6
        }
      }) {
        Row() {
          Text('3')
        }.width('100%').height('50vp')
      }.backgroundColor(Color.Yellow)

      GridCol({
        order: {
          xs: 4,
          sm: 4,
          md: 2,
          lg: 5
        }
      }) {
        Row() {
          Text('4')
        }.width('100%').height('50vp')
      }.backgroundColor(Color.Green)
    }
    .onBreakpointChange((breakpoint) => {
      this.currentBp = breakpoint
    })
  }

  // 当类型为number时，子组件在任何尺寸下排序次序一致。
  @Builder
  example8() {
    GridRow() {
      GridCol({ order: 4 }) {
        Row() {
          Text('1')
        }.width('100%').height('50vp')
      }.backgroundColor('rgb(213,213,213)')

      GridCol({ order: 3 }) {
        Row() {
          Text('2')
        }.width('100%').height('50vp')
      }.backgroundColor('rgb(150,150,150)')

      GridCol({ order: 2 }) {
        Row() {
          Text('3')
        }.width('100%').height('50vp')
      }.backgroundColor('rgb(0,74,175)')

      GridCol({ order: 1 }) {
        Row() {
          Text('4')
        }.width('100%').height('50vp')
      }.backgroundColor('rgb(39,135,217)')
    }
    .onBreakpointChange((breakpoint) => {
      this.currentBp = breakpoint
    })
  }

  @Builder
  example7() {
    GridRow() {
      ForEach(['rgb(213,213,213)', 'rgb(150,150,150)', 'rgb(0,74,175)', 'rgb(39,135,217)', 'rgb(61,157,180)',
        'rgb(23,169,141)', 'rgb(255,192,0)', 'rgb(170,10,33)'],
        (color: ResourceColor, index?: number | undefined) => {
          GridCol({
            offset: {
              xs: 1,
              sm: 2,
              md: 3,
              lg: 4
            }
          }) {
            Row() {
              Text('' + index)
            }.width('100%').height('50vp')
          }
          .backgroundColor(color)
        })
    }
    .onBreakpointChange((breakpoints) => {
      this.currentBp = breakpoints
    })
  }

  @Builder
  example6() {
    GridRow() {
      ForEach(['rgb(213,213,213)', 'rgb(150,150,150)', 'rgb(0,74,175)', 'rgb(39,135,217)', 'rgb(61,157,180)',
        'rgb(23,169,141)', 'rgb(255,192,0)', 'rgb(170,10,33)'],
        (color: ResourceColor, index?: number | undefined) => {
          GridCol({ offset: 2 }) {
            Row() {
              Text('' + index)
            }.width('100%').height('50vp')
          }
          .backgroundColor(color)
        })
    }
    .onBreakpointChange((breakpoint) => {
      this.currentBp = breakpoint
    })
  }

  @Builder
  example5() {
    GridRow({ columns: 8 }) {
      ForEach(['rgb(213,213,213)', 'rgb(150,150,150)', 'rgb(0,74,175)', 'rgb(39,135,217)', 'rgb(61,157,180)',
        'rgb(23,169,141)', 'rgb(255,192,0)', 'rgb(170,10,33)'],
        (color: ResourceColor, index?: number | undefined) => {
          GridCol({
            span: {
              xs: 1,
              sm: 2,
              md: 3,
              lg: 4
            }
          }) {
            Row() {
              Text(`${index}`)
            }.width('100%').height('50vp')
          }
          .backgroundColor(color)
        })
    }
    .onBreakpointChange((breakpoint) => {
      this.currentBp = breakpoint
    })
  }

  // 当columns类型为GridRowColumnOption时，支持下面六种不同尺寸（xs, sm, md, lg, xl, xxl）设备的总列数设置，各个尺寸下数值可不同。
  @Builder
  example4() {
    GridRow({
      columns: { sm: 4, md: 8 },
      breakpoints: { value: ['200vp', '300vp', '400vp', '500vp', '600vp'] }
    }) {
      ForEach(['rgb(213,213,213)', 'rgb(150,150,150)', 'rgb(0,74,175)', 'rgb(39,135,217)', 'rgb(61,157,180)',
        'rgb(23,169,141)', 'rgb(255,192,0)', 'rgb(170,10,33)', 'rgb(23,169,141)', 'rgb(255,192,0)', 'rgb(170,10,33)',
        'rgb(255,192,0)'],
        (item: ResourceColor, index?: number | undefined) => {
          GridCol() {
            Row() {
              Text(`${index}`)
            }.width('100%').height('50')
          }.backgroundColor(item)
        })
    }.onBreakpointChange((breakpoints) => {
      this.currentBp = breakpoints
    })
  }

  // 当columns为自定义值，栅格布局在任何尺寸设备下都被分为columns列。下面分别设置栅格布局列数为4和8，子元素默认占一列，效果如下：
  @Builder
  example3() {
    Column() {
      Text(this.currentBp).height(100)
      Row() {
        GridRow({ columns: 4 }) {
          ForEach(
            ['rgb(213,213,213)', 'rgb(150,150,150)', 'rgb(0,74,175)', 'rgb(39,135,217)', 'rgb(61,157,180)',
              'rgb(23,169,141)', 'rgb(255,192,0)', 'rgb(170,10,33)'],
            (item: ResourceColor, index?: number | undefined) => {
              GridCol() {
                Row() {
                  Text(`${index}`)
                }.width('100%').height('50')
              }.backgroundColor(item)
            })
        }
        .width('100%').height('100%')
        .onBreakpointChange((breakpoint: string) => {
          let CurrSet: CurrTmp = new CurrTmp()
          CurrSet.set(breakpoint)
          this.currentBp = breakpoint
        })
      }
      .height(160)
      .border(BorderWH)
      .width('90%')

      Row() {
        GridRow({ columns: 8 }) {
          ForEach(
            ['rgb(213,213,213)', 'rgb(150,150,150)', 'rgb(0,74,175)', 'rgb(39,135,217)', 'rgb(61,157,180)',
              'rgb(23,169,141)', 'rgb(255,192,0)', 'rgb(170,10,33)'],
            (item: ResourceColor, index?: number | undefined) => {
              GridCol() {
                Row() {
                  Text(`${index}`)
                }.width('100%').height('50')
              }.backgroundColor(item)
            })
        }
        .width('100%').height('100%')
        .onBreakpointChange((breakpoint: string) => {
          let CurrSet: CurrTmp = new CurrTmp()
          CurrSet.set(breakpoint)
        })
      }
      .height(160)
      .border(BorderWH)
      .width('90%')
    }.width(Constants.FULL_PERCENT).height(Constants.FULL_PERCENT)
  }

  @Builder
  example2() {
    GridRow() {
      ForEach(
        ['rgb(213,213,213)', 'rgb(150,150,150)', 'rgb(0,74,175)', 'rgb(39,135,217)', 'rgb(61,157,180)',
          'rgb(23,169,141)', 'rgb(255,192,0)', 'rgb(170,10,33)', 'rgb(213,213,213)', 'rgb(150,150,150)',
          'rgb(0,74,175)', 'rgb(39,135,217)'],
        (item: ResourceColor, index?: number | undefined) => {
          GridCol() {
            Row() {
              Text(`${index}`)
            }.width('100%').height('50')
          }.backgroundColor(item)
        }
      )
    }
  }

  @Builder
  example1() {
    GridRow({
      breakpoints: {
        value: ['200vp', '300vp', '400vp', '500vp', '600vp'],
        ////// xs //// sm ///// md ///// lg ////// xl //// xxl
        reference: BreakpointsReference.WindowSize
      }
    }) {
      ForEach(
        ['rgb(213,213,213)', 'rgb(150,150,150)', 'rgb(0,74,175)', 'rgb(39,135,217)', 'rgb(61,157,180)',
          'rgb(23,169,141)', 'rgb(255,192,0)', 'rgb(0,74,175)', 'rgb(39,135,217)', 'rgb(61,157,180)', 'rgb(23,169,141)',
          'rgb(255,192,0)', 'rgb(150,150,150)', 'rgb(0,74,175)', 'rgb(39,135,217)', 'rgb(61,157,180)',
          'rgb(23,169,141)', 'rgb(255,192,0)', 'rgb(0,74,175)', 'rgb(39,135,217)', 'rgb(61,157,180)', 'rgb(23,169,141)',
          'rgb(255,192,0)', 'rgb(170,10,33)'],
        (color: ResourceColor, index?: number | undefined) => {
          GridCol({
            span: {
              xs: 2, // 在最小宽度类型设备上，栅格子组件占据的栅格容器2列。
              sm: 3, // 在小宽度类型设备上，栅格子组件占据的栅格容器3列。
              md: 4, // 在中等宽度类型设备上，栅格子组件占据的栅格容器4列。
              lg: 6, // 在大宽度类型设备上，栅格子组件占据的栅格容器6列。
              xl: 8, // 在特大宽度类型设备上，栅格子组件占据的栅格容器8列。
              xxl: 12 // 在超大宽度类型设备上，栅格子组件占据的栅格容器12列。
            }
          }) {
            Row() {
              Text(`${index}`)
            }.width("100%").height('50vp')
          }.backgroundColor(color)
        })
    }
  }
}