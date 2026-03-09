import router from '@ohos.router'

@Entry
@Component
struct ShareTargetPage {
  // 与行内布局保持一致的常量
  private readonly rowLeft: number = 16
  private readonly iconGap: number = 16

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()

        // 1) 提示条：靠左
        Row() {
          Text('通过微信将文件发送至')
            .fontSize(14)
            .fontColor(0xFF8A8A8A)
        }
        .width('100%')
        .padding({ left: this.rowLeft, right: this.rowLeft, top: 10, bottom: 10 })
        .backgroundColor(0xFFF2F2F2)

        // 列表 + 下方空白全白
        Column() {
          this.RowItem('发送给自己', $r('app.media.background'), () => console.info('发送给自己'))
          // 2) 分割线从图片开始（也就是从左侧 16 开始）
          Divider().color(0xFFE6E6E6).strokeWidth(1).margin({ left: this.rowLeft })

          this.RowItem('发送给同事或群', $r('app.media.background'), () => console.info('发送给同事或群'))
          Divider().color(0xFFE6E6E6).strokeWidth(1).margin({ left: this.rowLeft })

          this.RowItem('上传至宇通网盘', $r('app.media.background'), () => console.info('上传至宇通网盘'))
          // 3) 最后一项下面也有分割线
          Divider().color(0xFFE6E6E6).strokeWidth(1).margin({ left: this.rowLeft })

          Blank().layoutWeight(1).backgroundColor(Color.White)
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(Color.White)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      // 悬浮按钮（可选）
      //this.Fab().margin({ right: 18, bottom: 24 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  private TopBar() {
    Row() {
      Row() {
        Text('‹')
          .fontSize(26)
          .fontColor(Color.Black)
          .margin({ bottom: 2 })
      }
      .width(44)
      .height(44)
      .justifyContent(FlexAlign.Center)
      .onClick(() => router.back())

      Text('掌上宇通')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Blank().width(44).height(44)
    }
    .width('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  private RowItem(title: string, iconRes: Resource, onTap: () => void) {
    Row() {
      Image(iconRes)
        .width(24)
        .height(24)
        .margin({ left: this.rowLeft, right: this.iconGap })
        .objectFit(ImageFit.Contain)

      Text(title)
        .fontSize(18)
        .fontColor(Color.Black)
        .layoutWeight(1)

      Text('›')
        .fontSize(22)
        .fontColor(0xFFBFBFBF)
        .margin({ right: this.rowLeft, bottom: 2 })
    }
    .width('100%')
    .height(62)
    .backgroundColor(Color.White)
    .onClick(onTap)
  }

  @Builder
  private Fab() {
    Stack() {
      Circle()
        .width(52)
        .height(52)
        .fill(0xFF3A3A3A)
        .opacity(0.95)

      Text('↗')
        .fontSize(18)
        .fontColor(Color.White)
        .margin({ bottom: 2 })
    }
    .width(52)
    .height(52)
    .shadow({ radius: 14, color: 0x33000000, offsetX: 0, offsetY: 6 })
    .onClick(() => console.info('fab click'))
  }
}
