<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('compiled_issues', function (Blueprint $table) {
            $table->id();
            $table->float('latitude');
            $table->float('longitude');
            $table->string('title');
            $table->string('description');
            $table->integer('risk_level');
            $table->integer('report_count');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('compiled_issues');
    }
};
