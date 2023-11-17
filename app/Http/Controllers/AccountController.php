<?php

namespace App\Http\Controllers;

use App\Models\Account;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log;

class AccountController extends Controller
{
    public function index()
    {
        Log::info("Account index");
        $accounts = Account::all();
        return response()->json($accounts);
    }


    public function store(Request  $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email:rfc,dns',
            'avatar' => 'image',
        ]);


        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        // $account = Account::create($request->all());
        // return response()->json($account, 201);
    }

    public function show($id)
    {
        $account = Account::find($id);
        return response()->json($account);
    }

    public function update(Request $request, $id)
    {
        $account = Account::find($id);
        $account->update($request->all());

        return response()->json($account, 200);
    }

    public function destroy($id)
    {
        Account::softDeleted($id);
        return response()->json(null, 204);
    }
}
