<!-- 设置项目根路径全局变量 -->
<#assign ctx=request.contextPath/>
<script type="text/javascript">
	var ctx = "${ctx}";
</script>
<html>
  <head>
    <meta charset="UTF-8">
    <title>ego管理后台</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Bootstrap 3.3.4 -->
    <link href="${ctx}/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- FontAwesome 4.3.0 -->
 	<link href="${ctx}/bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons 2.0.0 -->
    <link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="${ctx}/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins 
    	folder instead of downloading all of them to reduce the load. -->
    <link href="${ctx}/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="${ctx}/plugins/iCheck/flat/blue.css" rel="stylesheet" type="text/css" />   
    <!-- jQuery 2.1.4 -->
    <script src="${ctx}/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<script src="${ctx}/js/global.js"></script>
    <script src="${ctx}/js/myFormValidate.js"></script>    
    <script src="${ctx}/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${ctx}/js/layer/layer-min.js"></script><!-- 弹窗js 参考文档 http://layer.layui.com/-->
    <script src="${ctx}/js/myAjax.js"></script>
    <script type="text/javascript">
    function delfunc(obj){
    	layer.confirm('确认删除？', {
    		  btn: ['确定','取消'] //按钮
    		}, function(){
   				$.ajax({
   					type : 'post',
   					url : $(obj).attr('data-url'),
   					data : {act:'del',del_id:$(obj).attr('data-id')},
   					dataType : 'json',
   					success : function(data){
   						if(data==1){
   							layer.msg('操作成功', {icon: 1});
   							$(obj).parent().parent().remove();
   						}else{
   							layer.msg(data, {icon: 2,time: 2000});
   						}
   						layer.closeAll();
   					}
   				})
    		}, function(index){
    			layer.close(index);
    			return false;// 取消
    		}
    	);
    }
    
    //全选
    function selectAll(name,obj){
    	$('input[name*='+name+']').prop('checked', $(obj).checked);
    }   
    
    function get_help(obj){
        layer.open({
            type: 2,
            title: '帮助手册',
            shadeClose: true,
            shade: 0.3,
            area: ['90%', '90%'],
            content: $(obj).attr('data-url'), 
        });
    }
    
    function delAll(obj,name){
    	var a = [];
    	$('input[name*='+name+']').each(function(i,o){
    		if($(o).is(':checked')){
    			a.push($(o).val());
    		}
    	})
    	if(a.length == 0){
    		layer.alert('请选择删除项', {icon: 2});
    		return;
    	}
    	layer.confirm('确认删除？', {btn: ['确定','取消'] }, function(){
    			$.ajax({
    				type : 'get',
    				url : $(obj).attr('data-url'),
    				data : {act:'del',del_id:a},
    				dataType : 'json',
    				success : function(data){
    					if(data == 1){
    						layer.msg('操作成功', {icon: 1});
    						$('input[name*='+name+']').each(function(i,o){
    							if($(o).is(':checked')){
    								$(o).parent().parent().remove();
    							}
    						})
    					}else{
    						layer.msg(data, {icon: 2,time: 2000});
    					}
    					layer.closeAll();
    				}
    			})
    		}, function(index){
    			layer.close(index);
    			return false;// 取消
    		}
    	);	
    }
    </script>        
  <meta name="__hash__" content="4215372d5f63004790e1b9f4ed8df8b8_e74f2c0a9d3eff6e5b0e2ac8545e8177" /></head>
  <body style="background-color:#ecf0f5;">
 

<!--物流配置 css -start-->
<style>
    ul.group-list {
        width: 96%;min-width: 1000px; margin: auto 5px;list-style: disc outside none;
    }
    ul.group-list li {
        white-space: nowrap;float: left;
        width: 150px; height: 25px;
        padding: 3px 5px;list-style-type: none;
        list-style-position: outside;border: 0px;margin: 0px;
    }
</style>
<!--物流配置 css -end-->

