<?php

namespace App\Http\Controllers\API\Admin;

use App\Http\Controllers\API\MasterAPIController;
use App\Http\Controllers\Controller;
use App\Http\Resources\API\RolesResource;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RolesController extends MasterAPIController
{
    function spatie($class, $request_key)
    {
        $create = $class::findOrCreate($request_key);
        return $this->response($create, 'success');
    }

    function createRole(Request $request)
    {
        return $this->spatie(Role::class,$request->name);
    }

    function getRoles()
    {
        $roles = Role::all(['id','name']);
        return $this->response($roles, RolesResource::collection($roles));
    }

    function createPermission(Request $request)
    {
        return $this->spatie(Permission::class,$request->name);
    }

    function getPermissions()
    {
        $permissions = Permission::all()->pluck('name');
        return $this->response($permissions, $permissions);
    }

    function givePermissionsToRole(Request $request)
    {
        $role = Role::findByName($request->role_name);
        if(is_array($request->permissions)){
            foreach ($request->permissions as $permission) {
                $permission = permission::findByName($permission);
                $role->givePermissionTo($permission);
                $permission->assignRole($role);
            }
        return response()->json("Permissions was given to $request->role_name role");
        }
    }
}