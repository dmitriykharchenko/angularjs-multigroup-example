module.exports = function(grunt) {
  grunt.registerMultiTask('angular_template_cache', 'Composes html-files to angular $templateCache', function() {

    var data = this.data;
    var files = this.files;

    var pre = "angular.module('" + this.data.options.module_name + "', []).run(function($templateCache){\n\t";
    var post = "\n});"
    var template_cache = [];

    var cutoff_comments = function(template){
      return template.replace(/<!--[\s.<\w="'->]*-->/g, "");
    };

    files.forEach(function(files, index){

      files.src.map(function(src){
        return grunt.file.read(files.cwd + src);
      }).forEach(function(template, index){

        var template_name = files.src[index];
        var template_cache_name = template_name.replace(/\.[\w]*$/, '');
        template_cache.push("$templateCache.put('" + template_cache_name + "', '" + cutoff_comments(template).replace(/\n/g, "").replace(/\'/g, "\\'") + "')");
      });

      var content = pre + template_cache.join(";\n\t") + post;
      grunt.file.write(files.dest, content);
    });
  });
};
