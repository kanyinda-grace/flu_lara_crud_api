<h1>Create Product</h1>


<form action="/products" method="post">
	@csrf
	name : <input type="text" name="name"><br>
  description :	<input type="text" name="description"><br>
	price : <input type="number" name="price"><br>
	image: <input type="text" name="image_url"><br>

	<input type="submit" value="save">
</form>