# mVeinPaycheck
- Special character salary system for QBCore
- New QBCore

# Showcase (tr)
![image](https://github.com/mertvein/mVeinPaycheck/assets/79944577/bd44b5b2-65d5-4e98-be27-cf6bd6eca0f8)

## Discord
- https://discord.gg/mert

## Features
- Compatible with qb-core
- Salaries are deposited into your account at the Central Bank at regular intervals.
- In your account at the central bank, you can view your salary history, down to the amount deposited, when it was deposited or when you withdrew your salary.
- If you wish, you can withdraw all the money accumulated in your salary account or a certain amount you want.

## qb-core
- qb-core/server/events.lua find `QBCore:job-money` and change with:
```
RegisterServerEvent("QBCore:job-money")
AddEventHandler('QBCore:job-money', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local citizenid = Player.PlayerData.citizenid
	if Player ~= nil then
		local money = Player.PlayerData.job.payment
		if Player.PlayerData.job.paySafe then
			if QBCore.Functions.removeJobMoney(Player.PlayerData.job.name, money) then
				TriggerEvent('mVeinPaycheck:server:AddMoneyToPayCheck', citizenid,money,Player.PlayerData.job.name)
				TriggerClientEvent('QBCore:Notify', src, "Maaşınız " ..money.. "$ Yatırıldı. Merkez Bankasından Çekebilirsiniz")
			else
				TriggerClientEvent('QBCore:Notify', src, "Şirket Hesabında Yeteri Kadar Para Olmadığı İçin Maaşınız Yatırılamadı!")
			end
		else
            TriggerEvent('mVeinPaycheck:server:AddMoneyToPayCheck', citizenid,money,Player.PlayerData.job.name)
			TriggerClientEvent('QBCore:Notify', src, "Maaşınız " ..money.. "$ Yatırıldı. Merkez Bankasından Çekebilirsiniz")
		end
	end
end)
```
- qb-core/server/functions.lua find `PaycheckInterval()` and change with:
```
function PaycheckInterval()
    if next(QBCore.Players) then
        for _, Player in pairs(QBCore.Players) do
            if Player then
                local citizenid = Player.PlayerData.citizenid
                local payment = QBShared.Jobs[Player.PlayerData.job.name]['grades'][tostring(Player.PlayerData.job.grade.level)].payment
                if not payment then payment = Player.PlayerData.job.payment end
                if Player.PlayerData.job and payment > 0 and (QBShared.Jobs[Player.PlayerData.job.name].offDutyPay or Player.PlayerData.job.onduty) then
                    TriggerEvent('mVeinPaycheck:server:AddMoneyToPayCheck', citizenid, payment, Player.PlayerData.job.name)
                    TriggerClientEvent('QBCore:Notify', src, "Maaşınız " ..payment.. "$ olarak merkez bankasına yatırıldı.", "success")
                end
            end
        end
    end
    SetTimeout(QBCore.Config.Money.PayCheckTimeOut * (60 * 1000), PaycheckInterval)
end
```

## Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-target](https://github.com/qbcore-framework/qb-target)

### Installation
- Download the script and put it in the your resource directory.
- Charge sql file `paycheck.sql`
- Add the following code to your server.cfg/resources.cfg
```
ensure mVeinPaycheck
```
