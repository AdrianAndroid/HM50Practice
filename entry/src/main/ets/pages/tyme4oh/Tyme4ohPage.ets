import {
  Duty,
  EarthBranch,
  Element,
  FetusDay,
  FetusMonth,
  JulianDay,
  KitchenGodSteed,
  LegalHoliday,
  LunarDay,
  LunarFestival,
  LunarHour,
  LunarMonth, LunarSeason,
  LunarWeek,
  LunarYear, NineStar,
  Phase,
  SixtyCycle,
  SixtyCycleMonth,
  SixtyCycleYear,
  SolarDay,
  SolarMonth,
  SolarTerm,
  SolarTime,
  SolarYear,
  TwelveStar,
  Twenty,
  TwentyEightStar,
  Zodiac} from 'tyme4oh';
import Logger from '../../common/Logger';
import { FULL_PERCENT } from '../../model/ConstantsData';
import { JSON } from '@kit.ArkTS';

// https://6tail.cn/tyme.html

@Builder
export function PageBuilder(name: string, param: Object) {
  Tyme4ohPage()
}

class Pair<T, U> {
  first: T;
  second: U;

  constructor(first: T, second: U) {
    this.first = first;
    this.second = second;
  }
}


@Builder
function dt() {
  Column() {
    Text('hello').fontColor(Color.Black)

  }
  .alignItems(HorizontalAlign.Start)
  .width(FULL_PERCENT)
}

