module.exports = (grunt) ->

  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-stylus"

  grunt.loadTasks "./grunt_tasks/"


  assets =
    fonts: "application/fonts/"
    images: "application/images/"
    stylesheets: "application/styles/"
    javascripts: "application/coffee/"
    views: "application/views/"
    components: "application/bower_components/"

  grunt.initConfig

    angular_template_cache:
      build:
        options:
          module_name: "app.views"

        src: "**/**.html"
        dest: "public/javascripts/views.js"
        cwd: assets.views


    clean:
      public: ["public/javascripts", "public/images", "public/stylesheets", "public/fonts"]

    copy:
      fontawesome:
        expand: true
        src: "**"
        dest: "public/fonts/"
        cwd: "#{assets.components}/font-awesome/fonts"

      fonts:
        expand: true
        src: "**"
        dest: "public/fonts/"
        cwd: assets.fonts

      images:
        expand: true
        src: "**"
        dest: "public/images/"
        cwd: assets.images

    coffee:
      compile:
        files:
          'public/javascripts/application.js': [
            "#{assets.javascripts}main.coffee"
            "#{assets.javascripts}controllers/**/**.coffee"
            "#{assets.javascripts}services/**/**.coffee"
            "#{assets.javascripts}directives/**/**.coffee"
            "#{assets.javascripts}filters/**/**.coffee"
          ]

    stylus:
      compile:
        files:
          'public/stylesheets/application.css': ["#{assets.stylesheets}**/**.styl"]


    concat:
      lib:
        options:
          separator: "\n"
        files:
          "public/javascripts/lib.js": [
            "#{assets.components}lodash/dist/lodash.js"
            "#{assets.components}chance/chance.js"
            "#{assets.components}angular/angular.js"
          ]

          "public/stylesheets/lib.css": [
            "#{assets.components}bootstrap/dist/css/bootstrap.css"
            "#{assets.components}bootstrap/dist/css/bootstrap-theme.css"
            "#{assets.components}font-awesome/css/font-awesome.css"
          ]

    watch:
      images:
        files: ["#{assets.images}**/**"]
        tasks: ["copy:images"]
        options:
          atBegin: true

      fonts:
        files: ["#{assets.fonts}**/**"]
        tasks: ["copy:fonts"]
        options:
          atBegin: true

      views:
        files: ["#{assets.views}**/**.html"]
        tasks: ["angular_template_cache"]
        options:
          atBegin: true

      stylesheets:
        files: [
          "#{assets.stylesheets}**/**.styl"
        ]
        tasks: ["stylus"]
        options:
          atBegin: true

      scripts:
        files: [
          "#{assets.javascripts}**/**.coffee"
        ]
        tasks: ["coffee"]
        options:
          atBegin: true


  grunt.event.on "watch", (action, filepath, target) ->
    grunt.log.writeln target + ": " + filepath + " has " + action
    return

  grunt.registerTask "build", [
    "clean"
    "copy"
    "coffee"
    "stylus"
    "angular_template_cache"
    "concat"
  ]
