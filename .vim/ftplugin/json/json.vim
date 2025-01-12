if exists("b:did_ftplugin")
  finish
endif

syntax match Comment +\/\/.\+$+
set conceallevel=1
