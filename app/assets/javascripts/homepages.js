// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
Ext.BLANK_IMAGE_URL = 'images/s.gif';

var Apps = {} ;

MainPanel = function(){
    MainPanel.superclass.constructor.call(this , {
		 	  id:'dsp-body' , 
		    region:'center',
				margins:'0 0 5 0',
			  resizeTabs: true,
				minTabWidth: 135,
				tabWidth: 135,
			  plugins: new Ext.ux.TabCloseMenu(),
				enableTabScroll: true,
				activeTab: 0,
		        items: {
		            id:'welcome-panel',
		            title: 'Dashboard',
		            iconCls:'icon-docs',
		            autoScroll: true
		        }
			});	
};
Ext.extend(MainPanel ,Ext.TabPanel , {
	 initEvents: function(){
		 MainPanel.superclass.initEvents.call(this);
		this.body.on('click' , this.onClick , this);
	} , 
	onClick:function(e , target){
		 if(target = e.getTarget('a:not(.exi)', 3)){
		            var cls = Ext.fly(target).getAttributeNS('ext', 'cls');
		            e.stopEvent();
		            if(cls){
		                var member = Ext.fly(target).getAttributeNS('ext', 'member');
		                this.loadClass(target.href, cls, member);
		            }else if(target.className == 'inner-link'){
		                this.getActiveTab().scrollToSection(target.href.split('#')[1]);
		            }else{
		                window.open(target.href);
		            }
		        }else if(target = e.getTarget('.micon', 2)){
		            e.stopEvent();
		            var tr = Ext.fly(target.parentNode);
		            if(tr.hasClass('expandable')){
		                tr.toggleClass('expanded');
		            }
		        }
	} ,
	loadClass : function(href , title , iconCls , menuid){
  	 var cls = iconCls;
		 var id = 'docs-' + menuid;
		 var tab=  this.getComponent(id);
	    var autoLoad = {url : href , scripts:true , nocache: true};
			var p = this.add(new Ext.Panel({
				 id : id , cclass : cls , region:'center',
					autoLoad:autoLoad , layout:'border'
				 , iconCls: cls , title:title,closable:true
			}));
			this.setActiveTab(p);
	}
}) ;


