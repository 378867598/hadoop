class redis::memcache_start{
  $memcache_dir = "/data/memcache"

  file {"memcache-run":
    ensure    =>  directory,
    path      =>  "/data/memcache/run/",
    owner     =>  "memcached",
    group     =>  "memcached",
    mode      =>  "755",
    }-> 

  file {"memcache-lock":
    ensure    =>  directory,
    path      =>  "/data/memcache/lock/",
    owner     =>  "memcached",
    group     =>  "memcached",
    mode      =>  "755",
    }   
  file {"memcache-dir":
    ensure    =>  directory,
    path      =>  "$memcache_dir",
    owner     =>  "memcached",
    group     =>  "memcached",
    mode      =>  755,
    }
    
  package {"memcached":
      ensure  =>  "present",
    }
  
  redis::memcached::memcache-start{"doman-name":
    memcache_dir  =>  $memcache_dir,
    port          =>  "11211",
    maxmemory     =>  "1500",
    connect       =>  "4000"
    }

  }
