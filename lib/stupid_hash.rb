module StupidHash
  class SHash
    attr_reader :stupid_hash, :buckets, :bucket_sizes, :maximum_bucket_size

    def initialize(maximum_bucket_size = 5)
      @buckets = 2
      @stupid_hash  = Array.new(@buckets) { nil }
      @bucket_sizes = Array.new(@buckets) { 0 }
      @maximum_bucket_size = maximum_bucket_size
    end

    def hash(key)
      key.to_s.each_char.inject(0) do |sum, ch|
        (sum << 4) ^ (ch.ord) ^ (sum >> 2)
      end % buckets
    end

    def set(key, value)
      hash_key = hash(key)

      if stupid_hash[hash_key].nil?
        stupid_hash[hash_key] = []
      else
        return if override_duplicate_key(hash_key, key, value)
      end
    
      stupid_hash[hash_key] << [key, value]
      bucket_sizes[hash_key] += 1

      if bucket_sizes[hash_key] > maximum_bucket_size
        self.stupid_hash = resize_hash
      end

      stupid_hash
    end
    
    def get(key)
      hash_key = hash(key)

      return nil if stupid_hash[hash_key].nil?
    
      stupid_hash[hash_key].each do |s|
        return s[1] if s[0] == key
      end
    
      return nil
    end

    alias_method :[]= , :set
    alias_method :[]  , :get

    private
    attr_writer :stupid_hash, :buckets, :bucket_sizes

    def override_duplicate_key(hash_key, key, value)
      stupid_hash[hash_key].each do |member|
        if member[0] == key
          member[1] = value
          return true
        end
      end

      false
    end

    def resize_hash
      self.buckets = self.buckets * 2
      new_hash = Array.new(buckets) { nil }
      self.bucket_sizes = Array.new(buckets) { 0 }

      stupid_hash.each do |array|
        next if array.nil?

        array.each do |member|
          hash_key = hash(member[0])

          if new_hash[hash_key].nil?
            new_hash[hash_key] = []
          end

          new_hash[hash_key] << [member[0], member[1]]
          bucket_sizes[hash_key] += 1
        end
      end

      new_hash
    end
  end
end
