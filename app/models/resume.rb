class Resume < ActiveRecord::Base
	
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.

  validates :name, presence: true # Make sure the owner's name is present.



  def format_data
	
	
	r = Rserve::Connection.new
	r.eval("file_path='/home/ruby/appdata/R1/'")
	r.void_eval <<-EOF

	library(xml2, warn.conflicts = FALSE)
	suppressMessages(library(foreach, warn.conflicts = FALSE))
	suppressMessages(library(doSNOW, warn.conflicts = FALSE))
	library(plyr, warn.conflicts = FALSE)
	suppressMessages(library(data.table, warn.conflicts = FALSE))
	library(dtplyr, warn.conflicts = FALSE)
	library(dplyr, warn.conflicts = FALSE)
	library(purrr, warn.conflicts = FALSE)
	library(stringr, warn.conflicts = FALSE)
	library(pipeR, warn.conflicts = FALSE)
	library(rlist, warn.conflicts = FALSE)
	library(tidyr)
	 
	dat <- fread(paste(file_path,"input/input.csv",sep=""))
	dat$統計日期 <- dat$統計日期 %>>% as.Date
	dat %>>% group_by(課別名稱,統計日期,商品類別名稱,卡友分群類別名稱) %>>%
	        summarise(全館消費金額=sum(全館消費金額)) %>>% ungroup %>>%
	        write.csv(paste(file_path,"output/output.csv",sep=""))
	EOF
    # r.eval("file_path").to_ruby

  end

end