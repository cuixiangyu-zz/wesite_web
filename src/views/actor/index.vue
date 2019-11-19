<template>
  <div v-if="tableData" class="main">
    <!-- 查询表单 -->
    <el-form :inline="true">
      <el-form-item label="作者">
        <el-select v-model="listQuery.actorName" placeholder="请选择" value-key="id">
          <el-option
            v-for="item in actors"
            :key="item.id"
            :label="item.chineseName"
            :value="item.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item style="margin-right: 50px;">
        <el-button type="primary" @click="getPageList">查询</el-button>
      </el-form-item>
    </el-form>
    <el-row class="row-ul" gutter="20">
      <el-col
        v-for="item in tableData.list"
        :span="4"
        :key="item.id"
        class="row-li"
        @click.native="handleClick"
      >
        <el-card :body-style="{ padding: '0px' }">
          <el-image :src="item.coverUrl"  lazy></el-image>
          <div style="padding: 14px;" @click="jump(item.id)">
            <div class="bottom clearfix">
              <span class="tag-group__title">姓名: {{ item.name }}</span>
            </div>
            <div class="bottom clearfix">
              <span class="tag-group__title">中文姓名: {{ item.chineseName }}</span>
            </div>
            <div class="bottom clearfix">
              <span class="tag-group__title">作品数量: {{ item.count }}</span>
            </div>
            <div class="bottom clearfix">
              <el-rate
                v-model="item.level"
                disabled
                show-score
                text-color="#ff9900"
                score-template="{value}"
              ></el-rate>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 分页器 -->
    <el-pagination
      :total="tableData.total"
      :current-page="listQuery.pageNum"
      :page-sizes="[1, 5, 10, 20, 30]"
      :page-size="listQuery.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      style="margin-top: 20px"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />
  </div>
</template>
<script>
import { findAll } from '@/api/actor'
export default {
  data() {
    return {
      tableData: [],
      listQuery: {
        pageNum: 1,
        pageSize: 10
      },
      typeMap: '',
      actors: '',
      deviceDetail: null,
      imgSrc: 'http://127.0.0.1:8081/website/resources/_MG_0170.jpg',
      url: 'http://127.0.0.1:8081/website/resources/_MG_0170.jpg',
      srcList: [
        // 'http://127.0.0.1:8081/website/resources/_MG_0170.jpg',
        // 'http://127.0.0.1:8081/website/resources/_MG_0177.jpg'
      ]
    }
  },
  created() {
    this.findAll()
  },
  methods: {
    findAll() {
      console.log(this.listQuery)
      findAll(this.listQuery).then(res => {
        this.tableData = res
        console.log(res)
      })
    },
    handleCurrentChange(index) {
      this.listQuery.pageNum = index
      this.getPageList()
    },
    handleSizeChange(pageSize) {
      this.listQuery.pageSize = pageSize
      this.getPageList()
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
    jump(videoid) {
      this.$router.push({
        path: '/video_detail/index',
        name: '影片详情', // 要跳转的路径的 name,可在 router 文件夹下的 index.js 文件内找
        params: { id: videoid }
      })
    },
    showimg() {
      const arr = []
      arr.push('http://127.0.0.1:8081/website/resources/_MG_0177.jpg')
      arr.push('http://127.0.0.1:8081/website/resources/_MG_0170.jpg')
      this.srcList = arr
    }
  }
}
</script>

<style lang="scss" scoped>
.main {
  padding: 20px;
}
</style>
<style>
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
