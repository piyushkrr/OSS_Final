#!/bin/bash
echo "Starting OSS Application..."

# Kill existing java and node processes
killall -9 java node 2>/dev/null

# Start Eureka Server
echo "Starting Eureka Server..."
cd oss-backend/eureka-server
nohup ./mvnw spring-boot:run > ../../eureka.log 2>&1 &
echo "Eureka Server started (PID: $!). Logs in eureka.log"
cd ../..
sleep 15

# Start configuration dependent services
echo "Starting API Gateway..."
cd oss-backend/api-gateway
nohup ./mvnw spring-boot:run > ../../gateway.log 2>&1 &
echo "API Gateway started (PID: $!). Logs in gateway.log"
cd ../..

echo "Starting User Service..."
cd oss-backend/user-service
nohup ./mvnw spring-boot:run > ../../user.log 2>&1 &
echo "User Service started (PID: $!). Logs in user.log"
cd ../..

echo "Starting Product Catalog..."
cd oss-backend/product-catalog
nohup ./mvnw spring-boot:run > ../../product.log 2>&1 &
echo "Product Catalog started (PID: $!). Logs in product.log"
cd ../..

echo "Starting Order Management..."
cd oss-backend/order-management-master
nohup ./mvnw spring-boot:run > ../../order.log 2>&1 &
echo "Order Management started (PID: $!). Logs in order.log"
cd ../..

echo "Starting Payment Service..."
cd oss-backend/payment-processing-service-master
nohup ./mvnw spring-boot:run > ../../payment.log 2>&1 &
echo "Payment Service started (PID: $!). Logs in payment.log"
cd ../..

echo "Starting Cart Service..."
cd oss-backend/cart-service
nohup ./mvnw spring-boot:run > ../../cart.log 2>&1 &
echo "Cart Service started (PID: $!). Logs in cart.log"
cd ../..

echo "Waiting for backend services to initialize..."
sleep 30

# Start Frontend
echo "Starting Frontend..."
cd oss-frontend
nohup npm start > ../frontend.log 2>&1 &
echo "Frontend started (PID: $!). Logs in frontend.log"
cd ..

echo "All services started!"
