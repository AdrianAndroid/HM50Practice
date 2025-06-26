import { createPostNode, getPostNode, PostNode } from './PostNode';
import { componentUtils, curves } from '@kit.ArkUI';
class PostData {
  avatar: Resource = $r('app.media.img');
  name: string = '';
  message: string = '';
  images: Resource[] = [];
}
/**
 * 不新建容器并直接变化原容器
 */
@Entry
@Component
struct ShareAnimate1Page {
  @State message: string = 'Hello World';
  @State isExpand: boolean = false;
  @State @Watch('onItemClicked') selectedIndex: number = -1;

  private allPostData: PostData[] = [
    { avatar: $r('app.media.img'), name: 'Alice', message: '天气晴朗',
      images: [$r('app.media.img_1'), $r('app.media.img_2')] },
    { avatar: $r('app.media.add'), name: 'Bob', message: '你好世界',
      images: [$r('app.media.img_1')] },
    { avatar: $r('app.media.video'), name: 'Carl', message: '万物生长',
      images: [$r('app.media.img_1'), $r('app.media.img_2'), $r('app.media.img_3')] }];

  private onItemClicked(): void {
    if (this.selectedIndex < 0) {
      return;
    }
    this.getUIContext()?.animateTo({
      duration: 350,
      curve: Curve.Friction
    }, () => {
      this.isExpand = !this.isExpand;
    });
  }
  build() {
    Column({ space: 20 }) {
      ForEach(this.allPostData, (postData: PostData, index: number) => {
        // 当点击了某个post后，会使其余的post消失下树
        if (!this.isExpand || this.selectedIndex === index) {
          Column() {
            Post({ data: postData, selecteIndex: this.selectedIndex, index: index })
          }
          .width('100%')
          // 对出现消失的post添加透明度转场和位移转场效果
          .transition(
            TransitionEffect.OPACITY
              .combine(TransitionEffect.translate({ y: index < this.selectedIndex ? -250 : 250 }))
              .animation({ duration: 350, curve: Curve.Friction})
          )
        }
      }, (postData: PostData, index: number) => index.toString())
    }
    .size({ width: '100%', height: '100%' })
    .backgroundColor('#40808080')
    .height('100%')
    .width('100%')
  }
}

@Component
export default struct  Post {
  @Link selecteIndex: number;

  @Prop data: PostData;
  @Prop index: number;

  @State itemHeight: number = 250;
  @State isExpand: boolean = false;
  @State expandImageSize: number = 100;
  @State avatarSize: number = 50;

  build() {
    Column({ space: 20 }) {
      Row({ space: 10 }) {
        Image(this.data.avatar)
          .size({ width: this.avatarSize, height: this.avatarSize })
          .borderRadius(this.avatarSize / 2)
          .clip(true)
        Text(this.data.name)
      }
      .justifyContent(FlexAlign.Start)

      Text(this.data.message)

      Row({ space: 15 }) {
        ForEach(this.data.images, (imageResource: Resource, index: number) => {
          Image(imageResource).size({ width: this.expandImageSize, height: this.expandImageSize })
        }, (imageResource: Resource, index: number) => index.toString())
      }

      // 展开态下组件增加的内容
      if (this.isExpand) {
        Column() {
          Text('评论区')
            // 对评论区文本添加出现消失转场效果
            .transition( TransitionEffect.OPACITY
              .animation({ duration: 350, curve: Curve.Friction }))
            .padding({ top: 10 })
        }
        .backgroundColor(Color.Green)
        .transition(TransitionEffect.asymmetric(
          TransitionEffect.opacity(0.99).animation({ duration: 350, curve: Curve.Friction }),
          TransitionEffect.OPACITY.animation({ duration: 0 })
        ))
        .size({ width: '100%'})
      }
    }
    .backgroundColor(Color.White)
    .size({ width: '100%', height: this.itemHeight })
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 10, top: 10 })
    .onClick(() => {
      this.selecteIndex = -1;
      this.selecteIndex = this.index;
      this.getUIContext()?.animateTo({ duration: 350, curve: Curve.Friction }, () => {
        // 对展开的post做宽高动画，并对头像尺寸和图片尺寸加动画
        this.isExpand = !this.isExpand;
        this.itemHeight = this.isExpand ? 780 : 250;
        this.avatarSize = this.isExpand ? 75: 50;
        this.expandImageSize = (this.isExpand && this.data.images.length > 0)
          ? (360 - (this.data.images.length + 1) * 15) / this.data.images.length
          : 100;
      })
    })
  }
}