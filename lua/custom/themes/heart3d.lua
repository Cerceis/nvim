-- ╔══════════════════════════════════════════════════════╗
-- ║  3D Heart — rotating ASCII renderer (donut-style)   ║
-- ╚══════════════════════════════════════════════════════╝
-- Renders the Taubin implicit heart surface
--   (x² + 9/4·y² + z² − 1)³ − x²·z³ − 9/80·y²·z³ = 0
-- spinning about its vertical (z) axis, with per-pixel depth
-- scanning + gradient-shaded luminance. Frames are precomputed
-- once into strings; animation just cycles them (cheap).

local M = {}

-- shading ramp dark→bright (no leading space; space = empty pixel)
local RAMP = ".,-~:;=!*o#%@"

local COLS = 68        -- wide: terminal cells are ~2:1 tall, so oversample x
local ROWS = 24
local U_RANGE = 1.42   -- horizontal half-extent (smaller range over more cols = wider heart)
local V_TOP = 1.32     -- top (lobes)
local V_BOT = -1.48    -- bottom (cusp)

local function F(x, y, z)
	local a = x * x + 2.25 * y * y + z * z - 1.0
	return a * a * a - x * x * z * z * z - 0.1125 * y * y * z * z * z
end

-- render one frame at rotation angle `ang`, return array of ROWS strings
local function render(ang)
	local ca, sa = math.cos(ang), math.sin(ang)
	-- view-space light (upper-left, toward camera)
	local lx, ly, lz = -0.35, 0.45, 0.82
	local ll = math.sqrt(lx * lx + ly * ly + lz * lz)
	lx, ly, lz = lx / ll, ly / ll, lz / ll

	local lines = {}
	for j = 1, ROWS do
		-- vertical screen coord → heart up-axis (z)
		local v = V_TOP + (V_BOT - V_TOP) * ((j - 1) / (ROWS - 1))
		local row = {}
		for i = 1, COLS do
			local u = -U_RANGE + (2 * U_RANGE) * ((i - 1) / (COLS - 1))
			local ch = " "
			-- scan depth d front→back, find nearest surface crossing
			local prev, pd = nil, nil
			local dstep = 0.06
			for d = 1.5, -1.5, -dstep do
				local x = u * ca + d * sa
				local y = -u * sa + d * ca
				local z = v
				local f = F(x, y, z)
				if prev ~= nil and ((prev > 0) ~= (f > 0)) then
					-- crossing between pd and d → refine midpoint
					local dm = (pd + d) * 0.5
					local x2 = u * ca + dm * sa
					local y2 = -u * sa + dm * ca
					-- gradient (object space) via finite diff
					local e = 0.012
					local gx = (F(x2 + e, y2, z) - F(x2 - e, y2, z))
					local gy = (F(x2, y2 + e, z) - F(x2, y2 - e, z))
					local gz = (F(x2, y2, z + e) - F(x2, y2, z - e))
					-- rotate gradient into view space
					-- view: right=(ca,-sa,0) up=(0,0,1) toward-camera=(sa,ca,0)
					local nx = gx * ca - gy * sa   -- right
					local ny = gz                  -- up
					local nz = gx * sa + gy * ca   -- toward camera
					local nl = math.sqrt(nx * nx + ny * ny + nz * nz)
					if nl > 1e-6 then
						nx, ny, nz = nx / nl, ny / nl, nz / nl
						-- front face (toward camera) lit; soft key light from upper-left
						local lum = 0.62 * nz + 0.30 * ny - 0.16 * nx + 0.12
						if lum < 0 then lum = 0 end
						if lum > 1 then lum = 1 end
						local idx = math.floor(lum * (#RAMP - 1) + 0.5) + 1
						if idx < 1 then idx = 1 end
						if idx > #RAMP then idx = #RAMP end
						ch = RAMP:sub(idx, idx)
					else
						ch = ":"
					end
					break
				end
				prev, pd = f, d
			end
			row[i] = ch
		end
		lines[j] = table.concat(row)
	end
	return lines
end

-- precompute N frames around a full turn
function M.build(nframes)
	nframes = nframes or 48
	local frames = {}
	for k = 0, nframes - 1 do
		frames[k + 1] = render((k / nframes) * 2 * math.pi)
	end
	return frames
end

M.render = render
M.ROWS = ROWS
return M
