import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/my_drawer.dart';
import 'package:flutter_application_1/components/my_product_tile.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/models/shop.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  // remove item from cart method
  void removeItemFromCart (BuildContext context, Product product){
    // dialog box for user to confirm remove from cart 
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        content: Text("Remove this item from your cart"),
        actions: [
          //cancel button
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),

          //yes button
          MaterialButton(
            onPressed: () {
              // pop dialog box
              Navigator.pop(context);

              // remove from cart
              context.read<Shop>().removeFromCart(product);
            },
            child: Text("Yes"),
          )
        ],
      )
      );
  }

  void payButtonPressed (BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) => const AlertDialog(
        content: 
        Text("User wants to pay! Connect your app to backend"),
      )
      );
  }

  @override
  Widget build(BuildContext context) {
    // get access to cart
    final cart = context.watch<Shop>().cart;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, 
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Cart Page"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          // cart list
          Expanded(
            child: cart.isEmpty ? 
            Center(child: Text("Your cart is empty.."))
            : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index){
                // get individual item in cart
                final item = cart[index];

                //return cart UI
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.price.toStringAsFixed(2)),
                  trailing: IconButton(
                    onPressed: () => removeItemFromCart(context, item), 
                    icon: Icon(Icons.remove)
                    ),
                );
              }
              ),
            ),
            // pay button
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: MyButton(onTap: () => payButtonPressed(context), child: Text("Pay now")),
            )
        ],
      ),
    );
  }
}