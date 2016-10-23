class redis::memcached{
  define memcache-start($port,$maxmemory,$connect,$memcache_dir){
    file {"memcache-start-${port}":
      ensure    =>  present,
      owner     =>  root,
      group     =>  root,
      mode      =>  755,
      path      =>  "/etc/init.d/memcache-$port",
      content   =>  template('syq_redis_web/memcache-start.erb'),
      }->
    service { "memcache-${port}":
        enable => true,
        ensure => 'running',
      }
    }
  }
