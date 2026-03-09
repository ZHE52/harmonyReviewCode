// ===================================================================
// 文件说明：聊天界面主页面
// 功能：
// 1. 显示聊天消息列表
// 2. 集成置顶消息面板（TopPinnedPanel）
// 3. 使用 Stack 布局实现置顶面板覆盖效果
// 4. 模拟聊天消息和视频消息的显示
// ===================================================================

import { TopPinnedPanel } from '../pages/TopPinnedPanel';
import { objData } from './废弃代码/testConponent/dataPage';

// 置顶消息数据模型（与 TopPinnedPanel 中的定义保持一致）
class PinnedItem {
  id: number        // 消息唯一标识
  text: string      // 消息文本内容
  
  constructor(id: number, text: string) {
    this.id = id
    this.text = text
  }
}

@Entry
@Component
struct Index1 {
  // ===== 模拟数据获取 =====
  private fetchDynamicData(): objData {
    const timestamp = new Date().getTime()
    return new objData('张三', `我是动态内容，ID: ${timestamp}`)
  }

  // ===== 生命周期：组件即将显示 =====
  aboutToAppear(): void {
    const backendData = this.fetchDynamicData()
    this.zhangsan = backendData

    // 将获取到的数据添加到置顶列表
    if (this.zhangsan) {
      const pinnedText = `${this.zhangsan.name}: ${this.zhangsan.content}`
      const newItem = new PinnedItem(this.nextPinnedId, pinnedText)

      if (!this.pinnedList.some(item => item.text === pinnedText)) {
        this.pinnedList.unshift(newItem)
        this.nextPinnedId += 1
      }
    }
  }

  // ===== 状态变量 =====
  @State zhangsan: objData | null = null
  
  // 置顶消息列表（初始化4条测试数据）
  @State pinnedList: PinnedItem[] = [
    new PinnedItem(1, '王恩连: 1111'),
    new PinnedItem(2, '王恩连: 6'),
    new PinnedItem(3, '王恩连: [郭国政: 体验新]——————————————...'),
    new PinnedItem(4, '王恩连: 在吗 我想问下 在测试环境的eip上修...'),
  ]
  
  @State private nextPinnedId: number = 5  // 下一个消息的ID

  // ===== 添加置顶消息 =====
  private addPinned(text: string) {
    const next = [...this.pinnedList, new PinnedItem(this.nextPinnedId, text)]
    this.nextPinnedId += 1
    // 最多保留5条置顶消息
    this.pinnedList = next.length > 5 ? next.slice(next.length - 5) : next
  }

  // ===== 移除置顶消息 =====
  private removePinned(id: number) {
    this.pinnedList = this.pinnedList.filter(it => it.id !== id)
  }

  build() {
    // ===================================================================
    // 布局说明：使用 Stack 实现层叠布局
    // 第1层（底层）：聊天内容区域（标题栏 + 消息列表 + 输入栏）
    // 第2层（顶层）：置顶消息面板（通过 zIndex 确保在最上层）
    // 
    // 关键点：
    // 1. Stack 的 alignContent 设为 Alignment.Top，让置顶面板从顶部开始
    // 2. 置顶面板设置 zIndex(10)，确保覆盖在聊天内容之上
    // 3. 展开时，置顶面板会向下扩展，覆盖聊天内容，但聊天内容不会移动
    // ===================================================================
    Stack({ alignContent: Alignment.Top }) {
      
      // ===== 第1层：聊天内容区域 =====
      Column() {
        // --- 顶部标题栏 ---
        Row() {
          Text('← ')
            .fontSize(24)
            .fontColor('#333')
          
          Text('王恩连')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          
          Row() {
            Text('☎')
              .fontSize(20)
              .margin({ right: 16 })
            Text('⋯')
              .fontSize(20)
          }
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor(Color.White)

        // --- 聊天消息列表区域 ---
        Scroll() {
          Column() {
            // 模拟聊天消息
            this.renderChatMessage('你直顶了一条消息', '2025-12-25 16:21')
            this.renderVideoMessage('0:04', '2025-12-25 16:56')
            this.renderChatMessage('你撤回了一条消息', '2025-12-25 16:56')
            this.renderVideoMessage('0:04', '2025-12-25 16:56')
            
            // 测试按钮：添加新的置顶消息
            Button('点我新增一条置顶')
              .onClick(() => this.addPinned(`新消息 ${this.nextPinnedId}`))
              .margin({ top: 20 })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 12 })
        }
        .layoutWeight(1)
        .backgroundColor('#F2F3F5')
        .scrollBar(BarState.Off)

        // --- 底部输入栏 ---
        Row() {
          Text('⏸')
            .fontSize(24)
            .margin({ right: 12 })
          Text('☺')
            .fontSize(24)
            .margin({ right: 12 })
          Text('+')
            .fontSize(24)
        }
        .width('100%')
        .height(60)
        .padding({ left: 16, right: 16 })
        .backgroundColor(Color.White)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .height('100%')

      // ===== 第2层：置顶消息面板 =====
      // 关键点：
      // 1. zIndex(10) 确保在最上层
      // 2. 展开时会向下扩展，覆盖下面的聊天内容
      // 3. 聊天内容保持不动（不会被推下去）
      Column() {
        TopPinnedPanel({
          pinnedList: $pinnedList,              // 双向绑定置顶列表
          onRemoveItem: (id: number) => {       // 移除消息的回调
            this.removePinned(id)
          }
        })
      }
      .width('100%')
      .zIndex(10)  // 设置层级，确保在最上层
    }
    .width('100%')
    .height('100%')
  }

  // ===================================================================
  // 渲染普通聊天消息
  // 参数：text - 消息文本，time - 时间戳
  // ===================================================================
  @Builder
  private renderChatMessage(text: string, time: string) {
    Column() {
      Text(time)
        .fontSize(12)
        .fontColor('#999')
        .margin({ bottom: 8 })
      
      Text(text)
        .fontSize(14)
        .fontColor('#999')
        .padding(10)
        .backgroundColor('#E8E8E8')
        .borderRadius(8)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .margin({ bottom: 16 })
  }

  // ===================================================================
  // 渲染视频消息
  // 参数：duration - 视频时长，time - 时间戳
  // ===================================================================
  @Builder
  private renderVideoMessage(duration: string, time: string) {
    Column() {
      Text(time)
        .fontSize(12)
        .fontColor('#999')
        .margin({ bottom: 8 })
        .alignSelf(ItemAlign.End)
      
      Stack() {
        // 视频背景
        Column()
          .width(150)
          .height(200)
          .backgroundColor('#2D5A3D')
          .borderRadius(12)
        
        // 播放按钮
        Text('▶')
          .fontSize(40)
          .fontColor(Color.White)
        
        // 视频时长
        Text(duration)
          .fontSize(12)
          .fontColor(Color.White)
          .position({ x: '80%', y: '85%' })
        
        // 置顶标签
        Text('置顶')
          .fontSize(12)
          .fontColor('#333')
          .backgroundColor('#FFD700')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(4)
          .position({ x: '65%', y: '5%' })
      }
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.End)
    .margin({ bottom: 16 })
  }
}
