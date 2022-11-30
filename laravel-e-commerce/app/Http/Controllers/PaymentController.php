<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\API\PaymentRequest;
use App\Models\Order;
use Illuminate\Http\Request;
use Omnipay\Omnipay;
use App\Models\Payment;
use App\Models\Product;
use Exception;

class PaymentController extends Controller
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
    public function payment(PaymentRequest $request)
    {
        session_start();
        $_SESSION['user']    = auth('sanctum')->user();
        $_SESSION['request'] = $request->all();
        // $_SESSION['test'] = 'test';
        // return $_SESSION['user'];

        $shipping = 5;
        $total = $shipping;
        $order_details = json_decode($request['order_details']);
        foreach ($order_details as $order) {
            $product = Product::find($order->product_id);
            if ($product) {
                if ($product->stock < $order->qty)
                    return response()->json("The qty that you are chosen to {$product->name} is not available");
                $total += $product->price * $order->qty;
            } else return response()->json('This product is not available');
        }

        try {
            $response = $this->gateway->purchase([
                'amount'    => $total,
                'currency'  => env('PAYPAL_CURRENCY'),
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
        session_start();
        $user = $_SESSION['user'] ?? null;
        $session_data = $_SESSION['request'] ?? null;
        if ($user) {
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
                    $payment = Payment::create([
                        'user_id'        => $user->id,
                        'payment_id'     => $data['PAYMENTINFO_0_TRANSACTIONID'],
                        'payer_id'       => $request->PayerID,
                        'amount'         => $data['PAYMENTINFO_0_AMT'],
                        'fee_amount'     => $data['PAYMENTINFO_0_FEEAMT'],
                        'currency'       => $data['PAYMENTINFO_0_CURRENCYCODE'],
                        'payment_status' => $data['PAYMENTINFO_0_PAYMENTSTATUS'],
                    ]);
                    if ($payment)
                        foreach (json_decode($session_data['order_details']) as $order) {
                            $product = Product::find($order->product_id);
                            if ($product) {
                                $product->update(['stock' => $product->stock - $order->qty]);
                                $order = Order::create([
                                    'seller_id'      => $product->user_id,
                                    'customer_id'    => $user->id,
                                    'product_id'     => $product->id,
                                    'payment_id'     => $payment->id,
                                    'qty'            => $order->qty,
                                    'price'          => $product->price,
                                    'shipping'       => 5,
                                    'currency'       => $payment->currency,
                                    'total_price'    => $product->price * $order->qty,
                                    'payment_method' => $session_data['payment_method'],
                                ]);
                            }
                        }
                    return "Payment is successful. Your transaction id is: " . $data['PAYMENTINFO_0_TRANSACTIONID'];
                } else {
                    return $response->getMessage();
                }
            } else {
                return 'Transaction is declined';
            }
        } else
            return response()->json('Unauthorized');
    }

    /**
     * Error Handling.
     */
    public function error()
    {
        return 'User cancelled the payment.';
    }
}