<!--以下是在线编辑器 代码 -->
<script type="text/javascript">
    /*
	 * 在线编辑器相 关配置 js 
	 *  参考 地址 http://fex.baidu.com/ueditor/
	 */
    window.UEDITOR_Admin_URL = "${ctx}/plugins/Ueditor/";
    var URL_upload = "/index/Admin/Ueditor/imageUp/savepath/goods";
    var URL_fileUp = "/index/Admin/Ueditor/fileUp/savepath/article";
    var URL_scrawlUp = "/index/Admin/Ueditor/scrawlUp/savepath/article";
    var URL_getRemoteImage = "/index/Admin/Ueditor/getRemoteImage/savepath/article";
    var URL_imageManager = "/index/Admin/Ueditor/imageManager/savepath/article";
    var URL_imageUp = "/index/Admin/Ueditor/imageUp/savepath/article";
    var URL_getMovie = "/index/Admin/Ueditor/getMovie/savepath/article";
    var URL_home = "";
</script>
<script type="text/javascript" charset="utf-8" src="${ctx}/plugins/Ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/plugins/Ueditor/ueditor.all.min.js"> </script>
 <script type="text/javascript" charset="utf-8" src="${ctx}/plugins/Ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">  
  
    var editor;
    $(function () {
        //具体参数配置在  editor_config.js  中
        var options = {
            zIndex: 999,
            initialFrameWidth: "95%", //初化宽度
            initialFrameHeight: 400, //初化高度
            focus: false, //初始化时，是否让编辑器获得焦点true或false
            maximumWords: 99999, removeFormatAttributes: 'class,style,lang,width,height,align,hspace,valign'
            , //允许的最大字符数 'fullscreen',
            pasteplain:false, //是否默认为纯文本粘贴。false为不使用纯文本粘贴，true为使用纯文本粘贴
            autoHeightEnabled: true
         /*   autotypeset: {
                mergeEmptyline: true,        //合并空行
                removeClass: true,           //去掉冗余的class
                removeEmptyline: false,      //去掉空行
                textAlign: "left",           //段落的排版方式，可以是 left,right,center,justify 去掉这个属性表示不执行排版
                imageBlockLine: 'center',    //图片的浮动方式，独占一行剧中,左右浮动，默认: center,left,right,none 去掉这个属性表示不执行排版
                pasteFilter: false,          //根据规则过滤没事粘贴进来的内容
                clearFontSize: false,        //去掉所有的内嵌字号，使用编辑器默认的字号
                clearFontFamily: false,      //去掉所有的内嵌字体，使用编辑器默认的字体
                removeEmptyNode: false,      //去掉空节点
                                             //可以去掉的标签
                removeTagNames: {"font": 1},
                indent: false,               // 行首缩进
                indentValue: '0em'           //行首缩进的大小
            }*/,
        	toolbars: [
                   ['fullscreen', 'source', '|', 'undo', 'redo',
                       '|', 'bold', 'italic', 'underline', 'fontborder',
                       'strikethrough', 'superscript', 'subscript',
                       'removeformat', 'formatmatch', 'autotypeset',
                       'blockquote', 'pasteplain', '|', 'forecolor',
                       'backcolor', 'insertorderedlist',
                       'insertunorderedlist', 'selectall', 'cleardoc', '|',
                       'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
                       'customstyle', 'paragraph', 'fontfamily', 'fontsize',
                       '|', 'directionalityltr', 'directionalityrtl',
                       'indent', '|', 'justifyleft', 'justifycenter',
                       'justifyright', 'justifyjustify', '|', 'touppercase',
                       'tolowercase', '|', 'link', 'unlink', 'anchor', '|',
                       'imagenone', 'imageleft', 'imageright', 'imagecenter',
                       '|', 'insertimage', 'emotion', 'insertvideo',
                       'attachment', 'map', 'gmap', 'insertframe',
                       'insertcode', 'webapp', 'pagebreak', 'template',
                       'background', '|', 'horizontal', 'date', 'time',
                       'spechars', 'wordimage', '|',
                       'inserttable', 'deletetable',
                       'insertparagraphbeforetable', 'insertrow', 'deleterow',
                       'insertcol', 'deletecol', 'mergecells', 'mergeright',
                       'mergedown', 'splittocells', 'splittorows',
                       'splittocols', '|', 'print', 'preview', 'searchreplace']
               ]
        };
        editor = new UE.ui.Editor(options);
        editor.render("goods_content");  //  指定 textarea 的  id 为 goods_content

    }); 
