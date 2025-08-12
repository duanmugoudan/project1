<template>

</template>

<script>
export default {
  name: "Home",
  data() {
    return {
      user: JSON.parse(localStorage.getItem('honey-user') || '{}'),
      notices: [],
      activeName: '0'
    }
  },
  created() {
    this.loadNotice()
  },
  methods: {
    // loadNotice() {
    //   this.$request.get('/notice/selectUserData').then(res => {
    //     this.notices = res.data
    //   })
    // }
  }
}
</script>

<style scoped>

</style>