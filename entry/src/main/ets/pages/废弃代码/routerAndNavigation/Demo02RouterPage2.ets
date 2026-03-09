import { router } from '@kit.ArkUI'
interface User {
  name: string
  age: number
}
interface ParamsObj {
  id: number
  user: User
}

@Entry
@ComponentV2
struct Demo02RouterPage2 {
  @Local user: User = {} as User
  aboutToAppear(): void {
    // 1. 标准的方式(推荐)
    // console.log(JSON.stringify(router.getParams()))
    // let obj = router.getParams() as ParamsObj
    // // 如果跳转过来没有带参数 => undefined
    // if (obj) {
    //   console.log(obj.id.toString())
    //   console.log(obj.user.name)
    //   this.user = obj.user
    // }

    // 2. 偷懒的方式(了解) 失去了TS的能力, 适合简易传参, 懒得写interface了
    let obj = router.getParams() as object
    let id = obj['id'] as number
    console.log(id + '')

    // getState() 获取当前页面路由的状态
    console.log(JSON.stringify(router.getState()))
  }

  build() {
    Column() {
      Text(this.user?.name)
      Text(this.user?.age?.toString())
      Text('我是页面二').fontSize(30)
      Button('跳转到页面三').onClick(() => {
        // pushUrl 累加页面栈
        router.pushUrl({
          url: 'pages/09/Demo03RouterPage3'
        })
      })
      Button('替换到页面三').onClick(() => {
        // replaceUrl 将当前页面出栈, 跳转的页面入栈
        router.replaceUrl({
          url: 'pages/09/Demo03RouterPage3'
        })
      })
    }
  }
}