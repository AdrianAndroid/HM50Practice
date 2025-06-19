import { common } from '@kit.AbilityKit';
import { buffer } from '@kit.ArkTS';
import { fileIo, ReadOptions } from '@kit.CoreFileKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import Logger from '../common/Logger';

const TAG: string = '[Page_Context]';
const DOMAIN_NUMBER: number = 0xFF00;

@Entry
@Component
struct ContextGetPage {
  @State message: string = 'Hello World';
  private context = getContext(this) as common.UIAbilityContext;

  otherPrintDirs() {
    let applicationContext = this.context.getApplicationContext();
    // 获取应用文件路径
    let filesDir = applicationContext.filesDir;
    hilog.info(DOMAIN_NUMBER, TAG, `filePath: ${filesDir}`);
    // 文件不存在时创建并打开文件，文件存在时打开文件
    let file = fileIo.openSync(filesDir + '/test.txt', fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
    // 写入一段内容至文件
    let writeLen = fileIo.writeSync(file.fd, "Try to write str.");
    hilog.info(DOMAIN_NUMBER, TAG, `The length of str is: ${writeLen}`);
    // 创建一个大小为1024字节的ArrayBuffer对象，用于存储从文件中读取的数据
    let arrayBuffer = new ArrayBuffer(1024);
    // 设置读取的偏移量和长度
    let readOptions: ReadOptions = {
      offset: 0,
      length: arrayBuffer.byteLength
    };
    // 读取文件内容到ArrayBuffer对象中，并返回实际读取的字节数
    let readLen = fileIo.readSync(file.fd, arrayBuffer, readOptions);
    // 将ArrayBuffer对象转换为Buffer对象，并转换为字符串输出
    let buf = buffer.from(arrayBuffer, 0, readLen);
    hilog.info(DOMAIN_NUMBER, TAG, `the content of file: ${buf.toString()}`);
    // 关闭文件
    fileIo.closeSync(file);
  }

  printDirs(): string {
    let applicationContext = this.context.getApplicationContext()
    let bundleCodeDir = applicationContext.bundleCodeDir
    let cacheDir = applicationContext.cacheDir
    let filesDir = applicationContext.filesDir
    let preferencesDir = applicationContext.preferencesDir
    let tempDir = applicationContext.tempDir
    let databaseDir = applicationContext.databaseDir
    let distributedFilesDir = applicationContext.distributedFilesDir
    let resourceDir = applicationContext.resourceDir
    let cloudFileDir = applicationContext.cloudFileDir
    let describe = JSON.stringify({
      'bundleCodeDir ': bundleCodeDir,
      'cacheDir': cacheDir,
      'filesDir': filesDir,
      'preferencesDir': preferencesDir,
      'tempDir': tempDir,
      'databaseDir': databaseDir,
      'distributedFilesDir': distributedFilesDir,
      'resourceDir ': resourceDir,
      'cloudFileDir': cloudFileDir
    })
    Logger.info('ContextGetPage', describe)
    return describe
  }

  build() {
    Row() {
      Column() {
        Blank()
          .height(100)
        Text(this.message)
        Button() {
          Text('create file')
            .fontSize(30)
            .onClick(() => {
              this.message = this.printDirs()
            })
        }
      }
    }
  }
}