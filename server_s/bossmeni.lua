ESX = nil
local JobInfo = {}


TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

MySQL.ready(
    function()
        MySQL.Async.fetchAll(
            "SELECT * FROM jobs WHERE 1",
            {},
            function(name)
                for _, v in ipairs(name) do
                    JobInfo[v.name] = {}
                    JobInfo[v.name].job_label = v.label
                    JobInfo[v.name].grades = {}

                    MySQL.Async.fetchAll(
                        "SELECT * FROM job_grades WHERE job_name = @job",
                        {["@job"] = v.name},
                        function(gradeInfo)
                            for __, g in ipairs(gradeInfo) do
                                JobInfo[v.name].grades[g.grade] = g
                            end
                        end
                    )
                end
            end
        )

       
    end
)



ESX.RegisterServerCallback(
    "core_jobutilities:getBossMenuData",
    function(source, cb, job)
        local xPlayer = ESX.GetPlayerFromId(source)

        local gradeInfo = {}
        for k, v in pairs(JobInfo[job].grades) do
            table.insert(gradeInfo, {grade = k, grade_label = v.label})
        end

        local employees = {}


        MySQL.Async.fetchAll(
            "SELECT * FROM users WHERE job = @job",
            {
                ["@job"] = job
            },
            function(info)
                for _, v in ipairs(info) do

                    if v.job_grade == nil then
                        v.job_grade = 0 end

                    table.insert(
                        employees,
                        {
                            identifier = v.identifier,
                            fullname = (v.firstname .. ' ' .. v.lastname) or "",
                            grade = v.job_grade,
                            grade_label = JobInfo[job].grades[tonumber(v.job_grade)].label
                        }
                    )
                end
 TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job, function(account)
                        if true then
                            cb(gradeInfo, employees, account.money, xPlayer.getJob().grade_name)
                        else
                            cb(gradeInfo, employees, "-", xPlayer.getJob().grade_name)
                        end
                    end
                )
            end
        )
    end
)


RegisterServerEvent("core_jobutilities:addJob")
AddEventHandler(
    "core_jobutilities:addJob",
    function(job)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        xPlayer.setJob(job, 0)

    end
)

RegisterServerEvent("core_jobutilities:hire")
AddEventHandler(
    "core_jobutilities:hire",
    function(id, job)
        local src = source

        local xPlayer = ESX.GetPlayerFromId(id)

        if xPlayer then
            TriggerClientEvent("core_jobutilities:sendMessage", xPlayer.source, Config.Text["hired"])
            TriggerClientEvent('okokNotify:Alert', source, "", "Radnja uspesno izvrsena", 5000, 'success')
           -- TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["action_success"])
            xPlayer.setJob(job, 0)

             MySQL.Async.execute(
                "UPDATE users SET `job`=@job, `job_grade`=@rank WHERE `identifier` = @identifier",
                {["@job"] = job, ["@rank"] = "0", ["@identifier"] = xPlayer.identifier},
                function()
                end
            )
        else
            TriggerClientEvent('okokNotify:Alert', source, "", "Radnja uspesno izvrsena", 5000, 'success')
        end
    end
)

RegisterServerEvent("core_jobutilities:fire")
AddEventHandler(
    "core_jobutilities:fire",
    function(identifier, job)
        local src = source
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)


        if xPlayer then
            if xPlayer.getJob().name == job then
                xPlayer.setJob("unemployed", 0)



                TriggerClientEvent("core_jobutilities:sendMessage", xPlayer.source, Config.Text["fired"])
                TriggerClientEvent('okokNotify:Alert', source, "", "Radnja uspesno izvrsena", 5000, 'success')
            else
                TriggerClientEvent("core_jobutilities:sendMessage", xPlayer.source, Config.Text["fired_other"])
            end

             
        end
            MySQL.Async.execute(
                "UPDATE users SET `job`=@job, `job_grade`=@rank WHERE `identifier` = @identifier",
                {["@job"] = "unemployed", ["@rank"] = "0", ["@identifier"] = identifier},
                function()
                end
            )
        
    end
)

