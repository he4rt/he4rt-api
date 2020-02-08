<?php


namespace App\FieldManagers\Category;


use App\FieldManagers\FieldManager;

class CategoryFieldManager extends FieldManager
{
    protected $fields = [
        'name' => [
            'rules' => 'string'
        ]
    ];

    public function store()
    {
        $fields = [
            'name' => 'required'
        ];

        return $this->rules($fields);
    }

    public function simpleFilters()
    {
        return [];
    }
}