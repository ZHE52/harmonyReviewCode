//这个demo主要是讲@builderParam的使用方法，功能主要是外面往里面传递结构（传递一个按钮）
//1.至此之前都是正常流程写，到这里就是需要使用那个代码模板
//
@Component
struct sonComp {
  //1。定义builderParam接受外部传入的ui，并设置默认值，如果外部没有传递结构，那就是默认值，如果传递了，就是是使用外面的那个结构
  //2.在build中使用这个结构
  @Builder
  defaultB() { //默认结构
    Button('我是默认的按钮')
  }

  @BuilderParam contentB: () => void = this.defaultB //这就是如果有就传递，没有就默认的结构

  build() {
    Column() {
      this.contentB()
    }
  }
}


@Entry
@Component
struct indexjj {
  build() {
    Column() {
      sonComp()
      //{
      //   //Button('我是外面传递过来的按钮')
      // }
    }
  }
}


