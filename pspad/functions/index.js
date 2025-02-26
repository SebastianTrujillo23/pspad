const functions = require('firebase-functions');
const admin = require('firebase-admin');
const express = require('express');
const stripe = require('stripe')('sk_test_your_stripe_secret_key'); // Usa tu clave secreta de Stripe
const cors = require('cors');

admin.initializeApp();
const db = admin.firestore();

const app = express();
app.use(cors({ origin: true })); // Permite CORS para todas las solicitudes

// Ruta para registrar un usuario
app.post('/register', async (req, res) => {
  const { nombre, edad, gmail, tarjeta_credito, caducidad, cvv } = req.body;

  if (!nombre || !edad || !gmail || !tarjeta_credito || !caducidad || !cvv) {
    return res.status(400).json({ error: 'Faltan campos obligatorios' });
  }

  try {
    const userRef = db.collection('users').doc(gmail);
    await userRef.set({
      nombre,
      edad,
      gmail,
      tarjeta_credito,
      caducidad,
      cvv
    });

    res.status(201).json({ message: 'Usuario registrado correctamente' });
  } catch (error) {
    res.status(500).json({ error: 'Error al registrar el usuario', details: error });
  }
});

// Ruta para crear productos
app.post('/products', async (req, res) => {
  const { nombre, precio } = req.body;

  if (!nombre || !precio) {
    return res.status(400).json({ error: 'Faltan campos obligatorios' });
  }

  try {
    const productRef = await db.collection('products').add({
      nombre,
      precio,
      estado: 'pendiente'
    });

    res.status(201).json({ message: 'Producto creado', productId: productRef.id });
  } catch (error) {
    res.status(500).json({ error: 'Error al crear el producto', details: error });
  }
});

// Ruta para realizar un pago
app.post('/pay', async (req, res) => {
  const { userEmail, productId } = req.body;

  if (!userEmail || !productId) {
    return res.status(400).json({ error: 'Faltan campos obligatorios' });
  }

  try {
    // Obtener el producto y usuario
    const productSnapshot = await db.collection('products').doc(productId).get();
    const userSnapshot = await db.collection('users').doc(userEmail).get();

    if (!productSnapshot.exists) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }

    if (!userSnapshot.exists) {
      return res.status(404).json({ error: 'Usuario no encontrado' });
    }

    const product = productSnapshot.data();
    const user = userSnapshot.data();

    // Crear el pago con Stripe
    const paymentIntent = await stripe.paymentIntents.create({
      amount: product.precio * 100, // En centavos
      currency: 'usd',
      payment_method_types: ['card'],
      description: `Pago por ${product.nombre}`,
    });

    res.status(200).json({
      clientSecret: paymentIntent.client_secret,
      product: product.nombre,
      price: product.precio
    });
  } catch (error) {
    res.status(500).json({ error: 'Error al procesar el pago', details: error });
  }
});

// Escuchar cambios en la colección de productos (listener)
exports.onPaymentSuccess = functions.firestore
  .document('products/{productId}')
  .onUpdate(async (change, context) => {
    const after = change.after.data();

    if (after.estado === 'pagado') {
      try {
        // Actualizar el estado del producto en la base de datos
        await db.collection('products').doc(context.params.productId).update({
          estado: 'pagado'
        });

        // Guardar recibo de pago en el perfil del usuario
        const userEmail = after.userEmail;
        const receipt = {
          productId: context.params.productId,
          amount: after.precio,
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
        };

        const userRef = db.collection('users').doc(userEmail);
        await userRef.collection('receipts').add(receipt);

        console.log('Estado del producto actualizado y recibo guardado en el perfil del usuario');
      } catch (error) {
        console.error('Error al actualizar el estado del producto o guardar el recibo:', error);
      }
    }
  });

// Exportar la aplicación Express para Firebase Functions
exports.api = functions.https.onRequest(app);
