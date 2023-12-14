    <?php

    use App\Http\Controllers\BuildingController;
    use Illuminate\Http\Request;
    use Illuminate\Support\Facades\Route;
    use App\Http\Controllers\AuthController;
    use Illuminate\Support\Facades\DB;
    use Illuminate\Support\Facades\Mail;

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
    Route::post('building', [BuildingController::class, 'store']);
    Route::patch('building/{id}', [BuildingController::class, 'update']);
    Route::delete('building/{id}', [BuildingController::class, 'delete']);
    Route::get('building/search', [BuildingController::class, 'search']);
    Route::get('building', [BuildingController::class, 'index']);
    Route::get('building/{id}', [BuildingController::class, 'getById']);


    use App\Mail\MailableName;


    //Thêm vào file .env
    // MAIL_DRIVER=smtp
    // MAIL_HOST=smtp.gmail.com
    // MAIL_PORT=465
    // MAIL_USERNAME=21520252@gm.uit.edu.vn
    // MAIL_PASSWORD=Nhap password cua mail hoac app password tu 
    // https://knowledge.workspace.google.com/kb/how-to-generate-an-app-passwords-000009237?hl=vi
    // MAIL_ENCRYPTION=ssl
    // MAIL_FROM_NAME=Newsletter

    Route::get('sendmail/{mail}', function (string $mail) {
        Mail::to($mail)->send(new MailableName());
        return 'Mail sent successfully';
    });
