class Excel

	def self.to_excel(company , config , employees)
	   yearmonth = config[:yearmonth]
	   begin
	      Dir.mkdir("#{Rails.root}/public/bill/#{yearmonth}")
     rescue
       
     end
	   f = File.new(File.join("#{Rails.root}/public/bill/#{yearmonth}","#{company.ccname}.xls"),"w+")
	   f.puts('<table align="center" width="80%" border="1" cellpadding="0" cellspacing="0" class="borderTable1">')
	   f.puts("<caption><font color=blue size=3>#{company.ccname}<b><font color=blue size=3><b>对账单</b></font></caption>")
	   f.puts('<col width=60 span="18">')
	   f.puts('<tr height="30">')
	   f.puts("<td height='30' class='tdss' colspan='18'>帐单日期：#{yearmonth.slice(0,4)}年#{yearmonth.slice(4,2)}月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  最迟付款日: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  制作单位：#{Infomation.available_systemsettings.company}</td>")
	   f.puts('</tr><tr height="30">')
	   f.puts('<td height="30" colspan="2">新增人员名单</td>')
	   f.puts("<td colspan='13' class='tdss'>#{config[:new].join(',')}</td>")
 	   f.puts("<td colspan='3'>合计#{config[:new].length}人</td>")	   	   	   
	   f.puts('</tr><tr height="30">') 
	   f.puts('<td height="30" colspan="2">终止人员名单</td>')
	   f.puts("<td colspan='13' class='tdss'>#{config[:quit].join(',')}</td>")
 	   f.puts("<td colspan='3'>合计#{config[:quit].length}人</td>")	   
 	   f.puts('</tr><tr height="30">') 
	   f.puts('<td colspan="2" height="30">服务反馈及说明</td>')
	   f.puts('<td colspan="16"></td>')
 	   f.puts('</tr><tr height="30">') 
      f.puts('<td rowspan="2" height="30" width="10" align="center">序号</td>')
      f.puts('<td rowspan="2" width="20" align="center">社保卡号</td>')
      f.puts('<td rowspan="2" align="center">姓名</td>')
      f.puts('<td rowspan="2" width="20" align="center">进本单位参保时间</td>')
      f.puts('<td rowspan="2" width="20" align="center">社保基数</td>')
      f.puts('<td colspan="4" align="center">社保费用明细</td>')
      f.puts('<td rowspan="2" width="20" align="center">公积金基数</td>')
      f.puts('<td colspan="4" align="center">公积金费用明细</td>')
      f.puts('<td rowspan="2" width="20" align="center">其他费用</td>')
      f.puts('<td rowspan="2" width="20" align="center">服务费</td>')
      f.puts('<td rowspan="2" align="center">合计</td>')
      f.puts('<td width="20" rowspan="2" align="center">备注</td>')
      f.puts('</tr>')
      f.puts('<tr height="30">')
      f.puts('<td height="30" width="20" align="center">企业</td>')
      f.puts('<td width="20" align="center">补缴</td>')
      f.puts('<td width="20" align="center">员工</td>')
      f.puts('<td width="20" align="center">补缴</td>')
      f.puts('<td width="20" align="center">企业</td>')
      f.puts('<td width="20" align="center">补缴</td>')
      f.puts('<td width="20" align="center">员工</td>')
      f.puts('<td width="20" align="center">补缴</td>')
      f.puts('</tr>')
      i = 1
      suminsurecolu = 0.00
    	sumprovidcolu = 0.00
      employees.each do |employee|
        suminsure = 0.00
       	sumprovid = 0.00
       	f.puts("")
       	f.puts('<tr height="30">')
        f.puts("<td height=\"30\" width=\"20\" align=\"center\">#{i}</td>")
        f.puts("<td align='center'>#{employee.insure_card}</td>")
        f.puts("<td align='center'>#{employee.empname}</td>")
        f.puts("<td align='center'>#{yearmonth.slice(0,4)}年#{yearmonth.slice(4,2)}月</td>")
        f.puts("<td align='center'>#{employee.insure_base}</td>")
        money = config[:moneysPerson][yearmonth + ";" + employee.company.to_s + ";" + employee.id.to_s]  
        if money.blank?
            f.puts("<td width='20' align='right'>&nbsp;</td>")
        else
            f.puts("<td width='20' align='right'>#{money[0]}</td>")
            suminsurecolu = suminsurecolu + money[0].to_f
            suminsure = suminsure + money[0].to_f
        end      
        f.puts("<td width='20' align=right>-</td>")
        if money.blank? 
           f.puts("<td width='20' align='right'>&nbsp;</td>")
        else
          f.puts("<td width='20' align='right'>#{money[1]}</td>")
          suminsurecolu = suminsurecolu + money[1].to_f
          suminsure = suminsure + money[1].to_f
        end
        f.puts("<td width='20' align=right>-</td>")
        f.puts("<td width='20' align=right>#{employee.provident_base}</td>")
        moneyCom = config[:moneysCom][yearmonth + ";" + employee.company.to_s + ";" + employee.id.to_s]
        if moneyCom.blank?  
            f.puts("<td width='20' align=right>&nbsp;</td>")
        else
            f.puts("<td width='20' align=right>#{moneyCom[0]}</td>")
            sumprovidcolu = sumprovidcolu + moneyCom[0].to_f
            sumprovid = sumprovid + moneyCom[0].to_f
        end
        if moneyCom.blank? 
           f.puts("<td width='20' align=right>&nbsp;</td>")
        else
           f.puts("<td width='20' align=right>#{moneyCom[1]}</td>")      
           sumprovidcolu = sumprovidcolu + moneyCom[1].to_f
           sumprovid = sumprovid + moneyCom[1].to_f   
        end
        f.puts("<td width='20' align=right>-</td>")
        f.puts("<td width='20' align=right>-</td>")
        f.puts("<td width='20' align=right>-</td>")
        f.puts("<td width='20' align=right>#{suminsure + sumprovid}</td>")   
        f.puts("<td></td>")                             
        f.puts("</tr>")
        i += 1
      end
      f.puts("<tr height=30>")
      f.puts("<td colspan=5 height=30 align=left>费用合计:</td>")
      f.puts("<td colspan=4 height=20 align=right>#{suminsurecolu}</td>")
      f.puts("<td colspan=5 height=20 align=right>#{sumprovidcolu}</td>")      
      f.puts("<td width='20' align=right>-</td>")
      f.puts("<td width='20' align=right>-</td>")
      f.puts("<td width='20' align=right>#{suminsurecolu + sumprovidcolu}</td>")
      f.puts("<td></td>")                               
      f.puts("</tr>")    
      f.puts("<tr>")
      f.puts("<td colspan=18 height=30>#{yearmonth.slice(0,4)}年#{yearmonth.slice(4,2)}月应付款合计(元):#{suminsurecolu + sumprovidcolu}元  发票金额: #{suminsurecolu + sumprovidcolu}元")
      f.puts("</tr><tr height=30><td colspan=18></td></tr>")
      f.puts("<tr height=30><td colspan=18 align=left>户名: #{Infomation.available_systemsettings.company}   银行帐户: #{Infomation.available_systemsettings.bank_account}   开户行:#{Infomation.available_systemsettings.open_bank}</td></tr>")
      f.puts("</tr>")
	    f.puts('</table>')
	   f.close
	end

end