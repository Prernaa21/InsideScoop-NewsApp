import 'package:insidescoop/section/category_section.dart';

List<CategorySection> getcategories() {

  List<CategorySection> category = new List<CategorySection>();
  CategorySection categorySection = new CategorySection();

  categorySection.categoryName = "General";
  category.add(categorySection);

  categorySection = new CategorySection();
  categorySection.categoryName = "Business";
   category.add(categorySection);

  categorySection = new CategorySection();
  categorySection.categoryName = "Entertainment" ;
  category.add(categorySection);

  categorySection = new CategorySection();
  categorySection.categoryName = "Health";
  category.add(categorySection);

  categorySection = new CategorySection();
  categorySection.categoryName = "Sports";
  category.add(categorySection);

  categorySection = new CategorySection();
  categorySection.categoryName = "Technology";
  category.add(categorySection);


  categorySection = new CategorySection();
  categorySection.categoryName = "Science";
  category.add(categorySection);


  return category;
}