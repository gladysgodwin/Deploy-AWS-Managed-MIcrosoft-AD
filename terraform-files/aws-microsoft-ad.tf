module "windows-workloads-on-aws_managed-ad" {
  source  = "aws-samples/windows-workloads-on-aws/aws//modules/managed-ad"
  version = "1.1.7"

  ds_managed_ad_directory_name = "gladysproj.name.ng"
  ds_managed_ad_short_name     = "gladysproj"
  ds_managed_ad_edition        = "Standard"
  ds_managed_ad_vpc_id         = aws_vpc.AD-vpc1.id
  ds_managed_ad_subnet_ids     = [element(var.pubsubnets, 0), element(var.privsubnets, 0)]
}