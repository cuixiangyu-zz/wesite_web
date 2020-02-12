<template>
  <div class="main">
    <el-container>
      <el-header></el-header>
    </el-container>
    <el-row type="flex">
      <el-col :span="6" :offset="6">
        <el-card>
          <el-image :src="tableData.coverUrl" fit="fill"></el-image>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-row style="bottom: 0px; top: 0px; right: 0px; left: 20px;">
          <el-col :span="24">
            <p style="font-size: 25px; ">{{tableData.name}}</p>
            <el-button @click="getWatchList()" type="primary" >播放列表</el-button>
          </el-col>
          <el-col :span="24">
            <div class="block">
              <span class="demonstration">评分</span>
              <el-rate v-model="level.level" :colors="colors" @change="changelevel(tableData)"></el-rate>
            </div>
            <div class="block">
              <span class="demonstration">收藏</span>
              <el-tooltip class="item" effect="dark" content="添加收藏" placement="right">
                <el-button v-if="tableData.userFavorite==null" size="small" type="primary" icon="el-icon-star-off"
                           @click="addFavorite(tableData)"></el-button>
              </el-tooltip>
              <el-tooltip class="item" effect="dark" content="取消收藏" placement="right">
                <el-button v-if="tableData.userFavorite!==null" size="small" type="primary" icon="el-icon-star-on"
                           @click="deleteFavorite(tableData)"></el-button>
              </el-tooltip>
            </div>
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
              <el-tag>{{tableData.chineseName}}</el-tag>
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
              <el-tag>{{tableData.chineseName}}</el-tag>
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

    <el-drawer
      title="播放列表!"
      :visible.sync="tableVisible"
      direction="rtl"
      size="50%">
      <el-table :data="pictureAndIdList.videoList" height="800" :row-class-name="tableRowClassName">
        <el-table-column property="name" label="影片名" width="250"></el-table-column>
        <el-table-column prop="type" label="类型"/>
        <el-table-column prop="actors" label="作者">
          　　
          <template scope="scope">
            　　　　
            <div v-for="item in scope.row.actors">{{item.chineseName}}</div>
            　　
          </template>
        </el-table-column>
        <el-table-column label="封面" >
          　　
          <template slot-scope="scope">
            　　　　<img :src="scope.row.coverUrl" width="90%" height="90%" alt="封面"/>
            　　
          </template>
        </el-table-column>
        <el-table-column
          fixed="right"
          label="操作"
          width="100">
          <template slot-scope="scope">
            <el-button size="mini" @click="selectPicture(scope.$index, scope.row)">查看影片</el-button>
            <el-button size="mini" type="primary" @click="deletePicture(scope.$index, scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-drawer>

  </div>
