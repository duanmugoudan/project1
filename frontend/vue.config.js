const { defineConfig } = require('@vue/cli-service')
module.exports =
  defineConfig(
    {
      transpileDependencies: true,
      devServer: {
        port: 7000
      },

      configureWebpack: {
        resolve: {
          fallback: {
            "net": false,
            "fs": false,
            "tls": false,
            "path": false
          }
        }
      },


      chainWebpack: config => {
        config.plugin('html')
          .tap(args => {
            args[0].title = "新闻系统";
            return args;
          })
      }
    })
