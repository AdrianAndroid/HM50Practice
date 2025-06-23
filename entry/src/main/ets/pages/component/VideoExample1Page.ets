@Entry
@Component
struct VideoExample1Page {
  private controller: VideoController = new VideoController()
  private previewUris: Resource = $r('app.media.short_video1')
  private innerResource: Resource = $rawfile('tab_play_video.MP4')

  build() {
    Column() {
      Video({
        src: this.innerResource,
        previewUri: this.previewUris,
        controller: this.controller
      })
    }
  }
}