import { User } from './TestDAO/UserDao'
import { userDao } from './TestDAO/UserDao'

@Entry
@Component
struct Index {
  insertId: number = 2000

  build() {
    Column() {
      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
        Button("新增商品").onClick(() => {
          try {
            this.insertTestPType()
          } catch (e) {
            console.debug(e)
          }
        })
        Button("查询商品").onClick(() => {
          userDao.findOnePTypeName((name: string) => {
            console.debug('商品 =' + name)
          })
        })
      }.width('100%').margin({ bottom: '10vp' })

      //主数据库
      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {

        Button("插入数据").onClick(() => {
          try {
            this.insert()
          } catch (e) {
            console.debug(e)
          }
        })
        Button("插入数据(事务)").onClick(() => {
          try {
            this.randomGenInsertId()
            userDao.execTransactional(this.insertId)
          } catch (e) {
            console.debug(e)
          }
        })
      }.width('100%').margin({ bottom: '10vp' })

      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
        Button("查找单一实体类数据").onClick(() => {
          userDao.findOneUser((user: User) => {
            if (!user) {
              console.debug('无数据')
              return
            }
            console.debug('数据 =' + user.id + ' name = ' + user.name)
          })
        })

        Button("查找多条实体类数据").onClick(() => {
          userDao.findAllUser((userList: User[]) => {
            userList.forEach((user: User) => {
              console.debug('多条数据 =' + user.id + ' name = ' + user.name)
            })
          })
        })

        Button("查找所有数据count").onClick(() => {
          userDao.findAllCount((result) => {
            console.debug(JSON.stringify(result))
          })
        })

        Button("查找单一名称数据").onClick(() => {
          userDao.findOneName((name: string) => {
            console.debug('数据 =' + name)
          })
        })

        Button("查找多条名称数据").onClick(() => {
          userDao.findAllName((userList: string[]) => {
            if (!userList) {
              console.debug('无数据')
              return
            }
            userList.forEach((name: string) => {
              console.debug('多条数据 =' + name)
            })
          })
        })
      }.width('100%').margin({ bottom: '10vp' })

      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
        Button("删除所有数据").onClick(() => {
          userDao.deleteAll().then((result) => {
            console.debug("删除成功")
          })
        })
      }.width('100%').margin({ bottom: '10vp' })

      Blank().height('40vp')

    }
  }

  randomGenInsertId() {
    this.insertId = Math.floor(Math.random() * 100_000_100)
  }

  async insert() {
    this.randomGenInsertId()
    console.debug("开始插入：" + this.insertId)
    let isSuccess = await userDao.insert(this.insertId, "name" + this.insertId)
    console.debug("是否插入成功=" + isSuccess)
  }

  async insertTestPType() {
    let isSuccess = await userDao.insertTestPType()
    console.debug("是否插入成功=" + isSuccess)
  }
}