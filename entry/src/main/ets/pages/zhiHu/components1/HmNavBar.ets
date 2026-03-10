@Preview
@ComponentV2
struct HmNavBar {//导航栏部分
  @Param title: string = "标题"
  build() {
    Row() {
      // 返回键
      Row() {
        Image($r('sys.media.ohos_ic_public_arrow_left'))//返回图片，可以加上点急时间
          .width(16)
          .height(16)
      }
      .width(30)
      .height(30)
      .borderRadius(15)
      .backgroundColor("#f4f4f4")
      .justifyContent(FlexAlign.Center)
      .margin({
        left: 20
      })
      Text(this.title)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .margin({
          right: 50
        })
    }
    .width('100%')
    .height(50)
    .border({
      color: "#f4f5f6",
      width: {
        bottom: 1
      }
    })
  }
}
export { HmNavBar }