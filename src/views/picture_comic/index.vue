<template>
  <div v-if="tableData" class="main">
    <!-- 查询表单 -->
    <el-form :inline="true">
      <el-form-item label="图片名">
        <el-input v-model="listQuery.pictureName" clearable placeholder="请输入图片名" />
      </el-form-item>
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
      <el-form-item label="语言">
        <el-select v-model="listQuery.language" placeholder="请选择" clearable>
          <el-option label="汉语" value="chinese" />
          <el-option label="英语" value="english" />
          <el-option label="日语" value="japan" />
        </el-select>
      </el-form-item>
      <el-form-item label="分类">
        <el-cascader-multi v-model="listQuery.types" :data="typeMap" filterable reserve-keyword />
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
        <el-card :body-style="{ padding: '0px' ,height: '500px'}">
          <el-image :src="item.coverUrl" :preview-src-list="item.address" @click="showimg" lazy></el-image>
          <div style="padding: 14px;" @click="jump(item.id)">
            <span class="spantest">{{ item.name }}</span>
            <div class="bottom clearfix">
              <time class="time">{{ item.actorname }}</time>
              <span class="tag-group__title">类型:</span>
              <el-tag
                v-for="types in item.types"
                :key="types.id"
                size="mini"
                effect="plain"
                @click="getType(types)"
              >{{ types.chineseName }}</el-tag>
            </div>
            <div class="bottom clearfix">
              <time class="time">{{ item.actorname }}</time>
              <span class="tag-group__title">作者:</span>
              <el-tag
                v-for="actors in item.actors"
                :key="actors.id"
                size="mini"
                effect="plain"
                @click="getActor(actors.id)"
              >{{ actors.chineseName }}</el-tag>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 分页器 -->
    <el-pagination
      :total="tableData.total"
      :current-page="listQuery.pageNum"
      :page-sizes="[1, 6, 12, 18, 24]"
      :page-size="listQuery.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      style="margin-top: 20px"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />
  </div>
</template>
<script>
import { getPageList } from '@/api/picture'
export default {
  data() {
    return {
      tableData: [],
      listQuery: {
        pageNum: 1,
        pageSize: 12,
        actorName: null,
        pictureName: null,
        language: null,
        types: null
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
    this.getPageList()
  },
  beforeRouteLeave(to, form, next) {
    sessionStorage.setItem(
      "listQuery_comic_picture",
      JSON.stringify(this.listQuery)
    );
    sessionStorage.setItem("refresh_comic_picture", true);
    next()
  },
  methods: {
    getPageList() {
      var listQuery = sessionStorage.getItem('listQuery_comic_picture')
      var refresh = sessionStorage.getItem('refresh_comic_picture')
      if(listQuery!==null&&refresh!==null&&refresh==='true'){
        this.listQuery = JSON.parse(listQuery)
        console.log('aaaaaaaaaaaaaaaaaa')
      }
      console.log(this.listQuery)
      getPageList(this.listQuery).then(res => {
        this.tableData = res.PageInfo
        this.actors = res.actors
        this.typeMap = res.typeMap
      })
    },
    handleCurrentChange(index) {
      sessionStorage.setItem('refresh_comic_picture',false)
      this.listQuery.pageNum = index
      this.getPageList()
    },
    handleSizeChange(pageSize) {
      sessionStorage.setItem('refresh_comic_picture',false)
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
      sessionStorage.setItem('refresh_comic_picture',false)
      this.getPageList()
    },
    getActor(actor) {
      event.stopPropagation()
      this.listQuery.actorName = actor
      this.listQuery.types = null
      sessionStorage.setItem('refresh_comic_picture',false)
      this.getPageList()
    },
    imgview() {
      alert('2222')
    },
    jump(picid) {
      sessionStorage.setItem('listQuery_comic_picture',JSON.stringify(this.listQuery))
      sessionStorage.setItem('refresh_comic_picture',true)
      sessionStorage.setItem("refresh_comic_picture_detail", true);
      this.$router.push({
        path: '/picture_detail/index',
        name: '图片详情', // 要跳转的路径的 name,可在 router 文件夹下的 index.js 文件内找
        params: { id: picid }
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

.spantest{
     overflow: hidden;
    -webkit-line-clamp: 1;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    width: 250px;
}
</style>
