@Entry
@Component
struct ParticleExamplePage {
  @State message: string = 'Hello World';
  @State emitterProperties: Array<EmitterProperty> = [
    {
      index: 0,
      emitRate: 100,
      position: { x: 60, y: 80 },
      size: { width: 200, height: 200 }
    }
  ]

  build() {
    Scroll() {
      Column() {
        Text('粒子动画的简单实现')
        Particle({
          particles: [
            {
              emitter: {
                particle: {
                  type: ParticleType.POINT, // 粒子类型
                  config: {
                    radius: 5 // 圆点半径
                  },
                  count: 100, // 粒子总数
                },
              },
              color: {
                range: ['rgb(39, 135, 217)', 'rgb(0, 74, 175)'], //初始颜色范围
              },
            },
          ]
        }).width(300).height(300).backgroundColor(Color.Gray)


        Text('实现粒子发射器')
        Particle({
          particles: [
            {
              emitter: {
                particle: {
                  type: ParticleType.POINT, // 粒子类型
                  config: {
                    radius: 5 // 圆点半径
                  },
                  count: 100, // 粒子总数
                },
              },
              color: {
                range: ['rgb(39, 135, 217)', 'rgb(0, 74, 175)'], //初始颜色范围
              },
            },
          ]
        }).width(300).height(300).emitter(this.emitterProperties)


        Text('设置粒子颜色')
        Particle({
          particles: [
            {
              emitter: {
                particle: {
                  type: ParticleType.POINT, // 粒子类型
                  config: {
                    radius: 5 // 圆点半径
                  },
                  count: 100, // 粒子总数
                },
              },
              color: {
                range: ['rgb(39, 135, 217)', 'rgb(0, 74, 175)'], // 初始颜色范围
                distributionType: DistributionType.GAUSSIAN // 初始颜色随机值分布
              },
            },
          ]
        }).width(300).height(300).backgroundColor(Color.Gray)

        Text('粒子的生命周期')
        Particle({
          particles: [
            {
              emitter: {
                particle: {
                  type: ParticleType.POINT, // 粒子类型
                  lifetime: 300, // 粒子声明周期，单位ms
                  lifetimeRange: 100, // 粒子生命周期取值范围，单位ms
                  config: {
                    radius: 5 // 圆点半径
                  },
                  count: 100, // 粒子总数
                },
                emitRate: 10, // 每秒发射粒子数
              },
              color: {
                range: ['rgb(39, 135, 217)', 'rgb(0, 74, 175)'], // 初始颜色范围
              },
            },
          ]
        }).width(300).height(300).backgroundColor(Color.Gray)


        Text('设置粒子扰动场')
        Particle({
          particles: [
            {
              emitter: {
                particle: {
                  type: ParticleType.POINT, // 粒子类型
                  lifetime: 300, // 粒子声明周期，单位ms
                  lifetimeRange: 100, // 粒子生命周期取值范围，单位ms
                  config: {
                    radius: 5 // 圆点半径
                  },
                  count: 100, // 粒子总数
                },
                emitRate: 10, // 每秒发射粒子数
              },
              color: {
                range: ['rgb(39, 135, 217)', 'rgb(0, 74, 175)'], // 初始颜色范围
              },
              scale: {
                range: [0.0, 0.0],
                updater: {
                  type: ParticleUpdater.CURVE,
                  config: [
                    {
                      from: 0.0,
                      to: 0.5,
                      startMillis: 0,
                      endMillis: 3000,
                      curve: Curve.EaseIn
                    }
                  ]
                }
              },
              acceleration: {
                //加速度的配置，从大小和方向两个维度变化，speed表示加速度大小，angle表示加速度方向
                speed: {
                  range: [3, 9],
                  updater: {
                    type: ParticleUpdater.RANDOM,
                    config: [1, 20]
                  }
                },
                angle: {
                  range: [90, 90]
                }
              }
            },
          ]
        }).width(300).height(300).backgroundColor(Color.Gray).disturbanceFields([{
          strength: 10,
          shape: DisturbanceFieldShape.RECT,
          size: { width: 100, height: 100 },
          position: { x: 100, y: 100 },
          feather: 15,
          noiseScale: 10,
          noiseFrequency: 15,
          noiseAmplitude: 5
        }])
      }
    }.width("100%").height("100%")
  }
}