package com.yjxxt.manager.query;

import lombok.Data;

@Data
public class GoodsQuery {
    /**
     * 分类id
     */
    private Integer catId;

    /**
     * 品牌id
     */
    private Short brandId;

    /**
     * 是否上架
     */
    private Byte isOnSale;


    /**
     * 新品1  推荐2
     */
    private Byte flag;

    /**
     * 商品关键词
     */
    private String keywords;


    private Integer pageNum=1;

    private Integer pageSize=10;

}
