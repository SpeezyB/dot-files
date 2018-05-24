function upduck -d "Alias to update the dynamic DNS DuckDNS.org"
  set -l currentIP (curl --silent --show-error ipinfo.io/ip)
  #set -l addys [greenpickle.duckdns.org greenpickles.duckdns.org werf.duckdns.org]


  #for $addys

  printf %b 'Updatting Dynamic DNS addresses:'\n 
  printf %b \t\tgreenpickles.duckdns.org,\n
  printf %b \t\tgreenpickle.duckdns.org,\n
  printf %b \t\twerf.duckdns.org\n
  printf %b \n

  curl "https://www.duckdns.org/update?domains=greenpickle.duckdns.org,greenpickles.duckdns.org,werf.duckdns.org&token=32d027c4-b7e3-4c16-b80a-2d2735a69ad7&ip=$currentIP&verbose=true"
  
  printf %b \n\n
end
