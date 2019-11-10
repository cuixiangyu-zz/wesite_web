<template>
  <div v-if="tableData" class="main">
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
      <div class="player-container">
        <video-player class="vjs-custom-skin" :options="playerOptions"></video-player>
      </div>
    </el-row>
  </div>
</template>
<script>
import { getDetil } from '@/api/pictureDetail'
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
      ],
      playerOptions: {
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
            type: 'application/x-mpegURL',
            src: 'http://127.0.0.1:8081/website/resources/japan/myab-006.mp4'
          }
        ],
        poster:
          'http://static.smartisanos.cn/pr/img/video/video_03_cc87ce5bdb.jpg', // 你的封面地址
        width: document.documentElement.clientWidth,
        notSupportedMessage: '此视频暂无法播放，请稍后再试' // 允许覆盖Video.js无法播放媒体源时显示的默认信息。
      }
    }
  },
  created() {
    // this.getDetil()
  },
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
