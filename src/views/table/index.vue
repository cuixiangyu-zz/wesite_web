<template>
  <div v-if="tableData">
    <div class="filter-container">
      <div class="filter-item">
        卡号：
        <el-input v-model="listQuery.cardNo" style="width: 200px" placeholder="请输入卡号" />
      </div>
      <div class="filter-item">
        病人姓名:
        <el-input v-model="listQuery.patiendName" style="width: 200px" placeholder="请输入病人姓名" />
      </div>
      <div class="filter-item">
        终端编号：
        <el-input v-model="listQuery.terminalNo" style="width: 200px" placeholder="请输入终端编号" />
      </div>
      <div class="filter-item">
        订单号：
        <el-input v-model="listQuery.tradeNo" style="width: 200px" placeholder="请输入订单号" />
      </div>
      <div class="filter-item">
        订单状态：
        <el-select v-model="listQuery.tradeStatus" style="width: 150px" placeholder="请选择">
          <el-option label="全部" value />
          <el-option label="正常" value="0" />
          <el-option label="取消订单" value="1" />
        </el-select>
      </div>
      <div class="filter-item">
        支付状态：
        <el-select v-model="listQuery.payStatus" style="width: 150px" placeholder="请选择">
          <el-option label="待支付" value="0" />
          <el-option label="支付成功" value="1" />
          <el-option label="支付失败" value="2" />
        </el-select>
      </div>
      <div class="filter-item">
        HIS状态：
        <el-select v-model="listQuery.hisStatius" style="width: 150px" placeholder="请选择">
          <el-option label="通知成功" value="0" />
          <el-option label="通知失败" value="1" />
        </el-select>
      </div>
      <div class="filter-item">
        退费状态：
        <el-select v-model="listQuery.refundStatus" style="width: 150px" placeholder="请选择">
          <el-option label="未退费" value="0" />
          <el-option label="退费成功" value="1" />
          <el-option label="退费失败" value="2" />
        </el-select>
      </div>
      <div class="filter-item">
        注册时间：
        <el-date-picker
          v-model="listQuery.regitsterTime"
          type="daterange"
          range-separator="——"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        />
      </div>
      <el-button class="filter-item" type="primary" @click="resetQueryList">重置查询</el-button>
      <el-button class="filter-item" type="primary" @click="getPrepayList">开始查询</el-button>
      <el-button class="filter-item" type="primary" @click="exportList">导出数据</el-button>
    </div>
    <el-table :data="tableData.list" height="600" border style="width: 100%">
      <el-table-column prop="payId" label="ID" fixed="left" width="150" />
      <el-table-column prop="patiendId" label="病人ID" width="100" />
      <el-table-column prop="cardNo" label="卡号" width="150" />
      <el-table-column prop="patiendName" label="病人姓名" />
      <el-table-column prop="terminalNo" label="终端编号" />
      <el-table-column prop="tradeNo" label="订单号" width="250" />
      <el-table-column prop="totalFree" label="充值金额" />
      <el-table-column prop="tradeStatus" label="订单状态" />
      <el-table-column prop="payStatus" label="支付状态" />
      <el-table-column prop="hisStatius" label="通知HIS状态" width="150" />
      <el-table-column prop="refundStatus" label="退费状态" />
      <el-table-column prop="detail" label="商品信息" />
      <el-table-column prop="posid" label="商户柜台代码POS" width="150" />
      <el-table-column prop="payType" label="支付类型" />
      <el-table-column prop="payTime" label="收到通知时间" width="150" />
      <el-table-column prop="createdTime" label="订单创建时间" width="160" />
    </el-table>
    <el-pagination
      :page-sizes="[5, 10, 15, 400]"
      :page-size="10"
      layout="total, sizes, prev, pager, next, jumper"
      :total="tableData.totals"
      @current-change="handleCurrentChange"
    />
  </div>
</template>
<script>
import { getList } from '@/api/table'
export default {
  data() {
    return {
      tableData: null,
      listQuery: {
        pageNo: 1,
        pageSize: 10,
        cardNo: undefined,
        patiendName: undefined,
        terminalNo: undefined,
        tradeNo: undefined,
        tradeStatus: '',
        payStatus: undefined,
        hisStatius: undefined,
        refundStatus: undefined,
        regitsterTime: undefined
      }
    }
  },
  computed: {},
  created() {
    this.getPrepayList()
  },
  methods: {
    getPrepayList() {
      getList(this.listQuery).then(res => {
        this.tableData = res
      })
    },
    handleCurrentChange(index) {
      this.listQuery.pageNo = index
      this.getPrepayList()
    },
    resetQueryList() {
      this.listQuery = {
        pageNo: 1,
        pageSize: 10,
        cardNo: undefined,
        patiendName: undefined,
        terminalNo: undefined,
        tradeNo: undefined,
        tradeStatus: '',
        payStatus: undefined,
        hisStatius: undefined,
        refundStatus: undefined,
        regitsterTime: undefined
      }
      this.getPrepayList()
    },
    exportList() {
    }
  }
}
</script>
<style lang="scss" scoped>
.filter-container {
  padding: 10px;
  .filter-item {
    display: inline-block;
    vertical-align: middle;
    margin: 10px;
  }
}
</style>
