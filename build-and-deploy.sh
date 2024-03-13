mvn clean package

lambroll deploy \
--src="./target/app.jar" \
--publish \
--alias="current"

while true
do
  STATE=$(aws lambda get-function --function-name lambroll-sample --qualifier current --query "Configuration.State" --output text)
  echo "STATE = $STATE"
  if [ "$STATE" = "Active" ]; then
    echo "Lambda関数のデプロイが完了しました。"
    break
  fi
  sleep 10
done
