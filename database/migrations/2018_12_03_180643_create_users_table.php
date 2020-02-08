<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->increments('id');
            $table->string('discord_id')->unique();
            $table->string('name')->nullable();
            $table->string('nickname')->nullable();
            $table->string('git')->nullable();
            $table->text('about')->nullable();
            $table->string('language')->default("pt_BR");
            $table->integer('level')->default(1);
            $table->integer('current_exp')->default(0);
            $table->decimal('money',8,2)->default(0);
            $table->timestamp('daily')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
