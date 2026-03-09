import { router } from "@kit.ArkUI"

export interface UserInfo {
  name: string
  age: number
}

@Entry
@ComponentV2
struct Demo06Navigation {
  // 需求:
  // 1. 首页-默认就可以访问
  // 2. 个人中心-需要登录才能访问, 做登录拦截 (这里就完成一下拦截操作, 具体判断结合项目写)
  // 3. 登陆页
  pathStack: NavPathStack = new NavPathStack()

  aboutToAppear(): void {
    this.pathStack.setInterception({
      willShow: (from, to) => {
        // console.log(JSON.stringify(from))
        // console.log('willShow', JSON.stringify(this.pathStack.getAllPathName()))
        // 判断是否是起始页, 如果是去起始页, 不管
        // 类型约束
        if (typeof to === 'string') {
          console.log('home page')
          return
        }

        if (to.pathInfo.name === "Mine") {
          // 需要判断授权, 判断有没有token, 如果没有token需要拦截到登录页
          to.pathStack.pop() // 先把要去的Mine栈页面, 先移除
          to.pathStack.pushPath({
            name: 'Login'
          })
        }
      }
    })
  }

  build() {
    Navigation(this.pathStack) {
      Column() {
        Text('我是首页').fontSize(50)

        Button('跳转到个人中心').onClick(() => {
          let obj: UserInfo = {
            name: '刘备',
            age: 200
          }
          // this.pathStack.pushPath({
          //   name: 'Mine',
          //   param: obj
          // })
          this.pathStack.pushPathByName('Mine', obj, (popInfo) => {
            // 获取返回回来的信息
            console.log(JSON.stringify(popInfo))
          })
        })


        Button('跳转到登录').onClick(() => {
          this.pathStack.pushPath({
            name: 'Login'
          })
        })
      }
    }
  }
}