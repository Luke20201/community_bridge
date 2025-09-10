---@diagnostic disable: duplicate-set-field
if GetResourceState('fd_banking') == 'missing' then return end
Banking = Banking or {}

local fd_banking = exports['fd_banking']

---This will get the name of the Managment system being being used.
---@return string
Banking.GetManagmentName = function()
    return 'fd_banking'
end

---This will get the name of the in use resource.
---@return string
Banking.GetResourceName = function()
    return 'fd_banking'
end

---This will return a number
---@param account string
---@return number
Banking.GetAccountMoney = function(account)
    return fd_banking:GetAccount(account)
end

---This will add money to the specified account of the passed amount
---@param account string
---@param amount number
---@param reason string
---@return boolean
Banking.AddAccountMoney = function(account, amount, reason)
    return fd_banking:AddMoney(account, amount, reason)
end

---This will remove money from the specified account of the passed amount
---@param account string
---@param amount number
---@param reason string
---@return boolean
Banking.RemoveAccountMoney = function(account, amount, reason)
    return fd_banking:RemoveMoney(account, amount, reason)
end

return Banking