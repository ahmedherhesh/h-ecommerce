<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Brand;
class BrandSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Brand::insert([
            ['name' => 'samsung'],
            ['name' => 'toshiba'],
            ['name' => 'huawei'],
            ['name' => 'oppo'],
            ['name' => 'realme'],
            ['name' => 'xiaomi'],
            ['name' => 'apple'],
            ['name' => 'nokia'],
        ]);
    }
}
