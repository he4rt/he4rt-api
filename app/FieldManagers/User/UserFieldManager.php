<?php
/**
 * Created by PhpStorm.
 * User: idani
 * Date: 05/01/2019
 * Time: 16:16
 */

namespace App\FieldManagers\User;


use App\FieldManager\FieldManager;

class UserFieldManager extends FieldManager
{

    protected $fields = [
        'first_name' => [
            'rules' => 'string',
        ],
        'last_name' => [
            'rules' => 'string',
        ],
        'document_number' => [
            'rules' => 'string',
        ],
        'email' => [
            'rules' => 'email',
        ],
        'password' => [
            'rules' => '',
        ],
        'facebook_id' => [
            'rules' => 'string',
        ],
        'google_id' => [
            'rules' => 'string',
        ],
        'address_street' => [
            'rules' => 'string',
        ],
        'address_number' => [
            'rules' => 'string',
        ],
        'address_neighborhood' => [
            'rules' => 'string',
        ],
        'address_city' => [
            'rules' => 'string',
        ],
        'address_state' => [
            'rules' => 'string',
        ],
        'address_' => [
            'rules' => 'boolean',
        ],
        'is_admin' => [
            'rules' => 'boolean'
        ]
    ];

    public function store()
    {
        $fields = [
            'first_name' => 'required',
            'last_name' => 'required',
            'email' => 'required|email',
            'password' => 'required',
            'is_admin' => 'boolean'
        ];

        return $this->rules($fields);
    }

    public function simpleFilters() {
        return [
            'document_number',
            'email'
        ];
    }
}