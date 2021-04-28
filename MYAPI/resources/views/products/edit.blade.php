<h1>edit Product</h1>


<form action="/products/{{$products->id}}" method="post">
	@method('PUT')
	@csrf
	name : <input type="text" name="name" value="{{$products->name}}"><br>
    description :	<input type="text" name="description" value="{{$products->description}}"><br>
	price : <input type="number" name="price" value="{{$products->price}}"><br>
	image: <input type="text" name="image_url" value="{{$products->image_url}}"><br>

	<input type="submit" value="save">
</form>