interface  Materials {
  title: string,
  url: string
}

export class LearningUtils {
  static readonly navigation: Materials[] = [
    {
      title: '组件导航 (Navigation)(推荐)',
      url: 'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-navigation-navigation'
    }
  ]

  static readonly tabs: Materials[] = [
    {
      title: '选项卡 (Tabs)',
      url: 'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-navigation-tabs'
    }
  ]
}