这是一个在饥荒联机版服务器中增强雪球发射器的小模组喵。

当前功能：
- 雪球发射器的覆盖范围从原版 `15` 提升到 `20`。
- 更大的范围会同时作用于火焰探测、灭火发射、警报预警和紧急模式。
- 每次成功触发灭火时会额外补射 `3` 发雪球，合计形成 `4` 发短间隔连射。
- 更适合保护占地更大的基地。

说明：
- 这个模组目前会改雪球发射器的范围和单次灭火时的雪球密度，不额外增加燃料消耗。
- 已修正一次“手持摆放预览圈变大，但落地后显示圈和实际范围还是原版”的问题，现在部署后的显示和实际生效范围会保持一致。
- 已修正一次增强范围边缘目标虽然进入检测区，但雪球飞行速度仍偏原版，导致最外侧目标灭不到的问题。
- 当前版本没有做外部配置文件开关。
- 如果后面想继续扩大范围，直接改 `modmain.lua` 里的 `ENHANCED_RANGE` 就行。

Current features:
- Ice Flingomatic range is increased from the vanilla `15` to `20`.
- The larger radius applies to fire detection, extinguishing shots, warning coverage, and emergency mode.
- Each successful extinguish trigger now adds `3` extra snowballs for a short `4` shot burst.
- This makes the structure better suited for protecting larger base layouts.

Notes:
- This mod now changes Ice Flingomatic range plus per-trigger snowball density, while keeping fuel cost unchanged.
- A previous mismatch where the placement preview was larger but the deployed machine still showed and behaved like vanilla range has been fixed.
- A previous issue where outer-edge targets entered the enhanced radius but snowballs still used an effectively vanilla travel-speed limit has been fixed.
- There are no external configuration options in this version.
- If you want an even larger radius later, you only need to change `ENHANCED_RANGE` in `modmain.lua`.
