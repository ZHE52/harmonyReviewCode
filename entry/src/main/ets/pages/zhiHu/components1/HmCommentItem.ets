import { ReplyItem, ReplyItemModel } from "../models"

@Preview
@ComponentV2
struct HmCommentItem {
  @Param item:ReplyItemModel=new ReplyItemModel({}as ReplyItem)  // 接收渲染的选项
  @Event changeLike:()=>void =() =>{}//?不懂..event是事件，类型是()=>void。。子组件使用父组件，用event



  build() {
    Row({ space: 10 }) {
      Image(this.item.avatar)
        .width(40)
        .height(40)
        .borderRadius(20)

      Column({ space: 10 }) {
        Text(this.item.author)
          .fontColor("#303a43")
          .fontSize(18)
          .fontWeight(FontWeight.Bold)

        Text(this.item.content)
          .fontColor("#2f3642")
          .lineHeight(22)
        Row() {
          Text(`${this.item.time} .IP属地${this.item.area}`)
            .fontColor("#cacaca")
            .fontSize(12)

          Row({ space: 4 }) {
            Image($r("app.media.ic_like"))
              .width(12)
              .height(12)
              .fillColor(this.item.likeFlag ? Color.Red : "#cacaca")

            Text((this.item.likeNum??0).toString())//空指针异常了
              .fontColor(this.item.likeFlag ? Color.Red :"#cacaca")
              .fontSize(12)

          }
          .onClick(()=>{
            this.changeLike()
          })
        }
        .justifyContent(FlexAlign.SpaceBetween)//中间留空，靠近两边
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)//居左
      .layoutWeight(1)//占居一行

    }
    .alignItems(VerticalAlign.Top)
    .padding(20)
    .width('100%')
  }
}

export {HmCommentItem}