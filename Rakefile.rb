require 'rake/clean'
require 'fileutils'

directory 'daily-mail-blocker'
CLOBBER << 'daily-mail-blocker'

STATIC_SOURCES = FileList['src/*.json',
        'src/*.png', 'src/*.html', 'src/*.js']
STATIC_SOURCES.each do |source|
    target = source.pathmap('%{src,daily-mail-blocker}p')
    file target => [source, 'daily-mail-blocker'] do
        cp source, target
    end
    task :build => target
end

COFFEE_SOURCES = FileList['src/*.coffee']
COFFEE_SOURCES.each do |source|
    target = source.pathmap('daily-mail-blocker/%n.js')
    file target => [source, 'daily-mail-blocker'] do
        sh "coffee -c -o daily-mail-blocker #{source}"
    end
    task :build => target
end

task :copy_tests do
    FileUtils.cp_r 'src/test', 'daily-mail-blocker', :verbose => true
end

desc "Build the extension."
task :build => :copy_tests

file 'daily-mail-blocker.zip' => [:build, 'daily-mail-blocker'] + FileList['daily-mail-blocker/**/*.*'] do
    sh "zip -r daily-mail-blocker daily-mail-blocker"
end
CLOBBER << 'daily-mail-blocker.zip'

file 'daily-mail-blocker.crx' => [:build, 'daily-mail-blocker'] + FileList['daily-mail-blocker/**/*.*'] do
    sh "chrome --pack-extension=#{File.expand_path('daily-mail-blocker')} --pack-extension-key=#{File.expand_path('daily-mail-blocker.pem')} --no-message-box"
end
CLOBBER << 'daily-mail-blocker.crx'

desc "Create a zip file containing the extension - suitable for upload."
task :package => ['daily-mail-blocker.zip', 'daily-mail-blocker.crx']

task :default => :build
