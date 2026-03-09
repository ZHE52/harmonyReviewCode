@Entry
@Component
struct NavDmeoPage {
  pathStack: NavPathStack=new NavPathStack()

  @Builder pagesBuilder(name:String){
    if (name ==='my1'){
      NavDestination(){
        Column(){
          Text('我是个人页面1')
          .fontSize(50)
          .fontColor(Color.Red)
          Button('点击下一页')
            .onClick(()=>{
              this.pathStack.pushPath({
                name:'next2'
              })
            })
        }
      }.title('我是个人中心')
    }
    if (name ==='next2'){
      NavDestination(){
        Column(){
          Text('我是下一个页面2')
            .fontSize(50)
            .fontColor(Color.Red)
          Button('点击去下一个页面')
            .onClick(()=>{
               this.pathStack.pushPath({
                 name:'nextandnext3'
               })
            })
        }
      }.title('我是个人中心')
    }
    if (name ==='nextandnext3'){
      NavDestination(){
        Column(){
          Text('我是下一个下一个页面3')
            .fontSize(50)
            .fontColor(Color.Red)
          Button('点击返回首页')
            .onClick(()=>{
            //  this.pathStack.popToIndex(0)
            })
        }
      }.title('我是个人中心')
    }
  }
  build() {
    Navigation(this.pathStack){//?
      Column(){
            Text('我是首页')
              .fontSize(50)
              .fontColor(Color.Red)
        Button('点击跳转到个人页面')
          .onClick(()=>{
            this.pathStack.pushPath({
              name:'my1'
            })
          })
      }
    }
    .navDestination(this.pagesBuilder)
  }

}