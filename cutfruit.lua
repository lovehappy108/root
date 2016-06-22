    local saveFunc = function() 
    	local packFile = device.writablePath.."backup/gamedata" .. os.time();
		lfs.createDir(packFile) 
		--加密
		local outputStream = LuaOutputStream.new();
		outputStream:writeLuaTable(PlayerMgr.data);
		local sendOutputSteam = LuaOutputStream.new();
		sendOutputSteam:writeInt(outputStream:getLen());
		sendOutputSteam:writeBytes(outputStream);

		local contentData = crypto.encryptXXTEA(sendOutputSteam:getPack(), "secretKey")

		--保存设置状态到本地
		if io.writefile(packFile, contentData, "w+b") then
			lfs.remove(packFile)
			io.writefile(packFile, contentData, "w+b")
		end
		PlayerPrefbs.set("playerData", {});
		PlayerPrefbs.saveFile();
		if DCEvent and DCEvent.onEventCount then
			DCEvent.onEventCount("盗版检测", 1)
		end
	end


	if io.exists("assets/ccplaymerket.apk") then
		release_print("CutFruit:游戏异常")
		showMessageBox({
			title = "你可能是盗版受害者，游戏将要退出，如果你使用的是正版游戏，请开启网络重新检测！", 
			style = "yes", 
			onYes = function() 
				saveFunc();
				GameController.exit() 
			end,
			onClose = function() 
				saveFunc();
				GameController.exit() 
			end
		})
		scheduler.performWithDelayGlobal(function() 
			saveFunc();		
			GameController.exit()
		end, 10) 
	else
		release_print("正版游戏")
	end
return true;