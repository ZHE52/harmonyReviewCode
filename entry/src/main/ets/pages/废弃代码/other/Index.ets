class Msg {
  id: number
  text: string
  translated: string = ''
  show: boolean = false

  constructor(id: number, text: string) {
    this.id = id
    this.text = text
  }
}

@Entry
@Component
struct Index {
  @State msgs: Msg[] = [
    new Msg(1, 'Hello, how are you?'),
    new Msg(2, 'I am fine.'),
    new Msg(3, 'Nice to meet you'),
    new Msg(4, 'This is a test message')
  ]

  build() {
    Column() {
      Text('点击气泡翻译（稳定版）')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 24, bottom: 16 })

      // 消息列表（不用 List，避免吞事件）
      ForEach(this.msgs, (item: Msg, index: number) => {
        Column() {
          // 原文气泡
          Text(item.text)
            .fontSize(18)
            .fontColor('#111')
            .padding(12)
            .backgroundColor('#A7F28B')
            .borderRadius(12)
            .margin({ bottom: 6 })
            .onClick(() => {
              this.onMsgClick(index)
            })

          // 翻译结果
          if (item.show) {
            Text(item.translated)
              .fontSize(16)
              .fontColor('#333')
              .padding(10)
              .backgroundColor('#F0F0F0')
              .borderRadius(10)
              .margin({ bottom: 12 })
          } else {
            Blank().height(12)
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 16, right: 16 })
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F3F5')
  }

  private onMsgClick(index: number) {
    let msg = this.msgs[index]

    if (!msg.show) {
      // 第一次点击：翻译
      msg.translated = this.mockTranslate(msg.text)
      msg.show = true
    } else {
      // 再点一次：收起
      msg.show = false
    }

    // 关键：刷新数组，触发 UI 更新
    this.msgs = [...this.msgs]
  }

  private mockTranslate(text: string): string {
    if (text.indexOf('Hello') >= 0) return '你好，你最近怎么样？'
    if (text.indexOf('fine') >= 0) return '我挺好的。'
    if (text.indexOf('Nice') >= 0) return '很高兴认识你'
    return `【翻译】${text}`
  }
}
