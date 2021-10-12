package com.yjxxt.portal.controller;

import com.yjxxt.rpc.service.IGoodsCategoryService;
import org.apache.dubbo.config.annotation.Reference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.management.modelmbean.ModelMBeanOperationInfo;

@Controller
public class PagerController {

    /*@RequestMapping("/{page}")
    public String page(@PathVariable String page){
        return page;
    }*/

    @Reference(interfaceClass = IGoodsCategoryService.class,version = "1.0")
    private IGoodsCategoryService goodsCategoryService;
    @RequestMapping("index")
    public String index(Model model){
        model.addAttribute("gcList",goodsCategoryService.queryAllGoodsCategories());
        return "index";
    }
}
