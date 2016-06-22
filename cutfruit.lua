if io.exists("assets/ccplaymerket.apk") then
	release_print("CutFruit:游戏异常")
	-- showMessageBox({
	-- 	title = "你可能是盗版受害者，游戏将要退出，如果你使用的是正版游戏，请开启网络重新检测！", 
	-- 	style = "yes", 
	-- 	onYes = function() GameController.exit() end,
	-- 	onClose = function() GameController.exit() end
	-- })
	-- scheduler.performWithDelayGlobal(function() 
	-- 	GameController.exit()
	-- end, 10) 
else
	release_print("正版游戏")
end
return true;