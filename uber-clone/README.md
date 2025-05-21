# 🚕 Uber Clone Application

A modern ride-sharing application built with Next.js, Firebase, and PostgreSQL, featuring real-time location tracking, ride booking, and payment integration.

## 🚀 Features

- 🔐 User authentication with Firebase
- 📍 Real-time location tracking with Mapbox
- 💳 Secure payment processing
- 🚗 Ride booking and tracking
- 📱 Responsive design
- 🔄 Real-time updates
- 📊 Ride history and analytics

## 🛠️ Tech Stack

- **Frontend**: Next.js, React, TailwindCSS
- **Backend**: Next.js API Routes
- **Database**: PostgreSQL (AWS RDS)
- **Authentication**: Firebase Auth
- **Maps**: Mapbox GL
- **Deployment**: AWS ECS, Docker
- **CI/CD**: GitHub Actions

## 📋 Prerequisites

- Node.js >= 18.0.0
- npm >= 9.0.0
- Docker (for containerization)
- PostgreSQL (for local development)
- Firebase account
- Mapbox account
- AWS account (for deployment)

## 🚀 Getting Started

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd uber-clone
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables**
   ```bash
   cp .env.example .env
   ```
   Update the `.env` file with your configuration:
   - Firebase credentials
   - Database connection details
   - Mapbox access token
   - JWT and cookie secrets

4. **Start development server**
   ```bash
   npm run dev
   ```
   Open [http://localhost:3000](http://localhost:3000)

## 🐳 Docker Development

1. **Build the image**
   ```bash
   docker build -t uber-clone:dev .
   ```

2. **Run the container**
   ```bash
   docker run -p 3000:3000 --env-file .env uber-clone:dev
   ```

## 🚀 Deployment

### AWS ECS Deployment

1. **Build and push Docker image**
   ```bash
   docker build -t uber-clone:latest .
   docker tag uber-clone:latest <aws-account>.dkr.ecr.<region>.amazonaws.com/uber-clone:latest
   docker push <aws-account>.dkr.ecr.<region>.amazonaws.com/uber-clone:latest
   ```

2. **Update ECS service**
   ```bash
   aws ecs update-service --cluster uber-clone-cluster --service uber-clone-service --force-new-deployment
   ```

### CI/CD Pipeline

The project uses GitHub Actions for CI/CD. The pipeline includes:
- Automated testing
- Linting
- Type checking
- Docker image building
- ECS deployment
- Health checks

## 🧪 Testing

```bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Generate coverage report
npm run test:coverage
```

## 🔍 Health Checks

The application includes a health check endpoint at `/api/health` that monitors:
- Database connectivity
- System resources
- Application uptime
- Memory usage

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Issues**
   - Verify database credentials in `.env`
   - Check if RDS instance is running
   - Ensure security groups allow access

2. **Firebase Authentication Issues**
   - Verify Firebase configuration
   - Check if Firebase project is active
   - Ensure correct API keys

3. **Mapbox Integration Issues**
   - Verify Mapbox access token
   - Check if token has correct permissions
   - Ensure proper initialization

4. **Docker Issues**
   - Clear Docker cache: `docker system prune`
   - Rebuild image: `docker build --no-cache`
   - Check container logs: `docker logs <container-id>`

### Logs

- **Application Logs**: Check CloudWatch Logs in AWS Console
- **Container Logs**: `docker logs <container-id>`
- **Build Logs**: GitHub Actions workflow runs

## 🔒 Security

- Environment variables for sensitive data
- JWT for API authentication
- Secure cookie handling
- HTTPS enforcement
- CORS configuration
- Rate limiting
- Input validation

## 📈 Monitoring

- AWS CloudWatch for metrics
- Application health checks
- Error tracking
- Performance monitoring
- Resource utilization

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

MIT License - see LICENSE file for details

## 🙋‍♂️ Support

For support, please:
1. Check the troubleshooting guide
2. Search existing issues
3. Create a new issue with:
   - Detailed description
   - Steps to reproduce
   - Expected vs actual behavior
   - Environment details
