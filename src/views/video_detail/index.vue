<template>
  <div class="main">
    <el-container>
      <el-header></el-header>
    </el-container>
    <el-col :span="16" :offset="4">
    <div class="mc-window" style="height: 813px;">
      <el-container>
        <el-header style="height: 26px;" height="117px">
          <!--<span style="width: 66.07%; height: 54px;">行文本</span>-->

        </el-header>
        <p style="font-size: 25px; ">{{tableData.name}}</p>
        <el-container>
          <el-aside style="width: 80%; height: 559px;" width="300px">
            <template slot-scope="scope">
              <el-row  v-for="video in videos" :key="video.poster">
                <div class="player-container">
                  <video-player
                    class="vjs-custom-skin"
                    :options="video"
                    @keyup.left="down"
                    @keyup.right="up"
                  ></video-player>
                </div>
              </el-row>
            </template>
          </el-aside>
          <el-container>
            <el-main style="height: 559px;">
              <p style="font-size: 15px; ">推荐列表</p>
                <el-card
                         v-for="item in suggestVideos"
                         :span="4"
                         :key="item.id"
                         class="row-li"
                         @click.native="handleClick">
                  <el-image :src="item.coverUrl" @click="showimg" lazy></el-image>
                  <div style="padding: 14px;" @click="selectVideo(0,item)">
                    <span class="spantest">{{ item.name }}</span>
                  </div>
                </el-card>
            </el-main>
            <el-footer v-if="false">
            </el-footer>
          </el-container>
        </el-container>
      </el-container>
      <el-row style="width: 100.01%;">
        <el-col :md="12" :xs="24">
          <div class="block">
            <span class="demonstration">评分</span>
            <el-rate v-model="level.level" :colors="colors" @change="changelevel(tableData)"></el-rate>
          </div>
        </el-col>
        <el-col :md="12" :xs="24">
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
            <el-button @click="getWatchList()" type="primary" >播放列表</el-button>
          </div>
        </el-col>

      </el-row>
      <el-row style="width: 100.01%;">
        <el-col :md="12" :xs="24">
          <el-col :span="24">
            <p style="font-size: 17px; ">作者</p>
            <el-col>
              <el-tag
                v-for="actor in tableData.actors"
                :span="4"
                :key="actor.id"
                class="row-li"
                @click="getActor(actor.name)">{{actor.chineseName}}</el-tag>
            </el-col>
          </el-col>
        </el-col>
        <el-col :md="12" :xs="24">
          <el-col :span="24">
            <p style="font-size: 17px; width: 20%;">分类</p>
            <el-col>
              <el-tag
                v-for="type in tableData.types"
                :key="type.id"
                class="row-li"
                >{{type.chineseName}}</el-tag>
            </el-col>
          </el-col>
        </el-col>

      </el-row>
    </div>
    </el-col>
    <el-row type="flex">
    </el-row>
    <el-drawer
      title="播放列表!"
      :visible.sync="tableVisible"
      direction="rtl"
      size="50%">
      <el-table :data="videoAndIdList.videoList" height="800" :row-class-name="tableRowClassName">
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
            <el-button size="mini" @click="selectVideo(scope.$index, scope.row)">查看影片</el-button>
            <el-button size="mini" type="primary" @click="deleteVideo(scope.$index, scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-drawer>
    <el-container>
      <el-header></el-header>
    </el-container>

  </div>
