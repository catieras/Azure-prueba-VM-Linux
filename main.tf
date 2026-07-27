terraform {
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "4.80.0"
    }
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "res-0" {
  location   = "westeurope"
  name       = "myResourceGroup"
  tags       = {}
}
resource "azurerm_ssh_public_key" "res-1" {
  location            = "northeurope"
  name                = "mykey"
  public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCaO622dEv8sCRcGDiVmFNE3gOc7vIZaJRlzUjpCk7t9ja9jY8XnRaIf61um7L6t7+wCgN9ic/2ICZNCPZtvB2N0tqhHHZUEhNjewsrjE/UuFuihPehJt2HiI8dHbUnETLN8s5IaaEUb1Saopb3DM9tDqrK6PHHNVEszX5R99y2w4syfxRhe/nzm05n+gRpgtYLJoNgUCEj1Exy4QOWt6JxDPQSrb7+vyADW1JGYP0MFz0KlMiJB+vc/wBj58n7lKES08YJGvM8tshkGppjWy7m91dvEUEi5qWhn+uY/Jw75hRXjW2x13cVidUNsf3VXVmfMen3GQxjXgCLzzIouB+Vf9VHsnYirMb7OegPe7kNg4fXHxDvdUcy7dPqCaNllNTUjXQd4DuhhLNiv6YmZluX0lW+Jfn87yaVVucl9d8wb2ZRX2obaHIlFXjZuPlEyWJe7pTz8kbLuaOqaYxJ7nj0kZ3Kp6d2C4RC8vfDBuZcdtHhBKra3czuCaahVjKiUyk= generated-by-azure"
  resource_group_name = azurerm_resource_group.res-0.name
  tags                = {}
}
resource "azurerm_linux_virtual_machine" "res-2" {
  admin_username                                         = "azureuser"
  allow_extension_operations                             = true
  bypass_platform_safety_checks_on_user_schedule_enabled = false
  computer_name                                          = "myVM"
  disable_password_authentication                        = true
  disk_controller_type                                   = "SCSI"
  encryption_at_host_enabled                             = false
  extensions_time_budget                                 = "PT1H30M"
  location                                               = "northeurope"
  max_bid_price                                          = -1
  name                                                   = "myVM"
  network_interface_ids                                  = [azurerm_network_interface.res-3.id]
  patch_assessment_mode                                  = "ImageDefault"
  patch_mode                                             = "ImageDefault"
  priority                                               = "Regular"
  provision_vm_agent                                     = true
  resource_group_name                                    = azurerm_resource_group.res-0.name
  secure_boot_enabled                                    = false
  size                                                   = "Standard_DC4as_cc_v5"
  tags                                                   = {}
  vtpm_enabled                                           = false
  additional_capabilities {
    hibernation_enabled = false
    ultra_ssd_enabled   = false
  }
  admin_ssh_key {
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCaO622dEv8sCRcGDiVmFNE3gOc7vIZaJRlzUjpCk7t9ja9jY8XnRaIf61um7L6t7+wCgN9ic/2ICZNCPZtvB2N0tqhHHZUEhNjewsrjE/UuFuihPehJt2HiI8dHbUnETLN8s5IaaEUb1Saopb3DM9tDqrK6PHHNVEszX5R99y2w4syfxRhe/nzm05n+gRpgtYLJoNgUCEj1Exy4QOWt6JxDPQSrb7+vyADW1JGYP0MFz0KlMiJB+vc/wBj58n7lKES08YJGvM8tshkGppjWy7m91dvEUEi5qWhn+uY/Jw75hRXjW2x13cVidUNsf3VXVmfMen3GQxjXgCLzzIouB+Vf9VHsnYirMb7OegPe7kNg4fXHxDvdUcy7dPqCaNllNTUjXQd4DuhhLNiv6YmZluX0lW+Jfn87yaVVucl9d8wb2ZRX2obaHIlFXjZuPlEyWJe7pTz8kbLuaOqaYxJ7nj0kZ3Kp6d2C4RC8vfDBuZcdtHhBKra3czuCaahVjKiUyk= generated-by-azure"
    username   = "azureuser"
  }
  boot_diagnostics {
    storage_account_uri = ""
  }
  os_disk {
    caching                          = "ReadWrite"
    disk_size_gb                     = 30
    storage_account_type             = "Premium_LRS"
    write_accelerator_enabled        = false
  }
  source_image_reference {
    offer     = "ubuntu-24_04-lts"
    publisher = "canonical"
    sku       = "ubuntu-pro"
    version   = "latest"
  }
}
resource "azurerm_network_interface" "res-3" {
  accelerated_networking_enabled = true
  ip_forwarding_enabled          = false
  location                       = "northeurope"
  name                           = "myvm48"
  resource_group_name            = azurerm_resource_group.res-0.name
  tags                           = {}
  ip_configuration {
    name                                               = "ipconfig1"
    primary                                            = true
    private_ip_address                                 = "10.0.0.224"
    private_ip_address_allocation                      = "Static"
    private_ip_address_version                         = "IPv4"
    public_ip_address_id                               = azurerm_public_ip.res-8.id
    subnet_id                                          = azurerm_subnet.res-10.id
  }
}
resource "azurerm_network_interface_security_group_association" "res-4" {
  network_interface_id      = azurerm_network_interface.res-3.id
  network_security_group_id = azurerm_network_security_group.res-5.id
}
resource "azurerm_network_security_group" "res-5" {
  location            = "northeurope"
  name                = "myVM-nsg"
  resource_group_name = azurerm_resource_group.res-0.name
  security_rule {
    access                                     = "Allow"
    destination_address_prefix                 = "*"
    destination_port_range                     = "22"
    direction                                  = "Inbound"
    name                                       = "SSH"
    priority                                   = 300
    protocol                                   = "Tcp"
    source_address_prefix                      = "*"
    source_port_range                          = "*"
    }
 security_rule {
    access                                     = "Allow"
    destination_address_prefix                 = "*"
    destination_port_range                     = "80"
    direction                                  = "Inbound"
    name                                       = "HTTP"
    priority                                   = 320
    protocol                                   = "Tcp"
    source_address_prefix                      = "*"
    source_port_range                          = "*"
  }
  tags = {}
}
resource "azurerm_network_security_rule" "res-6" {
  access                                     = "Allow"
  destination_address_prefix                 = "*"
  destination_port_range                     = "80"
  direction                                  = "Inbound"
  name                                       = "HTTP"
  network_security_group_name                = "myVM-nsg"
  priority                                   = 320
  protocol                                   = "Tcp"
  resource_group_name                        = azurerm_resource_group.res-0.name
  source_address_prefix                      = "*"
  source_port_range                          = "*"
  depends_on = [
    azurerm_network_security_group.res-5,
  ]
}
resource "azurerm_network_security_rule" "res-7" {
  access                                     = "Allow"
  destination_address_prefix                 = "*"
  destination_port_range                     = "22"
  direction                                  = "Inbound"
  name                                       = "SSH"
  network_security_group_name                = "myVM-nsg"
  priority                                   = 300
  protocol                                   = "Tcp"
  resource_group_name                        = azurerm_resource_group.res-0.name
  source_address_prefix                      = "*"
  source_port_range                          = "*"
  depends_on = [
    azurerm_network_security_group.res-5,
  ]
}
resource "azurerm_public_ip" "res-8" {
  allocation_method       = "Static"
  ddos_protection_mode    = "VirtualNetworkInherited"
  idle_timeout_in_minutes = 4
  ip_tags                 = {}
  ip_version              = "IPv4"
  location                = "northeurope"
  name                    = "myVM-ip"
  resource_group_name     = azurerm_resource_group.res-0.name
  sku                     = "Standard"
  sku_tier                = "Regional"
  tags                    = {}
}
resource "azurerm_virtual_network" "res-9" {
  address_space                  = ["10.0.0.0/16"]
  location                       = "northeurope"
  name                           = "myVM-vnet"
  private_endpoint_vnet_policies = "Disabled"
  resource_group_name            = azurerm_resource_group.res-0.name
  tags = {}
}
resource "azurerm_subnet" "res-10" {
  address_prefixes                              = ["10.0.0.0/24"]
  default_outbound_access_enabled               = true
  name                                          = "default"
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = true
  resource_group_name                           = azurerm_resource_group.res-0.name
  virtual_network_name                          = "myVM-vnet"
  depends_on = [
    azurerm_virtual_network.res-9,
  ]
}
