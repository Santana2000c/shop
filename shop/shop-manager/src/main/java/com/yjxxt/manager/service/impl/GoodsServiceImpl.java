package com.yjxxt.manager.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yjxxt.common.result.BaseResult;
import com.yjxxt.manager.mapper.GoodsCategoryMapper;
import com.yjxxt.manager.mapper.GoodsMapper;
import com.yjxxt.manager.pojo.Goods;
import com.yjxxt.manager.pojo.GoodsExample;
import com.yjxxt.manager.query.GoodsQuery;
import com.yjxxt.manager.service.IGoodsService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
@SuppressWarnings("all")
public class GoodsServiceImpl implements IGoodsService {
    @Autowired
    private GoodsMapper goodsMapper;

    @Autowired
    private GoodsCategoryMapper goodsCategoryMapper;

    @Autowired
    private RedisTemplate redisTemplate;

    @Override
    public Integer saveGoods(Goods goods) {
        /**
         * 1.参数校验
         *     商品名不能为空  唯一
         *     spu & sku 非空
         *     商品分类非空
         *2.商品其他参数值
         *    商品货号(唯一) yyyyMMddHHmmss+时间毫秒数
         *    商品为实物is_real=1
         *    商品默认不上架 is_on_sale=0
         *    商品默认不包邮 is_free_shipping=0
         *    商品默认不推荐  is_recommend=0
         *    商品默认为新品 is_new=1
         *    商品默认为普通商品 is_hot=0
         *    last_update=new Date
         *3.执行添加 返回主键
         */
        checkParams(goods.getGoodsName(),goods.getSpu(),goods.getSku(),goods.getCatId());
        goods.setGoodsSn(new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+System.currentTimeMillis());
        goods.setIsReal((byte)1);
        goods.setIsOnSale((byte)0);
        goods.setIsFreeShipping((byte)0);
        goods.setIsRecommend((byte)0);
        goods.setIsNew((byte)1);
        goods.setIsHot((byte)0);
        //goods.setLastUpdate(Long.System.currentTimeMillis());
        int result =  goodsMapper.insertSelective(goods);
        if(result<=0){
            throw new RuntimeException("商品添加失败!");
        }
        return goods.getGoodsId();
    }

    /**
     * 商品分页查询引入动态缓存key
     *    catId
     *    brandId
     *    isOnSale
     *    flag
     *    keywords
     *    pageNum
     *    pageSize
     *  1.goods:list:pageNum:1:pageSize:10:catId:1
     *  2.goods:list:pageNum:1:pageSize:10:brandId:20
     *  3.goods:list:pageNum:1:pageSize:10:isOnSale:1
     *  4.goods:list:pageNum:1:pageSize:10:keywords:test
     *  5.goods:list:pageNum:1:pageSize:10:brandId:20:flag:1:keywords:test
     */
    @Override
    public BaseResult queryGoodsForListPage(GoodsQuery goodsQuery) {
        StringBuffer goodsListCacheKey = new StringBuffer("goods:list:pageNum:"
            +goodsQuery.getPageNum()+":pageSize:"+goodsQuery.getPageSize());
        GoodsExample goodsExample =new GoodsExample();
        // 设置查询条件
        GoodsExample.Criteria criteria= goodsExample.createCriteria();
        if(!(null==goodsQuery.getCatId()|| goodsQuery.getCatId()==0)){
            criteria.andCatIdEqualTo(goodsQuery.getCatId());
            goodsListCacheKey.append(":catId:"+goodsQuery.getCatId());
        }
        if(null !=goodsQuery.getBrandId()){
            criteria.andBrandIdEqualTo(goodsQuery.getBrandId());
            goodsListCacheKey.append(":brandId:"+goodsQuery.getBrandId());

        }
        if(null !=goodsQuery.getIsOnSale()){
            criteria.andIsOnSaleEqualTo(goodsQuery.getIsOnSale());
            goodsListCacheKey.append(":isOnSale:"+goodsQuery.getIsOnSale());
        }
        if(null !=goodsQuery.getFlag()){
            if(goodsQuery.getFlag()==1){
                // 新品
                criteria.andIsNewEqualTo((byte)1);
            }
            if(goodsQuery.getFlag()==2){
                // 推荐
                criteria.andIsRecommendEqualTo((byte)1);
            }
            goodsListCacheKey.append(":flag:"+goodsQuery.getFlag());
        }

        if(StringUtils.isNotBlank(goodsQuery.getKeywords())){
            criteria.andKeywordsLike("%"+goodsQuery.getKeywords()+"%");
            goodsListCacheKey.append(":keywords:"+goodsQuery.getKeywords());
        }

        String goodsListCachekeyStr = goodsListCacheKey.toString();
        PageInfo<Goods> pageInfo = null;
        if(redisTemplate.hasKey(goodsListCachekeyStr)){
            System.out.println("这是从Redis中查询数据......");

            pageInfo =(PageInfo<Goods>) redisTemplate.opsForValue().get(goodsListCachekeyStr);
            if(pageInfo.getTotal()>0){
                return BaseResult.success(pageInfo);
            }
        }

        System.out.println("这是从数据库中查询数据......");
        PageHelper.startPage(goodsQuery.getPageNum(),goodsQuery.getPageSize());
        List<Goods> goods=goodsMapper.selectByExample(goodsExample);
        pageInfo = new PageInfo<Goods>(goods);
        if(pageInfo.getTotal()>0){
            redisTemplate.opsForValue().set(goodsListCachekeyStr,pageInfo);
        }

        return BaseResult.success(pageInfo);
    }

    private void checkParams(String goodsName, String spu, String sku, Integer catId) {
        if(StringUtils.isBlank(goodsName)){
            throw new RuntimeException("请输入商品名称!");
        }
        GoodsExample goodsExample = new GoodsExample();
        goodsExample.createCriteria().andGoodsNameEqualTo(goodsName);
        if(!CollectionUtils.isEmpty(goodsMapper.selectByExample(goodsExample))){
            throw  new RuntimeException("该商品已存在!");
        }

        if(StringUtils.isBlank(spu)){
            throw new RuntimeException("请输入商品spu!");
        }
        if(StringUtils.isBlank(sku)){
            throw new RuntimeException("请输入商品sku!");
        }

        if(null == catId || 0==catId || null == goodsCategoryMapper.selectByPrimaryKey(catId.shortValue()) ){
            throw new RuntimeException("请指定商品分类!");
        }
    }
}
