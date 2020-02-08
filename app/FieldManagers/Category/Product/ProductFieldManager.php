<?php


namespace App\FieldManagers\Category\Product;


use App\FieldManagers\FieldManager;

class ProductFieldManager extends FieldManager
{
    protected $fields = [
        'name' => [
            'rules' => 'string'
        ],
        'description' => [
            'rules' => 'string'
        ],
        'price' => [
            'rules' => 'numeric'
        ],
        'category_id' => [
            'rules' => 'integer|exists:categories,id'
        ]
    ];

    public function store()
    {
        $fields = [
            'name' => 'required',
            'price' => 'required',
            'category_id' => 'required'
        ];

        return $this->rules($fields);
    }

    public function simpleFilters()
    {
        return [
            [
                'field' => 'category_id',
                'type' => 'equals'
            ]
        ];
    }
}