import { LengthMetrics } from "@kit.ArkUI";

@Entry
@Component
struct FlexPage01 {
  @State message: string = 'Hello World';

  build() {
    Column(){
      Text('阶段选择')
        .fontWeight(600)
        .fontSize(24)
        .width('100%')
        .margin({
          bottom: 15
        })
      Flex({wrap:FlexWrap.Wrap,space:{
        main:LengthMetrics.vp(10)
      }}) {
        Text('ArkUI')
              .padding(10)
              .backgroundColor('#c6c6c6')
        Text('ArkTs')
              .padding(10)
              .backgroundColor('#c6c6c6')
        Text('ArkUI')
              .padding(10)
              .backgroundColor('#c6c6c6')
        Text('ArkUI')
              .padding(10)
              .backgroundColor('#c6c6c6')
        Text('ArkUI')
              .padding(10)
              .backgroundColor('#c6c6c6')
        Text('ArkUI')
              .padding(10)
              .backgroundColor('#c6c6c6')
        Text('ArkUI')
              .padding(10)
              .backgroundColor('#c6c6c6')
        Text('ArkUI')
              .padding(10)
              .backgroundColor('#c6c6c6')
      }
    }

    .height('100%')
    .width('100%')
  }
}