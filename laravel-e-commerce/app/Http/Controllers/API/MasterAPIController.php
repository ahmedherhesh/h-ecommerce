<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;

class MasterAPIController extends Controller
{
    public $user = '';

    public function __construct()
    {
        $this->user = auth('sanctum')->user();
    }

    public function response($condition = null, $data = null, $error_message = 'Failed Request',$failed_status = 403)
    {
        if (!empty($condition))
            return response()->json($data, 200);
        return response()->json($error_message, $failed_status);
    }
}
