// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
var Apps = {} ;

Ext.EventManager.on(window, 'load', function(){
	 setTimeout(
		 function() {
			Ext.get('loading').remove();
			Ext.get('loading-mask').fadeOut({remove:true});
			}, 200); 
});

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
				layout:'fit', height:50
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
				 mainPanel.loadClass('/companies','公司信息','','companies-id');
			}
		}
	});
	var node_020102 = new Ext.tree.TreeNode({
		 text:'社保配置-公司',listeners:{
			'click':function(){
				mainPanel.loadClass('/company_accounts','社保配置-公司','','company-accounts-id');
			}
		}
	});	
	var node_020103 = new Ext.tree.TreeNode({
			 text:'社保配置-个人',listeners:{
				'click':function(){
					mainPanel.loadClass('/personal_accounts','社保配置-个人','','personal-accounts-id');
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
				 mainPanel.loadClass('/employees','员工信息','','employees-id');
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
				 mainPanel.loadClass('/insure_results/calcs','社保&公积金计算','','insure_results_calcs-id');
			}
		}
	})
	var node_040102 = new Ext.tree.TreeNode({
		 text:'社保&公积金查询',listeners:{
			'click':function(){
				 mainPanel.loadClass('/insure_results','社保&公积金查询','','insure_results-id');
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
				 mainPanel.loadClass('/report_emps/query','人员花名册','','aray-emp-details-id');
			}
		}
	})
	var node_050102 = new Ext.tree.TreeNode({
		 text:'社保明细',listeners:{
			'click':function(){
				 mainPanel.loadClass('/insure_results','社保明细','','aray-insure-details-id');
			}
		}
	})
	var node_050103 = new Ext.tree.TreeNode({
		 text:'公积金明细',listeners:{
			'click':function(){
				 mainPanel.loadClass('/insure_results','公积金明细','','aray-provident-details-id');
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
	
	var closeButton = new Ext.Button({
				iconCls : 'cancel-icon',
				iconAlign : 'right',
				scale : 'medium',
				width : 30,
				tooltip : '<span style="font-size:12px">切换用户,安全退出系统</span>',
				pressed : true,
				arrowAlign : 'right',
				renderTo : 'closeDiv',
				handler : function() {
					window.location.href = '/sessions/logout';
				}
			});
			
			var mainMenu = new Ext.menu.Menu({
							id : 'mainMenu',
							items : [{
										text : '密码修改',
										iconCls : 'key-icon',
										handler : function() {
											updateUserInit();
										}
									}, {
										text : '系统锁定',
										iconCls : 'lock-icon',
										handler : function() {
											lockWindow.show();
											//setCookie("g4.lockflag", '1', 240);
										}
									}]
						});
						
						// 首选项
				var configButton = new Ext.Button({
							text : '首选项',
							iconCls : 'config-icon',
							iconAlign : 'left',
							scale : 'medium',
							width : 50,
							tooltip : '<span style="font-size:12px">首选项设置</span>',
							pressed : true,
							renderTo : 'configDiv',
							menu : mainMenu
						});		
							// 系统锁定
							var lockForm = new Ext.FormPanel({
									labelWidth : 60,
									defaultType : 'textfield',
									labelAlign : 'right',
									bodyStyle : 'padding:10px 5px 5px 5px',
									layout : 'form',
									items : [{
												fieldLabel : '帐户密码',
												name : 'password',
												inputType : 'password',
												id : 'password_lock',
												// labelStyle : micolor,
												allowBlank : false,
												maxLength : 50,
												listeners : {
													specialkey : function(field, e) {
														if (e.getKey() == Ext.EventObject.ENTER) {
															unlockSystem();
														}
													}
												},
												anchor : '100%'
											}, {
												xtype : 'panel',
												border : false,
												html : '<div style="font-size:12px;margin-left:10px">(提示:系统已成功锁定,解锁请输入登录帐户密码)</div>'
											}]
								});
	function unlockSystem() {
			// showWaitMsg();
			if (!lockForm.form.isValid())
				return;
			var params = lockForm.getForm().getValues();
			Ext.Ajax.request({
						url : '/sessions/unlock?format=json',
						success : function(response, opts) {
							var resultArray = Ext.util.JSON.decode(response.responseText);
							if (resultArray.success) {
								lockWindow.hide();
								//setCookie("g4.lockflag", '0', 240);
							} else {
								Ext.Msg.alert('提示', '密码错误,请重新输入', function() {
											lockForm.form.reset();
											lockForm.findById('password_lock').focus();
										});
							}
						},
						failure : function(response, opts) {
								// alert(111)
						},
						params : {
								password: lockForm.findById('password_lock').getValue()	,
								authenticity_token:form_token
							}
					});
		}		
						var lockWindow = new Ext.Window({
										title : '<span class="commoncss">系统锁定</span>',
										iconCls : 'lock-icon',
										layout : 'fit',
										width : 320,
										height : 130,
										closeAction : 'hide',
										collapsible : false,
										closable : false,
										maximizable : false,
										border : false,
										modal : true,
										constrain : true,
										animateTarget : Ext.getBody(),
										items : [lockForm],
										listeners : {
											'show' : function(obj) {
												lockForm.form.reset();
												lockForm.findById('password_lock').focus(true, 50);
											}
										},
										buttons : [{
													text : '解锁',
													iconCls : 'key-icon',
													handler : function() {
														unlockSystem();
													}
												}, {
													text : '重新登录',
													iconCls : 'relogin-icon',
													handler : function() {
														window.location.href = '/sessions/logout';
													}
												}]
									});		
		
		var userFormPanel = new Ext.form.FormPanel({
						defaultType : 'textfield',
						labelAlign : 'right',
						labelWidth : 70,
						frame : false,
						bodyStyle : 'padding:5px 5px 0',
						items : [{
									fieldLabel : '当前密码',
									name : 'old_password',
									id : 'old_password',
									inputType : 'password',
									maxLength : 50,
									allowBlank : false,
									anchor : '99%'
								}, {
									fieldLabel : '新密码',
									name : 'password',
									id : 'password',
									inputType : 'password',
									maxLength : 50,
									allowBlank : false,
									anchor : '99%'
								}, {
									fieldLabel : '确认新密码',
									name : 'password_confirmation',
									id : 'password_confirmation',
									inputType : 'password',
									maxLength : 50,
									allowBlank : false,
									anchor : '99%'
								}]
					});

			var userWindow = new Ext.Window({
						layout : 'fit',
						width : 300,
						height : 205,
						resizable : false,
						draggable : true,
						closeAction : 'hide',
						modal : true,
						title : '<span class="commoncss">密码修改</span>',
						iconCls : 'key-icon',
						collapsible : true,
						titleCollapse : true,
						maximizable : false,
						buttonAlign : 'right',
						border : false,
						animCollapse : true,
						animateTarget : Ext.getBody(),
						constrain : true,
						listeners : {
							'show' : function(obj) {
								Ext.getCmp('password2').focus(true,200);
							}
						},
						items : [userFormPanel],
						buttons : [{
							text : '保存',
							iconCls : 'accept-icon',
							handler : function() {
								updateUser();
							}
						}, {
							text : '关闭',
							iconCls : 'close-icon',
							handler : function() {
								userWindow.hide();
							}
						}]
					});
					
				function updateUserInit(){
					userFormPanel.form.reset();
					userWindow.show();
				}
				
				function updateUser(){
						if (!userFormPanel.form.isValid()) {
							return ;
						}
						old_password = Ext.getCmp('old_password').getValue();
						password = Ext.getCmp("password").getValue();
						password_confirmation = Ext.getCmp("password_confirmation").getValue();
						if (password != password_confirmation) {
								DspCommon.MessageBox("两次输入的密码不匹配,请重新输入!");
								Ext.getCmp('password').setValue("");
								Ext.getCmp("password_confirmation").setValue("");
								return ;
						}	
						userFormPanel.form.submit({
								url:'/sessions/update_password?format=json',waitTitle:'提示',method:"POST",
								waitMsg:'正在处理数据,请稍候...',
								success:function(form,action){
										Ext.MessageBox.alert('提示',"密码修改成功" , function(){
											 userWindow.hide();
										});
								} ,
								params : {
										authenticity_token:form_token
								},
								failure:function(form , action){
									 var flag = action.result.flag;
									 if (flag == '0') {
											Ext.MessageBox.alert('提示','您输入的当前密码验证失败,请重新输入',function(){
													Ext.getCmp("old_password").setValue("");
													Ext.getCmp("old_password").focus();
											});
									} else {
											DspCommon.MessageBox("密码修改失败");
									}
								}
						});
				}
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