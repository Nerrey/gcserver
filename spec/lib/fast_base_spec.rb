describe 'FastBase inspect' do
  require "fast_base"

  let(:setkey) {FastBase.set("test", "1")}
  let(:getkey) {FastBase.get("test")}
  let(:getdelkey) {FastBase.get_and_del_by_key("test")}
  let(:delkey) {FastBase.del_by_key("test")}

  describe '.set' do
    it 'created key' do
      expect(setkey).to eql "OK"
      expect($redis.keys("gcserver|test|*").count).to eql 1
    end
  end

  describe '.get' do
    it 'got key' do
      expect(getkey.count).to equal 1
      expect(getkey.first).to eql "1"
    end
  end

  describe '.get_and_del_by_key' do
    it 'got and del key' do
      expect(getdelkey.count).to equal 1
      expect($redis.keys.count).to equal 0
    end
  end

  describe '.del_by_key' do
    before(:context) { FastBase.set("test", ["1", "2", "3"]); FastBase.set("test2", ["1", "2", "3"])  }
    it 'got del keys count' do
      expect(delkey).to eql 3
    end
    it 'got redis keys count' do
      expect($redis.keys.count).to eql 3
    end
  end

  describe '.del_all' do
    before(:context) { FastBase.del_all }
    it 'got del keys count' do
      expect($redis.keys.count).to equal 0
    end
  end

  describe '.set_light' do
    before(:context) { FastBase.set_light("1234567890") }
    after(:context) { FastBase.del_all }
    it 'ckeck light' do
      expect(FastBase.get("light1234567890").count).to equal 1
    end
  end
  
end