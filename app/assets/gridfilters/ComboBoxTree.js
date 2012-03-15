ComboBoxTree = Ext.extend(Ext.form.ComboBox, {
    treeHeight : 180,
    allowUnLeafClick:false,
    url:'',
    setFieldValue:function(id,text){
        this.setValue(text);
        this.hiddenField.value = id;
    },
    onSelect:function(id , text){
        
    },

    store : new Ext.data.SimpleStore({
            fields : [],
            data : [[]]
    }),

    //Default
    editable : false, // 禁止手写及联想功能
    mode : 'local',
    triggerAction : 'all',
    maxHeight : 500,
    selectedClass : '',
    onSelect : Ext.emptyFn,
    emptyText : '请选择...',

    /**
     * 初始化
     * Init
     */
    initComponent : function() {
        ComboBoxTree.superclass.initComponent.call(this);
        this.tplId = Ext.id();
        this.tpl = '<div id="' + this.tplId + '" style="height:' + this.treeHeight + 'px;overflow:hidden;"></div>';

        var tree = new Ext.tree.TreePanel({
            root:new Ext.tree.AsyncTreeNode({id:'0',text:''}),
            loader:new Ext.tree.TreeLoader({dataUrl:this.url}),
            autoScroll:true,
            height:this.treeHeight,
            rootVisible:false,
            border:false
        });
        var combo = this;
        tree.on('beforeload',function(node){
            tree.loader.dataUrl = combo.url+'&parent_id='+node.id;
        });
        tree.on('click',function(node){
            if (combo.allowUnLeafClick == true){
                combo.setValue(node.text);
                combo.hiddenField.value = node.id;
                combo.collapse();
                combo.onSelect(node.id , node.text);
            }
            else if (node.leaf == true){
                combo.setValue(node.text);
                combo.hiddenField.value = node.id;
                combo.collapse();
                combo.onSelect(node.id , node.text);
            }
        });
        this.tree = tree;
    },
		onViewClick : function(doFocus){
				 var index = this.view.getSelectedIndexes()[0] , 
				 s = this.store ,
				 r = s.getAt(index);
				 if(r){
					 this.onSelect(r,index);
				}
				if(doFocus !== false) {
					 this.el.focus();
				}
		} ,

    /**
     * ------------------
     * 事件监听器 
     * Listener
     * ------------------
     */
    listeners : {
        'expand' : {
            fn: function() {
                if (!this.tree.rendered && this.tplId) {
                    this.tree.render(this.tplId);
                    this.tree.root.expand();
                    this.tree.root.select();
                }
                this.tree.show();
            }
        },
        'render':{
            fn:function(){
                this.hiddenField = this.el.insertSibling({
                    tag:'input',
                    type:'hidden',
                    name:this.getName()
                },'before',true);
                this.el.dom.removeAttribute('name');
            }
        }
    }
});

/**
 * --------------------------------- 
 * 将ComboBoxTree注册为Ext的组件,以便使用
 * Ext的延迟渲染机制，xtype:'combotree' 
 * ---------------------------------
 */
Ext.reg('combotree', ComboBoxTree);