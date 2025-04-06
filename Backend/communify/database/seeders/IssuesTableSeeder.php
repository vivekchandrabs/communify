<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;

class IssuesTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('issues')->insert([
            [
                'user_id' => 1,
                'latitude' => 37.7749,
                'longitude' => -122.4194,
                'image_path' => '/images/issue1.jpg',
                'compiled_issues_id' => 1001,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
            [
                'user_id' => 2,
                'latitude' => 40.7128,
                'longitude' => -74.0060,
                'image_path' => '/images/issue2.jpg',
                'compiled_issues_id' => null,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
            [
                'user_id' => 3,
                'latitude' => 34.0522,
                'longitude' => -118.2437,
                'image_path' => '/images/issue3.jpg',
                'compiled_issues_id' => 1002,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
            [
                'user_id' => 4,
                'latitude' => 51.5074,
                'longitude' => -0.1278,
                'image_path' => '/images/issue4.jpg',
                'compiled_issues_id' => null,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
            [
                'user_id' => 5,
                'latitude' => 48.8566,
                'longitude' => 2.3522,
                'image_path' => '/images/issue5.jpg',
                'compiled_issues_id' => 1003,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
        ]);
    }
}
