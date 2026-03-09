export interface obj{
  name?:string;
  content: string
}
export class objData implements obj{
  name= "";
  content=''
  constructor(name:string,content:string) {
    this.name=name;
    this.content=content;
  }
}

@Entry
@Component
struct DataPage {
 zhangsan=new objData('张三','我是内容')

  aboutToAppear(): void {
    AppStorage.setOrCreate('zhangsan',this.zhangsan)
  }

  build() {
    RelativeContainer() {
      // Text(this.message)
      //   .id('DataPageHelloWorld')
      //   .fontSize($r('app.float.page_text_font_size'))
      //   .fontWeight(FontWeight.Bold)
      //   .alignRules({
      //     center: { anchor: '__container__', align: VerticalAlign.Center },
      //     middle: { anchor: '__container__', align: HorizontalAlign.Center }
      //   })
      //   .onClick(() => {
      //     this.message = 'Welcome';
      //   })
    }
    .height('100%')
    .width('100%')
  }
}