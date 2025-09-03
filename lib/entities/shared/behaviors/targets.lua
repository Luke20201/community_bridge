if IsDuplicityVersion() then return end
local Targets = {
    property = "targets",
    default = {
        label = "Default Target Label",
        distance = 2,
    }
}

function Targets.OnSpawn(entityData)
    if not entityData.spawned or not entityData.targets then return end
    if entityData.targets?.label then
        local temp = entityData.targets
        entityData.targets = {temp}
    end
    local numberedTargets = {}
    for k, v in pairs(entityData.targets) do
        local onSelect = v.onSelect
        if onSelect then
            v.onSelect = function(entity)
                onSelect(entityData, entity)
            end
        end
        table.insert(numberedTargets, v)
    end
    table.sort(numberedTargets, function(a, b) return (a.label < b.label) end)
    Bridge.Target.AddLocalEntity(entityData.spawned, numberedTargets)
    entityData.oldTargets = entityData.targets
    Bridge.Entity.Set(entityData.id, "oldTargets", entityData.oldTargets)
end

function Targets.OnRemove(entityData)
    if not entityData.spawned or not entityData.oldTargets then return end
    Bridge.Target.RemoveLocalEntity(entityData.spawned)
end

function Targets.OnUpdate(entityData)
    if not entityData.spawned or not entityData.oldTargets then return end
    local doesntMatch = false
    for k, v in pairs(entityData.targets) do
        if not entityData.oldTargets or not entityData.oldTargets[k] then
            doesntMatch = true
            break
        end
        local old = entityData.oldTargets[k]
        if old.label ~= v.label
            or old.distance ~= v.distance
            or old.description ~= v.description
        then
            doesntMatch = true
            break
        end
    end
    if doesntMatch then
        Targets.OnRemove(entityData)
        Wait(100)
        Targets.OnSpawn(entityData)
    end
end
Bridge.Entity.RegisterBehavior("targets", Targets)
return Targets