</template>
<script>
    import {getDetil, changelevel, saveViewHistory, getWatchList,suggestVideo} from "@/api/videoDetail";
    import {addHistory} from "@/api/viewHistory";
    import {addFavorite, deleteFavorite} from "@/api/userFavorite";
    // 引入video样式
    import "video.js/dist/video-js.css";
    import "vue-video-player/src/custom-theme.css";

    export default {
        data() {
            return {
                tableData: [],
                querylist: [],
                querydata: null,
                tableVisible: false,
                editableTabsValue: "",
                video: undefined,
                videos: [],
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
                imgSrc: "http://192.168.1.14:5003/8t-2/cover/japanVideoCover/ABP-856.jpg",
                url: "http://192.168.1.14:5003//8t-1/resources/japanvideo/野々浦暖/ABP-856.mp4",
                level: {
                    id: null,
                    type: null,
                    level: null
                },
                colors: ['#99A9BF', '#F7BA2A', '#FF9900'],
                viewHistory: {
                    type: null,
                    videoId: null,
                    startData: '',
                    watchTime: ''
                },
                addFavoriteParms: {
                    type: null,
                    videoId: null
                },
                videoAndIdList: {
                    idList: [],
                    videoList: []
                },
                suggestVideos: []
            };
        },
        created() {
            this.viewHistory.startData = Date.now();
            var list = sessionStorage.getItem("videoAndIdList");
            if (list !== null &&
                list !== undefined &&
                list !== "") {
                this.videoAndIdList = JSON.parse(list);
            }
            this.getDetil();
        },
        mounted() {
            this.video = this.$refs.video;
        },
        updated() {
            this.video = this.$refs.video;
        },
        beforeRouteLeave(to, form, next) {
            sessionStorage.setItem(
                "listQuery_video_detail",
                JSON.stringify(this.querydata)
            );
            sessionStorage.setItem("refresh_video_detail", true);
            sessionStorage.setItem("videoAndIdList", JSON.stringify(this.videoAndIdList));
            const currentTime = Date.now();

            this.viewHistory.watchTime = currentTime - this.viewHistory.startData;
            this.viewHistory.startData = new Date(this.viewHistory.startData);
            this.saveViewHistory();
            next();
        },
        methods: {
            getDetil() {
                var listQuery = sessionStorage.getItem("listQuery_video_detail");
                var refresh = sessionStorage.getItem("refresh_video_detail");
                if (listQuery !== null && refresh !== null && refresh === "true") {
                    this.querydata = JSON.parse(listQuery);
                }
                if (
                    this.$route.query.id !== null &&
                    this.$route.query.id !== undefined &&
                    this.$route.query.id !== ""
                ) {
                    this.querydata = this.$route.query.id;
                }
                this.viewHistory.videoId = this.querydata;
                this.videoAndIdList.idList.unshift(this.querydata);
                getDetil({id: this.querydata}).then(res => {
                    this.viewHistory.type = res.type;
                    this.level.level = res.level;
                    //strurl = strurl .replace("\\", "\/");
                    res.coverUrl = res.coverUrl.replace(/\\/g,"/");
                    this.tableData = res;
                    const srcList = [];
                    for (const i of res.address) {
                        const videoInfo = {
                            playbackRates: [0.7, 1.0, 1.5, 2.0], // 播放速度
                            autoplay: false, // 如果true,浏览器准备好时开始回放。
                            controls: true, // 控制条
                            preload: "auto", // 视频预加载
                            muted: false, // 默认情况下将会消除任何音频。
                            loop: false, // 导致视频一结束就重新开始。
                            language: "zh-CN",
                            aspectRatio: "16:9", // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
                            fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
                            sources: [
                                {
                                    src: i
                                }
                            ],
                            poster: res.coverUrl,
                            width: document.documentElement.clientWidth,
                            notSupportedMessage: "此视频暂无法播放，请稍后再试" // 允许覆盖Video.js无法播放媒体源时显示的默认信息。
                        };
                        srcList.push(videoInfo);
                    }


                    this.videos = srcList
                });
                suggestVideo({id: this.querydata}).then(res => {
                    console.log(res);
                    this.suggestVideos = res;
                });
            },
            saveViewHistory() {
                addHistory(this.viewHistory).then(res => {

                })
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
                this.jump();
            },
            getActor(actor) {
                event.stopPropagation();
                if(this.tableData.type === 1){
                    var listQuery = sessionStorage.getItem("listQuery_japan_video");
                    this.listQuery = JSON.parse(listQuery);
                    sessionStorage.setItem("refresh_japan_video", true);
                    this.listQuery.actorName = actor;
                    this.listQuery.types = null;
                    sessionStorage.setItem(
                        "listQuery_japan_video",
                        JSON.stringify(this.listQuery)
                    );
                    this.$router.push({
                        path: "/video/video_japan",
                    });
                }else if(this.tableData.type === 2){
                    var listQuery = sessionStorage.getItem("listQuery_american_video");
                    this.listQuery = JSON.parse(listQuery);
                    sessionStorage.setItem("refresh_american_video", true);
                    this.listQuery.actorName = actor;
                    this.listQuery.types = null;
                    sessionStorage.setItem(
                        "listQuery_american_video",
                        JSON.stringify(this.listQuery)
                    );
                    this.$router.push({
                        path: "/video/video_american",
                    });
                }
            },
            jump() {
                if(this.tableData.type === 1){
                    this.$router.push({
                        path: "/video/video_japan",
                    });
                }else if(this.tableData.type === 2){
                    this.$router.push({
                        path: "/video/video_american",
                    });
                }

            },
            showimg() {
                const arr = [];
                arr.push("http://127.0.0.1:8081/website/resources/_MG_0170.jpg");
                arr.push("http://127.0.0.1:8081/website/resources/_MG_0177.jpg");
                this.srcList = arr;
            },
            up() {
                var time = this.video.currentTime;
                console.log(time);
                this.video.currentTime = time + 120;
            },
            down() {
                var time = this.video.currentTime;
                console.log(time);
                this.video.currentTime = time - 120;
            },
            changelevel(item) {
                this.level.id = item.id;
                this.level.type = item.type;
                changelevel(this.level);
            },
            addFavorite(data) {
                this.addFavoriteParms.videoId = data.id;
                this.addFavoriteParms.type = data.type;
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
                getWatchList({idList: JSON.stringify(this.videoAndIdList.idList)}).then(res => {
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
                    this.videoAndIdList.videoList = res;
                    this.tableVisible = true;
                    console.log(this.videoAndIdList);
                })
            },
            deleteVideo(index, row) {
                for (var i = 0; i < this.videoAndIdList.idList.length; i++) {
                    if (row.id === this.videoAndIdList.idList[i]) {
                        this.videoAndIdList.idList.splice(i, 1); // 将使后面的元素依次前移，数组长度减1
                        i--; // 如果不减，将漏掉一个元素
                    }
                }
                this.getWatchList();
            },
            selectVideo(index, row) {
                const currentTime = Date.now();

                this.viewHistory.watchTime = currentTime - this.viewHistory.startData;
                this.viewHistory.startData = new Date(this.viewHistory.startData);
                this.saveViewHistory();
                this.viewHistory.startData = Date.now();
                this.tableVisible = false;
                this.querydata = row.id;
                getDetil({id: this.querydata}).then(res => {
                    this.viewHistory.type = res.type;
                    this.level.level = res.level;
                    this.tableData = res;
                    const srcList = [];
                    for (const i of res.address) {
                        const videoInfo = {
                            playbackRates: [0.7, 1.0, 1.5, 2.0], // 播放速度
                            autoplay: false, // 如果true,浏览器准备好时开始回放。
                            controls: true, // 控制条
                            preload: "auto", // 视频预加载
                            muted: false, // 默认情况下将会消除任何音频。
                            loop: false, // 导致视频一结束就重新开始。
                            language: "zh-CN",
                            aspectRatio: "16:9", // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
                            fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
                            sources: [
                                {
                                    src: i
                                }
                            ],
                            poster: res.coverUrl,
                            width: document.documentElement.clientWidth,
                            notSupportedMessage: "此视频暂无法播放，请稍后再试" // 允许覆盖Video.js无法播放媒体源时显示的默认信息。
                        };
                        srcList.push(videoInfo);
                    }
                    this.videos = srcList
                });
                suggestVideo({id: this.querydata}).then(res => {
                    console.log(res);
                    this.suggestVideos = res;
                });
            },
            tableRowClassName({row, rowIndex}) {
                if (row.id === this.querydata) {
                    return 'success-row';
                }
                return '';
            }
        }
    };
</script>

<style>
  .el-table .warning-row {
    background: oldlace;
  }

  .el-table .success-row {
    background: #f0f9eb;
  }
</style>
