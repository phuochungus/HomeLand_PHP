<?php

namespace App\Http\Controllers;

use App\Models\Building;
use GuzzleHttp\Exception\RequestException;
use Haruncpi\LaravelIdGenerator\IdGenerator;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class BuildingController extends Controller
{
    //
    public function index()
    {
        $buildings = Building::all();
        return response()->json(['buildings' => $buildings, 'status' => 200]);
    }
    public function store(Request $request)
    {
        $validate = Validator::make($request->all(),[
            "name" => ['required'],
            "max_floor" => ['required', 'integer'],
            "address" => ['required'],
        ]);
        if($validate->fails()) {
            return response()->json($validate->messages(), 400);
        }
        else {
            $id = IdGenerator::generate(['table' => 'building','field' => 'building_id','length' => 6, 'prefix' => 'BD']);
            $building = Building::create(
                [   
                    'building_id' => $id,
                    'name' => $request->name,
                    'max_floor' => $request->max_floor,
                    'address' => $request->address,
                ]
            );
            if($building) {
                return response()->json(['status'=> 200, 'message' => 'create building successfully', 'building' => $building]);

            }
        }



    }
    public function getById(Request $request) {
        $id = $request->route('id');
        $building = Building::findOrFail($id);
        if($building) {
            return response()->json(['status'=> 200, 'building' => $building]);
        }
        else return response()->json(['status'=> 400, 'message' => 'not found building']);
    }
    public function update(Request $request) {
        $validate = Validator::make($request->all(),[
            "name" => ['required'],
            "max_floor" => ['required', 'integer'],
            "address" => ['required'],
        ]);
        if($validate->fails()) {
            return response()->json($validate->messages(), 400);
        }
        else {
            $id = $request->route('id');
            $building = Building::find($id);
            $building->update($request->all());
            if($building) {
                return response()->json(['status'=> 200, 'message' => 'update building successfully', 'building' => $building]);
            }
        }
    }
    public function delete(Request $request) {
        $id = $request->route('id');
        $data = Building::find($id)->delete();
        if($data) {
            return response()->json(['status'=> 200, 'message' => 'delete building successfully']);
        }

    }
    public function search(Request $request) {

        $query = $request->query('query');
        $data = Building::where('name', 'LIKE', '%'.$query.'%')->get();
        if($data) { 
            return response()->json(['status'=> 200, 'data'=> $data]);
        }

    }
}
