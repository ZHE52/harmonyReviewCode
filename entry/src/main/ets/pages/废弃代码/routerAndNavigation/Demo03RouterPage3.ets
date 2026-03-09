import { promptAction, router } from '@kit.ArkUI'

@Entry
@Component
struct Demo03RouterPage3 {
  aboutToAppear(): void {
    console.log('Page3 aboutToAppear')
    promptAction.showToast({
      message: '页面栈长度:' + router.getLength()
    })
  }
  aboutToDisappear(): void {
    console.log('Page3 aboutToDisappear')
  }
  build() {
    Column() {
      Text('我是页面三').fontSize(30)
      Button('跳转到页面三').onClick(() => {
        router.pushUrl({
          url: 'pages/09/Demo03RouterPage3'
        })
      })
      Button('清空之前的页面栈').onClick(() => {
        router.clear()
      })
      Button('返回上一页').onClick(() => {
        router.back()
      })

      // 首页 => 页面二 => 页面三   单例跳首页
      // 页面二 => 页面三 => 首页
      Button('单例跳转到首页').onClick(() => {
        // 你可以决定: 将来跳转的页面, 如果在页面栈中已存在如何处理
        // ① 已存在的不管, 继续叠加 => 默认标准
        // ② 发现已存在, 将已存在的, 挪到栈顶 => 单例
        router.pushUrl({
          url: 'pages/09/Demo01RouterPage'
        }, router.RouterMode.Single)
      })
    }
  }
}