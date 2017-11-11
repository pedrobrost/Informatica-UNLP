require 'minitest/autoload'
require 'minitest/spec'

require_relative 'longitud'

describe '#longitud' do
  
  describe 'cuando el arreglo contiene strings' do
    it 'debe devolver las longitudes correctas' do
      longitud(['TTPS', 'Opción', 'Ruby', 'Cursada 2015']).must_equal [4, 6, 4, 12]
    end

    it 'debe devolver las longitudes correctas' do
      longitud([]).must_equal []
    end
  end
end
