resource "aws_iam_role" "lambroll_sample" {
  name = "lambroll-sample-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambroll_sample" {
  role       = aws_iam_role.lambroll_sample.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "lambroll_sample" {
  function_name    = "lambroll-sample"
  role             = aws_iam_role.lambroll_sample.arn
  runtime          = "java21"
  memory_size      = 256
  package_type     = "Zip"
  handler          = "com.example.SampleFunction"
  filename         = "target/app.jar"
  source_code_hash = base64sha256("target/app.jar")
  publish = true

  snap_start {
    apply_on = "PublishedVersions"
  }

  environment {
    variables = {
      MESSAGE = "Hello!"
    }
  }
}

resource "aws_lambda_alias" "lambroll_sample" {
  function_name    = aws_lambda_function.lambroll_sample.function_name
  function_version = aws_lambda_function.lambroll_sample.version
  name             = "current" # 現在のlambrollはエイリアス名として「current」のみサポートしている
}
