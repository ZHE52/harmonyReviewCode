// ===================================================================
// 文件说明：置顶消息面板组件
// 功能：
// 1. 显示置顶消息列表（最多5条）
// 2. 支持堆叠效果（2条及以上时显示）
// 3. 支持展开/收起动画（顶部固定，底部展开）
// 4. 支持移除置顶消息
// ===================================================================

// 置顶消息数据模型
class PinnedItem {
  id: number        // 消息唯一标识
  text: string      // 消息文本内容
  
  constructor(id: number, text: string) {
    this.id = id
    this.text = text
  }
}

@Component
export struct TopPinnedPanel {
  // ===== 组件属性 =====
  @Link pinnedList: PinnedItem[]                          // 置顶消息列表（双向绑定）
  onRemoveItem: (id: number) => void = (id: number) => {} // 移除消息的回调函数
  
  // ===== 状态变量 =====
  @State private panelExpanded: boolean = false           // 面板是否展开
  @State private expandedHeight: number = 0               // 展开区域的高度（用于动画）

  // ===================================================================
  // 切换面板展开/收起状态
  // 实现原理：
  // 1. 使用 animateTo 包裹状态变化，实现平滑动画
  // 2. 展开时：计算需要显示的消息数量，设置对应高度
  // 3. 收起时：高度设为 0
  // 4. 动画时长 300ms，使用 EaseInOut 缓动曲线
  // ===================================================================
  private togglePanel() {
    animateTo({ 
      duration: 300,                    // 动画时长 300 毫秒
      curve: Curve.EaseInOut,           // 缓动曲线：先加速后减速
    }, () => {
      this.panelExpanded = !this.panelExpanded
      
      if (this.panelExpanded) {
        // 展开：计算高度 = (消息数量 - 1) * 每条消息高度
        // 减1是因为第一条消息始终显示，不需要计算在展开区域内
        const itemsToShow = Math.min(this.pinnedList.length - 1, 4) // 最多展开4条（总共5条）
        this.expandedHeight = itemsToShow * 56
      } else {
        // 收起：高度设为 0
        this.expandedHeight = 0
      }
    })
  }

  build() {
    Column() {
      // ===================================================================
      // 主体区域：根据消息数量显示不同的UI
      // ===================================================================
      
      if (this.pinnedList.length === 0) {
        // ===== 情况1：没有置顶消息 =====
        Text('暂无置顶内容')
          .fontSize(14)
          .fontColor('#999')
          .width('100%')
          .height(40)
          .textAlign(TextAlign.Center)
          
      } else if (this.pinnedList.length === 1) {
        // ===== 情况2：只有1条消息（不显示堆叠效果，不显示展开按钮）=====
        this.renderSingleItem(this.pinnedList[0])
        
      } else {
        // ===== 情况3：2条及以上消息（显示堆叠效果和展开按钮）=====
        Column() {
          // --- 顶部固定区域：显示最新的一条消息（带堆叠效果）---
          if (this.panelExpanded) {
            // 展开状态：只显示最新一条，无堆叠效果
            this.renderSingleItem(this.pinnedList[this.pinnedList.length - 1])
          } else {
            // 收起状态：显示堆叠效果（最多3层）
            this.renderStackedView()
          }
          
          // --- 展开区域：从下往上展开的消息列表 ---
          Column() {
            // 显示除了最新一条之外的其他消息（最多4条）
            ForEach(
              [...this.pinnedList].reverse().slice(1, 5),
              (item: PinnedItem) => {
                this.renderSingleItem(item)
              },
              (item: PinnedItem) => String(item.id)
            )
          }
          .width('100%')
          .height(this.expandedHeight)  // 动画高度
          .clip(true)                    // 裁剪超出部分
          
          // --- 展开/收起按钮 ---
          Row() {
            Text(this.panelExpanded ? '⌃' : '⌄')
              .fontSize(18)
              .fontColor('#666')
              .width(34)
              .height(34)
              .textAlign(TextAlign.Center)
              .backgroundColor('#F2F3F5')
              .borderRadius(17)
          }
          .width('100%')
          .height(44)
          .justifyContent(FlexAlign.Center)
          .onClick(() => this.togglePanel())
        }
      }
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(14)
    .margin({ left: 16, right: 16, top: 12 })
    .clip(true)
    .shadow({
      radius: this.panelExpanded ? 20 : 10,
      color: this.panelExpanded ? '#40000000' : '#20000000',
      offsetX: 0,
      offsetY: this.panelExpanded ? 4 : 2
    })
  }

  // ===================================================================
  // 渲染单条消息
  // 参数：item - 消息对象
  // 用途：展开状态下的每一条消息
  // ===================================================================
  @Builder
  private renderSingleItem(item: PinnedItem) {
    Row() {
      Text('◎')
        .fontSize(18)
        .fontColor('#F5A623')
        .margin({ right: 10 })
      
      Text(item.text)
        .fontSize(16)
        .fontColor('#222')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)
      
      Text('移除')
        .fontSize(14)
        .fontColor('#4A90E2')
        .padding({ left: 10, right: 6, top: 8, bottom: 8 })
        .onClick(() => this.onRemoveItem(item.id))
    }
    .width('100%')
    .height(56)
    .padding({ left: 14, right: 14 })
  }

  // ===================================================================
  // 渲染堆叠效果（收起状态）
  // 实现原理：
  // 1. 使用 Stack 容器实现层叠效果
  // 2. 最多显示3层，从底到顶依次为：第3条、第2条、第1条（最新）
  // 3. 通过 offset 控制垂直偏移，通过 opacity 控制透明度
  // 4. 只有最顶层可以点击展开
  // ===================================================================
  @Builder
  private renderStackedView() {
    Stack() {
      // 获取最后三条消息（倒序后取前3条，再倒序回来）
      ForEach(
        [...this.pinnedList].reverse().slice(0, 3).reverse(),
        (item: PinnedItem, index: number) => {
          Column() { 
            Row() {
              Text('◎')
                .fontSize(18)
                .fontColor('#F5A623')
                .margin({ right: 10 })
              
              Text(item.text)
                .fontSize(16)
                .fontColor('#222')
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .layoutWeight(1)
              
              Text('移除')
                .fontSize(14)
                .fontColor('#4A90E2')
                .padding({ left: 10, right: 6, top: 8, bottom: 8 })
                .onClick(() => this.onRemoveItem(item.id))
            }
            .width('100%')
            .height(56)
            .padding({ left: 14, right: 14 })
          }
          .width('100%')
          .backgroundColor(index === 2 ? Color.White : '#F7F7F7')  // 最顶层白色，其他灰色
          .borderRadius(index === 2 ? 12 : 10)
          .offset({ x: 0, y: index * 6 })                          // 垂直偏移：0, 6, 12
          .opacity(index === 0 ? 0.4 : (index === 1 ? 0.7 : 1))   // 透明度：0.4, 0.7, 1
          .onClick(() => {
            if (index === 2) {  // 只有最顶层可以点击展开
              this.togglePanel()
            }
          })
        },
        (item: PinnedItem) => String(item.id)
      )
    }
    .width('100%')
    .height(56 + 14)  // 高度 = 单条高度 + 堆叠偏移量
  }
}