describe 'Crypta inspect' do
  require "crypta"
  
  let(:str) {"teststring"}
  let(:crypt_str) {Crypta.crypt(str)}
  let(:decrypt_str) {Crypta.decrypt(crypt_str)}

  describe '.crypt' do 
    it 'data length is 200' do
      expect(crypt_str.length).to equal 200
    end
  end

  describe '.decrypt' do 
    it 'data equal instance str' do
      expect(decrypt_str).to eql str
    end
  end

end