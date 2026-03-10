export interface ReplyItem{
  avatar: ResourceStr // 头像
  author: string   // 作者
  id: number  // 评论的id
  content: string // 评论内容
  time: string // 发表时间
  area: string // 地区
  likeNum: number // 点赞数量
  likeFlag: boolean | null // 当前用户是否点过赞
}

export class ReplyItemModel implements ReplyItem{
  avatar: ResourceStr|string= ''
  author: string= ''
  id: number= 0
  content: string= ''
  time: string= ''
  area: string= ''
  likeNum: number= 0
  likeFlag:boolean|null= null
  constructor(model:ReplyItem) {//括号里面的是接口传过来的东西
    this.avatar=model.avatar//这里是通过接口传过来的东西，传递给当前class的xx值
    this.author=model.author
    this.id=model.id
    this.content=model.content
    this.time=model.time
    this.area=model.area
    this.likeNum=model.likeNum
    this.likeFlag=model.likeFlag

  }
}