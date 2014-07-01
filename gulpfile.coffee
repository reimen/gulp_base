# global task
gulp = require 'gulp'

# plugins
flatten = require 'gulp-flatten'
filter = require 'gulp-filter'
plumber = require 'gulp-plumber'
bowerFiles = require 'gulp-bower-files'
connect = require 'gulp-connect'
jade = require 'gulp-jade'
sass = require 'gulp-sass'
coffee = require 'gulp-coffee'


# package manager
gulp.task 'bower', ->
  jsFilter = filter('**/*.js')
  cssFilter = filter('**/*.css')
  # import js libraries
  files = bowerFiles()
    .pipe(flatten())

  files.pipe(jsFilter)
    .pipe(gulp.dest('./dist/lib/js'))
  # import css libraries
  files.pipe(cssFilter)
    .pipe(gulp.dest('./dist/lib/css'))


# local server
gulp.task 'connect', ->
  connect.server(
    root: 'dist'
    livereload: true
  )


gulp.task 'jade', ->
  gulp.src('./jade/dist/**/*.jade')
    .pipe(plumber())
    .pipe(jade(pretty: true))
    .pipe(gulp.dest('./dist/'))
    .pipe(connect.reload())

gulp.task 'sass', ->
  gulp.src('./sass/**/*.scss')
    .pipe(plumber())
    .pipe(sass(pretty: true))
    .pipe(gulp.dest('./dist/css'))
    .pipe(connect.reload())

gulp.task 'coffee', ->
  gulp.src('./coffee/**/*.coffee')
    .pipe(plumber())
    .pipe(coffee(bare: true))
    .pipe(gulp.dest('./dist/js/'))
    .pipe(connect.reload())


# watch application files
gulp.task 'watch', ->
  gulp.watch(
    ['./jade/**/*.jade', './sass/**/*.scss', './coffee/**/*.coffee'],
    ['jade', 'sass', 'coffee']
  )

# default task
gulp.task 'default', ['jade', 'sass', 'coffee', 'connect', 'watch']


