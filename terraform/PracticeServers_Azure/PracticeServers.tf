provider "azurerm" {
  subscription_id = "fillme" // https://portal.azure.com/ -> Subscriptions
  tenant_id       = "fillme" // https://portal.azure.com/ -> Azure Active Directory -> App registrations -> Create Service Principal
  client_id       = "fillme" // https://portal.azure.com/ -> Azure Active Directory -> App registrations -> Created Service Principal
  client_secret   = "fillme" // // https://portal.azure.com/ -> Azure Active Directory -> App registrations -> Created Service Principal -> Certificates & secrets
  // https://portal.azure.com/ -> Subscriptions -> AIM -> Add -> Contributor -> Service Principal -> Created Service Principal
  features {}
}

locals {
  sshKey  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNrATLMvLH5Ihix/rGi0xpwvuO8omeziwPIotHVEKRvPOKBNz7nlUg7CCXte0OMRShzvzNfiPV1XVIIKYfKx5zZlL0L0v+RNY/uFMJjCXEEtb2zinH0AaEuvFSYYTDHNv+bU4hDTIBMCJc8a+I1EwwWOJpHuRaEhYsS5+HqdhURrPvGTHEORNQCoWgn45fs3oGC01XSMt6qmcXhuBSGZuptGvuNbirUGMEKtoco1BSfe3Tqpy+Aqz2aZZm0Qn4sv6kCEILlV9RkwglcHWqy0yNEvEOc/KAG8kchA4xiNS50tjewvT7rH+Ew+cd353JTWKr8HQaD6HGXipfQ7/nm/841dTo/ovgu8Q1pscdoUP5j1HHkfT7fyPU7KlxmGlbszdIcCR0ayUB2fpono/j9N3/I/GrHig1EN8WrWOJ5YZy5c+VI6GJ2vCC9OdCSgvDE9ReOuLr1n8FsG1eXcbhZK8u/BlSTYotggxMpvMqz3QoZ/Teiiy+cCTo/zCtijC/Lo3XcNIrtGq9QrRALxWGw2lGggaBSDtBEdAs5xv0dUAzaGsJLukUUKrdaAc4DJMk9pgYQ+se/LLO+4kjYR9NO0x9Z14/0ey2+MnQaIdJK7uyq1bnDnUQtUM5LoXoT9x15hNZarchrOstpIPhfkwffUPp89UuuzZcSvV1ntLUf7+v3Q== stanislav.novotny@unicorn.com"
  vm1     = "lectorvm01"
  vm2     = "lectorvm02"
  vm3     = "user1vm01"
  vm4     = "user1vm02"
  vm5     = "user2vm01"
  vm6     = "user2vm02"
  vm7     = "user3vm01"
  vm8     = "user3vm02"
  vm9     = "user4vm01"
  vm10    = "user4vm02"
  vm11    = "user5vm01"
  vm12    = "user5vm02"
  vm13    = "user6vm01"
  vm14    = "user6vm02"
  vm1ip   = "10.0.1.101"
  vm2ip   = "10.0.1.102"
  vm3ip   = "10.0.1.103"
  vm4ip   = "10.0.1.104"
  vm5ip   = "10.0.1.105"
  vm6ip   = "10.0.1.106"
  vm7ip   = "10.0.1.107"
  vm8ip   = "10.0.1.108"
  vm9ip   = "10.0.1.109"
  vm10ip  = "10.0.1.110"
  vm11ip  = "10.0.1.111"
  vm12ip  = "10.0.1.112"
  vm13ip  = "10.0.1.113"
  vm14ip  = "10.0.1.114"
  vm1size = "Standard_B2S"
  vmSize  = "Standard_B2S"
}

