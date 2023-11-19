<?php

namespace Database\Seeders;

use App\Models\Account;
use App\Models\Admin;
use App\Models\Manager;
use App\Models\Resident;
use App\Models\Technician;
use Illuminate\Database\Seeder;


class AccountSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        $resident = (Resident::factory()->count(1)->create())[0];
        $resAcc = new Account([
            'owner_id' => $resident->id,
            'email' => 'resident@gmail.com',
            'password' => bcrypt('password'),
            'avatarURL' => fake()->imageUrl(900, 600, 'people'),
        ]);

        $resAcc->save();
        $resAcc->resident()->save($resident);

        $admin = (Admin::factory()->count(1)->create())[0];
        $adminAcc = new Account([
            'owner_id' => $admin->id,
            'email' => 'admin@gmail.com',
            'password' => bcrypt('password'),
            'avatarURL' => fake()->imageUrl(900, 600, 'people'),
        ]);
        $adminAcc->save();
        $adminAcc->admin()->save($admin);

        $technician = (Technician::factory()->count(1)->create())[0];
        $techAcc = new Account([
            'owner_id' => $technician->id,
            'email' => 'technician@gmail.com',
            'password' => bcrypt('password'),
            'avatarURL' => fake()->imageUrl(900, 600, 'people'),
        ]);
        $techAcc->save();
        $techAcc->technician()->save($technician);

        $manager = (Manager::factory()->count(1)->create())[0];
        $managerAcc = new Account([
            'owner_id' => $manager->id,
            'email' => 'manager@gmail.com',
            'password' => bcrypt('password'),
            'avatarURL' => fake()->imageUrl(900, 600, 'people'),
        ]);
        $managerAcc->save();
        $managerAcc->manager()->save($manager);
    }
}
