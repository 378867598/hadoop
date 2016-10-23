class redis::redis {
$redis_server_path = "/usr/local/bin/redis-server"
$redis_data_dir    = "/data/redis" 
$redis_cli_path = "/usr/local/bin/redis-cli" 

redis::mkdir{"mkdir redis":
    redis_data_dir => $redis_data_dir
}


redis::redis-start{"domain-name":
    redis_data_dir     => $redis_data_dir,
    redis_server_path  => $redis_server_path,
    redis_cli_path     => $redis_cli_path,
    port               => "20000",
    maxmemory          => "8000",
    persistent         => "true",
    master_slave       => "true",
    master_ip          => "10.0.0.1",
    domain_name        => "domain-name",
    enablelog          => "false"
	}->
  service { 'redis-20000':
    enable => true,
    ensure => 'running',
  }
 
}
