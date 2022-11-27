<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;

class MasterAPIController extends Controller
{
    public $user = '';
    public $errors = [];

    public function __construct()
    {
        $this->user = auth('sanctum')->user();
    }

    public function response($condition = null, $data = null, $error_message = 'Failed Request', $failed_status = 403)
    {
        if (!empty($condition))
            return response()->json($data, 200);
        return response()->json($error_message, $failed_status);
    }

    function validate_add($request ,$key, $item)
    {
        global $errors;
        if (!isset($request[$key]) || empty(trim($request[$key]))) {
            if ($item == 'required') {
                $errors[$key][] =  'the ' . $key . ' field is required';
            }
        } else {
            if (substr($item, 0, 3) == 'max') {
                $value = substr($item, 4);
                if (strlen($request[$key]) > $value) {
                    $errors[$key][] =  'the ' . $key . ' field is max length ' . $value;
                }
            }
            if (substr($item, 0, 3) == 'min') {
                $value = substr($item, 4);
                if (strlen($request[$key]) < $value) {
                    $errors[$key][] =  'the ' . $key . ' field is min length ' . $value;
                }
            }
            if ($item == 'string') {
                if (gettype($request[$key]) !== $item) {
                    $errors[$key][] =  'the ' . $key . ' field  must be a string';
                }
            }
            if ($item == 'integer' || $item == 'int') {
                if (gettype($request[$key]) !== 'integer') {
                    $errors[$key][] =  'the ' . $key . ' field  must be an integer';
                }
            }
            if ($item == 'array') {
                if (gettype($request[$key]) !== $item) {
                    $errors[$key][] =  'the ' . $key . ' field  must be a array';
                }
            }
        }
    }
    function validator($request,$array = [])
    {
        global $errors;
        foreach ($array as $key => $arr) {
            foreach (explode('|', $arr) as $item) {
                $this->validate_add($request,$key, $item);
            }
        }
        return $errors;
    }
}
