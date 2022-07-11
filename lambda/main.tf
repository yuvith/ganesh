resource "aws_lambda_function" "terraform_lambda_func" {
filename                       = "${path.module}/python/python.zip"
function_name                  = "mention_Lambda_Function"
role                           = aws_iam_role.lambda_role.arn
handler                        = "index.lambda_handler"
runtime                        = "python3.8" //mention runtime
depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}




// mention this in lambda resurce for vpc and subnet attachment
 // vpc_config {
  //  subnet_ids         = [aws_subnet.subnet_private.id]
   // security_group_ids = [aws_default_security_group.default_security_group.id]
  //}


// add the below if you face access issues when you mention vpc and subnet

//resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_lambda_vpc_access_execution" {
  //role       = aws_iam_role.iam_role.name
  //policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
//}