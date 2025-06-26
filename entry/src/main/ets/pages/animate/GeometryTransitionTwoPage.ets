import { curves } from '@kit.ArkUI';

@Entry
@Component
struct GeometryTransitionTwoPage {
  @State isShow: boolean = false;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      if (this.isShow) {
        Image($r('app.media.icon' +
          ''))
          .autoResize(false)
          .clip(true)
          .width(200)
          .height(200)
          .borderRadius(100)
          .geometryTransition("picture")
          .transition(TransitionEffect.OPACITY)
            // 在打断场景下，即动画过程中点击页面触发下一次转场，如果不加id，则会出现重影
            // 加了id之后，新建的spring图片会复用之前的spring图片节点，不会重新创建节点，也就不会有重影问题
            // 加id的规则为加在if和else下的第一个节点上，有多个并列节点则也需要进行添加
          .id('item1')
      } else {
        // geometryTransition此处绑定的是容器，那么容器内的子组件需设为相对布局跟随父容器变化，
        // 套多层容器为了说明相对布局约束传递
        Column() {
          Column() {
            Image($r('app.media.icon'))
              .size({ width: '100%', height: '100%' })
          }
          .size({ width: '100%', height: '100%' })
        }
        .width(100)
        .height(100)
        // geometryTransition会同步圆角，但仅限于geometryTransition绑定处，此处绑定的是容器
        // 则对容器本身有圆角同步而不会操作容器内部子组件的borderRadius
        .borderRadius(50)
        .clip(true)
        .geometryTransition("picture")
        // transition保证节点离场不被立即析构，设置通用转场效果
        .transition(TransitionEffect.OPACITY)
        .position({ x: 40, y: 40 })
        .id('item2')
      }
    }
    .onClick(() => {
      this.getUIContext()?.animateTo({
        curve: curves.springMotion()
      }, () => {
        this.isShow = !this.isShow;
      })
    })
    .size({ width: '100%', height: '100%' })
  }
}