RegisterServerEvent("core_jobutilities:deposit")
AddEventHandler(
    "core_jobutilities:deposit",
    function(job, amount)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        if xPlayer.getAccount("bank").money >= tonumber(amount) then

           TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job, function(account)
    account.addMoney( tonumber(amount))
end)
            xPlayer.removeAccountMoney("bank", tonumber(amount))
            TriggerClientEvent('okokNotify:Alert', source, "", "netacna kolicina", 5000, 'error')
        else
            TriggerClientEvent('okokNotify:Alert', source, "", "Radnja neuspesna", 5000, 'error')
           -- TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["insufficent_balance"])
        end
    end
)

RegisterServerEvent("core_jobutilities:givebonus")
AddEventHandler(
    "core_jobutilities:givebonus",
    function(identifier, amount, job)
        local src = source
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job, function(acc)

            local money = acc.money

        if money >= tonumber(amount) then
        if xPlayer then

                xPlayer.addAccountMoney('bank', tonumber(amount))
                TriggerClientEvent('okokNotify:Alert', source, "", "Dali ste bonus", 5000, 'success')
               -- TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["bonus_given"])
               TriggerClientEvent('okokNotify:Alert', xPlayer.source, "", "Primili ste bonus", 5000, 'success')
               -- TriggerClientEvent("core_jobutilities:sendMessage", xPlayer.source, Config.Text["bonus_recieved"] .. amount)
        else


                 MySQL.Async.execute(
               "UPDATE users SET `bank`=`bank` + @amount WHERE `identifier` = @identifier",
                {["@amount"] = tonumber(amount), ["@identifier"] = identifier},
                function()
                    TriggerClientEvent('okokNotify:Alert', source, "", "Dali ste bonus", 5000, 'success')
                end
            )

            --USER ACCOUNTS
            -- MySQL.Async.execute(
            --   "UPDATE user_accounts SET `money`=`money` + @amount WHERE `identifier` = @identifier AND `name` = 'bank'",
             --   {["@amount"] = tonumber(amount), ["@identifier"] = identifier},
            --    function()
             --        TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["bonus_given"])
             --   end
            --)
        end

        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job, function(account)
    account.removeMoney( tonumber(amount))

end)

    end
    end)
       
    end
)



RegisterServerEvent("core_jobutilities:withdraw")
AddEventHandler(
    "core_jobutilities:withdraw",
    function(job, amount)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

       TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job, function(account)
   

                if true then
                    local balance = account.money

                    if tonumber(balance) >= tonumber(amount) then

                        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job, function(account)
    account.removeMoney( tonumber(amount))
end)

                    
                                xPlayer.addAccountMoney("bank", tonumber(amount))
                           
                                TriggerClientEvent('okokNotify:Alert', source, "", "Radnja uspesno izvrsena", 5000, 'success')
                    else
                        TriggerClientEvent('okokNotify:Alert', source, "", "netacna kolicina", 5000, 'error')
                    end
                else
                    TriggerClientEvent('okokNotify:Alert', source, "", "Radnja neuspesna", 5000, 'error')
                end
            end
        )
    end
)

RegisterServerEvent("core_jobutilities:setRank")
AddEventHandler(
    "core_jobutilities:setRank",
    function(identifier, job, rank)
        local src = source
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)


        if xPlayer then
            if xPlayer.getJob().name == job then
                xPlayer.setJob(job, rank)
                TriggerClientEvent('okokNotify:Alert', source, "", "Radnja uspesna", 5000, 'success')
                TriggerClientEvent('okokNotify:Alert', source, "", "Unapredjeni ste", 5000, 'succes')
            else
                TriggerClientEvent('okokNotify:Alert', xPlayer.source, "", "Unapredili ste", 5000, 'error')
            end
        end
            MySQL.Async.execute(
                "UPDATE users SET `job`=@job, `job_grade`=@rank WHERE `identifier` = @identifier",
                {["@job"] = job, ["@rank"] = rank, ["@identifier"] = identifier},
                function()
                end
            )
        
    end
)

