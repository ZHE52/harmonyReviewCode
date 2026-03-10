import { HmCommentItem, HmNavBar } from './components1'
import { ReplyItemModel } from './models'

@Entry
@ComponentV2
struct ZhiHuSzPage {
  @Local commentList: ReplyItemModel[] = [
    new ReplyItemModel({
      id: 1,
      author: '偏菊花v和v家',
      avatar: 'https://picx.zhimg.com/027729d02bdf060e24973c3726fea9da_l.jpg?source=06d4cd63',
      content: '更何况还分到一个摩洛哥[惊喜]',
      time: '2021-01-01 00:00:00',
      area: '海南',
      likeNum: 34,
      likeFlag: false
    }),
    new ReplyItemModel({
      id: 1,
      author: 'asfdasdf',
      avatar: 'https://picx.zhimg.com/027729d02bdf060e24973c3726fea9da_l.jpg?source=06d4cd63',
      content: '更何况还分到一个摩洛哥[惊喜]',
      time: '2021-01-01 00:00:00',
      area: '海南',
      likeNum: 34,
      likeFlag: false
    }),
    new ReplyItemModel({
      id: 1,
      author: '偏时代峰峻拉萨的家',
      avatar: 'https://picx.zhimg.com/027729d02bdf060e24973c3726fea9da_l.jpg?source=06d4cd63',
      content: '更何况kjaskl手机里看到飞机惊喜]',
      time: '2021-01-01 00:00:00',
      area: '海南',
      likeNum: 34,
      likeFlag: false
    }),
    new ReplyItemModel({
      id: 1,
      author: '偏执狂-妄想家',
      avatar: 'https://picx.zhimg.com/027729d02bdf060e24973c3726fea9da_l.jpg?source=06d4cd63',
      content: '更何收到了开发交流额大理石复合板😂[惊喜]',
      time: '2021-01-01 00:00:00',
      area: '海南',
      likeNum: 34,
      likeFlag: false
    })
  ]

  build() {
    Column() {
      HmNavBar({ title: '评论回复' })
      HmCommentItem()
      Divider().strokeWidth(6) //这里不懂
      Row() {
        Text("评论数：50")
      }
      .width('100%')
      .height(50)
      .padding({
        left: 20
      })
      .border({
        color: '#f3f4f5',
        width: {
          bottom: 1
        }
      })

      List() {
        ForEach(this.commentList, (item:ReplyItemModel) => {
          ListItem() {
            HmCommentItem({ item})
          }
        })
      }.layoutWeight(1)

    }
  }
}