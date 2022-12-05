<?php

namespace Database\Seeders;

use App\Models\Image;
use App\Models\Product;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Product::truncate();
        Product::factory()->times(10)->create()->each(function ($product) {
            $product_imgs_dir = public_path("/uploads/product");
            $product_imgs_dir_id = public_path("/uploads/product/$product->id");

            if (!file_exists($product_imgs_dir))
                mkdir($product_imgs_dir);
            if (!file_exists($product_imgs_dir_id))
                mkdir("$product_imgs_dir/$product->id");

            $images = scandir(public_path('assets/product-imgs'));

            $image = public_path("assets/product-imgs/" . $images[rand(2, count($images) - 1)]);
            $imageName =  time() . rand(1000, 9999) . '.' . explode('.', $image)[1]; //extention
            copy($image, "$product_imgs_dir_id/$imageName");

            Image::insert([
                'type' => 'product',
                'model_id' => $product->id,
                'images' => json_encode([$imageName])
            ]);
        });
    }
}
