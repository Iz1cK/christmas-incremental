--!native
--!optimize 2
--!strict
--#region Services
--#endregion

--#region Packages
--#endregion

--#region Features
--#endregion

--#region Data
--#endregion

--#region Types
export type StateItem = {
    onEnter: () -> (),
    onUpdate: (deltaTime: number) -> (),
    onExit: () -> (),
}

export type _StateMachinePrototype = {
    __index: _StateMachinePrototype,
    new: () -> StateMachine,
    AddState: (self: StateMachine, stateName: string, stateItem: StateItem) -> boolean,
    RemoveState: (self: StateMachine, stateName: string) -> boolean,
    ChangeState: (self: StateMachine, stateName: string) -> boolean,
    GetCurrentState: (self: StateMachine) -> string?,
    Update: (self: StateMachine, deltaTime: number) -> (),
}

export type _StateMachineData = {
    currentState: string?,
    stateList: {[string]: StateItem},
}
export type StateMachine = typeof(setmetatable({} :: _StateMachineData, {} :: _StateMachinePrototype))
--#endregion

--#region Variables
local StateMachine: _StateMachinePrototype = {} :: _StateMachinePrototype
StateMachine.__index = StateMachine
--#endregion

--#region Function Declerations
--#endregion

--#region Functions
--- Creates a new StateMachine
--- @param initState string
--- @return StateMachine
function StateMachine.new(): StateMachine
    local _data: _StateMachineData = {
        currentState = nil,
        stateList = {},
    }
    local self = setmetatable(_data, StateMachine)
    return self
end

--- Adds a new state to the StateMachine
--- @param stateName string
--- @param state StateItem
function StateMachine:AddState(stateName: string, state: StateItem): boolean
    if self.stateList[stateName] then
        return false
    end
    self.stateList[stateName] = state
    return true
end

--- Removes a state from the StateMachine
--- @param stateName string
function StateMachine:RemoveState(stateName: string): boolean
    if not self.stateList[stateName] then
        return false
    end
    self.stateList[stateName] = nil
    return true
end

--- Changes the current state of the StateMachine
--- @param stateName string
function StateMachine:ChangeState(stateName: string): boolean
    if not self.stateList[stateName] then
        return false
    end
    if self.currentState and self.stateList[self.currentState].onExit then
        self.stateList[self.currentState].onExit()
    end
    self.currentState = stateName
    if self.stateList[stateName].onEnter then
        self.stateList[stateName].onEnter()
    end
    return true
end

--- Gets the current state of the StateMachine
--- @return string
function StateMachine:GetCurrentState(): string?
    return self.currentState
end

--- Updates the current state of the StateMachine
--- @param deltaTime number
function StateMachine:Update(deltaTime: number)
    if self.currentState and self.stateList[self.currentState].onUpdate then
        self.stateList[self.currentState].onUpdate(deltaTime)
    end
end
--#endregion

return table.freeze(StateMachine)