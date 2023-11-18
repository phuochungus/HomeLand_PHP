    <?php

use App\Http\Controllers\BuildingController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

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
Route::post('building',[BuildingController::class, 'store']);
Route::patch('building/{id}',[BuildingController::class, 'update']);
Route::delete('building/{id}',[BuildingController::class, 'delete']);
Route::get('building/search',[BuildingController::class, 'search']);
Route::get('building',[BuildingController::class, 'index']);
Route::get('building/{id}',[BuildingController::class, 'getById']);


