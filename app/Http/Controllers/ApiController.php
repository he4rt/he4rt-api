<?php

namespace App\Http\Controllers;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use App\Traits\ApiResponse;
use App\FieldManager\FieldManager;

class ApiController extends Controller
{
    use ApiResponse;

    /**
     * @var Model
     */
    protected $model;

    /**
     * @var Model
     */
    protected $query;


    /**
     * @var FieldManager
     */
    protected $fieldManager;

    /**
     * @var int
     */
    protected $limit = 15;

    /**
     * @var boolean
     */
    protected $list = false;

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        $query = $this->query ?: $this->model;

        foreach ($this->fieldManager->simpleFilters() as $filter) {
            if (!$request->has($filter['field'])) {
                continue;
            }

            if ($filter['type'] == 'equals') {
                $query = $query->where($filter['field'], $request->get($filter['field']));
                continue;
            }

            if ($filter['type'] == 'like') {
                $text = str_replace(' ', '%', $request->get($filter['field']));
                $this->query = $this->query->whereRaw(
                    $filter['field'] . ' like "%' . $text . '%"'
                );

                continue;
            }
        }

        if ($includes = $request->get('includes')) {
            $includes = is_array($includes) ? $includes : explode(',', $includes);
            $query = $query->with($includes);
        }

        if ($this->list || $request->get('search_type') == 'list') {
            $resources = $query->get();
        } else {
            $resources = $query->paginate($this->limit);
        }

        return $this->success($resources);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $this->validate($request, $this->fieldManager->store());
        $resource = $this->model->create($request->all());
        return response()->json($resource);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(int $id)
    {
        $resource = $this->model->find($id);
        if (!$resource) {
            return $this->notFound();
        }

//        if ($includes = $request->get('includes')) {
//            $includes = is_array($includes) ? $includes : explode(',', $includes);
//            $resource->load($includes);
//        }

        return $this->success($resource);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, int $id)
    {
        if (!$resource = $this->model->find($id)) {
            return $this->notFound();
        }

        $this->validate($request, $this->fieldManager->update());
        $resource->update($request->all());
        return $this->success($resource);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(int $id)
    {
        if (!$resource = $this->model->find($id)) {
            return $this->notFound();
        }
        $resource->delete();
        return $this->success();
    }
}