Ext.ns('Ext.ux.form');

/**
 * Creates new ThemeCombo
 * @constructor
 * @param {Object} config A config object
 */
Ext.ux.form.ThemeCombo = Ext.extend(Ext.form.ComboBox, {
	// configurables
	 themeBlueText: 'Ext Blue Theme'
	,themeGrayText: 'Gray Theme'
	,themeBlackText: 'Black Theme'
	,themeOliveText: 'Olive Theme'
	,themePurpleText: 'Purple Theme'
	,themeDarkGrayText: 'Dark Gray Theme'
	,themeSlateText: 'Slate Theme'
	,themeVistaText: 'Vista Theme'
	,themePeppermintText: 'Peppermint Theme'
	,themePinkText: 'Pink Theme'
	,themeChocolateText: 'Chocolate Theme'
	,themeGreenText: 'Green Theme'
	,themeIndigoText: 'Indigo Theme'
	,themeMidnightText: 'Midnight Theme'
	,themeSilverCherryText: 'Silver Cherry Theme'
	,themeSlicknessText: 'Slickness Theme'
	,themeVar:'theme'
	,selectThemeText: 'Select Theme'
	,themeGrayExtndText:'Gray-Extended Theme'
	,themeUbuntuHumanText:'Ubuntu Human'
	,lazyRender:true
	,lazyInit:true
	,cssPath:'../themes/' // mind the trailing slash

	// {{{
	,initComponent:function() {

		var config = {
			store: new Ext.data.SimpleStore({
				fields: ['themeFile', {name:'themeName', type:'string'}]
				,data: [
					 ['xtheme-default.css', this.themeBlueText]
					,['xtheme-gray.css', this.themeGrayText]
					,['darkgray/css/xtheme-darkgray.css', this.themeDarkGrayText]
					,['black/css/xtheme-black.css', this.themeBlackText]
					,['olive/css/xtheme-olive.css', this.themeOliveText]
					,['purple/css/xtheme-purple.css', this.themePurpleText]
					,['slate/css/xtheme-slate.css', this.themeSlateText]
					,['peppermint/css/xtheme-peppermint.css', this.themePeppermintText]
					,['chocolate/css/xtheme-chocolate.css', this.themeChocolateText]
					,['green/css/xtheme-green.css', this.themeGreenText]
					,['indigo/css/xtheme-indigo.css', this.themeIndigoText]
					,['midnight/css/xtheme-midnight.css', this.themeMidnightText]
					,['silvercherry/css/xtheme-silvercherry.css', this.themeSilverCherryText]
					,['slickness/css/xtheme-slickness.css', this.themeSlicknessText]
					,['gray-extend/css/xtheme-gray-extend.css', this.themeGrayExtndText]
					,['ubuntu_human/css/xtheme-human.css',this.themeUbuntuHumanText]
//					,['xtheme-pink.css', this.themePinkText]
				]
			})
			,valueField: 'themeFile'
			,displayField: 'themeName'
			,triggerAction:'all'
			,mode: 'local'
			,forceSelection:true
			,editable:false
			,fieldLabel: this.selectThemeText
		}; // eo config object

		// apply config
        Ext.apply(this, Ext.apply(this.initialConfig, config));

		this.store.sort('themeName');

		// call parent
		Ext.ux.form.ThemeCombo.superclass.initComponent.apply(this, arguments);

		if(false !== this.stateful && Ext.state.Manager.getProvider()) {
			this.setValue(Ext.state.Manager.get(this.themeVar) || 'gray-extend/css/xtheme-gray-extend.css');
		}
		else {
			this.setValue('gray-extend/css/xtheme-gray-extend.css');
		}

	} // end of function initComponent
	// }}}
	// {{{
	,setValue:function(val) {
		Ext.ux.form.ThemeCombo.superclass.setValue.apply(this, arguments);

		// set theme
		Ext.util.CSS.swapStyleSheet(this.themeVar, this.cssPath + val);

		if(false !== this.stateful && Ext.state.Manager.getProvider()) {
			Ext.state.Manager.set(this.themeVar, val);
		}
	} // eo function setValue
	// }}}

}); // end of extend

// register xtype
Ext.reg('themecombo', Ext.ux.form.ThemeCombo);

// eof