resource "azurerm_resource_group" "resourceGroup" {
  name     = "csob"
  location = "westeurope"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_security_group" "networkSecurityGroup" {
  name                = "networkSecurityGroup"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  security_rule {
    name               = "allow-ssh"
    priority           = 100
    direction          = "Inbound"
    access             = "Allow"
    protocol           = "TCP"
    source_port_range  = "*"
    source_port_ranges = []
    destination_port_ranges = [
      "22"
    ]
    source_address_prefix        = "*"
    source_address_prefixes      = []
    destination_address_prefix   = "*"
    destination_address_prefixes = []
  }

  security_rule {
    name               = "allow-activemq-console"
    priority           = 110
    direction          = "Inbound"
    access             = "Allow"
    protocol           = "TCP"
    source_port_range  = "*"
    source_port_ranges = []
    destination_port_ranges = [
      "8161"
    ]
    source_address_prefix        = "*"
    source_address_prefixes      = []
    destination_address_prefix   = "*"
    destination_address_prefixes = []
  }

  security_rule {
    name               = "allow-activemq-connector"
    priority           = 120
    direction          = "Inbound"
    access             = "Allow"
    protocol           = "TCP"
    source_port_range  = "*"
    source_port_ranges = []
    destination_port_ranges = [
      "61616"
    ]
    source_address_prefix        = "*"
    source_address_prefixes      = []
    destination_address_prefix   = "*"
    destination_address_prefixes = []
  }

  security_rule {
    name               = "allow-tomcat-web"
    priority           = 130
    direction          = "Inbound"
    access             = "Allow"
    protocol           = "TCP"
    source_port_range  = "*"
    source_port_ranges = []
    destination_port_ranges = [
      "8080"
    ]
    source_address_prefix        = "*"
    source_address_prefixes      = []
    destination_address_prefix   = "*"
    destination_address_prefixes = []
  }

  security_rule {
    name               = "allow-8443"
    priority           = 140
    direction          = "Inbound"
    access             = "Allow"
    protocol           = "TCP"
    source_port_range  = "*"
    source_port_ranges = []
    destination_port_ranges = [
      "8443"
    ]
    source_address_prefix        = "*"
    source_address_prefixes      = []
    destination_address_prefix   = "*"
    destination_address_prefixes = []
  }

  security_rule {
    name               = "allow-9993"
    priority           = 150
    direction          = "Inbound"
    access             = "Allow"
    protocol           = "TCP"
    source_port_range  = "*"
    source_port_ranges = []
    destination_port_ranges = [
      "9993"
    ]
    source_address_prefix        = "*"
    source_address_prefixes      = []
    destination_address_prefix   = "*"
    destination_address_prefixes = []
  }

  security_rule {
    name               = "allow-9990"
    priority           = 160
    direction          = "Inbound"
    access             = "Allow"
    protocol           = "TCP"
    source_port_range  = "*"
    source_port_ranges = []
    destination_port_ranges = [
      "9990"
    ]
    source_address_prefix        = "*"
    source_address_prefixes      = []
    destination_address_prefix   = "*"
    destination_address_prefixes = []
  }

  security_rule {
    name               = "allow-80"
    priority           = 170
    direction          = "Inbound"
    access             = "Allow"
    protocol           = "TCP"
    source_port_range  = "*"
    source_port_ranges = []
    destination_port_ranges = [
      "80"
    ]
    source_address_prefix        = "*"
    source_address_prefixes      = []
    destination_address_prefix   = "*"
    destination_address_prefixes = []
  }

  security_rule {
    name               = "allow-443"
    priority           = 180
    direction          = "Inbound"
    access             = "Allow"
    protocol           = "TCP"
    source_port_range  = "*"
    source_port_ranges = []
    destination_port_ranges = [
      "443"
    ]
    source_address_prefix        = "*"
    source_address_prefixes      = []
    destination_address_prefix   = "*"
    destination_address_prefixes = []
  }
}

resource "azurerm_virtual_network" "virtualNetwork1" {
  name                = "virtualNetwork1"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.resourceGroup.name
  virtual_network_name = azurerm_virtual_network.virtualNetwork1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.networkSecurityGroup.id
}

