module StupidHash
  class SHash
    BUCKETS = 256

    def initialize
      @stupid_hash  = Array.new(BUCKETS) { nil }
    end

    def hash(key)
      key.to_s.each_char.inject(0) do |sum, ch|
        (sum << 8) ^ (ch.ord) ^ (sum >> 4)
      end % BUCKETS
    end

    def set(key, value)
      hash_key = hash(key)

      if @stupid_hash[hash_key].nil?
        @stupid_hash[hash_key] = []
      else
        return if override_duplicate_key(@stupid_hash[hash_key], key, value)
      end
    
      @stupid_hash[hash_key] << [key, value]
    end
    
    def get(key)
      hash_key = hash(key)
      return nil if @stupid_hash[hash_key].nil?
    
      @stupid_hash[hash_key].each do |s|
        return s[1] if s[0] == key
      end
    
      return nil
    end

    private

    def override_duplicate_key(note_members, key, value)
      note_members.each do |member|
        if member[0] == key
          member[1] = value
          return true
        end
      end

      false
    end
  end
end