</script>
<!--以上是在线编辑器 代码  end-->
<div class="wrapper">
    <div class="breadcrumbs" id="breadcrumbs">
	<ol class="breadcrumb">
	<li><a href="javascript:void();"><i class="fa fa-home"></i>&nbsp;&nbsp;后台首页</a></li>
	        
	        <li><a href="javascript:void();">商品管理</a></li>    
	        <li><a href="javascript:void();">添加修改商品</a></li>          
	</ol>
</div>

    <section class="content">
        <!-- Main content -->
        <div class="container-fluid">
            <div class="pull-right">
                <a href="javascript:history.go(-1)" data-toggle="tooltip" title="" class="btn btn-default" data-original-title="返回"><i class="fa fa-reply"></i></a>
            	<a href="javascript:;" class="btn btn-default" data-url="http://www.ego.cn/Doc/Index/article/id/1007/developer/user.html" onclick="get_help(this)"><i class="fa fa-question-circle"></i> 帮助</a>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-list"></i>商品详情</h3>
                </div>
                <div class="panel-body">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab_tongyong" data-toggle="tab">通用信息</a></li>
						<!-- <li><a href="#tab_goods_desc" data-toggle="tab">描述信息</a></li>-->
                        <li><a href="#tab_goods_images" data-toggle="tab">商品相册</a></li>
                        <li><a href="#tab_goods_spec" data-toggle="tab">商品模型</a></li>                       
                        <li><a href="#tab_goods_shipping" data-toggle="tab">商品物流</a></li>
                    </ul>
                    <!--表单数据-->
                    <form method="post" id="addEditGoodsForm">
                        <input type="text" name="catId" id="catId" value="0"/>
                        <!--通用信息-->
                    <div class="tab-content">                 	  
                        <div class="tab-pane active" id="tab_tongyong">
                           
                            <table class="table table-bordered">
                                <tbody>
                                <tr>
                                    <td>商品名称:</td>
                                    <td>
                                        <input type="text" value="" name="goods_name" class="form-control" style="width:550px;"/>
                                        <span id="err_goods_name" style="color:#F00; display:none;"></span>                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td>商品简介:</td>
                                    <td>
	                                    <textarea rows="3" cols="80" name="goods_remark"></textarea>
                                        <span id="err_goods_remark" style="color:#F00; display:none;"></span>
                                         
                                    </td>                                                                       
                                </tr>
                                <tr>
                                    <td>商品货号</td>
                                    <td>                                                                               
                                        <input type="text" value="" name="goods_sn" class="form-control" style="width:350px;"/>
                                        <span id="err_goods_sn" style="color:#F00; display:none;"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>SPU</td>
                                    <td>                                                                               
                                        <input type="text" value="" name="spu" class="form-control" style="width:350px;"/>
                                        <span id="err_goods_spu" style="color:#F00; display:none;"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>SKU</td>
                                    <td>                                                                               
                                        <input type="text" value="" name="sku" class="form-control" style="width:350px;"/>
                                        <span id="err_goods_sku" style="color:#F00; display:none;"></span>
                                    </td>
                                </tr>                                
                                <tr>
                                    <td>商品分类:</td>
                                    <td>
                                      <div class="col-xs-3">
                                      <select name="cat_id" id="cat_id"
											  onchange="getCategory(this.value,'cat_id_2');"
											  class="form-control" style="width:250px;margin-left:-15px;">
										  <option value="0">请选择分类</option>
										  <#if goodsCategoriesList??>
										  	 <#list goodsCategoriesList as goodsCategory>
										  	 	<option value="${goodsCategory.id}">${goodsCategory.name}</option>
										  	 </#list>
										  </#if>
									  </select>
									  </div>
                                      <div class="col-xs-3">
                                      <select name="cat_id_2" id="cat_id_2" onchange="getCategory(this.value,'cat_id_3',2);" class="form-control" style="width:250px;margin-left:-15px;">
                                        <option value="0">请选择商品分类</option>
                                      </select>  
                                      </div>
                                      <div class="col-xs-3">                        
                                      <select name="cat_id_3" id="cat_id_3" class="form-control"
                                              style="width:250px;margin-left:-15px;"  onchange="setCatId(this.value)">
                                        <option value="0">请选择商品分类</option>
                                      </select> 
                                      </div>    
                                      <span id="err_cat_id" style="color:#F00; display:none;"></span>                                 
                                    </td>
                                </tr>                                 
                                <tr>
                                    <td>扩展分类:</td>
                                    <td>
                                      <div class="col-xs-3">
                                      <select name="extend_cat_id" id="extend_cat_id" onchange="get_category(this.value,'extend_cat_id_2','0');" class="form-control" style="width:250px;margin-left:-15px;">
                                        <option value="0">请选择商品分类</option>                                      
                                             <option value="1"  >
                                               		手机 、 数码 、 通信                                               </option><option value="2"  >
                                               		家用电器                                               </option><option value="3"  >
                                               		电脑、办公                                               </option><option value="4"  >
                                               		家居、家具、家装、厨具                                               </option><option value="5"  >
                                               		男装、女装、童装、内衣                                               </option><option value="6"  >
                                               		个人化妆                                               </option><option value="7"  >
                                               		鞋、箱包、珠宝、手表                                               </option><option value="8"  >
                                               		运动户外                                               </option><option value="9"  >
                                               		汽车用品                                               </option><option value="10"  >
                                               		母婴用品、儿童玩具                                               </option><option value="11"  >
                                               		图书、音像、电子书                                               </option>                                      </select>
                                      </div>
                                      <div class="col-xs-3">
                                      <select name="extend_cat_id_2" id="extend_cat_id_2" onchange="get_category(this.value,'extend_cat_id_3','0');" class="form-control" style="width:250px;margin-left:-15px;">
                                        <option value="0">请选择商品分类</option>
                                      </select>  
                                      </div>
                                      <div class="col-xs-3">                        
                                      <select name="extend_cat_id_3" id="extend_cat_id_3"
                                              class="form-control" style="width:250px;margin-left:-15px;" >
                                        <option value="0">请选择商品分类</option>
                                      </select> 
                                      </div>    
                                      <span id="err_cat_id" style="color:#F00; display:none;"></span>                                 
                                    </td>
                                </tr>                                 
                                
