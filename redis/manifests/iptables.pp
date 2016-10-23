class redis::iptables {

  firewall { '001 11211 i.mx':
    src_range  =>  '10.0.0.1-10.0.0.2',
    proto      =>  'tcp',
    dport      =>  ['11211','20000'],
    action     =>  'accept',
    provider   => 'iptables',
  }->

  firewall { '994 port notrack':
    proto   =>  'tcp',
    sport   =>  ['11211','20000'],
    action  =>  'notrack',
    table   =>  'raw',
    chain   =>  'OUTPUT',
    provider => 'iptables',
  }->
  firewall { '995 notrack':
    proto   =>  'tcp',
    dport   =>  ['11211','20000'],
    action  =>  'notrack',
    table   =>  'raw',
    chain   =>  'PREROUTING',
    provider => 'iptables',
  }->

}

