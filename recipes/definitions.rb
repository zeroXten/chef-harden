# security updates
define /must have no security updates pending/ do
  command 'check_security_updates'
  code <<-EOF
    #!/bin/bash

    security_updates=$(/usr/bin/list-security-updates | wc -l)

    if [[ -z "$security_updates" ]]; then
      echo "UNKNOWN - Problem running list-security-updates"; exit 3
    elif [[ "$security_updates" == "0" ]]; then
      echo "OK - There are 0 security updates pending"; exit 0
    else
      echo "CRITICAL - There are ${security_updates} security updates pending"; exit 2
    fi
  EOF
end
