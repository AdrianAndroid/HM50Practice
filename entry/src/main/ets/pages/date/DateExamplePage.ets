import { intl } from '@kit.LocalizationKit';

class DataFormat {
  static dateFormat(date: Date): string {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return `${year}-${month}-${day}`; // 按 pattern 拼接
  }
}

@ComponentV2
struct DateExamplePage {
  build() {
  }

  test () {
    // 一、创建Date对象
    //// 1. 当前时间：new Date() 无参构造函数获取当前日期时间^7^。
    let currentDate: Date = new Date();
    //// 2. 指定时间戳：通过 Unix 时间戳（毫秒数）创建^4^。
    let timestamp = 1728000000000; // 示例时间戳
    let dateFromTimestamp = new Date(timestamp);
    //// 3. 指定年月日：通过构造函数传参（注意月份从 0 开始计数）^7^。
    let specificDate = new Date(2025, 6, 16); // 实际为 2025年7月16日
    // 二、获取日期各部分
    let year = currentDate.getFullYear(); // 年份
    let month = currentDate.getMonth() + 1; // 月份需+1修正[^7^]
    let day = currentDate.getDate(); // 日期
    let hours = currentDate.getHours(); // 小时
    // 三、日期格式化
    //// 1. 自定义格式：手动拼接字符串^8^。‘
    let formattedDate = `${year}-${month.toString().padStart(2, '0')}-${day.toString().padStart(2, '0')}`;
    //// 2. 工具类封装：
    // 引用工具类[^14^]
    // import DataFormat from './DataFormat';
    let formatted = DataFormat.dateFormat(currentDate); // 输出 "2025-07-16"
    //// 3. 国际化支持：使用 intl 模块适配不同地区^15^。
    // import { intl } from '@kit.LocalizationKit';
    let formatter = new intl.DateTimeFormat('zh-Hans', { dateStyle: 'full' });
    console.log(formatter.format(currentDate)); // "2025年7月16日星期三"

    // 四、日期计算
    //// 1.增减天数
    let tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1); // 增加一天[^7^]
    //// 2.时间戳运算
    let nextWeekTimestamp = Date.now() + 7 * 24 * 3600 * 1000; // 当前时间戳+7天[^7^]

    // 五、注意事项
    //// 5.1 月份处理：getMonth() 返回 0-11，使用时需+1^7^。
    //// 5.2 时区问题：默认使用系统时区，跨时区应用需额外处理^6^。
    //// 5.3 三方库推荐：复杂操作可引入 dayjs 等库简化逻辑^6^。
  }
}