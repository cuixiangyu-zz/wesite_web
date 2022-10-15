<template>
  <div v-if="tableData" class="main">
    <!-- 查询表单 -->
    <el-form :inline="true">
      <el-form-item label="影片名">
        <el-input v-model="listQuery.pictureName" clearable placeholder="请输入影片名"/>
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
        style="height: 390px"
      >
        <el-card :body-style="{ padding: '0px',height: '390px'  }">
          <el-image :src="item.coverUrl" @click="showimg" lazy style="width: 280px;height: 157px"></el-image>
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
              >{{ types.chineseName }}
              </el-tag>
            </div>
            <div class="bottom clearfix">
              <time class="time">{{ item.actorname }}</time>
              <span class="tag-group__title">作者:</span>
              <el-tag
                v-for="actors in item.actors"
                :key="actors.id"
                size="mini"
                effect="plain"
                @click="getActor(actors.chineseName)"
              >{{ actors.chineseName }}({{actors.count}})
              </el-tag>
            </div>
            <div class="bottom clearfix">
              <el-rate
                v-model="item.level"
                disabled
                show-score
                text-color="#ff9900"
                score-template="{value}"
                class="rate"
              ></el-rate>
              <el-tooltip class="item" effect="dark" content="添加到播放列表" placement="top">
                <el-button type="text"  size="medium" class="button" icon="el-icon-plus" @click="addList(item.id)"></el-button>
              </el-tooltip>

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
    import {getPageList} from "@/api/video";

    export default {
        name: "pornHub",
        data() {
            return {
                tableData: [],
                listQuery: {
                    pageNum: 1,
                    pageSize: 12,
                    actorName: null,
                    videoName: null,
                    types: null,
                    videoType: 4
                },
                typeMap: "",
                actors: "",
                deviceDetail: null,
                imgSrc: "http://127.0.0.1:8081/website/resources/_MG_0170.jpg",
                url: "http://127.0.0.1:8081/website/resources/_MG_0170.jpg",
                srcList: [
                    // 'http://127.0.0.1:8081/website/resources/_MG_0170.jpg',
                    // 'http://127.0.0.1:8081/website/resources/_MG_0177.jpg'
                ],
                videoAndIdList: {
                    idList: [],
                    videoList: []
                }

            };
        },
        created() {
            var list = sessionStorage.getItem("videoAndIdList");
            if (list !== null &&
                list !== undefined &&
                list !== "") {
                this.videoAndIdList = JSON.parse(list);
            }
            this.getPageList();
        },
        beforeRouteLeave(to, form, next) {
            sessionStorage.setItem(
                "listQuery_pornHub_video",
                JSON.stringify(this.listQuery)
            );
            sessionStorage.setItem("refresh_pornHub_video", true);
            sessionStorage.setItem("videoAndIdList", JSON.stringify(this.videoAndIdList));
            next();
        },
        methods: {
            getPageList() {
                var listQuery = sessionStorage.getItem("listQuery_pornHub_video");
                var refresh = sessionStorage.getItem("refresh_pornHub_video");
                if (listQuery !== null && refresh !== null && refresh === "true") {
                    this.listQuery = JSON.parse(listQuery);
                    sessionStorage.setItem("refresh_pornHub_video", false);
                }
                getPageList(this.listQuery).then(res => {
                    this.tableData = res.PageInfo;
                    var actors = res.actors;
                    var list = []
                    actors.forEach(actor => {
                        list.push({"value": actor.chineseName})
                    })
                    this.actors = list
                    this.typeMap = res.typeMap;
                });
            },
            handleCurrentChange(index) {
                this.listQuery.pageNum = index;
                sessionStorage.setItem("refresh_pornHub_video", false);
                this.getPageList();
            },
            handleSizeChange(pageSize) {
                this.listQuery.pageSize = pageSize;
                sessionStorage.setItem("refresh_pornHub_video", false);
                this.getPageList();
            },
            handleClick() {
                // alert('11111111')
            },
            getType(type) {
                event.stopPropagation();
                const arr = [];
                const arr1 = [];
                arr.push("allTypes");
                arr.push(type.id);
                arr1.push(arr);
                this.listQuery.types = arr1;
                this.listQuery.actorName = null;
                console.log(this.listQuery);
                sessionStorage.setItem("refresh_pornHub_video", false);
                this.getPageList();
            },
            getActor(actor) {
                event.stopPropagation();
                this.listQuery.actorName = actor;
                this.listQuery.types = null;
                sessionStorage.setItem("refresh_pornHub_video", false);
                this.getPageList();
            },
            imgview() {
                alert("2222");
            },
            jump(videoid) {
                sessionStorage.setItem(
                    "listQuery_pornHub_video",
                    JSON.stringify(this.listQuery)
                );
                sessionStorage.setItem("refresh_pornHub_video", true);
                sessionStorage.setItem("refresh_video_detail", true);
                this.$router.push({
                    path: "/video/video_detail",
                    //name: "videoDetail", // 要跳转的路径的 name,可在 router 文件夹下的 index.js 文件内找
                    query: {id: videoid}
                });
            },
            showimg() {
                const arr = [];
                arr.push("http://127.0.0.1:8081/website/resources/_MG_0177.jpg");
                arr.push("http://127.0.0.1:8081/website/resources/_MG_0170.jpg");
                this.srcList = arr;
            },
            querySearch(queryString, cb) {
                var actors = this.actors;
                var results = queryString ? actors.filter(this.createFilter(queryString)) : actors;
                // 调用 callback 返回建议列表的数据
                cb(results);
            },
            createFilter(queryString) {
                return (restaurant) => {
                    return (restaurant.value.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
                };
            },
            addList(id){
                event.stopPropagation();
                this.videoAndIdList.idList.unshift(id);
                this.$message({
                    message: '成功添加到播放列表！！',
                    type: 'success'
                });
            }
        }
    };
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
    display:inline-block;
  }

  .rate {
    display:inline-block;
  }

  .image {
    width: 100%;
    display: block;
  }

  .clearfix:before,
  .clearfix:after {
    display: table;
    content: "";
  }

  .clearfix:after {
    clear: both;
  }

  .spantest {
    overflow: hidden;
    -webkit-line-clamp: 2;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-box-orient: vertical;
  }
</style>