resource "azurerm_mysql_server" "mysql57" {
  name                = "mysqlcsob2"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  administrator_login          = "csobadmin"
  administrator_login_password = "csobP@ssw0rd"

  sku_name   = "B_Gen5_1"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "lector" {
  name                = "lector"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  server_name         = azurerm_mysql_server.mysql57.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_public_ip" "vm1-publicip" {
  name                = "${local.vm1}-publicip"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  allocation_method   = "Static"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_interface" "vm1-nic" {
  name                = "${local.vm1}-nic"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${local.vm1}-ip-configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = local.vm1ip
    public_ip_address_id          = azurerm_public_ip.vm1-publicip.id
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_virtual_machine" "vm1" {
  name                  = local.vm1
  location              = azurerm_resource_group.resourceGroup.location
  resource_group_name   = azurerm_resource_group.resourceGroup.name
  network_interface_ids = [azurerm_network_interface.vm1-nic.id]
  vm_size               = local.vm1size

  storage_os_disk {
    name              = "${local.vm1}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "78-gen2"
    version   = "7.8.2020111310"
  }

  os_profile {
    computer_name  = local.vm1
    admin_username = "csob"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/csob/.ssh/authorized_keys"
      key_data = local.sshKey
    }
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_public_ip" "vm2-publicip" {
  name                = "${local.vm2}-publicip"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  allocation_method   = "Static"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_interface" "vm2-nic" {
  name                = "${local.vm2}-nic"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${local.vm2}-ip-configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = local.vm2ip
    public_ip_address_id          = azurerm_public_ip.vm2-publicip.id
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_virtual_machine" "vm2" {
  name                  = local.vm2
  location              = azurerm_resource_group.resourceGroup.location
  resource_group_name   = azurerm_resource_group.resourceGroup.name
  network_interface_ids = [azurerm_network_interface.vm2-nic.id]
  vm_size               = local.vmSize

  storage_os_disk {
    name              = "${local.vm2}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "78-gen2"
    version   = "7.8.2020111310"
  }

  os_profile {
    computer_name  = local.vm2
    admin_username = "csob"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/csob/.ssh/authorized_keys"
      key_data = local.sshKey
    }
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_public_ip" "vm3-publicip" {
  name                = "${local.vm3}-publicip"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  allocation_method   = "Static"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_interface" "vm3-nic" {
  name                = "${local.vm3}-nic"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${local.vm3}-ip-configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = local.vm3ip
    public_ip_address_id          = azurerm_public_ip.vm3-publicip.id
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_virtual_machine" "vm3" {
  name                  = local.vm3
  location              = azurerm_resource_group.resourceGroup.location
  resource_group_name   = azurerm_resource_group.resourceGroup.name
  network_interface_ids = [azurerm_network_interface.vm3-nic.id]
  vm_size               = local.vmSize

  storage_os_disk {
    name              = "${local.vm3}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "78-gen2"
    version   = "7.8.2020111310"
  }

  os_profile {
    computer_name  = local.vm3
    admin_username = "csob"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/csob/.ssh/authorized_keys"
      key_data = local.sshKey
    }
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_public_ip" "vm4-publicip" {
  name                = "${local.vm4}-publicip"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  allocation_method   = "Static"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_interface" "vm4-nic" {
  name                = "${local.vm4}-nic"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${local.vm4}-ip-configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = local.vm4ip
    public_ip_address_id          = azurerm_public_ip.vm4-publicip.id
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_virtual_machine" "vm4" {
  name                  = local.vm4
  location              = azurerm_resource_group.resourceGroup.location
  resource_group_name   = azurerm_resource_group.resourceGroup.name
  network_interface_ids = [azurerm_network_interface.vm4-nic.id]
  vm_size               = local.vmSize

  storage_os_disk {
    name              = "${local.vm4}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "78-gen2"
    version   = "7.8.2020111310"
  }

  os_profile {
    computer_name  = local.vm4
    admin_username = "csob"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/csob/.ssh/authorized_keys"
      key_data = local.sshKey
    }
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_public_ip" "vm5-publicip" {
  name                = "${local.vm5}-publicip"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  allocation_method   = "Static"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_interface" "vm5-nic" {
  name                = "${local.vm5}-nic"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${local.vm5}-ip-configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = local.vm5ip
    public_ip_address_id          = azurerm_public_ip.vm5-publicip.id
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_virtual_machine" "vm5" {
  name                  = local.vm5
  location              = azurerm_resource_group.resourceGroup.location
  resource_group_name   = azurerm_resource_group.resourceGroup.name
  network_interface_ids = [azurerm_network_interface.vm5-nic.id]
  vm_size               = local.vmSize

  storage_os_disk {
    name              = "${local.vm5}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "78-gen2"
    version   = "7.8.2020111310"
  }

  os_profile {
    computer_name  = local.vm5
    admin_username = "csob"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/csob/.ssh/authorized_keys"
      key_data = local.sshKey
    }
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_public_ip" "vm6-publicip" {
  name                = "${local.vm6}-publicip"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  allocation_method   = "Static"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_interface" "vm6-nic" {
  name                = "${local.vm6}-nic"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${local.vm6}-ip-configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = local.vm6ip
    public_ip_address_id          = azurerm_public_ip.vm6-publicip.id
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_virtual_machine" "vm6" {
  name                  = local.vm6
  location              = azurerm_resource_group.resourceGroup.location
  resource_group_name   = azurerm_resource_group.resourceGroup.name
  network_interface_ids = [azurerm_network_interface.vm6-nic.id]
  vm_size               = local.vmSize

  storage_os_disk {
    name              = "${local.vm6}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "78-gen2"
    version   = "7.8.2020111310"
  }

  os_profile {
    computer_name  = local.vm6
    admin_username = "csob"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/csob/.ssh/authorized_keys"
      key_data = local.sshKey
    }
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_public_ip" "vm7-publicip" {
  name                = "${local.vm7}-publicip"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  allocation_method   = "Static"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_interface" "vm7-nic" {
  name                = "${local.vm7}-nic"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${local.vm7}-ip-configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = local.vm7ip
    public_ip_address_id          = azurerm_public_ip.vm7-publicip.id
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_virtual_machine" "vm7" {
  name                  = local.vm7
  location              = azurerm_resource_group.resourceGroup.location
  resource_group_name   = azurerm_resource_group.resourceGroup.name
  network_interface_ids = [azurerm_network_interface.vm7-nic.id]
  vm_size               = local.vmSize

  storage_os_disk {
    name              = "${local.vm7}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "78-gen2"
    version   = "7.8.2020111310"
  }

  os_profile {
    computer_name  = local.vm7
    admin_username = "csob"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/csob/.ssh/authorized_keys"
      key_data = local.sshKey
    }
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_public_ip" "vm8-publicip" {
  name                = "${local.vm8}-publicip"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  allocation_method   = "Static"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_interface" "vm8-nic" {
  name                = "${local.vm8}-nic"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${local.vm8}-ip-configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = local.vm8ip
    public_ip_address_id          = azurerm_public_ip.vm8-publicip.id
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_virtual_machine" "vm8" {
  name                  = local.vm8
  location              = azurerm_resource_group.resourceGroup.location
  resource_group_name   = azurerm_resource_group.resourceGroup.name
  network_interface_ids = [azurerm_network_interface.vm8-nic.id]
  vm_size               = local.vmSize

  storage_os_disk {
    name              = "${local.vm8}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "78-gen2"
    version   = "7.8.2020111310"
  }

  os_profile {
    computer_name  = local.vm8
    admin_username = "csob"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/csob/.ssh/authorized_keys"
      key_data = local.sshKey
    }
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_public_ip" "vm9-publicip" {
  name                = "${local.vm9}-publicip"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  allocation_method   = "Static"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_interface" "vm9-nic" {
  name                = "${local.vm9}-nic"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${local.vm9}-ip-configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = local.vm9ip
    public_ip_address_id          = azurerm_public_ip.vm9-publicip.id
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_virtual_machine" "vm9" {
  name                  = local.vm9
  location              = azurerm_resource_group.resourceGroup.location
  resource_group_name   = azurerm_resource_group.resourceGroup.name
  network_interface_ids = [azurerm_network_interface.vm9-nic.id]
  vm_size               = local.vmSize

  storage_os_disk {
    name              = "${local.vm9}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "78-gen2"
    version   = "7.8.2020111310"
  }

  os_profile {
    computer_name  = local.vm9
    admin_username = "csob"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/csob/.ssh/authorized_keys"
      key_data = local.sshKey
    }
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_public_ip" "vm10-publicip" {
  name                = "${local.vm10}-publicip"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  allocation_method   = "Static"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_interface" "vm10-nic" {
  name                = "${local.vm10}-nic"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${local.vm10}-ip-configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = local.vm10ip
    public_ip_address_id          = azurerm_public_ip.vm10-publicip.id
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_virtual_machine" "vm10" {
  name                  = local.vm10
  location              = azurerm_resource_group.resourceGroup.location
  resource_group_name   = azurerm_resource_group.resourceGroup.name
  network_interface_ids = [azurerm_network_interface.vm10-nic.id]
  vm_size               = local.vmSize

  storage_os_disk {
    name              = "${local.vm10}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "78-gen2"
    version   = "7.8.2020111310"
  }

  os_profile {
    computer_name  = local.vm10
    admin_username = "csob"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/csob/.ssh/authorized_keys"
      key_data = local.sshKey
    }
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_public_ip" "vm11-publicip" {
  name                = "${local.vm11}-publicip"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  allocation_method   = "Static"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_interface" "vm11-nic" {
  name                = "${local.vm11}-nic"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${local.vm11}-ip-configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = local.vm11ip
    public_ip_address_id          = azurerm_public_ip.vm11-publicip.id
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_virtual_machine" "vm11" {
  name                  = local.vm11
  location              = azurerm_resource_group.resourceGroup.location
  resource_group_name   = azurerm_resource_group.resourceGroup.name
  network_interface_ids = [azurerm_network_interface.vm11-nic.id]
  vm_size               = local.vmSize

  storage_os_disk {
    name              = "${local.vm11}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "78-gen2"
    version   = "7.8.2020111310"
  }

  os_profile {
    computer_name  = local.vm11
    admin_username = "csob"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/csob/.ssh/authorized_keys"
      key_data = local.sshKey
    }
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_public_ip" "vm12-publicip" {
  name                = "${local.vm12}-publicip"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  allocation_method   = "Static"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_interface" "vm12-nic" {
  name                = "${local.vm12}-nic"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${local.vm12}-ip-configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = local.vm12ip
    public_ip_address_id          = azurerm_public_ip.vm12-publicip.id
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_virtual_machine" "vm12" {
  name                  = local.vm12
  location              = azurerm_resource_group.resourceGroup.location
  resource_group_name   = azurerm_resource_group.resourceGroup.name
  network_interface_ids = [azurerm_network_interface.vm12-nic.id]
  vm_size               = local.vmSize

  storage_os_disk {
    name              = "${local.vm12}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "78-gen2"
    version   = "7.8.2020111310"
  }

  os_profile {
    computer_name  = local.vm12
    admin_username = "csob"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/csob/.ssh/authorized_keys"
      key_data = local.sshKey
    }
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_public_ip" "vm13-publicip" {
  name                = "${local.vm13}-publicip"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  allocation_method   = "Static"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_interface" "vm13-nic" {
  name                = "${local.vm13}-nic"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${local.vm13}-ip-configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = local.vm13ip
    public_ip_address_id          = azurerm_public_ip.vm13-publicip.id
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_virtual_machine" "vm13" {
  name                  = local.vm13
  location              = azurerm_resource_group.resourceGroup.location
  resource_group_name   = azurerm_resource_group.resourceGroup.name
  network_interface_ids = [azurerm_network_interface.vm13-nic.id]
  vm_size               = local.vmSize

  storage_os_disk {
    name              = "${local.vm13}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "78-gen2"
    version   = "7.8.2020111310"
  }

  os_profile {
    computer_name  = local.vm13
    admin_username = "csob"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/csob/.ssh/authorized_keys"
      key_data = local.sshKey
    }
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_public_ip" "vm14-publicip" {
  name                = "${local.vm14}-publicip"
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  allocation_method   = "Static"

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_network_interface" "vm14-nic" {
  name                = "${local.vm14}-nic"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name

  ip_configuration {
    name                          = "${local.vm14}-ip-configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = local.vm14ip
    public_ip_address_id          = azurerm_public_ip.vm14-publicip.id
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  tags = {
    environment = "CSOB"
  }
}

resource "azurerm_virtual_machine" "vm14" {
  name                  = local.vm14
  location              = azurerm_resource_group.resourceGroup.location
  resource_group_name   = azurerm_resource_group.resourceGroup.name
  network_interface_ids = [azurerm_network_interface.vm14-nic.id]
  vm_size               = local.vmSize

  storage_os_disk {
    name              = "${local.vm14}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "78-gen2"
    version   = "7.8.2020111310"
  }

  os_profile {
    computer_name  = local.vm14
    admin_username = "csob"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/csob/.ssh/authorized_keys"
      key_data = local.sshKey
    }
  }

  tags = {
    environment = "CSOB"
  }
}
