const fs = require('fs');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../config/.env') });

const requiredEnvVars = {
  // Environment
  NODE_ENV: 'string',
  
  // Database
  DB_HOST: 'string',
  DB_PORT: 'number',
  DB_USERNAME: 'string',
  DB_PASSWORD: 'string',
  DB_NAME: 'string',
  
  // Firebase
  NEXT_PUBLIC_FIREBASE_API_KEY: 'string',
  NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN: 'string',
  NEXT_PUBLIC_FIREBASE_PROJECT_ID: 'string',
  NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET: 'string',
  NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID: 'string',
  NEXT_PUBLIC_FIREBASE_APP_ID: 'string',
  NEXT_PUBLIC_FIREBASE_MEASUREMENT_ID: 'string',
  
  // Mapbox
  NEXT_PUBLIC_MAPBOX_ACCESS_TOKEN: 'string',
  
  // Application
  NEXT_PUBLIC_APP_URL: 'string',
  NEXT_PUBLIC_API_URL: 'string',
  
  // Security
  JWT_SECRET: 'string',
  COOKIE_SECRET: 'string',
  
  // AWS
  AWS_REGION: 'string',
  AWS_ACCESS_KEY_ID: 'string',
  AWS_SECRET_ACCESS_KEY: 'string',
  
  // Monitoring
  ENABLE_METRICS: 'boolean',
  METRICS_PORT: 'number'
};

function validateEnvVar(name, type) {
  const value = process.env[name];
  
  if (value === undefined) {
    throw new Error(`Missing required environment variable: ${name}`);
  }
  
  switch (type) {
    case 'string':
      if (typeof value !== 'string' || value.trim() === '') {
        throw new Error(`Invalid string value for environment variable: ${name}`);
      }
      break;
      
    case 'number':
      const num = Number(value);
      if (isNaN(num)) {
        throw new Error(`Invalid number value for environment variable: ${name}`);
      }
      break;
      
    case 'boolean':
      if (!['true', 'false', '0', '1'].includes(value.toLowerCase())) {
        throw new Error(`Invalid boolean value for environment variable: ${name}`);
      }
      break;
  }
}

function validateUrls() {
  const urls = [
    process.env.NEXT_PUBLIC_APP_URL,
    process.env.NEXT_PUBLIC_API_URL
  ];
  
  for (const url of urls) {
    try {
      new URL(url);
    } catch (err) {
      throw new Error(`Invalid URL format: ${url}`);
    }
  }
}

function validateSecrets() {
  // Skip secret validation in development environment
  if (process.env.NODE_ENV === 'development') {
    return;
  }

  const secrets = [
    process.env.JWT_SECRET,
    process.env.COOKIE_SECRET,
    process.env.DB_PASSWORD,
    process.env.AWS_SECRET_ACCESS_KEY
  ];
  
  for (const secret of secrets) {
    if (secret.length < 32) {
      throw new Error('Secret keys must be at least 32 characters long');
    }
  }
}

function main() {
  try {
    // Validate all required environment variables
    for (const [name, type] of Object.entries(requiredEnvVars)) {
      validateEnvVar(name, type);
    }
    
    // Validate URLs
    validateUrls();
    
    // Validate secrets
    validateSecrets();
    
    console.log('✅ All environment variables are valid');
    process.exit(0);
  } catch (error) {
    console.error('❌ Environment validation failed:', error.message);
    process.exit(1);
  }
}

main(); 