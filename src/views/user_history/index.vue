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
      <el-form-item label="开始时间">
        <el-date-picker
          v-model="defaltQuery.startTime"
          type="datetime"
          format="yyyy-MM-dd HH:mm:ss"
          value-format="yyyy-MM-dd HH:mm:ss"
          placeholder="选择日期时间"
          align="right"
          :picker-options="pickerOptions">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="结束时间">
        <el-date-picker
          v-model="defaltQuery.endTime"
          type="datetime"
          format="yyyy-MM-dd HH:mm:ss"
          value-format="yyyy-MM-dd HH:mm:ss"
          placeholder="选择日期时间"
          align="right"
          :picker-options="pickerOptions">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="getList">查询</el-button>
      </el-form-item>
    </el-form>

    <!-- 用户数据表格 -->
    <el-table :data="tableData.list" border style="width: 100%">
      <el-table-column v-if="type!==5" prop="video.name" label="名字"  min-width="300" />
      <el-table-column v-if="type!==5" prop="video.type" label="类型" />
      <el-table-column v-if="type!==5" prop="video.actors" label="作者">
        　　<template scope="scope">
        　　　　<div v-for="item in scope.row.video.actors" >{{item.chineseName}}</div>
        　　</template>
      </el-table-column>
      <el-table-column v-if="type!==5" prop="video.level" label="个人评分" />
      <el-table-column v-if="type!==5" prop="creatTime" label="观看时间" />
      <el-table-column v-if="type!==5" label="封面" min-width="100">
        　　<template slot-scope="scope">
        　　　　<img :src="scope.row.video.coverUrl" width="90%" height="90%" alt="封面"/>
        　　</template>
      </el-table-column>

      <el-table-column v-if="type===5" prop="picture.name" label="名字"  min-width="300" />
      <el-table-column v-if="type===5" prop="picture.type" label="类型" />
      <el-table-column v-if="type===5" prop="picture.actors" label="作者">
        　　<template scope="scope">
        　　　　<div v-for="item in scope.row.picture.actors" >{{item.chineseName}}</div>
        　　</template>
      </el-table-column>
      <el-table-column v-if="type===5" prop="picture.level" label="个人评分" />
      <el-table-column v-if="type===5" prop="creatTime" label="观看时间" />
      <el-table-column v-if="type===5" label="封面" min-width="100">
        　　<template slot-scope="scope">
        　　　　<img :src="scope.row.picture.coverUrl" width="90%" height="90%" alt="封面"/>
        　　</template>
      </el-table-column>

      <el-table-column prop="address" label="操作" min-width="200">
        <template slot-scope="scope">
          <el-button size="mini" @click="jump(scope.$index, scope.row)">查看影片</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页器 -->
    <el-pagination
      :total="tableData.total"
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
        getHistory
    } from '@/api/viewHistory'
    import {deleteFavorite} from "../../api/userFavorite";
    export default {
        data() {
            return {
                defaltQuery: {
                    type: '',
                    startTime: null,
                    endTime: null,
                    pageSize: 10,
                    pageNum: 1
                },
                tableData: null,
                pickerOptions: {
                    shortcuts: [{
                        text: '今天',
                        onClick(picker) {
                            picker.$emit('pick', new Date());
                        }
                    }, {
                        text: '昨天',
                        onClick(picker) {
                            const date = new Date();
                            date.setTime(date.getTime() - 3600 * 1000 * 24);
                            picker.$emit('pick', date);
                        }
                    }, {
                        text: '一周前',
                        onClick(picker) {
                            const date = new Date();
                            date.setTime(date.getTime() - 3600 * 1000 * 24 * 7);
                            picker.$emit('pick', date);
                        }
                    }]
                }
            }
        },
        created() {
            this.getList()
        },
        methods: {
            getList() {
                // this.defaltQuery.startTime = moment(this.defaltQuery.startTime).format('YYYY-MM-DD HH:mm:ss');
                // this.defaltQuery.endTime = moment(this.defaltQuery.endTime).format('YYYY-MM-DD HH:mm:ss');
                getHistory(this.defaltQuery).then(res => {
                    res.list.forEach(item => {
                        if (item.video.type === 1) {
                            item.video.type = '日本影片'
                        }else if (item.video.type === 2) {
                            item.video.type = '美国影片'
                        }else if (item.video.type === 3) {
                            item.video.type = '动漫'
                        }else if (item.video.type === 4) {
                            item.video.type = '小视频'
                        }else if (item.video.type === 5) {
                            item.video.type = '图片'
                        }
                        item.creatTime = moment(item.creatTime).format('YYYY-MM-DD HH:mm:ss')
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
                        path: "/video/video_detail",
                        //name: "videoDetail", // 要跳转的路径的 name,可在 router 文件夹下的 index.js 文件内找
                        query: {id: row.videoId}
                    });
                }else{

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
