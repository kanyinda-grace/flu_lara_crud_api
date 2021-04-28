<?php

namespace App\Http\Controllers;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function index(){
    	$products = Product::all();
    	//dd($products);
    	
    	return view('products.index' , compact(['products']));
    }
    public function create(){
    	$products = Product::all();
    	//dd($products);
    	
    	return view('products.create');
    
}

public function store(Request $request){
    Product::create($request->all());
    return redirect('/products');
}
public function edit($id){
     $products = Product::find($id);
   
    return view('products.edit', compact(['products']));
}
public function update(Request $request ,$id){
    $product = Product::find($id);
    $product->update($request->all());
    return redirect('/products');
}
}