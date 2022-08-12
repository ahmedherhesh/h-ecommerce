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
    function spatie($class, $request_key, $msg_if_used, $msg_if_success)
    {
        $data = $class::all()->pluck('name')->toArray();
        if (in_array($request_key, $data))
            return response()->json($msg_if_used, 400);
        $create = $class::create(['name' => $request_key]);
        return $this->response($create, $msg_if_success);
    }

    function createRole(Request $request)
    {
        return $this->spatie(
            Role::class,
            $request->name,
            "Role's name already used",
            'Role has been created successfully'
        );
    }
    function getRoles()
    {
        $roles = Role::all(['id','name']);
        return $this->response($roles, RolesResource::collection($roles));
    }

    function createPermission(Request $request)
    {
        return $this->spatie(
            Permission::class,
            $request->name,
            "Permission's name already used",
            'Permission has been created successfully'
        );
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
