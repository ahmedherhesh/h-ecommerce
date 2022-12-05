<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $admin = User::create([
            'name' => 'Ahmed Herhesh',
            'username' => 'admin',
            'email' => 'ahmedherhesh3@gmail.com',
            'phone' => '01152958015',
            'password' => '123123123',
        ]);
        $admin->assignRole('super-admin');
        User::factory()->times(5)->create()->each(function ($user) {
            $user->assignRole('seller');
        });
        User::factory()->times(15)->create()->each(function ($user) {
            $user->assignRole('customer');
        });
    }
}
