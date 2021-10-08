package com.yjxxt.manager.controller;


import com.yjxxt.common.result.BaseResult;
import com.yjxxt.manager.pojo.GoodsCategory;
import com.yjxxt.manager.service.IGoodsCategoryService;
import com.yjxxt.manager.vo.GoodsCategoryVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.net.idn.Punycode;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("goodsCategory")
public class GoodsCategoryController {


    @Resource
    private IGoodsCategoryService goodsCategoryService;


    /**
     * 商品分类主页面
     * @return
     */
    @RequestMapping("index")
    public String index(Model model){
        model.addAttribute("gcvList",
                goodsCategoryService.queryAllGoodsCategories());
        return "/goods/goodsCategory/goods_category_list";
    }


    /**
     * 添加商品分页页面
     * @return
     */
    @RequestMapping("addPage")
    public String addPage(Model model){
        model.addAttribute("gcList",goodsCategoryService.queryGoodsCategoriesByParentId((short)0));
        return "/goods/goodsCategory/goods_category_add";
    }


    @RequestMapping("queryGoodsCategoriesByParentId")
    @ResponseBody
    public List<GoodsCategory> queryGoodsCategoriesByParentId(Short parentId) {
        return goodsCategoryService.queryGoodsCategoriesByParentId(parentId);
    }


    /**
     * 保存商品分类记录
     * @param goodsCategory
     * @return
     */
    @RequestMapping("save")
    @ResponseBody
    public BaseResult saveGoodsCategory(GoodsCategory goodsCategory){
        try {
            goodsCategoryService.saveGoodsCategory(goodsCategory);
            return BaseResult.success();
        } catch (Exception e) {
            e.printStackTrace();
            return BaseResult.error(e.getMessage());
        }
    }




    @RequestMapping("queryAllGoodsCatories")
    @ResponseBody
    public List<GoodsCategoryVo> queryAllGoodsCatories(){
        return goodsCategoryService.queryAllGoodsCategories();
    }






}
