<template>
  <div v-if="tableData" class="main">
    <!-- 查询用户表单 -->
    <el-form :model="defaltQuery" :inline="true">

      <el-form-item label="类型">
        <el-select v-model="defaltQuery.type"  clearable>
          <el-option label="日本影片" :value="1" />
          <el-option label="美国影片" :value="2" />
          <el-option label="动漫" :value="3" />
          <el-option label="小视频" :value="4" />
        </el-select>
      </el-form-item>
      <el-form-item label="分数">
        <el-select v-model="defaltQuery.level"  clearable>
          <el-option label="0" :value="0" />
          <el-option label="1" :value="1" />
          <el-option label="2" :value="2" />
          <el-option label="3" :value="3" />
          <el-option label="4" :value="4" />
          <el-option label="5" :value="5" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="getList">查询</el-button>
      </el-form-item>
    </el-form>

    <!-- 用户数据表格 -->
    <el-table :data="tableData.list" border style="width: 100%">
      <el-table-column  prop="video.name" label="名字"  :key="Math.random()" min-width="300" />
      <el-table-column prop="type" label="类型" />
      <el-table-column  prop="video.actors" label="作者">
        　　<template scope="scope">
        　　　　<div v-for="item in scope.row.video.actors" >{{item.chineseName}}</div>
        　　</template>
      </el-table-column>
      <el-table-column  prop="video.level" label="个人评分" />
      <el-table-column prop="creatTime" label="关注时间" />
      <el-table-column  label="封面" min-width="100">
        　　<template slot-scope="scope">
        　　　　<img :src="scope.row.video.coverUrl" width="90%" height="90%" alt="封面"/>
        　　</template>
      </el-table-column>

      <el-table-column prop="address" label="操作" min-width="200">
        <template slot-scope="scope">
          <el-button size="mini" @click="jump(scope.$index, scope.row)">查看影片</el-button>
          <el-button size="mini" type="primary" @click="deleteFavorite(scope.$index, scope.row)">删除收藏</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页器 -->
    <el-pagination
      :total="tableData.totals"
      :current-page="defaltQuery.pageNum"
      :page-sizes="[1, 5, 10, 20, 30]"
      :page-size="defaltQuery.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      style="margin-top: 20px"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />
  </div>
</template>

<script>
    const moment = require('moment')
    import {
        getList
    } from '@/api/userFavorite'
    import {deleteFavorite} from "../../api/userFavorite";
    export default {
        data() {
            return {
                defaltQuery: {
                    type: '',
                    level: '',
                    pageSize: 10,
                    pageNum: 1
                },
                tableData: null,
            }
        },
        created() {
            this.getList()
        },
        methods: {
            getList() {
                getList(this.defaltQuery).then(res => {
                    res.list.forEach(item => {
                        if (item.type === 1) {
                            item.type = '日本影片'
                        }else if (item.type === 2) {
                            item.type = '美国影片'
                        }else if (item.type === 3) {
                            item.type = '动漫'
                        }else if (item.type === 4) {
                            item.type = '小视频'
                        }else if (item.type === 5) {
                            item.type = '图片'
                        }
                        item.creatTime = moment(item.creatTime).format('YYYY-MM-DD')
                    })
                    this.tableData = res
                })
            },
            handleSizeChange(pageSize) {
                this.defaltQuery.pageSize = pageSize
                this.getList()
            },
            handleCurrentChange(index) {
                this.defaltQuery.pageNum = index
                this.getList()
            },
            deleteFavorite(index, row) {
                console.log(row)
                deleteFavorite({id: row.id}).then(res => {
                    this.getList();
                }).catch(res => {
                    this.getList();
                })
            },
            jump(index, row){
                sessionStorage.setItem(
                    "listQuery_user_favorite",
                    JSON.stringify(this.listQuery)
                );
                sessionStorage.setItem("refresh_user_favorite", true);
                if(row.type!=='图片'){
                    sessionStorage.setItem("refresh_video_detail", true);
                    this.$router.push({
                        path: "/video_detail/index",
                        name: "影片详情", // 要跳转的路径的 name,可在 router 文件夹下的 index.js 文件内找
                        params: {id: row.videoId}
                    });
                }else{
                    this.$router.push({
                        path: '/picture_detail/index',
                        name: '图片详情', // 要跳转的路径的 name,可在 router 文件夹下的 index.js 文件内找
                        params: { id: row.picture.id }
                    })
                }

            }
        }
    }
</script>

<style lang="scss" scoped>
  .main {
    padding: 20px;
  }
</style>
