import { router } from '@kit.ArkUI'

@Entry
@ComponentV2
struct Demo01RouterPage {
  build() {
    Column() {
      Text('首页').fontSize(30)
      Button('跳转到页面二').onClick(() => {
        // 跳转的逻辑
        router.pushUrl({
          url: 'pages/09/Demo02RouterPage2'
        })
      })
      Button('跳转到页面二 - 并携带参数').onClick(() => {
        router.pushUrl({
          url: 'pages/09/Demo02RouterPage2',
          params: {
            id: 100,
            user: {
              name: '张三',
              age: 18
            }
          }
        })
      })

      Button('跨模块跳转').onClick(() => {
        router.pushUrl({
          url: '@bundle:com.example.online08project/library/ets/pages/Index'
        })
      })
    }
  }
}