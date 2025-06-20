import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { BusinessError } from '@kit.BasicServicesKit';


@Entry
@Component
struct Index {
  @State imgDatas: string[] = [];
  // 获取照片url集
  getAllImg() {
    try {
      let PhotoSelectOptions:photoAccessHelper.PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
      PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
      PhotoSelectOptions.maxSelectNumber = 5;
      let photoPicker:photoAccessHelper.PhotoViewPicker = new photoAccessHelper.PhotoViewPicker();
      photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult:photoAccessHelper.PhotoSelectResult) => {
        this.imgDatas = PhotoSelectResult.photoUris;
        console.info('PhotoViewPicker.select successfully, PhotoSelectResult uri: ' + JSON.stringify(PhotoSelectResult));
      }).catch((err:Error) => {
        let message = (err as BusinessError).message;
        let code = (err as BusinessError).code;
        console.error(`PhotoViewPicker.select failed with. Code: ${code}, message: ${message}`);
      });
    } catch (err) {
      let message = (err as BusinessError).message;
      let code = (err as BusinessError).code;
      console.error(`PhotoViewPicker failed with. Code: ${code}, message: ${message}`);    }
  }


  // aboutToAppear中调用上述函数，获取图库的所有图片url，存在imgDatas中
  async aboutToAppear() {
    //this.getAllImg();
  }
  // 使用imgDatas的url加载图片。
  build() {
    Column() {
      Button(){
        Text('select image')
      }.onClick(() => {
        this.getAllImg()
      })
      Grid() {
        ForEach(this.imgDatas, (item:string) => {
          GridItem() {
            Image(item)
              .width(200)
          }
        }, (item:string):string => JSON.stringify(item))
      }
    }.width('100%').height('100%')
  }
}