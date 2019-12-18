# Stupid Hash
A gem that implement Stupid Hash Tables. It will run slower than Ruby Hash

## Install locally
Clone the git repo and run:
```
gem install stupid_hash
```

## Create the hash and set [key, value]
```ruby
hash = StupidHash::SHash.new
hash.set(key, value)
```

We also able to set the key, value as same as Ruby Hash
```ruby
hash.[key] = value
```

## Get value from key
```ruby
value =hash.get(key)
```

We also able to get the key, value as same as Ruby Hash
```ruby
value = hash[key]
```
