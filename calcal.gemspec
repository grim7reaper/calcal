open('lib/calcal.rb') do |file|
  file.each_line do |line|
    if /VERSION = \[([^\]]+)\]/ =~ line
      VERSION = $1.split(', ').join('.')
      break
    end
  end
end

Gem::Specification.new do |spec|
  spec.name        = 'calcal'
  spec.version     = VERSION
  spec.date        = Time.now.strftime("%F")
  spec.authors     = 'Sylvain Laperche'
  spec.email       = 'sylvain.laperche@gmail.com'
  spec.summary     = 'Calendrical Calculations in Ruby'
  spec.license     = 'BSD3'
  spec.homepage    = 'http://projects.gw-computing.net/projects/calcal'
  spec.description = <<-eos
                     A Ruby implementation of several calendrical calculations
                     algorithms.
                     Most of the algorithms are based on the book "Calendrical
                     Calculations", 3rd edition written by Edward M. Reingold
                     and Nachum Dershowitz.
                     eos
  spec.require_paths = [ 'lib' ]
  spec.files         = `git ls-files`.split("\n") - [ '.gitignore', '.yardopts',
                                                      __FILE__ ]
  spec.test_files    = [ 'test/ts_CalCal.rb' ]
  spec.has_rdoc      = 'yard'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'simplecov'
end

