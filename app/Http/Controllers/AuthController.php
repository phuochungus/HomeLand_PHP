<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Account;



class AuthController extends Controller
{
    public function signin(Request $request)
    {
        return response()->json(['message' => 'signin successfuly'], 200);
    }

    public function signup(Request $request)
    {
        return response()->json(['message' => 'signup successfuly'], 200);
    }
}
