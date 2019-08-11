<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return response("Servidor online!");
});

$router->group(['middleware' => 'api_key'], function($router){
    $router->post('auth/login','AuthController@loginPortal');
    $router->post('admin/auth/login','AuthController@loginAdmin');
    $router->post('auth/refresh','AuthController@refresh');
    $router->post('auth/logout','AuthController@logout');

    $router->get('users','Users\\UsersController@index');
    $router->post('users','Users\\UsersController@store');
    $router->post('users/all','Users\\UsersController@storeAll');
    $router->get('users/{discord_id}','Users\\UsersController@show');
    $router->put('users/{discord_id}','Users\\UsersController@update');
    $router->post('users/wipe','Users\\UsersController@wipe');
    $router->post('users/{discord_id}/levelup','Levelup\\LevelupController@store');
    $router->post('users/{discord_id}/daily', 'Users\\UsersController@daily');
    $router->post('users/{discord_id}/money/add', 'Users\\UsersController@addMoney');
    $router->post('users/{discord_id}/money/reduce', 'Users\\UsersController@reduceMoney');
    $router->post('users/{discord_id}/coupon', 'Users\\UsersController@coupon');
    $router->post('users/{discord_id}/reputation', 'Users\\UsersController@reputation');
    $router->get('users/{discord_id}/products', 'Users\\UsersController@getProducts');
    $router->delete('users/{discord_id}', 'Users\\UsersController@destroy');

    $router->get('ranking','Levelup\\RankingController@index');

    $router->get('tips/english','Tips\\EnglishController@index');
    $router->get('tips/english/get','Tips\\EnglishController@getTip');
    $router->post('tips/english','Tips\\EnglishController@store');
    $router->delete('tips/english/{id}','Tips\\EnglishController@destroy');

    $router->get('tips/development','Tips\\DevelopmentController@index');
    $router->post('tips/development','Tips\\DevelopmentController@store');
    $router->delete('tips/development/{id}','Tips\\DevelopmentController@destroy');

    $router->get('languages','Helpers\\LanguageController@index');
    $router->get('languages/{id}','Helpers\\LanguageController@show');

    $router->get('bans','Helpers\\BanController@index');
    $router->post('bans','Helpers\\BanController@store');
    $router->put('bans/{id}/revoke','Helpers\\BanController@update');

    $router->post('coupons', 'Coupon\\CouponController@store');

    $router->get('categories', 'Category\\CategoryController@index');
    $router->post('categories', 'Category\\CategoryController@store');
    $router->get('categories/{id}', 'Category\\CategoryController@show');
    $router->put('categories/{id}', 'Category\\CategoryController@update');
    $router->delete('categories/{id}', 'Category\\CategoryController@destroy');

    $router->get('products', 'Category\\Product\\ProductController@index');
    $router->post('products', 'Category\\Product\\ProductController@store');
    $router->get('products/{id}', 'Category\\Product\\ProductController@show');
    $router->put('products/{id}', 'Category\\Product\\ProductController@update');
    $router->delete('products/{id}', 'Category\\Product\\ProductController@destroy');

    $router->post('store/{productId}', 'Store\\StoreController@store');
});