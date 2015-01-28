var src_path = './sources/',
    build_path = './dev/',
    prod_path = './dist/';

module.exports = {
  src : {
    basedir: src_path,
    less : src_path+'/less/*.less',
    coffee : [src_path+'/coffee/inc/*.coffee', 'src/coffee/*.coffee', src_path+'/coffee/module/**/*.coffee']
  },
  build : {
    basedir: build_path,
    css : build_path+'css',
    js : build_path+'js',
    assets : build_path+'assets'
  },
  prod : {
    basedir: prod_path,
    css : prod_path+'css',
    js : prod_path+'js',
    assets : prod_path+'assets'
  },
  watch : {
    less : src_path+'/less/**/*.less',
    coffee : src_path+'/coffee/**/*.coffee'
  }
}