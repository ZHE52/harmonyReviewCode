//本案例主要是讲@sstate的练习
import { CardType } from "@kit.VisionKit"

//表示@state的局限性
interface Car{
  name:string
}

interface penson{
  name:string,
  car:Car
}

@Entry
@Component
struct indexx {
  @State wenzi:string='张三'
  @State buNeng:penson={
    name:'李四',
    car:{name:'宝马x5'}//对象定义的时候不用等号，而是用冒号
  }
  build() {
    Column() {
      Text(this.wenzi)
      Button('点击修改名字为张四').onClick(()=>{
        this.wenzi='张四'
      })
      Text(this.buNeng.name)
      Button('点击修改名字为王五').onClick(()=>{
        this.buNeng.name='王五'
      })
      Text(this.buNeng.car.name)
      Button('点击修改车名为保时捷').onClick(()=>{
        this.buNeng.car={//对象的赋值还是用等号，要用大括号包起来
          name:'保时捷'
        }
      })
    }
  }
}