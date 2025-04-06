<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});


Route::get('/get-problems', function(Request $request){
    $issues = DB::table('issues')->where('compiled_issues_id',null)->get();
    return response()->json($issues);
});
// ->middleware();

Route::get('/report', function(Request $request){
    $issues = DB::table('issues')->where('compiled_issues_id','!=',null)->get();
    return response()->json($issues);
});

Route::post('/register', function(Request $request) {
    $request->validate([
        'name' => 'required',
        'email' => 'required|email|unique:users,email',
        'password' => 'required|min:6',
    ]);

    $userId = DB::table('users')->insertGetId([
        'name' => $request->name,
        'email' => $request->email,
        'password' => Hash::make($request->password),
        'created_at' => now(),
        'updated_at' => now(),
    ]);

    return response()->json([
        'message' => 'User registered successfully',
        'user_id' => $userId,
        'email' => $request->email,
    ]);
});

Route::post('/login', function(Request $request) {
    $request->validate([
        'email' => 'required|email',
        'password' => 'required',
    ]);

    $user = DB::table('users')->where('email', $request->email)->first();

    if (!$user || !Hash::check($request->password, $user->password)) {
        return response()->json(['message' => 'Invalid credentials'], 401);
    }

    return response()->json([
        'message' => 'Login successful',
        'user' => [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
        ]
    ]);
});

