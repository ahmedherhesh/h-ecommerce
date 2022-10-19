<?php

use GuzzleHttp\Client;

class FatoorahServices{
    private $base_url;
    private $header;
    private $client;

    public function __construct(Client $client)
    {
        $this->client = $client;
        $this->base_url = env('MYFATOORAH_URL');
        $this->headers = [
            'Content-Type'  => 'application/json',
            'authorization' => 'Bearer ' . env('MYFATOORAH_TOKEN')
        ];
    }

}