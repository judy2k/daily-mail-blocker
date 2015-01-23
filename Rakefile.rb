require 'rake/clean'
require 'fileutils'

#INKSCAPE = '/Applications/Inkscape.app/Contents/Resources/bin/inkscape'
INKSCAPE = '~/Applications/Inkscape.app/Contents/Resources/bin/inkscape'

directory 'daily-mail-blocker'
CLOBBER << 'daily-mail-blocker'

def export_icon(dest, size)
    sh "#{INKSCAPE} -w #{size} -h #{size} -i logo --without-gui --export-png='#{dest}' graphics/icon_working.svg"
end

# Building Tasks --------------------------------------------------------------

# Copy static sources from src to dest:
STATIC_SOURCES = FileList['src/*.json',
        'src/*.png', 'src/*.html', 'src/*.js']
STATIC_SOURCES.each do |source|
    target = source.pathmap('%{src,daily-mail-blocker}p')
    file target => [source, 'daily-mail-blocker'] do
        cp source, target
    end
    task :build => target
end

# Compile Coffee files inside src to dest
COFFEE_SOURCES = FileList['src/*.coffee']
COFFEE_SOURCES.each do |source|
    target = source.pathmap('daily-mail-blocker/%n.js')
    file target => [source, 'daily-mail-blocker'] do
        sh "coffee -c -o daily-mail-blocker #{source}"
    end
    task :build => target
end

file 'daily-mail-blocker/icon256.png' => 'graphics/icon_working.svg' do |t|
    export_icon t.name, 256
end
task :icons => 'daily-mail-blocker/icon256.png'

file 'daily-mail-blocker/icon128.png' => 'graphics/icon_working.svg' do |t|
    export_icon t.name, 128
end
task :icons => 'daily-mail-blocker/icon128.png'

file 'daily-mail-blocker/icon48.png' => 'graphics/icon_working.svg' do |t|
    export_icon t.name, 48
end
task :icons => 'daily-mail-blocker/icon48.png'

file 'daily-mail-blocker/icon16.png' => 'graphics/icon_working.svg' do |t|
    export_icon t.name, 16
end
task :icons => 'daily-mail-blocker/icon16.png'


# Packaging Tasks -------------------------------------------------------------

file 'daily-mail-blocker.zip' => [:build, 'daily-mail-blocker'] + FileList['daily-mail-blocker/**/*.*'] do
    sh "zip -r daily-mail-blocker daily-mail-blocker"
end
CLOBBER << 'daily-mail-blocker.zip'


file 'daily-mail-blocker.crx' => [:build, 'daily-mail-blocker'] + FileList['daily-mail-blocker/**/*.*'] do
    sh "chrome --pack-extension=#{File.expand_path('daily-mail-blocker')} --pack-extension-key=#{File.expand_path('daily-mail-blocker.pem')} --no-message-box"
end
CLOBBER << 'daily-mail-blocker.crx'

#------------------------------------------------------------------------------
# Top-Level Tasks
#

desc "Build the extension."
task :build

desc "Build a zip file suitable for upload to the Google Play Store"
task :zip => 'daily-mail-blocker.zip'

desc "Build a crx file suitable for self-hosting"
task :crx => 'daily-mail-blocker.crx'

desc "Create distribution packages."
task :package => [:zip, :crx]

task :default => :build
