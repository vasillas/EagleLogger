<template>
  <v-list style="max-height: 250px; overflow-y: auto">
    <template v-for="net in nets">
      <v-subheader v-if="net.header" v-html="net.header"></v-subheader>
      <v-divider v-else-if="net.divider" :inset="net.inset"></v-divider>
      <v-list-tile v-else :key="net.id" @click="gotoNet(net.id)" class="list-item">
        <v-list-tile-content>
          <v-list-tile-title>
            <v-icon class="blue--text icon" style="margin-right: 15px">mdi-play</v-icon>
            <span>{{ net.title }}</span>
          </v-list-tile-title>
          <v-list-tile-sub-title v-text="net.subtitle"></v-list-tile-sub-title>
        </v-list-tile-content>
      </v-list-tile>
    </template>
  </v-list>
</template>

<style>
  .list-item .icon {
    opacity: 0;
  }
  .list-item:hover .icon {
    opacity: 1;
  }
</style>

<script>
  export default {
    data () {
      return {
        nets: []
      }
    },
    props: {
      all: {
        default: false,
        type: Boolean
      }
    },
    created () {
      this.$root.$on('NetsUpdated', (data) => {
        this.list()
      })
    },
    mounted () {
      this.list()
    },
    methods: {
      list () {
        let req = {}
        if (this.all) req.all = true

        this.$root.req('Nets:list', req).then(response => {
          this.nets = response
        })
      },
      gotoNet (netId) {
        this.$router.push(`/nets/${netId}`)
      }
    }
  }
</script>
