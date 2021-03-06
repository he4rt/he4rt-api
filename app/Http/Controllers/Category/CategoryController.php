<?php


namespace App\Http\Controllers\Category;


use App\Entities\Category\Category;
use App\FieldManagers\Category\CategoryFieldManager;
use App\Http\Controllers\ApiController;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class CategoryController extends ApiController
{
    use ApiResponse;

    public function __construct(Category $model, CategoryFieldManager $fieldManager)
    {
        $this->fieldManager = $fieldManager;
        $this->model = $model;
    }

    /**
     * @OA\Get(
     *     path="/categories",
     *     summary="Lista todas as categorias",
     *     operationId="GetCategories",
     *     tags={"categories"},
     *     @OA\Parameter(
     *         name="Api-key",
     *         in="header",
     *         description="Api Key",
     *         required=false,
     *         @OA\Schema(
     *           type="string"
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="includes",
     *         in="query",
     *         description="Faz o include das relações",
     *         required=false,
     *         @OA\Schema(
     *           type="array",
     *           @OA\Items(type="string")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="...",
     *     )
     * )
     */
    public function index(Request $request)
    {
        return parent::index($request); // TODO: Change the autogenerated stub
    }

    /**
     * @OA\Post(
     *     path="/categories",
     *     summary="Cria uma categoria",
     *     operationId="PostCategory",
     *     tags={"categories"},
     *     @OA\Parameter(
     *         name="Api-key",
     *         in="header",
     *         description="Api Key",
     *         required=false,
     *         @OA\Schema(
     *           type="string"
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="name",
     *         in="query",
     *         description="Nome da categoria",
     *         required=true,
     *         @OA\Schema(
     *           type="string"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="...",
     *     )
     * )
     */
    public function store(Request $request)
    {
        return parent::store($request); // TODO: Change the autogenerated stub
    }

    /**
     * @OA\Get(
     *     path="/categories/{id}",
     *     summary="Lista uma categoria",
     *     operationId="GetCategory",
     *     tags={"categories"},
     *     @OA\Parameter(
     *         name="Api-key",
     *         in="header",
     *         description="Api Key",
     *         required=false,
     *         @OA\Schema(
     *           type="string"
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         description="ID da categoria",
     *         required=true,
     *         @OA\Schema(
     *           type="string"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="...",
     *     )
     * )
     */
    public function show(int $id)
    {
        return parent::show($id); // TODO: Change the autogenerated stub
    }

    /**
     * @OA\Put(
     *     path="/categories/{id}",
     *     summary="Atualiza uma categoria",
     *     operationId="PutCategory",
     *     tags={"categories"},
     *     @OA\Parameter(
     *         name="Api-key",
     *         in="header",
     *         description="Api Key",
     *         required=false,
     *         @OA\Schema(
     *           type="string"
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         description="ID da categoria",
     *         required=true,
     *         @OA\Schema(
     *           type="string"
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="name",
     *         in="query",
     *         description="Nome da categoria",
     *         required=false,
     *         @OA\Schema(
     *           type="string"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="...",
     *     )
     * )
     */
    public function update(Request $request, int $id)
    {
        return parent::update($request, $id); // TODO: Change the autogenerated stub
    }

    /**
     * @OA\Delete(
     *     path="/categories/{id}",
     *     summary="Apaga uma categoria",
     *     operationId="DeleteCategory",
     *     tags={"categories"},
     *     @OA\Parameter(
     *         name="Api-key",
     *         in="header",
     *         description="Api Key",
     *         required=false,
     *         @OA\Schema(
     *           type="string"
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         description="ID da categoria",
     *         required=true,
     *         @OA\Schema(
     *           type="string"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="...",
     *     )
     * )
     */
    public function destroy(int $id)
    {
        return parent::destroy($id); // TODO: Change the autogenerated stub
    }
}