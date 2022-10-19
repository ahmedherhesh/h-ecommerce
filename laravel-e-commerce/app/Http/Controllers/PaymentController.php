<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Omnipay\Omnipay;
use App\Models\Payment;
use Exception;

class PaymentController extends Controller
{

    private $gateway;

    public function __construct()
    {
        $this->gateway = Omnipay::create('PayPal_Express');
        $this->gateway->setUsername(env('PAYPAL_SANDBOX_API_USERNAME'));
        $this->gateway->setPassword(env('PAYPAL_SANDBOX_API_PASSWORD'));
        $this->gateway->setSignature(env('PAYPAL_SANDBOX_API_SECRET'));
        // $this->gateway->setClientId(env('PAYPAL_CLIENT_ID'));
        // $this->gateway->setSecret(env('PAYPAL_CLIENT_SECRET'));
        $this->gateway->setTestMode(true); //set it to 'false' when go live
    }

    /**
     * Initiate a payment on PayPal.
     *
     * @param  \Illuminate\Http\Request  $request
     */
    public function payment(Request $request)
    {
        $total = 100;
        try {
            $response = $this->gateway->purchase([
                'amount' => $total,
                'currency' => env('PAYPAL_CURRENCY'),
                'returnUrl' => route('payment.success',$total),
                'cancelUrl' => route('payment.cancel'),
            ])->send();
            if ($response->isRedirect()) {
                $response->redirect(); // this will automatically forward the customer
            } else {
                // not successful
                return $response->getMessage();
            }
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }


    // Charge a payment and store the transaction.
    public function success(Request $request,$total)
    {

        // Once the transaction has been approved, we need to complete it.
        if ($request->input('PayerID')) {
            $transaction = $this->gateway->completePurchase([
                'payer_id'  => $request->PayerID,
                'amount'    => $total,
            ]);
            $response = $transaction->send();

            if ($response->isSuccessful()) {
                // The customer has successfully paid.
                $data = $response->getData();
                return $data;
                // Insert transaction data into the database
                Payment::insert([
                    'payment_id'     =>  $data['id'],
                    'payer_id'       =>  $data['payer']['payer_info']['payer_id'],
                    'payer_email'    =>  $data['payer']['payer_info']['email'],
                    'amount'         =>  $data['transactions'][0]['amount']['total'],
                    'currency'       =>  env('PAYPAL_CURRENCY'),
                    'payment_status' =>  $data['state']
                ]);

                return "Payment is successful. Your transaction id is: " . $data['id'];
            } else {
                return $response->getMessage();
            }
        } else {
            return 'Transaction is declined';
        }
    }

    /**
     * Error Handling.
     */
    public function error()
    {
        return 'User cancelled the payment.';
    }
}
