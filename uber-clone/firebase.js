import { initializeApp, getApps } from "firebase/app";
import { GoogleAuthProvider, getAuth } from 'firebase/auth'

// Firebase configuration
const firebaseConfig = {
    apiKey: process.env.NEXT_PUBLIC_FIREBASE_API_KEY,
    authDomain: process.env.NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN,
    projectId: process.env.NEXT_PUBLIC_FIREBASE_PROJECT_ID,
    storageBucket: process.env.NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET,
    messagingSenderId: process.env.NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID,
    appId: process.env.NEXT_PUBLIC_FIREBASE_APP_ID,
    measurementId: process.env.NEXT_PUBLIC_FIREBASE_MEASUREMENT_ID
};

// Validate Firebase configuration
const validateConfig = () => {
    const requiredFields = [
        'apiKey',
        'authDomain',
        'projectId',
        'storageBucket',
        'messagingSenderId',
        'appId'
    ];

    const missingFields = requiredFields.filter(field => !firebaseConfig[field]);
    
    if (missingFields.length > 0) {
        console.error('Missing Firebase configuration fields:', missingFields);
        return false;
    }
    return true;
};

// Initialize Firebase
let app;
let auth;
let googleProvider;

try {
    if (!validateConfig()) {
        throw new Error('Invalid Firebase configuration');
    }

    // Initialize Firebase only if it hasn't been initialized
    if (!getApps().length) {
        app = initializeApp(firebaseConfig);
    } else {
        app = getApps()[0];
    }

    // Initialize Auth
    auth = getAuth(app);
    googleProvider = new GoogleAuthProvider();

    // Configure Google Auth Provider
    googleProvider.setCustomParameters({
        prompt: 'select_account'
    });

    // Add scopes
    googleProvider.addScope('profile');
    googleProvider.addScope('email');

} catch (error) {
    console.error('Firebase initialization error:', error);
    throw error;
}

export { app, auth, googleProvider };