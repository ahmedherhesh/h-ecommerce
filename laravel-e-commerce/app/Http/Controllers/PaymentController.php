<?php

namespace App\Http\Controllers;

use App\Http\Controllers\API\MasterAPIController;
use Illuminate\Http\Request;
use Omnipay\Omnipay;
use App\Models\Payment;
use Exception;

class PaymentController extends MasterAPIController
{

    private $gateway;

    public function __construct()
    {
        $this->gateway = Omnipay::create('PayPal_Express');
        // $this->gateway->setTestMode(paypal_mode) set it to 'false' when go live

        if (env('PAYPAL_MODE') == 'sandbox') {
            $this->gateway->setUsername(env('PAYPAL_SANDBOX_API_USERNAME'));
            $this->gateway->setPassword(env('PAYPAL_SANDBOX_API_PASSWORD'));
            $this->gateway->setSignature(env('PAYPAL_SANDBOX_API_SECRET'));
            $this->gateway->setTestMode(true);
        } elseif (env('PAYPAL_MODE') == 'live') {
            $this->gateway->setUsername(env('PAYPAL_LIVE_API_USERNAME'));
            $this->gateway->setPassword(env('PAYPAL_LIVE_API_PASSWORD'));
            $this->gateway->setSignature(env('PAYPAL_LIVE_API_SECRET'));
            $this->gateway->setTestMode(false);
        }
    }

    /**
     * Initiate a payment on PayPal.
     *
     * @param  \Illuminate\Http\Request  $request
     */
    public function payment()
    {
        $request = apache_request_headers();
        $validator = $this->validator($request, [
            'country' => 'required',
            'region' => 'required',
            'city' => 'required',
            'address' => 'required',
            'payment_method' => 'required',
            'order_details'  => 'required',
        ]);
        if ($validator)
            return $validator;
        return json_decode($request['order_details']);
        $total = 100;
        try {
            $response = $this->gateway->purchase([
                'amount' => $total,
                'currency' => env('PAYPAL_CURRENCY'),
                'returnUrl' => route('payment.success', "total=$total"),
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
    public function success(Request $request)
    {
        // Once the transaction has been approved, we need to complete it.
        if ($request->input('PayerID') && $request->input('total')) {
            $transaction = $this->gateway->completePurchase([
                'payer_id'  => $request->PayerID,
                'amount'    => $request->total,
            ]);
            $response = $transaction->send();

            if ($response->isSuccessful()) {
                // The customer has successfully paid.
                $data = $response->getData();
                // Insert transaction data into the database
                if (Payment::wherePaymentId($data['PAYMENTINFO_0_TRANSACTIONID'])->first()) return;
                Payment::insert([
                    'payment_id'     => $data['PAYMENTINFO_0_TRANSACTIONID'],
                    'payer_id'       => $request->PayerID,
                    // 'payer_email'    => $data['payer']['payer_info']['email'],
                    'amount'         => $data['PAYMENTINFO_0_AMT'],
                    'fee_amount'     => $data['PAYMENTINFO_0_FEEAMT'],
                    'currency'       => $data['PAYMENTINFO_0_CURRENCYCODE'],
                    'payment_status' => $data['PAYMENTINFO_0_PAYMENTSTATUS'],
                ]);

                return "Payment is successful. Your transaction id is: " . $data['PAYMENTINFO_0_TRANSACTIONID'];
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
