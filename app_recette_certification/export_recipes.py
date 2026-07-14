import json

# Script to export recipes from 'lib/data/data_recipes.dart' to 'togolese_recipes_justin.jsonl' for TogoLM.

def export_recipes(recipes_list, output_file):
    with open(output_file, 'w', encoding='utf-8') as f:
        for recipe in recipes_list:
            data = {
                "source": "rececte_app",
                "category": "culinary",
                "title": recipe['title'],
                "text": recipe['description'],
                "content": f"### Ingrédients\n{chr(10).join(recipe['ingredients'])}\n\n### Instructions\n{recipe['instructions']}",
                "metadata": {
                    "prep_duration": recipe['prepDuration'],
                    "rating": recipe['rating'],
                    "category": recipe['category']
                }
            }
            f.write(json.dumps(data, ensure_ascii=False) + '\n')

# Example usage with extracted data
# recipes = [...] 
# export_recipes(recipes, 'togolese_recipes_justin.jsonl')
