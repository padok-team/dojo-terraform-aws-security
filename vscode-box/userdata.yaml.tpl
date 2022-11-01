#cloud-config
groups:
  - docker
users:
  - name: cs
    ssh_import_id:
      - gh:${github_username}
    lock_passwd: true
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: [docker] # for sudoless docker
    shell: /bin/bash

write_files:
  - path: /etc/ssh/banner
    content: |

      (                                         (     
      )\ )        (            )           (    )\ )  
      (()/(    )   )\ )      ( /(           )\  (()/(  
      /(_))( /(  (()/(  (   )\())    __  (((_)  /(_)) 
      (_))  )(_))  ((_)) )\ ((_)\    / /  )\___ (_))   
      | _ \((_)_   _| | ((_)| |(_)  / /  ((/ __|/ __|  
      |  _// _` |/ _` |/ _ \| / /  /_/    | (__ \__ \  
      |_|  \__,_|\__,_|\___/|_\_\          \___||___/  

        _._     _,-'""`-._
      (,-.`._,'(       |\`-/|
          `-.-' \ )-`( , o o)
                `-    \`_`"'-

                                                      
runcmd:
  # Install banner
  - echo 'Banner /etc/ssh/banner' >> /etc/ssh/sshd_config.d/banner.conf
  - sudo systemctl restart sshd

  # Install Terraform 
  # https://www.terraform.io/downloads
  - wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
  - echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  - apt update && sudo apt install terraform
  - alias tf=terraform

  # Clone the exercise repository
  - git clone https://github.com/padok-team/dojo-terraform-aws-security.git /home/cs/dojo-terraform-aws-security

  - curl "https://echo.dixneuf19.me/${github_username}" # telemetry
