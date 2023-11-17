<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class Account extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $primaryKey = 'owner_id';
    protected $keyType = 'string';

    protected $dates = ['deleted_at'];

    protected $fillable = [
        'email',
        'password',
        'avatarURL',
        'created_at',
        'activated_at'
    ];

    public function admin()
    {
        return $this->hasOne(Admin::class, "accountOwnerId");
    }

    public function resident()
    {
        return $this->hasOne(Resident::class, "accountOwnerId");
    }

    public function manager()
    {
        return $this->hasOne(Manager::class, "accountOwnerId");
    }

    public function technician()
    {
        return $this->hasOne(Technician::class, "accountOwnerId");
    }
}
