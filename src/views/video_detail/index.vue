<template>
  <div v-if="tableData" class="main">
    <el-container>
      <el-header></el-header>
    </el-container>
    <el-row type="flex">
      <el-col :span="6" :offset="6">
        <el-card>
          <el-image :key="tableData.id" :src="tableData.coverUrl" :lazy="true" fit="fill"></el-image>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-row style="bottom: 0px; top: 0px; right: 0px; left: 20px;">
          <el-col :span="24">
            <p style="font-size: 25px; ">{{tableData.name}}</p>
          </el-col>
          <el-col :span="24">
            <div class="block">
              <span class="demonstration">评分</span>
              <el-rate v-model="level.level" :colors="colors" @change="changelevel"></el-rate>
            </div>
          </el-col>
          <el-col :span="24">
            <p style="font-size: 17px; ">作者</p>
            <el-col
              v-for="actor in tableData.actors"
              :span="4"
              :key="actor.id"
              class="row-li"
              @click="getActor(actor.id)"
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
              @click="getType(type)"
            >
              <el-tag>{{type.chineseName}}</el-tag>
            </el-col>
          </el-col>
        </el-row>
      </el-col>
    </el-row>

    <el-row style="width: 60%; left: 20%;" v-for="video in this.srcList" :key="video.poster">
      <div class="player-container">
        <video-player class="vjs-custom-skin" :options="video" @keyup.left="down" @keyup.right="up"></video-player>
      </div>
    </el-row>
    <el-row style="width: 60%; left: 20%;"></el-row>
  </div>
</template>
<script>
import { getDetil, changelevel } from '@/api/videoDetail'
// 引入video样式
import 'video.js/dist/video-js.css'
import 'vue-video-player/src/custom-theme.css'
export default {
  data() {
    return {
      tableData: [],
      querylist: {
        id: null
      },
      video: undefined,
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
      srcList: [],
      level: {
        id: null,
        level: null
      }
    }
  },
  created() {
    this.getDetil()
  },
  mounted() {
    this.video = this.$refs.video
  },
  updated() {
    this.video = this.$refs.video
  },
  methods: {
    getDetil() {
      this.querylist.id = this.$route.params.id
      console.log(this.querylist)

      getDetil(this.querylist).then(res => {
        console.log(res)
        this.tableData = res
        this.level.level = res.level
        for (const i of this.tableData.address) {
          const videoinfo = {
            playbackRates: [0.7, 1.0, 1.5, 2.0], // 播放速度
            autoplay: false, // 如果true,浏览器准备好时开始回放。
            controls: true, // 控制条
            preload: 'auto', // 视频预加载
            muted: false, // 默认情况下将会消除任何音频。
            loop: false, // 导致视频一结束就重新开始。
            language: 'zh-CN',
            aspectRatio: '16:9', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
            fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
            sources: [
              {
                src: i
              }
            ],
            poster: this.tableData.coverUrl,
            width: document.documentElement.clientWidth,
            notSupportedMessage: '此视频暂无法播放，请稍后再试' // 允许覆盖Video.js无法播放媒体源时显示的默认信息。
          }
          this.srcList.push(videoinfo)
        }
        console.log(this.srcList)
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
      this.jump()
    },
    getActor(actor) {
      event.stopPropagation()
      this.listQuery.actorName = actor
      this.listQuery.types = null
      this.jump()
    },
    imgview() {
      alert('2222')
    },
    jump() {
      this.$router.push({
        path: '/video/index',
        name: '影片', // 要跳转的路径的 name,可在 router 文件夹下的 index.js 文件内找
        params: { listQuery: this.listQuery }
      })
    },
    showimg() {
      const arr = []
      arr.push('http://127.0.0.1:8081/website/resources/_MG_0170.jpg')
      arr.push('http://127.0.0.1:8081/website/resources/_MG_0177.jpg')
      this.srcList = arr
    },
    up() {
      var time = this.video.currentTime
      console.log(time)
      this.video.currentTime = time + 120
    },
    down() {
      var time = this.video.currentTime
      console.log(time)
      this.video.currentTime = time - 120
    },
    changelevel() {
      this.level.id = this.tableData.id
      changelevel(this.level)
    }
  }
}
</script>