<!--
                                <tr>
                                    <td>商品分类:</td>
                                    <td>
                                      <select name="cat_id" id="cat_id" class="form-control" style="width:250px;">
                                        <option value="">所有分类</option>
                                             <option value="1"  >
                                               		----- 手机 、 数码 、 通信                                               </option><option value="2"  >
                                               		----- 家用电器                                               </option><option value="3"  >
                                               		----- 电脑、办公                                               </option><option value="4"  >
                                               		----- 家居、家具、家装、厨具                                               </option><option value="5"  >
                                               		----- 男装、女装、童装、内衣                                               </option><option value="6"  >
                                               		----- 个人化妆                                               </option><option value="7"  >
                                               		----- 鞋、箱包、珠宝、手表                                               </option><option value="8"  >
                                               		----- 运动户外                                               </option><option value="9"  >
                                               		----- 汽车用品                                               </option><option value="10"  >
                                               		----- 母婴用品、儿童玩具                                               </option><option value="11"  >
                                               		----- 图书、音像、电子书                                               </option>                                      </select>                                    
                                    </td>
                                </tr>
-->                                
                                <tr>
                                    <td>商品品牌:</td>
                                    <td>
									<select name="brand_id" id="brand_id" class="form-control" style="width:250px;">
                                       		 <option value="">请选择品牌</option>
										<#if brandList??>
											<#list brandList as brand>
												<option value="${brand.id}">${brand.name}</option>
											</#list>
										</#if>

									</select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>供应商:</td>
                                    <td>
                                        <select name="suppliers_id" id="suppliers_id" class="form-control" style="width:250px;">
                                            <option value="0">不指定供应商属于本店商品</option>
                                                                                    </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>本店售价:</td>
                                    <td>
                                        <input type="text" value="" name="shop_price" class="form-control" style="width:150px;" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" />
                                        <span id="err_shop_price" style="color:#F00; display:none;"></span>					                                        
                                    </td>
                                </tr>  
                                <tr>
                                    <td>市场价:</td>
                                    <td>
                                        <input type="text" value="" name="market_price" class="form-control" style="width:150px;" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" />
                                        <span id="err_market_price" style="color:#F00; display:none;"></span>					                                        
                                    </td>
                                </tr>  
                                <tr>
                                    <td>成本价:</td>
                                    <td>
                                        <input type="text" value="" name="cost_price" class="form-control" style="width:150px;" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" />
                                        <span id="err_cost_price" style="color:#F00; display:none"></span>					                                        
                                    </td>
                                </tr>       
                                <tr>
                                    <td>佣金:</td>
                                    <td>
                                        <input type="text" value="" name="commission" class="form-control" style="width:150px;" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" />
                                        用于分销的分成金额
                                    </td>
                                </tr>                                  
                                <tr>
                                    <td>上传商品图片:</td>
                                    <td>
                                        <input type="button" value="上传图片"  onclick="GetUploadify(1,'','goods','call_back');"/>
                                        <input type="text" class="input-sm"  name="original_img" id="original_img" value=""/>
                                                                                <span id="err_original_img" style="color:#F00; display:none;"></span>					                                        
                                    </td>
                                </tr>                                 
                                <tr>
                                    <td>商品重量:</td>
                                    <td>
                                        <input type="text" class="form-control" style="width:150px;" value="" name="weight" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" />
                                        &nbsp;克 (以克为单位)                                        
                                        <span id="err_weight" style="color:#F00; display:none;"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>是否包邮:</td>
                                    <td>
                                        是:<input type="radio"  value="1" name="is_free_shipping" /> 
                                        否:<input type="radio" checked="checked" value="0" name="is_free_shipping" /> 
                                    </td>
                                </tr>                                
                                <tr>
                                    <td>库存数量:</td>
                                    <td>
                                                                                    <input type="text" value="1" class="form-control" style="width:150px;" name="store_count" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" />                                        
                                        <span id="err_store_count" style="color:#F00; display:none;"></span>					                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td>赠送积分:</td>
                                    <td>
                                        <input type="text" class="form-control" style="width:150px;" value="" name="give_integral" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" />
                                        <span id="err_give_integral" style="color:#F00; display:none;"></span>					                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td>兑换积分:</td>
                                    <td>
                                        <input type="text" class="form-control" style="width:150px;" value="" name="exchange_integral" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" />
                                        <span id="err_exchange_integral" style="color:#F00; display:none;"></span>
                                    </td>
                                </tr>
                                <!--
                                <tr>
                                    <td>设置:</td>
                                    <td>
                                    	<input type="checkbox" checked="checked" value="" name="is_on_sale"/> 上架&nbsp;&nbsp;
	                                <input type="checkbox" checked="checked" value="" name="is_free_shipping"/> 包邮&nbsp;&nbsp;
                                        <input type="checkbox" checked="checked" value="" name="is_recommend"/>推荐&nbsp;&nbsp;
                                        <input type="checkbox" checked="checked" value="" name="is_new"/>新品&nbsp;&nbsp;
                                    </td>
                                </tr>
                                -->
                                <tr>
                                    <td>商品关键词:</td>
                                    <td>
                                        <input type="text" class="form-control" style="width:550px;" value="" name="keywords"/>用空格分隔
                                        <span id="err_keywords" style="color:#F00; display:none;"></span>
                                    </td>
                                </tr>                                    
                                <tr>
                                    <td>商品详情描述:</td>
                                    <td width="85%">
										<textarea rows="6" cols="80" class="span12 ckeditor" id="goods_content" name="goods_content" title=""></textarea>
                                        <span id="err_goods_content" style="color:#F00; display:none;"></span>                                         
                                    </td>                                                                       
                                </tr>   
                                </tbody>                                
                                </table>
                        </div>
                         <!--其他信息-->
                         
                        <!-- 商品相册-->
                        <div class="tab-pane" id="tab_goods_images">
                            <table class="table table-bordered">
                                <tbody>
                                <tr>                                    
                                    <td>                                    
                                                                        
                                        <div class="goods_xc" style="width:100px; text-align:center; margin: 5px; display:inline-block;">
                                            <input type="hidden" name="goods_images[]" value="" />
                                            <a href="javascript:void(0);" onclick="GetUploadify(10,'','goods','call_back2');"><img src="${ctx}/images/add-button.jpg" width="100" height="100" /></a>
                                            <br/>
                                            <a href="javascript:void(0)">&nbsp;&nbsp;</a>
                                        </div>                                        
                                    </td>
                                </tr>                                              
                                </tbody>
                            </table>
                        </div>
                         <!--商品相册--> 
   
                        <!-- 商品模型-->
                        <div class="tab-pane" id="tab_goods_spec">
                            <table class="table table-bordered" id="goods_spec_table">                                
                                <tr>
                                    <td>商品模型:</td>
                                    <td>                                        
                                      <select name="goods_type" id="spec_type" class="form-control" style="width:250px;">
                                        <option value="0">选择商品模型</option>
                                        <option value="33" >运营商</option><option value="32" >相机</option><option value="4" >手机</option><option value="31" >电池、电源、充电器</option><option value="8" >化妆品</option><option value="9" >精品手机</option><option value="30" >洗衣机</option><option value="29" >冰箱</option><option value="16" >路由器</option><option value="15" >平板电脑</option><option value="13" >衣服</option><option value="17" >网络盒子</option><option value="18" >电视</option><option value="19" >家纺</option><option value="20" >吸顶灯</option><option value="21" >床</option><option value="22" >雨伞</option><option value="23" >餐具</option><option value="24" >毛呢大衣</option><option value="25" >针织衫</option><option value="26" >文胸</option><option value="27" >香水</option><option value="28" >珠宝</option>                                        
                                      </select>
                                    </td>
                                </tr>                            
                            </table>
                            <!-- ajax 返回属性-->
							<div id="" class="col-xs-6" style="border:1px solid #ddd;"><br/>
							<table class="table table-bordered" id="goods_attr_table">
								<tr>
									<td>商品属性:</td>
									<td>
										<select id="" name="" class="form-control" style="width:250px;">
											<option value="">选择商品属性</option>
										</select>
									</td>
								</tr>
							</table>
							</div>
							<div id="" class="col-xs-6" style="border:1px solid #ddd;height: 94px;"><br/>
								<table class="table table-bordered" id="goods_attr_table">
									<tr>
										<td>商品属性值:</td>
										<td>
											<select id="" name="" class="form-control" style="width:250px;">
												<option value="">选择商品属性值</option>
											</select>
										</td>
									</tr>
								</table>
							</div>
							<!-- ajax 返回规格-->
							<div id="" class="col-xs-6" style="border:1px solid #ddd;"><br/>
							<table class="table table-bordered" id="goods_attr_table">
								<tr>
									<td>商品规格:</td>
									<td>
										<select id="" name="" class="form-control" style="width:250px;">
											<option value="">选择商品规格</option>
										</select>
									</td>
								</tr>
							</table>
							</div>
							<div id="" class="col-xs-6" style="border:1px solid #ddd;height: 94px;"><br/>
								<table class="table table-bordered" id="goods_attr_table">
									<tr>
										<td>商品规格值:</td>
										<td>
											<select id="" name="" class="form-control" style="width:250px;">
												<option value="">选择商品规格值</option>
											</select>
										</td>
									</tr>
								</table>
							</div>
                        </div>
                        <!-- 商品模型-->

                        <!-- 商品属性-->

                        <!-- 商品属性-->

                        <!-- 商品物流-->
                        <div class="tab-pane" id="tab_goods_shipping">
                            <h4><b>物流配送：</b><input type="checkbox" onclick="choosebox(this)">全选</h4>
                            <table class="table table-bordered table-striped dataTable" id="goods_shipping_table">
                                <tr>
                                        <td class="title left" style="padding-right:50px;">
                                            <b>申通物流：</b>
                                            <label class="right"><input type="checkbox" value="1" cka="mod-0">全选</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <ul class="group-list">
                                                <li><label><input type="checkbox" name="shipping_area_ids[]" value="24"  ck="mod-0">全国其他地区</label></li><li><label><input type="checkbox" name="shipping_area_ids[]" value="37"  ck="mod-0">珠三角地区</label></li>                                                <div class="clear-both"></div>
                                            </ul>
                                        </td>
                                    </tr><tr>
                                        <td class="title left" style="padding-right:50px;">
                                            <b>顺丰物流：</b>
                                            <label class="right"><input type="checkbox" value="1" cka="mod-1">全选</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <ul class="group-list">
                                                <li><label><input type="checkbox" name="shipping_area_ids[]" value="25"  ck="mod-1">全国其他地区</label></li><li><label><input type="checkbox" name="shipping_area_ids[]" value="35"  ck="mod-1">珠三角地区</label></li><li><label><input type="checkbox" name="shipping_area_ids[]" value="36"  ck="mod-1">长三角</label></li><li><label><input type="checkbox" name="shipping_area_ids[]" value="38"  ck="mod-1">全国一线城市</label></li>                                                <div class="clear-both"></div>
                                            </ul>
                                        </td>
                                    </tr>                            </table>
                        </div>
                        <!-- 商品物流-->
                    </div>              
                    <div class="pull-right">
                        <input type="hidden" name="goods_id" value="">
                        <button class="btn btn-primary" onclick="ajax_submit_form('addEditGoodsForm','/index/Admin/Goods/addEditGoods/is_ajax/1');" title="" data-toggle="tooltip" type="button" data-original-title="保存">保存</button>
                    </div>
			    <input type="hidden" name="__hash__" value="4215372d5f63004790e1b9f4ed8df8b8_e74f2c0a9d3eff6e5b0e2ac8545e8177" /></form><!--表单数据-->
                </div>
            </div>
        </div>    <!-- /.content -->
    </section>
</div>
<script>

	/**
	 *
	 * @param parentId  上级分类id
	 * @param next    节点id
	 */
	function getCategory(parentId,next,level){
		var optionHtml="<option value='0'>请选择分类</option>";

        $("#catId").val(parentId);
		if(level==2){
           if(parentId==0){
               // 获取一级分类
               //$("input[name='select']").val();
               $("#catId").val($("#cat_id").val());
           }
        }



		if(next==='cat_id_2'){
			$("#"+next).html("");
			$("#cat_id_3").html(optionHtml);
		}

		$.ajax({
			type:"post",
			url:ctx+"/goodsCategory/queryGoodsCategoriesByParentId",
			data:{
				parentId:parentId
			},
			dataType:"json",
			success:function (data){
				if(data.length>0){
					for(var i=0;i<data.length;i++){
						optionHtml = optionHtml+"<option value='"+data[i].id+"'>"+data[i].name+"</option>";
					}
				}
				$("#"+next).html(optionHtml);
			}
		})
	}


	function setCatId(catId){
        $("#catId").val(catId);
    }

</script>
</body>
</html>