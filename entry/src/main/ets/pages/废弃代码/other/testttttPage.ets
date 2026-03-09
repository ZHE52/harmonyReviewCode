@Entry
@Component
struct TestttttPage {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {//相对布局，等于是安卓手机桌面的app布局，随便你放
      Text(this.message)
        .id('TestttttPageHelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })
    }
    .height('100%')
    .width('100%')
  }
}