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
            <el-input v-model="listQuery.target" clearable placeholder="请输入路径"/>
          </el-form-item>
          <el-form-item>
            <el-form-item label="类别">
              <el-select v-model="listQuery.type" placeholder="请选择" clearable>
                <el-option label="日本" value="japanvideo"/>
                <el-option label="欧美" value="english"/>
                <el-option label="美国" value="american"/>
                <el-option label="漫画" value="comic"/>
                <el-option label="动漫" value="animate"/>
                <el-option label="pornHub" value="pornHub"/>
                <el-option label="movie" value="movie"/>
                <el-option label="韩国" value="korean"/>
              </el-select>
            </el-form-item>
            <el-button type="primary" @click="updatefile">更新</el-button>
            <el-button type="primary" @click="reName">重命名</el-button>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>


    <el-row type="flex">
      <el-col :span="18" :offset="5">
        <el-form :inline="true">
          <el-form-item label="来源文件夹">
            <el-input
              v-model="moveFile.source"
              clearable
              placeholder="请输入路径"
              @change="selectfile"
            />
          </el-form-item>
          <el-form-item label="目标文件夹">
            <el-input v-model="moveFile.target" clearable placeholder="请输入路径"/>
            <el-button type="primary" @click="moveFileFunc">更新</el-button>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>


    <el-row style="width: 60%; left: 20%;">
      <el-form>
        <el-form-item
          span="8"
          v-for="updateFileNames in listQuery.filemap"
          :key="updateFileNames.filename"
        >
          <el-form-item v-bind:label="updateFileNames.filename">
            <el-input
              v-model="updateFileNames.suggestname"
              v-bind:placeholder="updateFileNames.suggestname"
            ></el-input>
          </el-form-item>
        </el-form-item>
      </el-form>
    </el-row>

    <el-row type="flex">
      <el-col :span="18" :offset="5">
        <el-form :inline="true">
          <el-form-item label="来源网站">
            <el-input
              v-model="updatetype.url"
              clearable
              placeholder="请输入路径"
            />
          </el-form-item>
          <el-form-item>
            <el-form-item label="类别">
              <el-select v-model="updatetype.type" placeholder="请选择" clearable>
                <el-option label="日本" value="1"/>
                <el-option label="欧美" value="2"/>
                <el-option label="漫画" value="3"/>
              </el-select>
            </el-form-item>
            <el-button type="primary" @click="updateType">更新</el-button>
            <el-button type="primary" @click="pornhub">pornhub</el-button>
            <el-button type="primary" @click="checkVideo">检查</el-button>
            <el-button type="primary" @click="refreshCover">刷新封面</el-button>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>

  </div>
</template>
<script>
    import {
        updatefile,reName, selectFileForJapan, selectFileForComic, selectFileForAmerican,moveFileFunc
        , updatePicsFromLocal, updateType, savePornVideo,checkVideo,selectFileForAnimate
      ,selectFileForPornHub, refreshCover
    } from "@/api/sysTools";
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
              moveFile: {
                target: null,
                source: null
              },
                updatetype: {
                    url: '',
                    type: ''
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
                if (this.listQuery.type === "japanvideo") {
                    selectFileForJapan(this.listQuery).then(res => {
                        console.log(res);
                        this.listQuery.filemap = res;
                    });
                } else if (this.listQuery.type === "english") {
                    selectFileForAmerican(this.listQuery).then(res => {
                        console.log(res);
                        this.listQuery.filemap = res;
                    });
                } else if (this.listQuery.type === "comic") {
                    selectFileForComic(this.listQuery).then(res => {
                        console.log(res);
                        this.listQuery.filemap = res;
                    });
                } else if (this.listQuery.type === "animate") {
                  selectFileForAnimate(this.listQuery).then(res => {
                    console.log(res);
                    this.listQuery.filemap = res;
                  });
                } else if (this.listQuery.type === "pornHub") {
                  selectFileForPornHub(this.listQuery).then(res => {
                    console.log(res);
                    this.listQuery.filemap = res;
                  });
                } else if (this.listQuery.type === "movie") {
                  selectFileForAnimate(this.listQuery).then(res => {
                    console.log(res);
                    this.listQuery.filemap = res;
                  });
                } else if (this.listQuery.type === "korean") {
                  selectFileForAnimate(this.listQuery).then(res => {
                    console.log(res);
                    this.listQuery.filemap = res;
                  });
                } else if (this.listQuery.type === "american") {
                  selectFileForAnimate(this.listQuery).then(res => {
                    console.log(res);
                    this.listQuery.filemap = res;
                  });
                }
            },
            checkVideo(){
                checkVideo().then(res=>{
                    console.log(res);
                });
            },
          moveFileFunc(){
            moveFileFunc(this.moveFile).then(res=>{
              console.log(res);
            });
          },
            refreshCover(){
              refreshCover().then(res=>{
                console.log(res);
              });
            },
            updatefile() {

                if (this.listQuery.type === "japanvideo") {
                    updatefile(this.listQuery).then(res => {
                        console.log(res);
                        this.listQuery.filemap = res;
                    });
                } else if (this.listQuery.type === "english") {
                    updatefile(this.listQuery).then(res => {
                        console.log(res);
                        this.listQuery.filemap = res;
                    });
                } else if (this.listQuery.type === "comic") {
                    updatePicsFromLocal(this.listQuery).then(res => {
                        console.log(res);
                        this.listQuery.filemap = res;
                    });
                } else if (this.listQuery.type === "animate") {
                  updatefile(this.listQuery).then(res => {
                    console.log(res);
                    this.listQuery.filemap = res;
                  });
                } else if (this.listQuery.type === "pornHub") {
                  updatefile(this.listQuery).then(res => {
                    console.log(res);
                    this.listQuery.filemap = res;
                  });
                } else if (this.listQuery.type === "movie") {
                  updatefile(this.listQuery).then(res => {
                    console.log(res);
                    this.listQuery.filemap = res;
                  });
                } else if (this.listQuery.type === "korean") {
                  updatefile(this.listQuery).then(res => {
                    console.log(res);
                    this.listQuery.filemap = res;
                  });
                } else if (this.listQuery.type === "american") {
                  updatefile(this.listQuery).then(res => {
                    console.log(res);
                    this.listQuery.filemap = res;
                  });
                }
            },
          reName() {
            reName(this.listQuery).then(res => {
              console.log(res);
              this.listQuery.filemap = res;
            });
          },
            updateType() {
                updateType(this.updatetype)
            },
            pornhub() {
                savePornVideo().then(res => {
                    console.log(res);
                });
            }
        }
    };
</script>
