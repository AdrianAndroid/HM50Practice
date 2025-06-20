// write.ets
import { fileIo } from '@kit.CoreFileKit'


// 定义并发函数，内部密集调用I/O能力
// 写入文件的实现
export async function write(data: string, filePath: string): Promise<void> {
  let file: fileIo.File = await fileIo.open(filePath, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
  await fileIo.write(file.fd, data);
  fileIo.close(file);
}