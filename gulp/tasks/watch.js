var gulp = require('gulp'),
  GLOBVARS = require('../vars');

gulp.task("watch", function () {
  gulp.watch(GLOBVARS.watch.less, ['dev-less']);
  // gulp.watch(GLOBVARS.watch.templates, ['dev-templates']);
  gulp.watch(GLOBVARS.watch.coffee, ['dev-coffee']);
  gulp.watch('bower.json', ['dev-bower']);
});