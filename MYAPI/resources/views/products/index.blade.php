<h1>List product</h1>


<h1>La liste</h1>
<table>
	<thead>
		<tr>
		<th>Name</th>
		<th>Description</th>
		<th>Price</th>
		</tr>
	</thead>
<tbody>
  @foreach($products as $product)
   <tr>
   	   <td>{{$product->name}}</td>
   	   <td>{{$product->description}}</td>
   	   <td>{{$product->price}}</td>
   	   <td><a href="/products/{{$product->id}}/edit">edit</a></td>
   </tr>
  @endforeach
</tbody>
<a href="/products/create">create</a>
</table>