@Component
struct Tyme4ohPage {
  private pathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          // ClickDisplayContent({title:'前言 pre'}) { this.lunarYear() }
          ClickDisplayContent({title:'农历年 LunarYear'}) { this.buildLunarYear() }
          ClickDisplayContent({title:'农历季节 LunarSeason'}) { this.buildLunarSeason() }
          ClickDisplayContent({title:'农历月 LunarMonth'}) { this.buildLunarMonth() }
          ClickDisplayContent({title:'农历周 LunarWeek'}) { this.buildLunarWeek() }
          ClickDisplayContent({title:'农历日 LunarDay'}) { this.buildLunarDay() }
          ClickDisplayContent({title:'农历时辰 LunarHour'}) { this.buildLunarHour() }
          ClickDisplayContent({title:'藏历年 RabByungYear'}) { this.buildRabByungYear() }
          ClickDisplayContent({title:'藏历月 RabByungMonth'}) { this.buildRabByungMonth() }
          ClickDisplayContent({title:'藏历日 RabByungDay'}) { this.buildRabByungDay() }
          ClickDisplayContent({title:'干支年 SixtyCycleYear'}) { this.buildSixtyCycleYear() }
          ClickDisplayContent({title:'干支月 SixtyCycleMonth'}) { this.buildSixtyCycleMonth() }
          ClickDisplayContent({title:'干支日 SixtyCycleDay'}) { this.buildSixtyCycleDay() }
          ClickDisplayContent({title:'干支时辰 SixtyCycleHour'}) { this.buildSixtyCycleHour() }
          ClickDisplayContent({title:'公历年 SolarYear'}) { this.buildSolarYear() }
          ClickDisplayContent({title:'公历半年 SolarHalfYear'}) { this.buildSolarHalfYear() }
          ClickDisplayContent({title:'公历季度 SolarSeason'}) { this.buildSolarSeason() }
          ClickDisplayContent({title:'公历月 SolarMonth'}) { this.buildSolarMonth() }
          ClickDisplayContent({title:'公历周 SolarWeek'}) { this.buildSolarWeek() }
          ClickDisplayContent({title:'公历日 SolarDay'}) { this.buildSolarDay() }
          ClickDisplayContent({title:'公历时刻 SolarTime'}) { this.buildSolarTime() }
          ClickDisplayContent({title:'生肖 Zodiac轮回'}) { this.buildZodiac() }
          ClickDisplayContent({title:'月相 Phase轮回'}) { this.buildPhase() }
          ClickDisplayContent({title:'星座 Constellation轮回'}) { this.buildConstellation() }
          ClickDisplayContent({title:'节气 SolarTerm轮回'}) { this.buildSolarTerm() }
          ClickDisplayContent({title:'儒略日 JulianDay'}) { this.buildJulianDay() }
          ClickDisplayContent({title:'法定假日 LegalHoliday'}) { this.buildLegalHoliday() }
          ClickDisplayContent({title:'公历现代节日 SolarFestival'}) { this.buildSolarFestival() }
          ClickDisplayContent({title:'农历传统节日 LunarFestival'}) { this.buildLunarFestival() }
          ClickDisplayContent({title:'星期 Week轮回'}) { this.buildWeek() }
          ClickDisplayContent({title:'三候 ThreePhenology轮回'}) { this.buildThreePhenology() }
          ClickDisplayContent({title:'三伏天 DogDay'}) { this.buildDogDay() }
          ClickDisplayContent({title:'五行 Element轮回'}) { this.buildElement() }
          ClickDisplayContent({title:'六曜 SixStar轮回'}) { this.buildSixStar() }
          ClickDisplayContent({title:'小六壬 MinorRen轮回'}) { this.buildMinorRen() }
          ClickDisplayContent({title:'七曜 SevenStar轮回'}) { this.buildSevenStar() }
          ClickDisplayContent({title:'八字 EightChar'}) { this.buildEightChar() }
          ClickDisplayContent({title:'九野 Land轮回'}) { this.buildLand() }
          ClickDisplayContent({title:'九星 NineStar轮回'}) { this.buildNineStar() }
          ClickDisplayContent({title:'北斗九星 Dipper轮回'}) { this.buildDipper() }
          ClickDisplayContent({title:'数九天 NineDay'}) { this.buildNineDay() }
          ClickDisplayContent({title:'十神 TenStar轮回'}) { this.buildTenStar() }
          ClickDisplayContent({title:'长生十二神 Terrain轮回'}) { this.buildTerrain() }
          ClickDisplayContent({title:'建除十二值神 Duty轮回'}) { this.buildDuty() }
          ClickDisplayContent({title:'黄道黑道十二神 TwelveStar轮回'}) { this.buildTwelveStar() }
          ClickDisplayContent({title:'黄道黑道 Ecliptic轮回'}) { this.buildEcliptic() }
          ClickDisplayContent({title:'二十八宿 TwentyEightStar轮回'}) { this.buildTwentyEightStar() }
          ClickDisplayContent({title:'七十二候 PhenologyDay'}) { this.buildPhenologyDay() }
          ClickDisplayContent({title:'干支 SixtyCycle轮回'}) { this.buildSixtyCycle() }
          ClickDisplayContent({title:'天干 HeavenStem轮回'}) { this.buildHeavenStem() }
          ClickDisplayContent({title:'地支 EarthBranch轮回'}) { this.buildEarthBranch() }
          ClickDisplayContent({title:'藏干 HideHeavenStem'}) { this.buildHideHeavenStem() }
          ClickDisplayContent({title:'人元司令分野 HideHeavenStemDay'}) { this.buildHideHeavenStemDay() }
          ClickDisplayContent({title:'纳音 Sound轮回'}) { this.buildSound() }
          ClickDisplayContent({title:'彭祖百忌 PengZu'}) { this.buildPengZu() }
          ClickDisplayContent({title:'吉凶 Luck轮回'}) { this.buildLuck() }
          ClickDisplayContent({title:'方位 Direction轮回'}) { this.buildDirection() }
          ClickDisplayContent({title:'宫 Zone轮回'}) { this.buildZone() }
          ClickDisplayContent({title:'神兽 Beast轮回'}) { this.buildBeast() }
          ClickDisplayContent({title:'动物 Animal轮回'}) { this.buildAnimal() }
          ClickDisplayContent({title:'元 Sixty轮回'}) { this.buildSixty() }
          ClickDisplayContent({title:'运 Twenty轮回'}) { this.buildTwenty() }
          ClickDisplayContent({title:'旬 Ten轮回'}) { this.buildTen() }
          ClickDisplayContent({title:'梅雨天 PlumRainDay'}) { this.buildPlumRainDay() }
          ClickDisplayContent({title:'逐月胎神 FetusMonth轮回'}) { this.buildFetusMonth() }
          ClickDisplayContent({title:'逐日胎神 FetusDay'}) { this.buildFetusDay() }
          ClickDisplayContent({title:'天干六甲胎神 FetusHeavenStem'}) { this.buildFetusHeavenStem() }
          ClickDisplayContent({title:'地支六甲胎神 FetusEarthBranch'}) { this.buildFetusEarthBranch() }
          ClickDisplayContent({title:'灶马头 KitchenGodSteed'}) { this.buildKitchenGodSteed() }
          ClickDisplayContent({title:'宜忌 Taboo'}) { this.buildTaboo() }
          ClickDisplayContent({title:'神煞 God'}) { this.buildGod() }
          ClickDisplayContent({title:'童限 ChildLimit'}) { this.buildChildLimit() }
          ClickDisplayContent({title:'大运 DecadeFortune'}) { this.buildDecadeFortune() }
          ClickDisplayContent({title:'小运 Fortune'}) { this.buildFortune() }
          ClickDisplayContent({title:'枚举 Enum'}) { this.buildEnum() }
        }
      }
      .height('100%')
      .width('100%')
    }
    .onReady((callback) => {
      this.pathStack = callback.pathStack
    })
  }

  private info(title: string, msg: string) {
    Logger.info('Tyme4ohPage111', title + ' : ' + msg)
  }

  @Builder
  buildEmpty() {
    Column() {
      Text('未实现').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }

  fontSize: number = 30

  // '前言 pre'
  // '农历年 LunarYear'
  @Builder
  buildLunarYear() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      // 1. 年初始化，支持-1到9999年
      const lunarYear: LunarYear = LunarYear.fromYear(2023)
      // 2. 从农历月LunarMonth得到农历年
      const lunarMonth2: LunarMonth = LunarMonth.fromYm(2023, 1)
      const lunarYear2: LunarYear = lunarMonth2.getLunarYear()
      // 1.年 得到2023
      const year: number = lunarYear.getYear();
      this.info('1.年', JSON.stringify(year))
      // 2.当年的总天数
      const dayCount: number = lunarYear.getDayCount();
      this.info('2.当年的总天数', JSON.stringify(dayCount))
      // 3. 当年的闰月月份
      const leapMonth: number = lunarYear.getLeapMonth();
      this.info('3. 当年的闰月月份', JSON.stringify(leapMonth))
      // 4. 当年的干支
      const sixtyCycle: SixtyCycle = lunarYear.getSixtyCycle();
      this.info('4. 当年的干支', JSON.stringify(sixtyCycle))
      // 5.运
      const twenty: Twenty = lunarYear.getTwenty();
      this.info('5.运', JSON.stringify(twenty))
      // 6.九星
      const nineStar: NineStar = lunarYear.getNineStar();
      this.info('6.九星', JSON.stringify(nineStar))
      // 7.太岁方位
      const direction12 = lunarYear.getJupiterDirection();
      this.info('7.太岁方位', JSON.stringify(direction12))
      // 8.农历月列表
      const months: LunarMonth[] = lunarYear.getMonths();
      this.info('8.农历月列表', JSON.stringify(months))
      // 9.灶码头
      const kitchenGodSteed = lunarYear.getKitchenGodSteed();
      this.info('9.灶码头', JSON.stringify(kitchenGodSteed))
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '农历季节 LunarSeason'
  @Builder
  buildLunarSeason() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      // 1. 从农历年、月初始化
      const lunarMonth: LunarMonth = LunarMonth.fromYm(2023, 5);
      // 2. 从农历日得到农历月
      const lunarDay: LunarDay = LunarDay.fromYmd(2023, 1, 1)
      const lunarMonth2: LunarMonth = lunarDay.getLunarMonth()
      // 从农历月可以得到那些什么？
      // 1. 农历年
      const lunarMonth3: LunarMonth = LunarMonth.fromYm(2023, 1);
      const lunarYear: LunarYear = lunarMonth.getLunarYear();
      // 2. 月
      const month: number = lunarMonth.getMonth();
      this.info('2. 月', JSON.stringify(month))
      // 3. 月（支持闰月）
      const month1: number = lunarMonth.getMonthWithLeap()
      this.info('3. 月（支持闰月）', JSON.stringify(month1))
      // 4. 是否闰月
      const leap: boolean = lunarMonth.isLeap();
      this.info('4. 是否闰月', JSON.stringify(leap))
      // 5. 位于当年的月索引
      const index: number = lunarMonth.getIndexInYear();
      this.info('5. 位于当年的月索引', JSON.stringify(index))
      // 6. 当月的总天数
      const dayCount: number = lunarMonth.getDayCount();
      this.info('6. 当月的总天数', JSON.stringify(dayCount))
      // 7. 农历季节
      const season: LunarSeason = lunarMonth.getSeason();
      this.info('7. 农历季节', JSON.stringify(season))
      // 8. 初一的儒略日
      const julianDay: JulianDay = lunarMonth.getFirstJulianDay();
      this.info('8. 初一的儒略日', JSON.stringify(julianDay))
      // 9. 当月有几周
      const weekCount: number = lunarMonth.getWeekCount(1);
      this.info('9. 当月有几周', JSON.stringify(weekCount))
      // 10. 当月的周列表
      const weeks: LunarWeek[] = lunarMonth.getWeeks(1);
      this.info('10. 当月的周列表', JSON.stringify(weeks))
      // 11. 当月的干支
      const sixtyCycle: SixtyCycle = lunarMonth.getSixtyCycle();
      this.info('11. 当月的干支', JSON.stringify(sixtyCycle))
      // 12. 九星
      const nineStar: NineStar = lunarMonth.getNineStar();
      this.info('12. 九星', JSON.stringify(nineStar))
      // 13. 太岁方位
      const direction = lunarMonth.getJupiterDirection();
      this.info('13. 太岁方位', JSON.stringify(direction))
      // 14. 农历日列表
      const days: LunarDay[] = lunarMonth.getDays();
      this.info('14. 农历日列表', JSON.stringify(days))
      // 15. 逐月胎神 (返回为逐月胎神 FetusMonth。闰月无胎神。)
      const fetus2 = lunarMonth.getFetus();
      this.info('15. 逐月胎神', JSON.stringify(fetus2))
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '农历月 LunarMonth'
  @Builder
  buildLunarMonth() {
    Column() {
      Text('农历月 LunarMonth 点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      // 1. 通过农历年月的周索引初始化，参数分别为农历年、农历月、周索引、起始星期（1234560分别代表星期一至星期日）
      // 农历癸卯年正月第一周，以星期2为一周的开始
      const lunarWeek: LunarWeek = LunarWeek.fromYm(2023, 1, 0, 2);
      // 1. 本周第一天的农历日
      const lunarDay: LunarDay = lunarWeek.getFirstDay();
      this.info('1. 本周第一天的农历日', JSON.stringify(lunarDay))
      // 2. 本周农历日列表
      const days: LunarDay[] = lunarWeek.getDays();
      this.info('2. 本周农历日列表', JSON.stringify(days))
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '农历周 LunarWeek'
  @Builder
  buildLunarWeek() {
    Column() {
      Text('农历周 LunarWeek 点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      // 如何得到农历周？
      // 从农历周可以得到些什么？
      // 1. 本周第一天的农历日 返回为农历日 LunarDay。
      const lunarWeek: LunarWeek = LunarWeek.fromYm(2023, 1, 0, 2);
      // 农历壬寅年十二月廿六
      const lunarDay: LunarDay = lunarWeek.getFirstDay();
      this.info('1. 本周第一天的农历日', JSON.stringify(lunarDay))
      // 2. 本周农历日列表 返回为农历日 LunarDay的列表。
      const lunarWeek2: LunarWeek = LunarWeek.fromYm(2023, 1, 0, 2);
      // 农历壬寅年十二月廿六
      const days: LunarDay[] = lunarWeek.getDays();
      this.info('2. 本周农历日列表 返回为农历日 LunarDay的列表。', JSON.stringify(days))
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '农历日 LunarDay'
  @Builder
  buildLunarDay() {
    Column() {
      Text('农历日 LunarDay 点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      // 1. 如何得到农历日？
      // 参数农历年，支持从-1到9999年；参数农历月，支持1到12，如果为闰月的，使用负数，即-3代表闰三月；参数农历日，支持1到30，大月30天，小月29天。
      const lunarDay: LunarDay = LunarDay.fromYmd(2023, 1, 1);
      // 2. 从农历时辰得到农历日
      const lunarHour: LunarHour = LunarHour.fromYmdHms(2023, 1, 1, 13, 0, 0);
      const lunarDay2: LunarDay = lunarHour.getLunarDay();
      // 3. 从公历日转农历日
      // 公历2024年2月9日
      const solarDay1: SolarDay = SolarDay.fromYmd(2024, 2, 9);
      // 农历癸卯年十二月三十
      const lunarDay3: LunarDay = solarDay1.getLunarDay();

      // 从农历日可以得到什么
      // 1. 农历月 LunarMonth
      const lunarMonth: LunarMonth = lunarDay.getLunarMonth();
      this.info('1. 农历月 LunarMonth', JSON.stringify(lunarMonth))
      // 2. 日
      const day: number = lunarDay.getDay();
      this.info('2. 日', JSON.stringify(day))
      // 3. 星期
      const week = lunarDay.getWeek();
      this.info('3. 星期', JSON.stringify(week))
      // 4. 当天的年干支（废弃）
      // 非当天所属的农历年干支，以立春换年。返回为干支 SixtyCycle。
      const sixtyCycle1: SixtyCycle = lunarDay.getYearSixtyCycle();
      this.info('4. 当天的年干支（废弃）', JSON.stringify(sixtyCycle1))
      // 5. 当天的月干支(已废弃)
      const sixtyCycle2: SixtyCycle = lunarDay.getMonthSixtyCycle();
      this.info('5. 当天的月干支(已废弃)', JSON.stringify(sixtyCycle2))
      // 6. 当天的干支
      const sixtyCycle: SixtyCycle = lunarDay.getSixtyCycle();
      this.info('6. 当天的干支', JSON.stringify(sixtyCycle))
      // 7. 九星
      const nineStar: NineStar = lunarDay.getNineStar();
      this.info('7. 九星', JSON.stringify(nineStar))
      // 8. 太岁方位
      const direction = lunarDay.getJupiterDirection();
      this.info('8. 太岁方位', JSON.stringify(direction))
      // 9. 建除十二值神
      const duty: Duty = lunarDay.getDuty();
      this.info('9. 建除十二值神', JSON.stringify(duty))
      // 10. 黄道黑道十二神
      const twelveStar: TwelveStar = lunarDay.getTwelveStar();
      this.info('10. 黄道黑道十二神', JSON.stringify(twelveStar))
      // 11. 逐日胎神
      const fetus: FetusDay = lunarDay.getFetusDay();
      this.info('11. 逐日胎神', JSON.stringify(fetus))
      // 12. 月相
      const phase: Phase = lunarDay.getPhase();
      this.info('12. 月相', JSON.stringify(phase))
      // 13. 二十八宿
      const twentyEightStar: TwentyEightStar = lunarDay.getTwentyEightStar();
      this.info('13. 二十八宿', JSON.stringify(twentyEightStar))
      // 14. 农历传统节日
      const festival = lunarDay.getFestival();
      this.info('14. 农历传统节日', JSON.stringify(festival))
      // 15. 农历日转公历日
      const solarDay: SolarDay = lunarDay.getSolarDay();
      this.info('15. 农历日转公历日', JSON.stringify(solarDay))
      // 16. 农历日前后比较
      // 农历2023年正月初一
      const a: LunarDay = LunarDay.fromYmd(2023, 1, 1);
      // 农历2023年正月初二
      const b: LunarDay = LunarDay.fromYmd(2023, 1, 2);
      // a在b之前吗？这里返回true
      const aIsBeforeB: boolean = a.isBefore(b);
      this.info('a在b之前吗？这里返回true', JSON.stringify(aIsBeforeB))
      // a在b之后吗？这里返回false
      const aIsAfterB: boolean = a.isAfter(b);
      this.info('a在b之后吗？这里返回false', JSON.stringify(aIsAfterB))
      // 17. 当天的时辰列表
      const lunarHours: LunarHour[] = lunarDay.getHours();
      this.info('17. 当天的时辰列表', JSON.stringify(lunarHours))
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '农历时辰 LunarHour'
  @Builder
  buildLunarHour() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '藏历年 RabByungYear'
  @Builder
  buildRabByungYear() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '藏历月 RabByungMonth'
  @Builder
  buildRabByungMonth() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '藏历日 RabByungDay'
  @Builder
  buildRabByungDay() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '干支年 SixtyCycleYear'
  @Builder
  buildSixtyCycleYear() {
    Column() {
      Text('干支年 SixtyCycleYear 点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      // 从年初始化
      const y: SixtyCycleYear = SixtyCycleYear.fromYear(2023);
      // 从干支月SixtyCycle得到干支年
      const m: SixtyCycleMonth = SixtyCycleMonth.fromIndex(2023, 0);
      const y1: SixtyCycleYear = m.getSixtyCycleYear();
      // 从干支年可以得到什么
      // 1. 年
      const year: number = y.getYear();
      this.info('1. 年', JSON.stringify(year))
      // 2. 当年的干支
      const sc: SixtyCycle = y.getSixtyCycle();
      this.info('2. 当年的干支', JSON.stringify(sc))
      // 3. 运
      const t: Twenty = y.getTwenty();
      this.info('3. 运', JSON.stringify(t))
      // 4. 九星
      const ns: NineStar = y.getNineStar();
      this.info('4. 九星', JSON.stringify(ns))
      // 5. 太岁方位
      const d = y.getJupiterDirection();
      this.info('5. 太岁方位', JSON.stringify(d))
      // 6. 干支月列表
      const ms: SixtyCycleMonth[] = y.getMonths();
      this.info('6. 干支月列表', JSON.stringify(ms))
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '干支月 SixtyCycleMonth'
  @Builder
  buildSixtyCycleMonth() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '干支日 SixtyCycleDay'
  @Builder
  buildSixtyCycleDay() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '干支时辰 SixtyCycleHour'
  @Builder
  buildSixtyCycleHour() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '公历年 SolarYear'
  @Builder
  buildSolarYear() {
    Column() {
      Text('点击打印 公历年 SolarYear').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      // 如何得到公历年
      // 1.从年初始化
      let solarYear = SolarYear.fromYear(2024);
      // 2. 从公历月得到公历年
      // 公历2024年2月
      let solarMonth = SolarMonth.fromYm(2024, 2);
      let solarYear2 = solarMonth.getSolarYear();

      // 从公历年可以得到什么
      // 1. 年
      let year = solarYear.getYear();
      this.info('1. 年', JSON.stringify(year))
      // 2. 当年的总天数
      let dayCount = solarYear.getDayCount();
      this.info('2. 当年的总天数', JSON.stringify(dayCount))
      // 3. 当年是否闰年
      let leap = solarYear.isLeap();
      this.info('3. 当年是否闰年', JSON.stringify(leap))
      // 4. 公历月列表
      let months = solarYear.getMonths();
      this.info('4. 公历月列表', JSON.stringify(months))
      // 5. 公历半年列表
      let halfYears = solarYear.getHalfYears();
      this.info('5. 公历半年列表', JSON.stringify(halfYears))
      // 6. 公历季度列表
      let seasons = solarYear.getSeasons();
      this.info('6. 公历季度列表', JSON.stringify(seasons))
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '公历半年 SolarHalfYear'
  @Builder
  buildSolarHalfYear() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '公历季度 SolarSeason'
  @Builder
  buildSolarSeason() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '公历月 SolarMonth'
  @Builder
  buildSolarMonth() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '公历周 SolarWeek'
  @Builder
  buildSolarWeek() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '公历日 SolarDay'
  @Builder
  buildSolarDay() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '公历时刻 SolarTime'
  @Builder
  buildSolarTime() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '生肖 Zodiac轮回'
  @Builder
  buildZodiac() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      // 十二生效依次为：鼠、牛、虎、兔、龙、蛇、马、羊、猴、鸡、狗、猪。

      // 如何得到生肖
      let zodiac = EarthBranch.fromName("子").getZodiac()
      this.info('如何得到生肖', JSON.stringify(zodiac))
      // 1. 生肖转地支
      let earthBranch = Zodiac.fromName("牛").getEarthBranch();
      this.info('1. 生肖转地支', JSON.stringify(earthBranch))
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '月相 Phase轮回'
  @Builder
  buildPhase() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '星座 Constellation轮回'
  @Builder
  buildConstellation() {
    Column() {
      Text('点击打印 星座 Constellation轮回').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      // 星座依次为：白羊、金牛、双子、巨蟹、狮子、处女、天秤、天蝎、射手、摩羯、水瓶、双鱼。
      let solarDay = SolarDay.fromYmd(2023, 1, 1);
      let constellation = solarDay.getConstellation();
      this.info('fff', JSON.stringify(constellation))
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '节气 SolarTerm轮回'
  @Builder
  buildSolarTerm() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      let term1 = SolarTerm.fromIndex(2013, 0);
      let term2 = SolarTerm.fromName(2013, '立春');
      let solarDay2 = SolarDay.fromYmd(2023, 1, 1);
      let term3 = solarDay2.getTerm();
      let solarDay3 = SolarDay.fromYmd(2023, 12, 7);
      let termDay4 = solarDay3.getTermDay();
      let dayIndex4 = termDay4.getDayIndex();
      let solarTime5 = SolarTime.fromYmdHms(2023, 1, 1, 13, 5, 20);
      let term5 = solarTime5.getTerm();

      // 从节气可以得到些什么
      // 1. 是否节令
      let term = SolarTerm.fromName(2013, '冬至');
      let isJie = term.isJie();
      this.info('1. 是否节令', JSON.stringify(isJie))
      // 2. 是否气令
      let isQi = term.isQi();
      this.info('2. 是否气令', JSON.stringify(isQi))
      // 3. 儒略日
      let julianDay = term.getJulianDay();
      this.info('3. 儒略日', JSON.stringify(julianDay))
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '儒略日 JulianDay'
  @Builder
  buildJulianDay() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '法定假日 LegalHoliday'
  @Builder
  buildLegalHoliday() {
    Column() {
      Text('点击打印 法定假日 LegalHoliday').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      let solarDay = SolarDay.fromYmd(2023, 10, 1);
      // 国庆节
      let holiday = solarDay.getLegalHoliday();
      // 国庆节
      holiday = LegalHoliday.fromYmd(2023, 10, 1);
      // 非法定假日，返回null
      holiday = LegalHoliday.fromYmd(2023, 4, 20);

      // 春节
      let isWork = holiday?.isWork();
      this.info('是否上班', JSON.stringify(isWork))

      // 放假倒计时
      // 设置最多10条
      let size = 10;
      // 取今天
      let now = new Date();
      let year = now.getFullYear();
      let today = SolarDay.fromYmd(year, now.getMonth() + 1, now.getDate());
      let name: string = '';
      let l:LegalHoliday[]  = [];
      // 元旦节当天肯定放假
      holiday = LegalHoliday.fromYmd(year, 1, 1);
      while (holiday && size > 0) {
        let nm = holiday.getName();
        if (nm != name && !holiday.isWork() && holiday.getDay().isAfter(today)) {
          l.push(holiday);
          name = nm;
          size--;
        }
        holiday = holiday.next(1);
      }
      for (let i = 0, j = l.length; i < j; i++) {
        let h = l[i];
        this.info('如何实现放假倒计时', '距 ' + h.getName() + '放假 还有 ' + (h.getDay().subtract(today) - 1) + ' 天');
      }

      // 如果只取一个最近的法定假日，就简单许多。
      // 取今天
      now = new Date();
      year = now.getFullYear();
      today = SolarDay.fromYmd(year, now.getMonth() + 1, now.getDate());
      // 元旦节当天肯定放假
      holiday = LegalHoliday.fromYmd(year, 1, 1);
      while (holiday) {
        if (!holiday.isWork() && holiday.getDay().isAfter(today)) {
          this.info('只取一个最近的法定假日', '距 ' + holiday.getName() + '放假 还有 ' + (holiday.getDay().subtract(today) - 1) + ' 天');
          break;
        }
        holiday = holiday.next(1);
      }
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '公历现代节日 SolarFestival'
  @Builder
  buildSolarFestival() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '农历传统节日 LunarFestival'
  @Builder
  buildLunarFestival() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '星期 Week轮回'
  @Builder
  buildWeek() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '三候 ThreePhenology轮回'
  @Builder
  buildThreePhenology() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '三伏天 DogDay'
  @Builder
  buildDogDay() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '五行 Element轮回'
  @Builder
  buildElement() {
    Column() {
      Text('点击打印 五行 Element轮回').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      // 1. 我生的
      let me = Element.fromName("火");
      // 土 （火生土）
      let el = me.getReinforce();
      this.info('1. 我生的', JSON.stringify(el))

      // 2. 我克的
      me = Element.fromName("金");
      // 木 （金克木）
      el = me.getRestrain();
      this.info('2. 我克的', JSON.stringify(el))

      // 3. 生我的
      me = Element.fromName("土");
      // 火 （火生土）
      el = me.getReinforced();
      this.info('3. 生我的', JSON.stringify(el))

      // 4. 克我的
      me = Element.fromName("木");
      // 金 （金克木）
      el = me.getRestrained();
      this.info('4. 克我的', JSON.stringify(el))
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '六曜 SixStar轮回'
  @Builder
  buildSixStar() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '小六壬 MinorRen轮回'
  @Builder
  buildMinorRen() {
    Column() {
      Text('点击打印 小六壬 MinorRen轮回').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      // 速喜
      let minorRen = LunarMonth.fromYm(1991, 3).getMinorRen();
      // 大安
      minorRen = LunarDay.fromYmd(2024, 3, 5).getMinorRen();
      // 留连
      minorRen = LunarHour.fromYmdHms(2024, 9, 7, 10, 0, 0).getMinorRen();

      // 1. 吉凶 Luck
      // 大安、速喜、小吉为吉，留连、赤口、空亡为凶。
      // 大安
      minorRen = LunarDay.fromYmd(2024, 3, 5).getMinorRen();
      // 吉
      let luck = minorRen.getLuck();
      this.info('1. 吉凶 Luck', JSON.stringify(luck))
      // 2. 五行 Element
      // 大安
      minorRen = LunarDay.fromYmd(2024, 3, 5).getMinorRen();
      // 木
      let element = minorRen.getElement();
      this.info('2. 五行 Element', JSON.stringify(element))
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '七曜 SevenStar轮回'
  @Builder
  buildSevenStar() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '八字 EightChar'
  @Builder
  buildEightChar() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '九野 Land轮回'
  @Builder
  buildLand() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '九星 NineStar轮回'
  @Builder
  buildNineStar() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '北斗九星 Dipper轮回'
  @Builder
  buildDipper() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '数九天 NineDay'
  @Builder
  buildNineDay() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '十神 TenStar轮回'
  @Builder
  buildTenStar() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '长生十二神 Terrain轮回'
  @Builder
  buildTerrain() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '建除十二值神 Duty轮回'
  @Builder
  buildDuty() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '黄道黑道十二神 TwelveStar轮回'
  @Builder
  buildTwelveStar() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '黄道黑道 Ecliptic轮回'
  @Builder
  buildEcliptic() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '二十八宿 TwentyEightStar轮回'
  @Builder
  buildTwentyEightStar() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '七十二候 PhenologyDay'
  @Builder
  buildPhenologyDay() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '干支 SixtyCycle轮回'
  @Builder
  buildSixtyCycle() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '天干 HeavenStem轮回'
  @Builder
  buildHeavenStem() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '地支 EarthBranch轮回'
  @Builder
  buildEarthBranch() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '藏干 HideHeavenStem'
  @Builder
  buildHideHeavenStem() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '人元司令分野 HideHeavenStemDay'
  @Builder
  buildHideHeavenStemDay() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '纳音 Sound轮回'
  @Builder
  buildSound() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '彭祖百忌 PengZu'
  @Builder
  buildPengZu() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '吉凶 Luck轮回'
  @Builder
  buildLuck() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '方位 Direction轮回'
  @Builder
  buildDirection() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '宫 Zone轮回'
  @Builder
  buildZone() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '神兽 Beast轮回'
  @Builder
  buildBeast() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '动物 Animal轮回'
  @Builder
  buildAnimal() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '元 Sixty轮回'
  @Builder
  buildSixty() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '运 Twenty轮回'
  @Builder
  buildTwenty() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '旬 Ten轮回'
  @Builder
  buildTen() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '梅雨天 PlumRainDay'
  @Builder
  buildPlumRainDay() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '逐月胎神 FetusMonth轮回'
  @Builder
  buildFetusMonth() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '逐日胎神 FetusDay'
  @Builder
  buildFetusDay() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '天干六甲胎神 FetusHeavenStem'
  @Builder
  buildFetusHeavenStem() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '地支六甲胎神 FetusEarthBranch'
  @Builder
  buildFetusEarthBranch() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '灶马头 KitchenGodSteed'
  @Builder
  buildKitchenGodSteed() {
    Column() {
      Text('点击打印 灶马头 KitchenGodSteed').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      // 第1种
      let kitchenGodSteed1 = LunarYear.fromYear(2017).getKitchenGodSteed();
      // 第2种
      let kitchenGodSteed2 = KitchenGodSteed.fromLunarYear(2017);

      // 1. 几鼠偷粮、草子几分、几牛耕田、花收几分、几龙治水、几马驮谷、几鸡抢米、几姑看蚕、几屠共猪、甲田几分、几人分饼、几日得金、几人几丙、几人几锄
      let  kitchenGodSteed = KitchenGodSteed.fromLunarYear(2017);
      // 十鼠偷粮
      let mouse = kitchenGodSteed.getMouse();
      this.info('十鼠偷粮', JSON.stringify(mouse))
      // 草子十分
      let grass = kitchenGodSteed.getGrass();
      this.info('草子十分', JSON.stringify(grass))
      // 十一牛耕田
      let cattle = kitchenGodSteed.getCattle();
      this.info('十一牛耕田', JSON.stringify(cattle))
      // 花收一分
      let flower = kitchenGodSteed.getFlower();
      this.info('花收一分', JSON.stringify(flower))
      // 二龙治水
      let dragon = kitchenGodSteed.getDragon();
      this.info('二龙治水', JSON.stringify(dragon))
      // 四马驮谷
      let horse = kitchenGodSteed.getHorse();
      this.info('四马驮谷', JSON.stringify(horse))
      // 七鸡抢米
      let chicken = kitchenGodSteed.getChicken();
      this.info('七鸡抢米', JSON.stringify(chicken))
      // 七姑看蚕
      let silkworm = kitchenGodSteed.getSilkworm();
      this.info('七姑看蚕', JSON.stringify(silkworm))
      // 九屠共猪
      let pig = kitchenGodSteed.getPig();
      this.info('九屠共猪', JSON.stringify(pig))
      // 甲田十分
      let field = kitchenGodSteed.getField();
      this.info('甲田十分', JSON.stringify(field))
      // 二人分饼
      let cake = kitchenGodSteed.getCake();
      this.info('二人分饼', JSON.stringify(cake))
      // 七日得金
      let gold = kitchenGodSteed.getGold();
      this.info('七日得金', JSON.stringify(gold))
      // 十二人二丙
      let peopleCakes = kitchenGodSteed.getPeopleCakes();
      this.info('十二人二丙', JSON.stringify(peopleCakes))
      // 十二人三锄
      let peopleHoes = kitchenGodSteed.getPeopleHoes();
      this.info('十二人三锄', JSON.stringify(peopleHoes))
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '宜忌 Taboo'
  @Builder
  buildTaboo() {
    Column() {
      Text('点击打印 宜忌 Taboo').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
      let d = SolarDay.fromYmd(2024, 6, 26).getLunarDay();
      // SixtyCycleDay d = SolarDay.fromYmd(2024, 6, 26).getSixtyCycleDay();
      // 宜：嫁娶, 祭祀, 理发, 作灶, 修饰垣墙, 平治道涂, 整手足甲, 沐浴, 冠笄
      let taboos = d.getRecommends();
      this.info('如何得到每日宜忌', JSON.stringify(taboos))
      // 忌：破土, 出行, 栽种
      taboos = d.getAvoids();
      this.info('如何得到每日宜忌', JSON.stringify(taboos))

      let h = SolarTime.fromYmdHms(2024, 4, 22, 0, 0, 0).getLunarHour();
      // SixtyCycleHour h = SolarTime.fromYmdHms(2024, 4, 22, 0, 0, 0).getSixtyCycleHour();
      // 宜：嫁娶, 交易, 开市, 安床, 祭祀, 求财
      taboos = h.getRecommends();
      this.info('如何得到时辰宜忌', JSON.stringify(taboos))
      // 忌：出行, 移徙, 赴任, 词讼, 祈福, 修造, 求嗣
      taboos = h.getAvoids();
      this.info('如何得到时辰宜忌', JSON.stringify(taboos))
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '神煞 God'
  @Builder
  buildGod() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '童限 ChildLimit'
  @Builder
  buildChildLimit() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '大运 DecadeFortune'
  @Builder
  buildDecadeFortune() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '小运 Fortune'
  @Builder
  buildFortune() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
  // '枚举 Enum'
  @Builder
  buildEnum() {
    Column() {
      Text('点击打印').fontSize(this.fontSize).fontColor(Color.Black)
    }
    .onClick(() => {
    })
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }

  @Builder
  buildTitleText(title: string) {
    Text(title).width(FULL_PERCENT).borderWidth(2)
  }
}

@Component
struct ClickDisplayContent {
  title: string = ''
  @State isShowContent: boolean = false
  @BuilderParam content: () => void

  build() {
    Column() {
      Text(this.title).width(FULL_PERCENT).borderWidth(2).padding({top: 10, bottom: 10}).onClick(() => {
        this.isShowContent = !this.isShowContent
      })
      if (this.isShowContent) {
        this.content()
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width(FULL_PERCENT)
  }
}