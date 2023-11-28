<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use Illuminate\Support\Facades\DB;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


Route::post('/signin', AuthController::class);

Route::delete('seed/DB', function () {
    db::statement('DROP SCHEMA public CASCADE');
    db::statement('CREATE SCHEMA public');
    return 'All tables dropped successfully!';
});

Route::post('seed/DB', function () {
    try {

        $filePath = storage_path('../database/schema/pgsql-schema.sql');
        $sqlStatements = file_get_contents($filePath);
        DB::unprepared($sqlStatements);

        return 'Migrations executed successfully';
    } catch (\Exception $e) {
        return 'Error: ' . $e->getMessage();
    }
});
