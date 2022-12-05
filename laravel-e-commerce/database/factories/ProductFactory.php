<?php

namespace Database\Factories;

use App\Models\Brand;
use App\Models\Category;
use App\Models\Product;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class ProductFactory extends Factory
{
    protected $model = Product::class;
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        $users_id = User::role('seller')->get(['id']);
        $categories_id = Category::all(['id']);
        $brands_id = Brand::all(['id']);
        return [
            'user_id' => $users_id[rand(0, count($users_id) - 1)],
            'category_id' => $categories_id[rand(0, count($categories_id) - 1)],
            'brand_id' => $brands_id[rand(0, count($brands_id) - 1)],
            'title' => $this->faker->unique()->text(17),
            'keyword' => str_replace(' ', '-', $this->faker->unique()->text(17)),
            'description' => $this->faker->text(100),
            'price' => rand(100, 900),
            'currency' => 'USD',
            'stock' => rand(1, 30),
        ];
    }
}