</template>
<script>
    import {getDetil} from "@/api/pictureDetail";
    import {changelevel, saveViewHistory, getWatchList} from "@/api/videoDetail";
    import {addHistory} from "@/api/viewHistory";
    import {addFavorite, deleteFavorite} from "@/api/userFavorite";

    export default {
        data() {
            return {
                tableData: [],
                queryId: null,
                editableTabsValue: "",
                listQuery: {
                    pageNum: 1,
                    pageSize: 10,
                    actorName: null,
                    pictureName: null,
                    language: null,
                    types: null
                },
                typeMap: "",
                actors: "",
                deviceDetail: null,
                imgSrc: "http://127.0.0.1:8081/website/resources/_MG_0138.jpg",
                url: "http://127.0.0.1:8081/website/resources/_MG_0138.jpg",
                srcList: [
                    // 'http://127.0.0.1:8081/website/resources/_MG_0170.jpg',
                    // 'http://127.0.0.1:8081/website/resources/_MG_0177.jpg'
                ],
                level: {
                    id: null,
                    type: 5,
                    level: null
                },
                colors: ['#99A9BF', '#F7BA2A', '#FF9900'],
                viewHistory: {
                    type: 5,
                    videoId: null,
                    startData: '',
                    watchTime: ''
                },
                addFavoriteParms: {
                    type: 5,
                    videoId: null
                },
                pictureAndIdList: {
                    idList: [],
                    videoList: []
                },
                tableVisible: false
            };
        },
        created() {
            this.viewHistory.startData = Date.now();
            var list = sessionStorage.getItem("pictureAndIdList");
            if (list !== null &&
                list !== undefined &&
                list !== "") {
                this.pictureAndIdList = JSON.parse(list);
            }
            this.getDetil();
        },
        beforeRouteLeave(to, form, next) {
            sessionStorage.setItem(
                "listQuery_comic_picture_detail",
                JSON.stringify(this.queryId)
            );
            sessionStorage.setItem("refresh_comic_picture_detail", true);
            sessionStorage.setItem("pictureAndIdList", JSON.stringify(this.pictureAndIdList));
            const currentTime = Date.now();

            this.viewHistory.watchTime = currentTime - this.viewHistory.startData;
            this.viewHistory.startData = new Date(this.viewHistory.startData);
            this.saveViewHistory();
            next();
        },
        methods: {
            getDetil() {
                var listQuery = sessionStorage.getItem("listQuery_comic_picture_detail");
                var refresh = sessionStorage.getItem("refresh_comic_picture_detail");
                if (listQuery !== null && refresh !== null && refresh === "true") {
                    this.queryId = JSON.parse(listQuery);
                }
                if (this.$route.params.id !== null && this.$route.params.id !== undefined && this.$route.params.id !== '') {
                    this.queryId = this.$route.params.id;
                }
                this.viewHistory.videoId = this.queryId;
                this.pictureAndIdList.idList.unshift(this.queryId);
                getDetil({id: this.queryId}).then(res => {
                    this.tableData = res;
                });

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
                sessionStorage.setItem(
                    "listQuery_comic_picture",
                    JSON.stringify(this.listQuery)
                );
                sessionStorage.setItem("refresh_comic_picture", true);
                this.getPageList();
            },
            getActor(actor) {
                event.stopPropagation();
                this.listQuery.actorName = actor;
                this.listQuery.types = null;
                sessionStorage.setItem(
                    "listQuery_comic_picture",
                    JSON.stringify(this.listQuery)
                );
                sessionStorage.setItem("refresh_comic_picture", true);
                this.getPageList();
            },
            imgview() {
                alert("2222");
            },
            jump() {
                alert("111");
            },
            showimg() {
                const arr = [];
                arr.push("http://127.0.0.1:8081/website/resources/_MG_0170.jpg");
                arr.push("http://127.0.0.1:8081/website/resources/_MG_0177.jpg");
                this.srcList = arr;
            },
            saveViewHistory() {
                addHistory(this.viewHistory).then(res => {

                })
            },
            changelevel(item) {
                this.level.id = item.id;
                changelevel(this.level);
            },
            addFavorite(data) {
                this.addFavoriteParms.videoId = data.id;
                addFavorite(this.addFavoriteParms).then(res => {
                    this.tableData.userFavorite = res;
                }).catch(res => {
                    this.getDetil();
                })
            },
            deleteFavorite(data) {
                deleteFavorite({id: this.tableData.userFavorite.id}).then(res => {
                    this.tableData.userFavorite = null;
                }).catch(res => {
                    this.getDetil();
                })
            },
            getWatchList() {
                getWatchList({idList: JSON.stringify(this.pictureAndIdList.idList)}).then(res => {
                    res.forEach(item => {
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
                    })
                    this.pictureAndIdList.videoList = res;
                    this.tableVisible = true;
                    console.log(this.pictureAndIdList);
                })
            },
            deletePicture(index, row) {
                for (var i = 0; i < this.pictureAndIdList.idList.length; i++) {
                    if (row.id === this.pictureAndIdList.idList[i]) {
                        this.pictureAndIdList.idList.splice(i, 1); // 将使后面的元素依次前移，数组长度减1
                        i--; // 如果不减，将漏掉一个元素
                    }
                }
                this.getWatchList();
            },
            selectPicture(index, row) {
                const currentTime = Date.now();

                this.viewHistory.watchTime = currentTime - this.viewHistory.startData;
                this.viewHistory.startData = new Date(this.viewHistory.startData);
                this.saveViewHistory();
                this.viewHistory.startData = Date.now();
                this.tableVisible = false;
                this.queryId = row.id;
                getDetil({id: this.queryId}).then(res => {
                    this.tableData = res;
                });
            },
            tableRowClassName({row, rowIndex}) {
                if (row.id === this.queryId) {
                    return 'success-row';
                }
                return '';
            }
        }
    };
</script>
<style>
  .el-row {
    margin-bottom: 20px;

  &
  :last-child {
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
    content: "";
  }

  .clearfix:after {
    clear: both;
  }
</style>
