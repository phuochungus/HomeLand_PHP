<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Account;
use Firebase\JWT\JWT;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function __invoke(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $account = Account::where('email', $request->email)->first();
        if (!$account) {
            return response()->json([
                'message' => 'Account not found'
            ], 404);
        }

        if (!Hash::check($request->password, $account->password)) {
            return response()->json([
                'message' => 'Wrong password'
            ], 401);
        }

        $role = "";
        if ($account->admin) {
            $role = "admin";
        } else if ($account->resident) {
            $role = "resident";
        } else if ($account->manager) {
            $role = "manager";
        } else if ($account->technician) {
            $role = "technician";
        }

        $customPayload = [
            'user_id' => $account->owner_id,
            "role" => $role,
        ];

        $token = JWT::encode($customPayload, env('JWT_SECRET'), 'HS256');

        return response()->json([
            'token' => $token,
            'role' => $role,
        ], 200);
    }
}
