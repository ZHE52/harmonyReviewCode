import { UserInfo } from "../Demo06Navigation"
import { JSON } from "@kit.ArkTS"

// 这个文件, 本质是在提供, 匹配的name, 渲染的结构
@Component
struct MinePage {
  pathStack: NavPathStack = new NavPathStack()
  build() {
    // 子页面, 必须包裹在中
    NavDestination() {
      Column() {
        Text('个人中心')
          .fontSize(50)
        Button('返回').onClick(() => {
          this.pathStack.pop(123456)
        })
        // Button('跳自己').onClick(() => {
        //   this.pathStack.pushPath({
        //     name: 'Mine'
        //   })
        // })
      }
    }
    // NavDestination准备就绪后, 通过onReady进行接受全局的pathStack
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
    .onAppear(() => {
      console.log(JSON.stringify(this.pathStack.getAllPathName()))
      // 注意得到的参数, 会是数组, 需要取出来
      let obj = this.pathStack.getParamByName("Mine")[0] as UserInfo
      console.log(JSON.stringify(obj))
    })
  }
}

@Builder
export function MineBuilder () {
  MinePage()
}