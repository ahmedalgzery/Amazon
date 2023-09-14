# Amazon

A full-stack Amazon with an included admin panel for managing products and orders.

## Demo

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/PgPUhr51UOA/0.jpg)](https://youtu.be/PgPUhr51UOA)

## Features

### User App

- Email & Password Authentication
- Persistent Authentication State
- Product Search
- Product Filtering by Category
- Product Details Display
- Rating and Reviews
- Deal of the Day
- Shopping Cart Functionality
- Secure Checkout with Google/Apple Pay
- Order History
- Order Details and Status Tracking
- Sign Out Functionality

### Admin Panel

- Manage Products
  - View All Products
  - Add New Products
  - Delete Products
- Manage Orders
  - View All Orders
  - Change Order Status
- Sales Analytics
  - View Total Earnings
  - Visualize Category-Based Earnings using Graphs

## Running the App Locally

After cloning this repository, navigate to the `Amazon` folder and follow these steps:

1. **Set Up MongoDB**:
   - Create a MongoDB Project and Cluster.
   - Obtain the MongoDB URI and replace it in the `server/index.js` file.

2. **Configure IP Address and Cloudinary**:
   - Replace `<yourip>` with your IP address in `lib/constants/global_variables.dart`.
   - Create a Cloudinary Project and enable unsigned operations in settings.
   - Replace `<yourCloudName>` and `<yourUploadPreset>` with your Cloudinary Cloud Name and Upload Preset respectively in `lib/features/admin/services/admin_services.dart`.

3. **Running the Server**:

   ```bash
   cd server
   npm install
   npm run dev # For continuous development
   # OR
   npm start  # To run the script once
   ```

4. **Running the Client**:

      ```bash
      flutter pub get
      flutter run
      ```

## [Dowenload Apk](https://drive.google.com/file/d/1QNvUsMniKg2qWDKdpnh254VprFNNgSWi/view?usp=drive_link)

## Feedback

If you have any feedback, please reach out to me at <algzeryahmed14@gmail.com>
