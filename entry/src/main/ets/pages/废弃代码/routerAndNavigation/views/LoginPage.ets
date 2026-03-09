// 这个文件, 本质是在提供, 匹配的name, 渲染的结构
@Component
struct LoginPage {
  build() {
    // 子页面, 必须包裹在中
    NavDestination() {
      Column() {
        Text('登录页面')
          .fontSize(50)
      }
    }
  }
}

@Builder
export function LoginBuilder () {
  LoginPage()
}