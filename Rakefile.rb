require 'rake/clean'

directory 'extension'
CLOBBER << 'extension'

STATIC_SOURCES = FileList['src/*.json',
        'src/*.png', 'src/*.html', 'src/*.js']
STATIC_SOURCES.each do |source|
    target = source.pathmap('%{src,extension}p')
    file target => [source, :extension] do
        cp source, target
    end
    task :build => target
end

COFFEE_SOURCES = FileList['src/*.coffee']
COFFEE_SOURCES.each do |source|
    target = source.pathmap('extension/%n.js')
    file target => [source, :extension] do
        sh "coffee -c -o extension #{source}"
    end
    task :build => target
end

desc "Build the extension."
task :build

task :default => :build
