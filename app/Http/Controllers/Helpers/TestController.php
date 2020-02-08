<?php
/**
 * Created by PhpStorm.
 * User: Daniel Reis
 * Date: 23-Sep-19
 * Time: 22:48
 */

namespace App\Http\Controllers\Helpers;


use App\Http\Controllers\ApiController;
use App\Services\CharacterService;

class TestController extends ApiController
{
    public function testFunction(){

        $charService = new CharacterService();

        $cap = $mask = $eyes = $ears = $coat = $pants = $glove = $cape = $shoes = $shield = $weapon = null;

        $charService->setVaribles([
            "Skin"   => 1,
            "Gender" => 0,
            "Hair"   => 30002,
            "Face"   => 20001,
            "Cap"    => $cap,
            "Mask"   => $mask,
            "Eyes"   => $eyes,
            "Ears"   => $ears,
            "Coat"   => 1050019,
            "Pants"  => $pants,
            "Shoes"  => 1070001,
            "Glove"  => $glove,
            "Cape"   => 1102222,
            "Shield" => $shield,
            "Weapon" => $weapon
        ]);


        $charService->setCap('capeBelowBody');
        $charService->setCap('capBelowHead');
        $charService->setCap('capAccessoryBelowBody');
        $charService->setCape('cape');
        $charService->setCape('backWing');
        $charService->setCap('backCap');
        $charService->setCape('capeBelowBody');
        $charService->setCap('capeBelowBody');
        $charService->setHair('hairBelowBody');
        $charService->setShoes('capAccessoryBelowBody');
        $charService->createBody('body');
        $charService->setShoes('shoes');
        $charService->setShoes('weaponOverBody');
        $charService->setGlove('l', 1);
        $charService->setPants();
        $charService->setCoat('mail');
        $charService->setShoes('shoesTop');
        $charService->setShoes('shoesOverPants');
        $charService->setShoes('pantsOverMailChest');
        $charService->setShoes('gloveWristBelowMailArm');
        $charService->setHair('hairBelowHead');
        $charService->setCap('capBelowHead');
        $charService->createBody('head');
        $charService->setAccessory('Ears', 'accessoryEar');
        $charService->setCap('backHairOverCape');
        $charService->setCap('backHair');
        $charService->setHair('hairShade');
        $charService->setCap('capAccessoryBelowAccFace');
        $charService->setAccessory('Mask', 'accessoryFaceBelowFace');
        $charService->setAccessory('Eyes', 'accessoryEyeBelowFace');
        $charService->setFace();
        $charService->setAccessory('Mask', 'accessoryFace');
        $charService->setCap('accessoryEyeOverCap');
        $charService->setAccessory('Eyes', 'accessoryEye');
        $charService->setCap('accessoryEar');
        $charService->setHair('hair');
        $charService->setHair('hairOverHead');
        $charService->setAccessory('Ears', 'accessoryEarOverHair');
        $charService->setAccessory('Eyes', 'accessoryOverHair');
        $charService->setAccessory('Eyes', 'hairOverHead');
        $charService->setCap('capBelowAccessory');
        $charService->setCap('0');
        $charService->setCap('cap');
        $charService->setCap('body');
        $charService->setCap('capOverHair');
        $charService->setAccessory('Mask', 'capOverHair');
        $charService->setAccessory('Eyes', 'accessoryEyeOverCap');
        $charService->setAccessory('Mask', 'capeOverHead');
        $charService->setCape('capeOverHead');
        $charService->setCape('capOverHair');
        $charService->createBody('arm');
        $charService->setCoat('mailArm');
        $charService->setCape('capeArm');
        $charService->createBody('hand');
        $charService->setGlove('l', 2);
        $charService->setGlove('r');



        $charService->charType('create', 'danielhe4rt');



    }
}