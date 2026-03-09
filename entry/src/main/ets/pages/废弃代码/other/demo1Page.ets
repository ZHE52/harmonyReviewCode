//本案例主要是讲多个builderParam的练习

@Component
struct son {
  //@BuilderParam tBuilder: () => void = this.tDefaultBuilder
  @BuilderParam titleBP: () => void = this.titleDefaultBP//上部分bp
  @BuilderParam contentBP:() => void =this.contentDefaultBP
  @Builder titleDefaultBP(){//上部分默认bp
    Text('我是默认上部分标题')
  }
  @Builder contentDefaultBP(){//下部分的默认bp
    Text('我是默认下部分内容')
  }

  build() {
    Column(){
      Column(){
        this.titleBP()//上层标题部分
      }.backgroundColor(Color.Red).width('100%').height(30).margin(5)
      Column(){
        this.contentBP()//下层内容部分
      }.backgroundColor(Color.Blue).width('100%').height(30).margin(5)
    }.padding(5)
  }
}

@Entry
@Component
struct demo {
  @Builder fatherTile(){
    Text('我是传入的大标题')
  }
  @Builder fatherContent(){
    Text('我是传入的大内容')
  }
  build() {
    Column(){
      son()
      son({
        titleBP: this.fatherTile,
        contentBP: this.fatherContent//这里不能加括号！！！！！
      })
      son({
        titleBP:this.fatherTile,
        contentBP: this.fatherContent
      })//这里是接收器，需要在父组件把东西准备好，塞进去


    }
  }
}