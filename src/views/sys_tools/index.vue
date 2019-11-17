<template>
  <div v-if="tableData" class="main">
    <el-container>
      <el-header></el-header>
    </el-container>
    <el-row type="flex">
      <el-col :span="18" :offset="5">
        <el-form :inline="true">
          <el-form-item label="来源文件夹">
            <el-input
              v-model="listQuery.source"
              clearable
              placeholder="请输入路径"
              @change="selectfile"
            />
          </el-form-item>
          <el-form-item label="目标文件夹">
            <el-input v-model="listQuery.target" clearable placeholder="请输入路径" />
          </el-form-item>
          <el-form-item>
            <el-form-item label="类别">
              <el-select v-model="listQuery.type" placeholder="请选择" clearable>
                <el-option label="日本" value="japanvideo" />
                <el-option label="欧美" value="english" />
                <el-option label="漫画" value="comic" />
              </el-select>
            </el-form-item>
            <el-button type="primary" @click="updatefile">更新</el-button>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>

    <el-row style="width: 60%; left: 20%;">
      <el-form>
        <el-form-item span="8" v-for="updateFileNames in listQuery.filemap" :key="updateFileNames.filename">
          <el-form-item v-bind:label="updateFileNames.filename">
            <el-input
              v-model="updateFileNames.suggestname"
              v-bind:placeholder="updateFileNames.suggestname"
            ></el-input>
          </el-form-item>
        </el-form-item>
      </el-form>
    </el-row>
  </div>
</template>
<script>
import { updatefile, selectfile } from "@/api/sysTools";
// 引入video样式
import "video.js/dist/video-js.css";
import "vue-video-player/src/custom-theme.css";
export default {
  data() {
    return {
      tableData: [],
      querylist: {
        id: null
      },
      listQuery: {
        target: null,
        source: null,
        type: null,
        filemap: null
      },
      updatefilemap: null,
      typeMap: "",
      actors: "",
      deviceDetail: null,
      imgSrc: "http://127.0.0.1:8081/website/resources/_MG_0138.jpg",
      url: "http://127.0.0.1:8081/website/resources/_MG_0138.jpg",
      srcList: []
    };
  },
  created() {
    // this.getDetil();
  },
  methods: {
    selectfile() {
      selectfile(this.listQuery).then(res => {
        console.log(res);
        this.listQuery.filemap = res;
      });
    },
    updatefile() {
      updatefile(this.listQuery).then(res => {
        console.log(res);
        this.listQuery = res;
      });
    }
  }
};
</script>
