module "terraform_module_for_sns" {
source =  "../sns_module"

name = var.name
display_name = var.display_name
protocol = var.protocol[0]
endpoint = var.endpoint
}
