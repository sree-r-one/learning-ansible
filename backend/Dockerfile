# 🐳 Use official Node image
FROM node:18

# 📁 Set working directory
WORKDIR /app

# 📦 Copy package files first (for layer caching)
COPY package*.json ./

# 📥 Install dependencies
RUN npm install

# 📂 Copy the rest of the code
COPY . .

# 🌍 Expose the port your app runs on
EXPOSE 3000

# 🚀 Run the app
CMD ["npm", "start"]