Ext.onReady(function(){
	 
	Ext.QuickTips.init();
	
	/**var themeCombo = new Ext.ux.form.ThemeCombo({
			  renderTo : 'themect'
		});
	*/
	var dsp = new Ext.Panel({
		  title:"系统导航",layoutConfig:{
					animate:true,
					activeOnTop:true
			} ,
		  region:'west', split:'true',width:210,margins:'0 0 5 0',
			layout:'accordion',
			items:[{
						title:'系统管理',border:false,autoScroll:true , contentEl:'dsp.card.0101'
						},
						{
							title:'公司管理',border:false,autoScroll:true, contentEl:'dsp.card.0201'
						}	,
							{
								title:'员工管理',border:false,autoScroll:true, contentEl:'dsp.card.0301'
							}	,
								{
									title:'社保管理',border:false,autoScroll:true, contentEl:'dsp.card.0401'
								}
								,
								{
									title:'分析管理',border:false,autoScroll:true, contentEl:'dsp.card.0501'
								}
			]
	})
	var mainPanel = new MainPanel();
	
	dsp.on('click' , function(node,e){
		  if (node.leaf) {
			  e.stopEvent();
				mainPanel.loadClass(node.attributes.href , node);
				//do_ajax_request(node.attributes.href,node);
		}
	});
	mainPanel.on('tabchange', function(tp , tab){
		 //dsp.selectClass(tab.cclass);
	});
	
	var viewport = new Ext.Viewport({
		   layout:'border', 
			 items : [{
				region:'north',contentEl:'north', 
				layout:'fit', height:40
			}, dsp , mainPanel]
	});
	
	viewport.doLayout();
	//tree start
	var node_0101 = new Ext.tree.TreeNode({
		 text:'系统管理', listeners:{
			 'click':function(){

			}
		 } ,
	 	 expanded:false,id:'id_node_0101'
	});
	var node_010101 = new Ext.tree.TreeNode({
		 text:'社保信息', listeners:{
			 'click':function(){
				mainPanel.loadClass('','社保信息','','insure-program-id');
			}
		 } ,
		 expanded:false,id:'id_node_010101'
	})
	node_0101.appendChild(node_010101);
	var treePanel_0101 = new Ext.tree.TreePanel({
			 autoHeight:false,autoWidth:false,autoScroll:false,
			 animate:false,rootVisible:false,
			useArrows:true,title:'',
			border:false,containerScroll:true,applyTo:'dsp.card.0101',
			root:node_0101
	});
	
	//公司信息
	var node_0201 = new Ext.tree.TreeNode({
			text:'公司信息' , expanded:false,id:'id_node_0201'
	});
	var node_020101 = new Ext.tree.TreeNode({
		 text:'公司信息',listeners:{
			'click':function(){
				 mainPanel.loadClass('companies','公司信息','','companies-id');
			}
		}
	});
	var node_020102 = new Ext.tree.TreeNode({
		 text:'社保配置-公司',listeners:{
			'click':function(){
				mainPanel.loadClass('company_accounts','社保配置-公司','','company-accounts-id');
			}
		}
	});	
	var node_020103 = new Ext.tree.TreeNode({
			 text:'社保配置-个人',listeners:{
				'click':function(){
					mainPanel.loadClass('personal_accounts','社保配置-个人','','personal-accounts-id');
				}
			}
		});
	node_0201.appendChild(node_020101);
	node_0201.appendChild(node_020102);
	node_0201.appendChild(node_020103);
	var treePanel_0201 = new Ext.tree.TreePanel({
		 autoHeight:false,autoWidth:false,autoScroll:false,
		 animate:false,rootVisible:false,
		 useArrows:true,title:'',
	 	 border:false,containerScroll:true,applyTo:'dsp.card.0201',
		 root:node_0201
	});
	
	var node_0301 = new Ext.tree.TreeNode({
		text:'员工管理', expanded:false,id:'id_node_0301'
	})
	var node_030101 = new Ext.tree.TreeNode({
		text:'员工信息',listeners:{
			'click':function(){
				 mainPanel.loadClass('employees','员工信息','','employees-id');
			}
		}
	})
	/*
	var node_030102 = new Ext.tree.TreeNode({
		 text:'社保管理',listeners:{
			'click':function(){
				 mainPanel.loadClass('employees/insure','社保管理','','employees_insure-id');
			}
		}
	})
	var node_030103 = new Ext.tree.TreeNode({
		 text:'公积金管理',listeners:{
			'click':function(){
				 mainPanel.loadClass('employees/provident','公积金管理','','employees_provident-id');
			}
		}
	})*/
	node_0301.appendChild(node_030101);
	//node_0301.appendChild(node_030102);
	//node_0301.appendChild(node_030103);
	var treePanel_0301 = new Ext.tree.TreePanel({
		 autoHeight:false,autoWidth:false,autoScroll:false,
		 animate:false,rootVisible:false,
		 useArrows:true,title:'',
	 	 border:false,containerScroll:true,applyTo:'dsp.card.0301',
		 root:node_0301
	});
	
	var node_0401 = new Ext.tree.TreeNode({
		text:"社保管理",expanded:false,id:'id_node_0401'
	});
	var node_040101 = new Ext.tree.TreeNode({
		 text:'社保&公积金计算',listeners:{
			'click':function(){
				 mainPanel.loadClass('insure_results/calcs','社保&公积金计算','','insure_results_calcs-id');
			}
		}
	})
	var node_040102 = new Ext.tree.TreeNode({
		 text:'社保&公积金查询',listeners:{
			'click':function(){
				 mainPanel.loadClass('insure_results','社保&公积金查询','','insure_results-id');
			}
		}
	})
	node_0401.appendChild(node_040101);
	node_0401.appendChild(node_040102);
	var treePanel_0401 = new Ext.tree.TreePanel({
		 autoHeight:false,autoWidth:false,autoScroll:false,
		 animate:false,rootVisible:false,
		 useArrows:true,title:'',
	 	 border:false,containerScroll:true,applyTo:'dsp.card.0401',
		 root:node_0401
	});
	//分析管理
	var node_0501 = new Ext.tree.TreeNode({
		text:"分析管理",expanded:false,id:'id_node_0501'
	});
	var node_050101 = new Ext.tree.TreeNode({
		 text:'人员花名册',listeners:{
			'click':function(){
				 mainPanel.loadClass('report_emps/query','人员花名册','','aray-emp-details-id');
			}
		}
	})
	var node_050102 = new Ext.tree.TreeNode({
		 text:'社保明细',listeners:{
			'click':function(){
				 mainPanel.loadClass('insure_results','社保明细','','aray-insure-details-id');
			}
		}
	})
	var node_050103 = new Ext.tree.TreeNode({
		 text:'公积金明细',listeners:{
			'click':function(){
				 mainPanel.loadClass('insure_results','公积金明细','','aray-provident-details-id');
			}
		}
	})
	var node_050104 = new Ext.tree.TreeNode({
		 text:'对帐单',listeners:{
			'click':function(){
				 mainPanel.loadClass('insure_results','对帐单','','aray-company-dsp-id');
			}
		}
	})
	var node_050105 = new Ext.tree.TreeNode({
		 text:'统计指标',listeners:{
			'click':function(){
				 mainPanel.loadClass('insure_results','统计指标','','aray-company-sum-id');
			}
		}
	})
	node_0501.appendChild(node_050101);
	node_0501.appendChild(node_050102);
	node_0501.appendChild(node_050103);
	node_0501.appendChild(node_050104);
	node_0501.appendChild(node_050105);
	var treePanel_0501 = new Ext.tree.TreePanel({
		 autoHeight:false,autoWidth:false,autoScroll:false,
		animate:false,rootVisible:false,useArrows:true,
		border:false , containerScroll:true,applyTo:'dsp.card.0501',
		root:node_0501
	})
	 //tree end
});

var Dsp = {};

function autoResize(){
	
	 var dspBody = Ext.getCmp("dsp-body");
	
	 var w = dspBody.getActiveTab().getInnerWidth();
	 var h = dspBody.getActiveTab().getInnerHeight();
	 
	 var subPage = Ext.getCmp('querys-grid');
	 if (subPage) {
			 subPage.setWidth(w);
			 subPage.setHeight(h);
	}
}

var oTime;
window.onresize = function(){
	  if (oTime){
		  clearTimeout(oTime);
	}
	oTime = setTimeout("autoResize();",100);
} 

Ext.override(Ext.form.ComboBox , {
	setValue:function(v){
		var text = v;
		         if (this.valueField) {
		             var r = this.findRecord(this.valueField, v);
		             if (r) {
		                 text = r.data[this.displayField];
		                 this.fireEvent('select', this, r, this.store.indexOf(r));
		             } else if (Ext.isDefined(this.valueNotFoundText)) {
		                 text = this.valueNotFoundText;
		             }
		         }
		         this.lastSelectionText = text;
		         if (this.hiddenField) {
		             this.hiddenField.value = v;
		         }
		         Ext.form.ComboBox.superclass.setValue.call(this, text);
		         this.value = v;
		         return this;
	}
})