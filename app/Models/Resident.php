<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Resident extends Model
{
    use HasFactory;

    protected $table = 'resident';

    protected $keyType = 'string';
    public $timestamps = false;

    public function account()
    {
        return $this->belongsTo(Account::class, "accountOwnerId");
    }
}
