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
  spec.summary     = 'Calendrical Calculations in Ruby'
  spec.license     = 'BSD3'
  spec.homepage    = ''
  spec.description = <<-eos
                     A Ruby implementation of several calendrical calculations
                     algorithms.
                     Most of the algorithms are based on the book "Calendrical
                     Calculations", 3rd edition written by Edward M. Reingold
                     and Nachum Dershowitz.
                     eos
  spec.authors       = ['Sylvain Laperche']
  spec.email         = 'sylvain.laperche@gmx.fr'
  spec.require_paths = [ 'lib' ]
  spec.files         = `git ls-files`.split("\n") - [ '.gitignore', __FILE__ ]
  spec.test_files    = [ 'test/ts_CalCal.rb' ]

  spec.extra_rdoc_files = ['README.rdoc', 'LICENSE']
  spec.rdoc_options     = [ 'lib', '-t', 'CalCal -- Calendrical Calculations',
                            '-m', 'README.rdoc' ]
end

