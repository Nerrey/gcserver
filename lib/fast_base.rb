class FastBase
  require "crypta"
  
  def initialize
    @crypta = Crypta.new
  end

  def set(key, value)
    case value
    when String
      set_to_redis(key, value)
    when Array
      value.each{|val| set_to_redis(key, val)}
    else
    end
  end

  def get(key)
    $redis.keys("gcserver|#{key}|*").map do |val| 
      val = val.gsub("gcserver|#{key}|", "")
      @crypta.decrypt(val)
    end
  end
  
  # def del_by_val(key, value)
  #   puts "gcserver|#{key}|#{@crypta.crypt(value)}"
  #   $redis.del("gcserver|#{key}|#{@crypta.crypt(value)}")
  # end
  def get_and_del_by_key(key)
    keys = $redis.keys("gcserver|#{key}|*")
    begin
      $redis.del(keys)
    rescue
    end
    keys
  end

  def del_by_key(key)
    keys = $redis.keys("gcserver|#{key}|*")
    $redis.del(keys)
  end

  def del_all
    keys = $redis.keys("gcserver|*")
    $redis.del(keys)
  end
  
  def set_light(phone)
    $redis.set("gcserver|light#{phone}|", 0)
  end

  private

  def set_to_redis(key, value)
    $redis.set("gcserver|#{key}|#{@crypta.crypt(value)}", 0)
  end

end