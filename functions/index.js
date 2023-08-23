/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

 //Перейдите в терминале в папку functions и выполните npm install,  затем npm install stripe --save и, собственно, firebase deploy --only functions, чтобы передать в Firebase написанные выше функции.



const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
//TODO: убрать ключ из публичного доступа
const stripe = require("stripe")("INSERT_KEY_HERE");
const functions = require("firebase-functions");

exports.stripePaymentIntentRequest = functions.https.onRequest(async (req, res) => {
    try {
        let customerId;

        //Gets the customer who's email id matches the one sent by the client
        const customerList = await stripe.customers.list({
            email: req.body.email,
            limit: 1
        });

        //Checks the if the customer exists, if not creates a new customer
        if (customerList.data.length !== 0) {
            customerId = customerList.data[0].id;
        }
        else {
            const customer = await stripe.customers.create({
                email: req.body.email
            });
            customerId = customer.data.id;
        }

        //Creates a temporary secret key linked with the customer
        const ephemeralKey = await stripe.ephemeralKeys.create(
            { customer: customerId },
            { apiVersion: '2020-08-27' }
        );

        //Creates a new payment intent with amount passed in from the client
        const paymentIntent = await stripe.paymentIntents.create({
            amount: parseInt(req.body.amount),
            currency: 'usd',
            customer: customerId,
        })

        res.status(200).send({
            paymentIntent: paymentIntent.client_secret,
            ephemeralKey: ephemeralKey.secret,
            customer: customerId,
            success: true,
        })

    } catch (error) {
        res.status(404).send({ success: false, error: error.message })
    }
});

exports.stripeCheckPremium = functions.https.onRequest(async (req, res) => {
    try {
        let customerId;
        let premium = false;

        //Gets the customer who's email id matches the one sent by the client
        const customerList = await stripe.customers.list({
            email: req.body.email,
            limit: 1
        });

        //Checks the if the customer exists, if not creates a new customer
        if (customerList.data.length !== 0) {
            customerId = customerList.data[0].id;
            customer = customerList.data[0];
        }
        else {
            const customer = await stripe.customers.create({
                email: req.body.email
            });
            customerId = customer.data.id;
        }

        //Creates a temporary secret key linked with the customer
        const ephemeralKey = await stripe.ephemeralKeys.create(
            { customer: customerId },
            { apiVersion: '2020-08-27' }
        );

        //Creates a new payment intent with amount passed in from the client
        const paymentIntent = await stripe.paymentIntents.list({
            customer: customerId,
        })
        if (paymentIntent.data.length !== 0 && paymentIntent.data[0].status == "succeeded" && paymentIntent.data[0].amount == 2000 && ((paymentIntent.data[0].created+parseInt(req.body.premiumDuration))*1000  > Date.now())) {
            premium = true;
        }

        res.status(200).send({
            ephemeralKey: ephemeralKey.secret,
            customerId: customerId,
            premium: premium,
            created: paymentIntent.data[0].created*1000,
            premiumDeadline: (paymentIntent.data[0].created +parseInt(req.body.premiumDuration))*1000,
            now: Date.now(),
            success: true,
        })

    } catch (error) {
        res.status(404).send({ success: false, error: error.message })
    }
});
// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
