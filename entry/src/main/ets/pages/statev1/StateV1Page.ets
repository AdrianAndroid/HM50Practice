@Entry
@Component
struct StateV1Page {
  @State vm: PlayDetailViewModel = new PlayDetailViewModel();

  build() {
    Stack() {
      Text(this.vm.coverUrl).width(100).height(100).backgroundColor(this.vm.coverUrl)
      Row() {
        Button('点击改变颜色')
          .onClick(() => {
            let self = this.vm;
            this.vm.changeCoverUrl(self);
          })
      }
      .offset({top: 300})

    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Top)
  }
}

export default class PlayDetailViewModel {
  coverUrl: string = '#00ff00';

  changeCoverUrl= (model:PlayDetailViewModel)=> {
    model.coverUrl = '#00F5FF';
  }

}