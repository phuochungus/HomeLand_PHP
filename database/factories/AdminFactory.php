<?php

namespace Database\Factories;

use App\Models\Admin;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Admin>
 */
class AdminFactory extends Factory
{
    protected $model = Admin::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'id' => 'ADM' . Carbon::now()->timestamp * 1000,
            'created_at' => Carbon::now(),
            'profileName' => fake()->name(),
            'profileDate_of_birth' => fake()->date(),
            'profileGender' => 'male',
            'profileFront_identify_card_photo_url' => fake()->imageUrl(900, 600, 'draw'),
            'profileBack_identify_card_photo_url' => fake()->imageUrl(900, 600, 'draw'),
            'profilePhone_number' => fake()->phoneNumber(),
        ];
    }
}
