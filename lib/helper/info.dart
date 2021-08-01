import 'package:insidescoop/section/category_section.dart';
import 'package:firebase_performance/firebase_performance.dart';

List<CategorySection> getcategories() {

  List<CategorySection> category = new List<CategorySection>();
  CategorySection categorySection = new CategorySection();

  categorySection.categoryName = "General";
  categorySection.imageUrl =
  "https://images.unsplash.com/photo-1611915792063-2bddd2ad5568?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bWFuJTIwcmVhZGluZyUyMG5ld3NwYXBlcnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  category.add(categorySection);

  categorySection = new CategorySection();
  categorySection.categoryName = "Entertainment";
  categorySection = new CategorySection();
  categorySection.categoryName = "Business" ;
  categorySection.imageUrl =
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqqRyaJ3YY0QqMcZWHdSiFk-AFjXvHPu6oow&usqp=CAU&auto=format&fit=crop&w=1502&q=80";
  category.add(categorySection);

  categorySection = new CategorySection();
  categorySection.categoryName = "Health";
  categorySection.imageUrl =
  "https://images.unsplash.com/photo-1535914254981-b5012eebbd15?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzR8fGhlYWx0aHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  category.add(categorySection);

  categorySection = new CategorySection();
  categorySection.categoryName = "Sports";
  categorySection.imageUrl =
  "https://mongooseagency.com/files/3415/9620/1413/Return_of_Sports.jpg";
  category.add(categorySection);

  categorySection = new CategorySection();
  categorySection.categoryName = "Technology";
  categorySection.imageUrl =
  "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80";
  category.add(categorySection);


  categorySection = new CategorySection();
  categorySection.categoryName = "Science";
  categorySection.imageUrl =
  "https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80";
  category.add(categorySection);


  return category;
}
