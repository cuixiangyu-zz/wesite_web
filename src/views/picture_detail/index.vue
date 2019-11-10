<template>
  <div v-if="tableData" class="main">
    <el-container>
      <el-header></el-header>
    </el-container>
    <el-row type="flex">
      <el-col :span="6" :offset="6">
        <el-card >
          <el-image :src="tableData.coverUrl" fit="fill" ></el-image>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-row style="bottom: 0px; top: 0px; right: 0px; left: 20px;">
          <el-col :span="24">
            <p style="font-size: 25px; width: 20%;">{{tableData.name}}</p>
          </el-col>
          <el-col :span="24">
            <p style="font-size: 17px; width: 20%;">作者</p>
            <el-col
              v-for="actor in tableData.actors"
              :span="4"
              :key="actor.id"
              class="row-li"
              @click.native="handleClick"
            >
              <el-tag>{{actor.chineseName}}</el-tag>
            </el-col>
          </el-col>
          <el-col :span="24">
            <p style="font-size: 17px; width: 20%;">分类</p>
            <el-col
              v-for="type in tableData.types"
              :span="4"
              :key="type.id"
              class="row-li"
              @click.native="handleClick"
            >
              <el-tag>{{type.chineseName}}</el-tag>
            </el-col>
          </el-col>
        </el-row>
      </el-col>
    </el-row>

    <el-row style="width: 80%; left: 125px;">
      <el-col
        :span="4"
        :offset="2"
        v-for="address in tableData.address"
        :key="address"
        class="row-li"
        @click.native="handleClick"
      >
        <el-image :src="address" :preview-src-list="tableData.address" fit="fill"></el-image>
      </el-col>
    </el-row>
  </div>
</template>
<script>
import { getDetil } from '@/api/pictureDetail'
export default {
  data() {
    return {
      tableData: [],
      querylist: {
        id: null
      },

      listQuery: {
        pageNum: 1,
        pageSize: 10,
        actorName: null,
        pictureName: null,
        language: null,
        types: null
      },
      typeMap: '',
      actors: '',
      deviceDetail: null,
      imgSrc: 'http://127.0.0.1:8081/website/resources/_MG_0138.jpg',
      url: 'http://127.0.0.1:8081/website/resources/_MG_0138.jpg',
      srcList: [
        // 'http://127.0.0.1:8081/website/resources/_MG_0170.jpg',
        // 'http://127.0.0.1:8081/website/resources/_MG_0177.jpg'
      ]
    }
  },
  created() {
    this.getDetil()
  },
  // beforeRouteEnter(to, from, next) {
  //   next(vm => {
  //     // 通过 `vm` 访问组件实例
  //     console.log(vm.$route.params)
  //     this.id = vm.$route.params.id
  //     getDetil(vm.$route.params.id).then(res => {
  //       this.tableData = res
  //     })
  //   })
  // },
  methods: {
    getDetil() {
      this.querylist.id = this.$route.params.id
      console.log(this.querylist)

      getDetil(this.querylist).then(res => {
        this.tableData = res
      })
    },

    handleClick() {
      // alert('11111111')
    },
    getType(type) {
      event.stopPropagation()
      const arr = []
      const arr1 = []
      arr.push('allTypes')
      arr.push(type.id)
      arr1.push(arr)
      this.listQuery.types = arr1
      this.listQuery.actorName = null
      console.log(this.listQuery)
      this.getPageList()
    },
    getActor(actor) {
      event.stopPropagation()
      this.listQuery.actorName = actor
      this.listQuery.types = null
      this.getPageList()
    },
    imgview() {
      alert('2222')
    },
    jump() {
      alert('111')
    },
    showimg() {
      const arr = []
      arr.push('http://127.0.0.1:8081/website/resources/_MG_0170.jpg')
      arr.push('http://127.0.0.1:8081/website/resources/_MG_0177.jpg')
      this.srcList = arr
    }
  }
}
</script>
<style>
.el-row {
  margin-bottom: 20px;
  &:last-child {
    margin-bottom: 0;
  }
}
.el-col {
  border-radius: 4px;
}
.bg-purple-dark {
  background: #99a9bf;
}
.bg-purple {
  background: #d3dce6;
}
.bg-purple-light {
  background: #e5e9f2;
}
.grid-content {
  border-radius: 4px;
  min-height: 36px;
  width: 440px;
  height: 400px;
}
.row-bg {
  padding: 10px 0;
  background-color: #f9fafc;
}
.time {
  font-size: 13px;
  color: #999;
}

.bottom {
  margin-top: 13px;
  line-height: 12px;
}

.button {
  padding: 0;
  float: right;
}

.image {
  width: 100%;
  display: block;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: '';
}

.clearfix:after {
  clear: both;
}
</style>
