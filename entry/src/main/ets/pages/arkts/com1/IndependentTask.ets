// IndependentTask.ets
import { IconItemSource } from './IconItemSource';

// 在Task中执行的方法，需要添加@Concurrent注解，否则无法正常调用。
@Concurrent
export function loadPicture(count: number): IconItemSource[] {
  let iconItemSourceList: IconItemSource[] = [];
  // 遍历添加6*count个IconItem的数据
  for (let index = 0; index < count; index++) {
    const numStart: number = index * 6;
    // 此处循环使用6张图片资源
    iconItemSourceList.push(new IconItemSource('$media:startIcon', `item${numStart + 1}`));
    iconItemSourceList.push(new IconItemSource('$media:background', `item${numStart + 2}`));
    iconItemSourceList.push(new IconItemSource('$media:foreground', `item${numStart + 3}`));
    iconItemSourceList.push(new IconItemSource('$media:startIcon', `item${numStart + 4}`));
    iconItemSourceList.push(new IconItemSource('$media:background', `item${numStart + 5}`));
    iconItemSourceList.push(new IconItemSource('$media:foreground', `item${numStart + 6}`));
  }
  return iconItemSourceList;
}