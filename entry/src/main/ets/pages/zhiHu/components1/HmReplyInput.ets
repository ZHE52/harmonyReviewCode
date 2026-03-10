@ComponentV2
struct HmReplyInput {
  @Local content:string=''
  @Event publishComment:(content:string)=>void=()=>{}//不明白

  build() {
    Row() {
      TextInput({ text:$$this.content,placeholder:'请输入评论' })
        .layoutWeight(1)
        .height(40)
        .onSubmit(()=>{//是啥
          //键盘的确定事件
          if (this.content) {
            this.publishComment(this.content)
            this.content=''
          }

        })
      Button('发布')
        .onClick(()=>{
          if (this.content) {
            this.publishComment(this.content)
            this.content=''
          }
        })
    }
    .padding({left:10,right:10})
    .width('100%')
    .height(60)
  }
}

export { HmReplyInput}