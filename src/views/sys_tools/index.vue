<template>
  <div v-if="tableData" class="main">
    <el-upload
      class="upload-demo"
      ref="upload"
      action="https://jsonplaceholder.typicode.com/posts/"
      :on-preview="handlePreview"
      :on-remove="handleRemove"
      :on-change="handleChange"
      :file-list="fileList"
      :auto-upload="false"
    >
      <el-button slot="trigger" size="small" type="primary">选取文件</el-button>
      <el-button style="margin-left: 10px;" size="small" type="success" @click="submitUpload">上传到服务器</el-button>
      <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
    </el-upload>
  </div>
</template>
<script>
import { getDetil } from '@/api/videoDetail'
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
      fileList: []
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
        console.log(res)
        this.tableData = res
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
      this.getPageList()
    },
    submitUpload() {
      // this.$refs.upload.submit()
      console.log(this.fileList)
    },
    handleRemove(file, fileList) {
      console.log(file, fileList)
    },
    handlePreview(file) {
      console.log(file)
    },
    handleChange(file, fileList) {
      this.fileList = fileList.slice(-3)
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
