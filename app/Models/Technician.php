<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Technician extends Model
{
    use HasFactory;

    protected $keyType = 'string';

    public function account()
    {
        return $this->belongsTo(Account::class, "accountOwnerId");
    }
}
