<template>
  <v-dialog v-model="opened" max-width="450px">
    <v-card>
      <v-card-title class="title flex-center">Reopen the Net</v-card-title>
      <v-card-text>
        <p class="body-1">
          Would you like to reopen this net?
        </p>
        <v-form @submit.prevent="update">
          <v-layout justify-space-between>
            <v-btn flat left @click="close">close</v-btn>
            <v-btn type="submit" color="primary">
              <v-icon left>mdi-door-open</v-icon>
              <span>Reopen the Net</span>
            </v-btn>
          </v-layout>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
  import Dialog from '@/components/Mixins/Dialog'

  export default {
    mixins: [Dialog],
    data () {
      return {
        net: {}
      }
    },
    methods: {
      afterOpen () {
        this.net = JSON.parse(JSON.stringify(this.$store.state.net))
      },
      update () {
        this.$root.req('Nets:reopen', this.net).then(response => {
          this.$store.dispatch('snackbar', {text: 'The net has been reopened.'})
          this.close()
        })
      }
    }
  }
</script>
