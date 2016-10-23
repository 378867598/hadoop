class syq_redis_web {
  define mkdir($redis_data_dir){
    file { "redis-data-dir":
        ensure => directory,
        path   => "${redis_data_dir}",
        owner => redis,
        group => redis,
        mode  => 644,
    }-> 
    file { "redis-conf":
        ensure => directory,
        path   => "${redis_data_dir}/conf/",
        owner => redis,
        group => redis,
        mode  => 644,
    }-> 
    file { "redis-run":
        ensure => directory,
        path   => "${redis_data_dir}/run/",
        owner => redis,
        group => redis,
        mode  => 644,
    }-> 
    file { "redis-data":
        ensure => directory,
        path   => "${redis_data_dir}/data/",
        owner => redis,
        group => redis,
        mode  => 644,
    }->
    file { "redis-logs":
        ensure => directory,
        path   => "${redis_data_dir}/logs/",
        owner => redis,
        group => redis,
        mode  => 644,
    }
  }
	define redis-start($redis_data_dir,
	$port,$maxmemory,$persistent,$master_slave,
	$master_ip,$access_ip,$domain_name,$enablelog,
	$redis_server_path,$redis_data_dir,$redis_cli_path){

    case $master_slave {
      'true': {
            if $ipaddress == "$master_ip" {
              $enableslave = false
              file {"redis.conf-$port":
                    ensure  => present,
                    owner   => redis,
                    group   => redis,
                    mode    => 644,
                    path    => "/data/redis/conf/${domain_name}_${port}_master.conf",
                    content => template('syq_redis_web/redis.conf.erb'),
              }
             }
            else {
              $enableslave = true
              file {"redis.conf-$port":
                   ensure  => present,
                   owner   => redis,
                   group   => redis,
                   mode    => 644,
                   path    => "/data/redis/conf/${domain_name}_${port}_master.conf",
                   content => template('syq_redis_web/redis.conf.erb'),
              }
             }
          }
      'false': {
            file { "redis.conf-$port":
                 ensure  => present,
                 owner   => redis,
                 group   => redis,
                 mode    => 644,
                 path    => "/data/redis/conf/${domain_name}_${port}_master.conf",
                 content => template('syq_redis_web/redis.conf.erb'),
             }
      	}
     }
  file {"redis.start-$port":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 755,
    path    => "/etc/init.d/redis-${port}",
    content => template('syq_redis_web/redis-start.erb'),
  	}
  
	}

}
