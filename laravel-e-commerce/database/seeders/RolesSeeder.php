<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class RolesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $roles_and_permissions = [
            'super-admin' => ['all'],
            'admin' => [
                'user-crud',
                'product-crud',
                'ads-crud',
            ],
            'seller' => [
                'receive-order',
                'edit-order-status',
                'product-crud',
            ],
            'customer' => [
                'buy',
                'cart',
                'favourite'
            ],
        ];

        foreach ($roles_and_permissions as $role => $permissions) {
            $role = Role::create(['name' => $role]);
            foreach ($permissions as $permission) {
                $permission = Permission::findOrCreate($permission);
                $role->givePermissionTo($permission);
                $permission->assignRole($role);
            }
        }
        $user = User::find(1);
        $user->assignRole('super-admin');
    }
}
