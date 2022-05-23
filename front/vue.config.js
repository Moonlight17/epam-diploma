const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true
})


// const static_dir = 'dist/'

// const template_path = 'index.html'
const static_dir = 'dist/static/'
const template_path = '../templates/index.html'



module.exports = {
  publicPath: process.env.NODE_ENV === 'production'
      ? './'
      : '/',

  outputDir: process.env.NODE_ENV === 'production' ? static_dir : 'dist/',
  // Куда пойдёт шаблон проекта
  indexPath: process.env.NODE_ENV === 'production' ? template_path : 'index.html',
  // Куда пойдут ассеты (относительно outputDir)
  assetsDir: '', // ассеты храним там же, где и JS/CSS
  // Путь по которому можно достать статику
  // Нужно указать тот, который прописан в STATIC_URL настроек django
  // publicPath: process.env.NODE_ENV === 'production' ? '' : '/',
  publicPath: process.env.NODE_ENV === 'production' ? 'static' : '/',

}