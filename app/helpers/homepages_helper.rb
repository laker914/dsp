module HomepagesHelper
  
  def ext_treemenu_for(options = {})
     renderto = options[:renderto] || "leftcolumn"
     
     javascript_tag <<-_JSTREE
     
          function init_tree_within_extonready(){
     
              var exttree_menu_root = new Ext.tree.AsyncTreeNode({
                  text:'Menu',draggable:false,id:'root',
                  expanded: true , children : [Apps.classData]
              });
              
              var exttree_menu_toolbar = new Ext.Toolbar({
                  items:[{
                    xtype:'button', text:'展开',
                    handler: function(){
                        exttree_menu.expandAll();
                    } ,
                    iconCls:'icon-expand-all'
                  } , {
                     xtype:'button',text:'关闭',
                     handler:function(){
                        exttree_menu.collapseAll();
                     },iconCls:'icon-collapse-all'
                  }]
              }) ;
              
              var exttree_menu = new Ext.tree.TreePanel({
                  renderTo : '#{renderto}',
                  containerScroll:true, animate:true, id:'exttreepanel_navgationmenu',
                  stateId : 'menutree_stateid', stateful:true,
                  stateEvents:['expandnode' , 'collapsenode'],
                  frame:false, border:false,lines:false,root:exttree_menu_root,
                  rootVisible:false, 
                  loader:new Ext.tree.TreeLoader(),
                  tbar:exttree_menu_toolbar, useArrows:false
              });
              
              var treePanelOnClick = function(node , e) {
                    if (node.leaf) {
              			  e.stopEvent();
              				do_ajax_request(node.attributes.href);
              		}
              }
              exttree_menu.on('click',treePanelOnClick,this , true);
          }
     _JSTREE
  end
  
end
