require 'rake'
require 'rake/rdoctask'
require 'rake/testtask'
require 'rcov/rcovtask'
require 'spec/rake/spectask'

MAIN      = "README"
LIBS      = FileList.new( File.basename(Dir.pwd) , 'lib' )
SRCFILES  = FileList.new( '*.rb', *LIBS.map { |l| l + "/**/*.rb" } )
TESTFILES = "test/unit/test*.rb"
SPECFILES = "spec/**/*_spec.rb"
SPECDOC   = "SPEC"

# Default: run all tests.
task :default => :test

# Wrapper for unit and/or functional tests.
desc "Run all tests"
task :test => [ :spec, :test_units ]

desc "Run the unit tests in test/unit"
Rake::TestTask.new( :test_units ) do |t|
  t.libs |= LIBS
  t.pattern = TESTFILES
  t.warning = true
  t.verbose = true
end

desc "Assert compliance with all specs"
Spec::Rake::SpecTask.new( :spec ) do |t|
  t.libs |= LIBS  
  t.spec_files = FileList[SPECFILES]
#  t.warning = true
  t.rcov = true
  t.rcov_opts = %w[--exclude spec --no-html --text-report]
end

desc "Generate rcov and spec reports"
Spec::Rake::SpecTask.new( :reports => :doc ) do |t|
  t.spec_files = FileList[SPECFILES]
  t.spec_opts = %w[--format html --diff]
  t.out = 'doc/rspec.html'
  t.rcov = true
  t.rcov_dir = 'doc/coverage'
  t.rcov_opts = %w[--exclude spec]
end

desc "Generate specdocs for examples for inclusion in RDoc"
Spec::Rake::SpecTask.new( :specdoc ) do |t|
  t.spec_files = FileList[SPECFILES]
  t.spec_opts << "--format rdoc"
  t.out = SPECDOC
end

task :doc => :specdoc
desc "Generate RDoc documentation"
Rake::RDocTask.new( :doc ) do |rdoc|
  rdoc.main = MAIN
  rdoc.rdoc_dir = "doc"
  rdoc.title = open(rdoc.main).readlines[0][2..-1].chomp
  rdoc.rdoc_files.include(rdoc.main, SPECDOC, *SRCFILES)
  rdoc.options << "--line-numbers" << "--inline-source" << "--tab-width=2"
end

task :clobber => :clobber_specdoc
task :clobber_specdoc do
  rm SPECDOC
end
