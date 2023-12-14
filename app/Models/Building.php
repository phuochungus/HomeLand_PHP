<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Building extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $table = 'building';
    public $incrementing = false;
    protected $primaryKey = 'building_id';
    protected $fillable = [
        "building_id",
        "name",
        "max_floor",
        "address",
    ];

}

