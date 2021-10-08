package com.yjxxt.manager.controller;

import com.yjxxt.common.result.BaseResult;
import com.yjxxt.manager.pojo.Goods;
import com.yjxxt.manager.service.IBrandService;
import com.yjxxt.manager.service.IGoodsCategoryService;
import com.yjxxt.manager.service.IGoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

@Controller
@RequestMapping("goods")
@SuppressWarnings("all")
public class GoodsController {

    @Resource
    private IGoodsCategoryService goodsCategoryService;

    @Autowired
    private IBrandService brandService;
    @Autowired
    private IGoodsService goodsService;

    @RequestMapping("/list/page")
    public String list(){
        return "goods/goods_list";
    }

    @RequestMapping("/add/page")
    public String add(Model model){
        model.addAttribute("goodsCategoriesList",goodsCategoryService.queryGoodsCategoriesByParentId((short)0));
        model.addAttribute("brandList",brandService.queryAllBrands());
        return "goods/goods_add";
    }

    public BaseResult saveGoods(Goods goods){
        try{
            goodsService.saveGoods(goods);
            return BaseResult.success(goods.getGoodsId());
        }catch (Exception e){
            e.printStackTrace();
            return BaseResult.error(e.getMessage());
        }
    }
}
