echo "==== VALID ===="
curl -i \
  -H "Content-Type: application/json" \
  -X POST -d '{"name":"cesar", "email":"cesar.gomez@michelada.io"}' \
  http://localhost:9292/test
echo "==============="

echo "==== 400 ===="
curl -i \
  -H "Content-Type: application/html" \
  -X POST -d '{"name":"cesar", "email":"cesar.gomez@michelada.io"}' \
  http://localhost:9292/test
echo "==============="

echo "==== 422 ===="
curl -i \
  -H "Content-Type: application/json" \
  -X POST -d '{"email":"cesar.gomez@michelada.io"}' \
  http://localhost:9292/test
echo "==============="
