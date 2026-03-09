@Entry
@Component
struct Demo04Navigation {
  // 创建路由栈(子页面/子路由维护的是同一个这个对象)
  pathStack: NavPathStack = new NavPathStack()

  @Builder pagesBuilder(name: string) {
    if (name === 'my') {
      // 加载的是我的, 子页面的内容, 必须用 NavDestination 包裹
      NavDestination() {
        Column() {
          Text('我是个人中心页').fontSize(50)
          Button('跳转到列表页')
            .onClick(() => {
              this.pathStack.pushPath({
                name: 'list'
              })
            })
        }
      }
      .title('个人中心')
    }
    // if (name === 'list') {
    //   // 加载的是我的, 子页面的内容, 必须用 NavDestination 包裹
    //   NavDestination() {
    //     Column() {
    //       Text('我是列表页').fontSize(50)
    //       Button('返回').onClick(() => {
    //         this.pathStack.pop()
    //       })
    //     }
    //   }
    //   .hideTitleBar(true)
    // }
  }
  build() {
    Navigation(this.pathStack) {
      Column() {
        Text('我是首页')
          .fontSize(50)
        Button('跳转个人中心').onClick(() => {
          this.pathStack.pushPath({
            name: 'my'
          })
        })
      }
    }
    // 配置页面栈的出口, 将来所有的页面, 都会走这个builder逻辑
    // 1. 需要在这个builder逻辑中, 进行判断, 不同的name, 解析渲染不同的结构
    // 2. 如果这行不配, 也可以, 就是通过路由表的方式, 匹配name和结构
    .navDestination(this.pagesBuilder)
  }
}