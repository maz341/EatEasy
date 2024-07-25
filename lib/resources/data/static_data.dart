import 'package:eat_easy/models/models.dart';

List colors = [
  '0xFFF6625E',
  '0xFF836DB8',
  '0xFFDECB9C',
];

List<Promotion> promotionFoodList = [
  Promotion(
    name: "Mighty Burger",
    label: "Limited Time",
    discountUpto: "upto 20% off",
    imageUrl:
        'https://www.chicken.ca/wp-content/uploads/2013/05/Moist-Chicken-Burgers-1180x580.jpg',
  ),
  Promotion(
    name: "White Chicken Lasagna",
    label: "Summer Discounted",
    discountUpto: "upto 10% off",
    imageUrl:
        'https://www.foodandwine.com/thmb/EUA6L1uauu2ykNb-WMb9C8YG9LE=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/201404-xl-easy-chicken-lasagna-33bb0d845642489b8828288b1763c2eb.jpg',
  ),
  Promotion(
    name: "Amazing Pizza",
    label: "Drooling Offer",
    discountUpto: "upto 30% off",
    imageUrl:
        'https://www.foodandwine.com/thmb/Wd4lBRZz3X_8qBr69UOu2m7I2iw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/classic-cheese-pizza-FT-RECIPE0422-31a2c938fc2546c9a07b7011658cfd05.jpg',
  ),
  Promotion(
    name: "Wow Spaghetti",
    label: "Christmas Surprise",
    discountUpto: "upto 25% off",
    imageUrl:
        'https://www.inspiredtaste.net/wp-content/uploads/2023/01/Spaghetti-with-Meat-Sauce-Recipe-Video.jpg',
  ),
  Promotion(
    name: "Uff Biryani",
    label: "Buy 1 get 1",
    discountUpto: "upto 5% off",
    imageUrl:
        'https://i.tribune.com.pk/media/images/1006872-rsz_-1450182904/1006872-rsz_-1450182904.jpg',
  ),
  Promotion(
    name: "More surprises",
    label: "Weekend Discounts",
    discountUpto: "upto 40% off",
    imageUrl:
        'https://gumlet.assettype.com/freepressjournal/2023-07/9901ca18-ed78-4156-9144-f7732ec22c83/Untitled_design.png',
  ),
];

List<Product> foodList = [
  Product(
    id: "3213221",
    title: 'Wow Pizza',
    price: 9,
    isFavourite: false,
    rating: 4.5,
    reviews: reviewsList,
    description: "Lorem ipsum dinor some more description shpuld be here!",
    images: [
      'https://www.foodandwine.com/thmb/Wd4lBRZz3X_8qBr69UOu2m7I2iw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/classic-cheese-pizza-FT-RECIPE0422-31a2c938fc2546c9a07b7011658cfd05.jpg',
      'https://tastesbetterfromscratch.com/wp-content/uploads/2023/06/Pepperoni-Pizza-1.jpg',
      'https://cdn.loveandlemons.com/wp-content/uploads/2023/02/vegetarian-pizza-500x500.jpg',
    ],
    categories: [
      "Pizza",
      "Food",
      "Fast Food",
    ],
  ),
  Product(
    id: "123654",
    title: 'Chicken Spaghetti',
    price: 6,
    isFavourite: false,
    rating: 1.3,
    reviews: reviewsList,
    description: "Lorem ipsum dinor some more description shpuld be here!",
    images: [
      'https://fettysfoodblog.com/wp-content/uploads/2021/06/Quick-And-Easy-Spaghetti-With-Blistered-Cherry-Tomato-Sauce3.jpg',
      'https://www.marionskitchen.com/wp-content/uploads/2022/12/Filipino-Spaghetti-02.jpg',
      'https://www.inspiredtaste.net/wp-content/uploads/2023/01/Spaghetti-with-Meat-Sauce-Recipe-Video.jpg',
      'https://www.indianhealthyrecipes.com/wp-content/uploads/2023/06/chicken-pasta-chicken-spaghetti-500x500.jpg',
      // 'https://www.servingdumplings.com/wp-content/uploads/2023/01/the-best-spicy-spaghetti-bolognese-3-b203c95c-1022x1536.jpg',
    ],
    categories: [
      "Spaghetti",
      "Food",
      "Chinese",
    ],
  ),
  Product(
    id: "333123",
    title: 'Lazeez Biryani',
    price: 18,
    isFavourite: false,
    rating: 4.2,
    reviews: reviewsList,
    description: "Lorem ipsum dinor some more description shpuld be here!",
    images: [
      'https://recipe30.com/wp-content/uploads/2023/03/chicken-Biryani.jpg',
      'https://images.food52.com/7f0yncraWeYUJG_lLbH2ie1xd6g=/2016x1344/d815e816-4664-472e-990b-d880be41499f--chicken-biryani-recipe.jpg',
      'https://www.thedeliciouscrescent.com/wp-content/uploads/2019/04/Chicken-Biryani-Square.jpg',
      'https://i.tribune.com.pk/media/images/1006872-rsz_-1450182904/1006872-rsz_-1450182904.jpg',
    ],
    categories: [
      "Pizza",
      "Food",
      "Fast Food",
    ],
  ),
  Product(
    id: "123123",
    title: 'Mighty Burger',
    price: 38,
    isFavourite: false,
    rating: 3.1,
    reviews: reviewsList,
    description: "Lorem ipsum dinor some more description shpuld be here!",
    images: [
      'https://www.chicken.ca/wp-content/uploads/2013/05/Moist-Chicken-Burgers-1180x580.jpg',
      'https://www.foodandwine.com/thmb/EUA6L1uauu2ykNb-WMb9C8YG9LE=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/201404-xl-easy-chicken-lasagna-33bb0d845642489b8828288b1763c2eb.jpg',
    ],
    categories: [
      "Burger",
      "Food",
      "Fast Food",
    ],
  ),
];

List<Review> reviewsList = [
  Review(
    comment:
        "Best food in town according to mysterious whispers and hidden secrets, the culinary creations at Pau Cafe",
    stars: 4.5,
    reviewerName: "Maaz Kamal",
    when: "12 days ago",
    isRecommend: false,
    reviewerPic:
        'https://i.tribune.com.pk/media/images/1006872-rsz_-1450182904/1006872-rsz_-1450182904.jpg',
  ),
  Review(
    comment: "They cheated me, worst place to eat",
    stars: 1.0,
    reviewerName: "Qasim Khan",
    when: "20 mins ago",
    isRecommend: false,
    reviewerPic:
        'https://motionarray.imgix.net/preview-1011863-1552663291272-high_0004.jpg',
  ),
  Review(
    comment: "The management and the food was amazing damn i am amazed!",
    stars: 4.5,
    reviewerName: "Jennifer Lawrence",
    when: "1 month ago",
    isRecommend: false,
    reviewerPic:
        'https://www.foodandwine.com/thmb/i0PF1kTaLedLZjlVTIAbrdD9Nag=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Best-US-Restaurants-for-Ambiance-Merois-FT-BLOG0423-072da39cb8104eb8b07d1f49c42f1dce.jpg',
  ),
];
