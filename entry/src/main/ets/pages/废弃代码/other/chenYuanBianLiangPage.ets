//本案例用于学习成员变量和成员函数
@Component
struct pannl {
  title: string = '我的订单'
  order: string = '全部订单>'
  getChenYanBianLiang = () => {
    AlertDialog.show({
      message: '我是成员变量,'
    })
  }

  getChenYuanHanShu() {
    AlertDialog.show({
      message: '我是成员函数'
    })
  }

  build() {
    Column() {
      Row() {
        //成员变量
        Text(this.title)
        Text(this.order)
          .onClick(() => {
            this.getChenYanBianLiang()
          })
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      Row() {
        Text('内容部分')
        Button('成员变量按钮')
          .onClick(() => {
            this.getChenYanBianLiang()
          })
        Button('成员函数按钮')
          .onClick(() => {
            this.getChenYuanHanShu()
          })
      }
    }
    .width('100%')
    .height(120)
    .padding(20)
  }
}

@Entry
@Component
struct ChenYuanBianLiangPage {
  @State message: string = 'sf';

  build() {
    Column() {
      Text(this.message)
        .id('ChenYuanBianLiangPageHelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })
      pannl({
        title: '全部订单', order: '查看全部订单>', getChenYanBianLiang() {
          AlertDialog.show({ message: '已查看全部订单' })
        }
      })
      pannl({
        title: '小米众筹', order: '众筹中。。。>', getChenYanBianLiang() {
          AlertDialog.show({ message: '都说了在众筹中。。。' })
        }
      })
    }
    .height('100%')
    .width('100%')
  }
}