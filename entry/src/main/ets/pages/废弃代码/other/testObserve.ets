
class user{
  name:string
  age:number

  constructor(name:string,age:number) {
    this.name=name
    this.age=age
  }
}

@Entry
@ComponentV2
struct  sldkjf{
  zhangsan:user=new user("张三",18)
  build() {
    Column() {
    Text(this.zhangsan.name)
      //Text(this.zhangsan.age)
    }
  }
}