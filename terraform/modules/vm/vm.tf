resource "azurerm_network_interface" "" {
  name                = ""
  location            = ""
  resource_group_name = ""

  ip_configuration {
    name                          = "internal"
    subnet_id                     = ""
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = ""
  }
}

resource "azurerm_linux_virtual_machine" "" {
  name                  = ""
  location              = ""
  resource_group_name   = ""
  size                  = "Standard_DS2_v2"
  admin_username        = ""
  network_interface_ids = []
  admin_ssh_key {
    username   = "angie"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzCjJdcuTqXyuZlcY/l67VP1JbO5fqpBC+XKnLyUyHK7gTUrKjdWTatC8c49kqDh4wb8zGhwVzjIR9/6NRCcsMLO7JUlO/5NjZ+Nk6OnrECxn8DzT1EI/ziYe5EDDNV51VE8Ga1FFd2d4k5S2t8A6b3ENwfRhGxoCkJowgUFm7+IHRPRtW0pnYQqaqU0vVLUy6Oy4j3xNRkoqwZAmLWf2BgfLPnWX6MHWNHghfuYgM9AyfQ8+FZLtrL2XJeI+AiSY0LfuCM4aWHkHprMjGyh8MYIVHSZ56cdIDkMt++9zHcEAOX3eR+HLq7FxlBUjCrit6+1U8xxfuD7oSueo2WThoVygVo8VD0k2hr3vkqwMwexJHee546qGD/FSuQZxg2lLH7IMZrlqbkQZE2VwPZhJiUo9J4Q3Pu21sIZmXfSMKaxaMJQas1sylCoGUIahFflWcoSj42X2j71R43yPhQpc+tex8LVJmGy06UVIVJe+TjxNaKL8Az7Q0CP8Y2ArYAF0= ancanchon@PCS-ANCANCHON.local"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
