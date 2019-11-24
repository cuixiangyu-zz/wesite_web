<template>
  <div class="main">
    <el-tabs v-model="editableTabsValue" type="card" closable @tab-remove="removeTab">
      <el-tab-pane
        v-for="(item,index) in tableData"
        :key="index"
        :label="item.res.name"
        :name="item.res.name"
      >
        <el-container>
          <el-header></el-header>
        </el-container>
        <el-row type="flex">
          <el-col :span="6" :offset="6">
            <el-card>
              <el-image :src="item.res.coverUrl" fit="fill"></el-image>
            </el-card>
          </el-col>
          <el-col :span="6">
            <el-row style="bottom: 0px; top: 0px; right: 0px; left: 20px;">
              <el-col :span="24">
                <p style="font-size: 25px; ">{{item.res.name}}</p>
              </el-col>
              <el-col :span="24">
                <p style="font-size: 17px; width: 20%;">作者</p>
                <el-col
                  v-for="actor in item.res.actors"
                  :span="4"
                  :key="actor.id"
                  class="row-li"
                  @click.native="handleClick"
                >
                  <el-tag>{{item.res.chineseName}}</el-tag>
                </el-col>
              </el-col>
              <el-col :span="24">
                <p style="font-size: 17px; width: 20%;">分类</p>
                <el-col
                  v-for="type in item.res.types"
                  :span="4"
                  :key="type.id"
                  class="row-li"
                  @click.native="handleClick"
                >
                  <el-tag>{{type.res.chineseName}}</el-tag>
                </el-col>
              </el-col>
            </el-row>
          </el-col>
        </el-row>

        <el-row style="width: 80%; left: 125px;">
          <el-col
            :span="4"
            :offset="2"
            v-for="address in item.res.address"
            :key="address"
            class="row-li"
            @click.native="handleClick"
          >
            <el-image :src="address" :preview-src-list="item.res.address" fit="fill"></el-image>
          </el-col>
        </el-row>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>
<script>
import { getDetil } from "@/api/pictureDetail";
export default {
  data() {
    return {
      tableData: [],
      querylist: [],
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
      ]
    };
  },
  created() {
    this.getDetil();
  },
  beforeRouteLeave(to, form, next) {
    sessionStorage.setItem(
      "listQuery_comic_picture_detail",
      JSON.stringify(this.querylist)
    );
    sessionStorage.setItem("refresh_comic_picture_detail", true);
    console.log("1111111111111111");
    next();
  },
  methods: {
    getDetil() {
      var listQuery = sessionStorage.getItem("listQuery_comic_picture_detail");
      var refresh = sessionStorage.getItem("refresh_comic_picture_detail");
      if (listQuery !== null && refresh !== null && refresh === "true") {
        this.querylist = JSON.parse(listQuery);
      }
      if (this.$route.params.id !== null&&this.$route.params.id !== undefined&&this.$route.params.id !== '') {
        this.querylist.push(this.$route.params.id);
      }
      console.log(this.$route.params.id);
      for (var i = 0; i < this.querylist.length; i++) {
        getDetil({ id: this.querylist[i] }).then(res => {
          this.tableData.push({ res });
          if (this.$route.params.id !== null&&this.$route.params.id !== undefined&&this.$route.params.id !== ''&&this.$route.params.id === res.id) {
            this.editableTabsValue = res.name;
          }
        });
      }
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
    removeTab(targetName) {
      let tabs = this.tableData;
      let activeName = this.editableTabsValue;
      if (activeName === targetName) {
        tabs.forEach((tab, index) => {
          if (tab.res.name === targetName) {
            let nextTab = tabs[index + 1] || tabs[index - 1];
            if (nextTab) {
              activeName = nextTab.res.name;
            }
          }
        });
      }
      console.log("3333333333333");
      this.editableTabsValue = activeName;
      this.tableData = tabs.filter(tab => tab.res.name !== targetName);
      this.querylist.length = 0;
      for (var i = 0; i < this.tableData.length; i++) {
        this.querylist.push(this.tableData[i].res.id);
      }
      console.log(this.querylist);
      console.log(this.tableData);
    }
  }
};
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
  content: "";
}

.clearfix:after {
  clear: both;
}
</style>
