-- Eclipse Loader
-- Fill in the SCRIPTS table below with the source for each hub.
-- Each entry can use either:
--   url    = "https://raw.githubusercontent.com/.../script.lua"  (fetched with game:HttpGet)
--   source = "raw lua code here"                                 (inline code)

local SCRIPTS = {
    {
        name = "Midnight Hub",
        desc = "",
        url = "", -- TODO: paste raw script URL
        source = "", -- or paste raw lua source
    },
    {
        name = "Overtime",
        desc = "",
        url = "",
        source = "",
    },
    {
        name = "Inferno Hub",
        desc = "",
        url = "",
        source = "",
    },
    {
        name = "Kalihub Updated",
        desc = "",
        url = "",
        source = "",
    },
}

-- ── Script sources ──────────────────────────────────────────────────────
-- Attach inline source to a script by name (keeps the table above readable)
local function setSource(name, code)
    for _, entry in ipairs(SCRIPTS) do
        if entry.name == name then
            entry.source = code
            return
        end
    end
end

setSource("Midnight Hub", [==[
-- ================================================
-- MIDNIGHT HUB - FULL SCRIPT (Amethyst Theme) 
-- + HITBOX EXPANDER + DAISY N ROSES FPS BOOST
-- + WAGER BUNDLE + CHAMPAGNE AND ROSES
-- Universe Football • Private & Undetected
-- ================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ===================== EXECUTOR COMPATIBILITY LAYER =====================
print("=== MIDNIGHT HUB COMPATIBILITY CHECK ===")
local isFileSupported = pcall(function() return isfile end) and typeof(isfile) == "function"
local isWriteSupported = pcall(function() return writefile end) and typeof(writefile) == "function"
local fflagSupported = (typeof(getfflag) == "function") and (typeof(setfflag) == "function")
local getConnectionsSupported = (typeof(getconnections) == "function")

print("✅ File System (isfile/writefile): " .. (isFileSupported and isWriteSupported and "YES" or "NO"))
print("✅ FFlag Injector: " .. (fflagSupported and "YES" or "NO (only works on advanced executors like Solara/Wave)"))
print("✅ Log Disabler: " .. (getConnectionsSupported and "YES" or "NO"))
print("===============================================")


-- ==================== FLAG INJECTOR HELPERS ====================
local function cleanFFlagName(flag)
    if type(flag) ~= "string" then return flag end
    return flag:gsub("DFInt", ""):gsub("DFFlag", ""):gsub("FFlag", ""):gsub("FInt", ""):gsub("DFString", ""):gsub("FString", "")
end

local function ToggleFFlag(flag, value)
    if not fflagSupported then
        warn("[Flag Injector] Your executor does NOT support FFlags (setfflag/getfflag). Feature disabled.")
        return false, "Executor does not support FFlags"
    end

    local cleanFlag = cleanFFlagName(flag)
    local success, err = pcall(function()
        if getfflag(cleanFlag) ~= nil then
            setfflag(cleanFlag, tostring(value))
            return true
        else
            return false, "FFlag not recognized"
        end
    end)

    if not success then
        warn("[Flag Injector] Error: " .. (err or "unknown error"))
    end
    return success
end

-- ==================== DAISY N ROSES FULL FPS BOOST FLAGS ====================
local daisyFFlags = {
    ["FLogNetwork"] = "7",
    ["DFIntTaskSchedulerTargetFps"] = "32",
    ["FFlagHandleAltEnterFullscreenManually"] = "False",
    ["DFIntTextureQualityOverride"] = "0",
    ["FFlagEnableVirtualReality"] = "False",
    ["DFIntNetworkPrediction"] = "120",
    ["FFlagDisablePostFx"] = "True",
    ["FIntRenderShadowIntensity"] = "0",
    ["FFlagDebugSkyGray"] = "True",
    ["FIntFRMMinGrassDistance"] = "0",
    ["DFIntConnectionMTUSize"] = "900",
    ["FFlagDebugDisplayFPS"] = "False",
    ["DFIntServerPhysicsUpdateRate"] = "60",
    ["DFFlagDisableDPIScale"] = "True",
    ["FFlagDisableNewIGMinDUA"] = "True",
    ["FFlagEnableInGameMenuControls"] = "False",
    ["FFlagEnableInGameMenuModernization"] = "False",
    ["FFlagEnableMenuControlsABTest"] = "False",
    ["FFlagEnableMenuModernizationABTest"] = "False",
    ["FFlagEnableMenuModernizationABTest2"] = "False",
    ["FFlagEnableV3MenuABTest3"] = "False",
    ["FIntDebugTextureManagerSkipMips"] = "6",
    ["FIntTerrainArraySliceSize"] = "0",
    ["FIntFontSizePadding"] = "2",
    ["FFlagDebugGraphicsPreferD3D11"] = "True",
    ["DFIntMaxParticles"] = "5000",
    ["FIntDebugForceMSAASamples"] = "1",
    ["DFFlagTextureQualityOverrideEnabled"] = "True",
    ["FIntFullscreenTitleBarTriggerDelayMillis"] = "3600000",
    ["FFlagEnableDepthOfField"] = "False",
    ["DFIntCanHideGuiGroupId"] = "32380007",
    ["FFlagEnableVolumetricFog"] = "True",
    ["DFIntTextureStreamingBudget"] = "4096",
    ["FFlagUseVulkanRenderer"] = "False",
    ["DFIntMaxComputeShaderWorkGroups"] = "1024",
    ["DFFlagDebugRenderForceTechnologyVoxel"] = "True",
    ["FFlagEnableInGameMenuChrome"] = "True",
    ["FFlagEnableBloom"] = "True",
    ["FFlagEnableAdaptiveResolution"] = "True",
    ["FFlagTaskSchedulerLimitTargetFpsTo2402"] = "False",
    ["FFlagEnableRealisticWaterReflections"] = "False",
    ["FFlagReduceJumpDelay"] = "True",
    ["FFlagEnableJumpBuffering"] = "True",
    ["FFlagEnableZBoostOnJump"] = "True",
    ["FFlagEnableAnglingBoost"] = "True",
    ["FFlagSetSkyBrightnessLow"] = "False",
    ["FFlagPreferStableFPS"] = "True",
    ["FFlagDisableDynamicWeather"] = "True",
    ["DFFlagDebugPauseVoxelizer"] = "True",
    ["FFlagQuaternionPoseCorrection"] = "True",
    ["DFFlagDebugRenderForceTechnologyVoxel"] = "True",
    ["FFlagUseLowLatencyInput"] = "True",
    ["FIntCharacterJumpBoost"] = "1",
    ["FFlagDebugDisableTelemetryEventIngest"] = "True",
    ["FFlagDebugDisableTelemetryEphemeralStat"] = "True",
    ["FFlagHighlightOutlinesOnMobile"] = "True",
    ["FStringDebugLuaLogLevel"] = "trace",
    ["FStringDebugLuaLogPattern"] = "ExpChat/mountClientApp",
    ["FFlagEnableHDR10"] = "False",
    ["FFlagChatTranslationSettingEnabled3"] = "False",
    ["FStringDebugGraphicsPreferredGPUName"] = "NVIDIA GeForce GTX 1650",
    ["FIntNewInGameMenuPercentRollout3"] = "0",
    ["FFlagUserShowGuiHideToggles"] = "True",
    ["FIntV1MenuLanguageSelectionFeaturePerMillageRollout"] = "0",
    ["DFFlagDebugPrintDataPingBreakDown"] = "True",
    ["FFlagDebugDisableTelemetryEphemeralCounter"] = "True",
    ["FFlagAlwaysShowVRToggleV3"] = "False",
    ["FFlagDisableFeedbackSoothsayerCheck"] = "False",
    ["DFIntTextureCompositorActiveJobs"] = "0",
    ["FStringWhitelistVerifiedUserId"] = "UserID",
    ["FFlagOptimizeNetworkRouting"] = "True",
    ["FFlagOptimizeNetworkTransport"] = "True",
    ["FFlagOptimizeServerTickRate"] = "True",
    ["FFlagDebugSimIntegrationStabilityTesting"] = "True",
    ["DFIntNetworkLatencyTolerance"] = "1",
    ["DFIntOptimizePingThreshold"] = "50",
    ["FFlagAXAAccessoryAdjustmentIXPEnabledForAll"] = "True",
    ["FFlagAdServiceEnabled"] = "False",
    ["FFlagGlobalWindActivated"] = "False",
    ["FIntCameraMaxZoomDistance"] = "9999",
    ["DFIntPerformanceControlTextureQualityBestUtility"] = "-1",
    ["FFlagFixGraphicsQuality"] = "True",
    ["FIntRakNetResendBufferArrayLength"] = "128",
    ["FStringPartTexturePackTable2022"] = "{\"foil\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[238,238,238,255]},\"asphalt\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[227,227,228,234]},\"basalt\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[160,160,158,238]},\"brick\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[229,214,205,227]},\"cobblestone\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[218,219,219,243]},\"concrete\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[225,225,224,255]},\"crackedlava\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[76,79,81,156]},\"diamondplate\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[210,210,210,255]},\"fabric\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[221,221,221,255]},\"glacier\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[225,229,229,243]},\"glass\":{\"ids\":[\"rbxassetid://9873284556\",\"rbxassetid://9438453972\"],\"color\":[254,254,254,7]},\"granite\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[210,206,200,255]},\"grass\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[196,196,189,241]},\"ground\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[165,165,160,240]},\"ice\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[235,239,241,248]},\"leafygrass\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[182,178,175,234]},\"limestone\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[250,248,243,250]},\"marble\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[181,183,193,249]},\"metal\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[226,226,226,255]},\"mud\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[193,192,193,252]},\"pavement\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[218,218,219,236]},\"pebble\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[204,203,201,234]},\"plastic\":{\"ids\":[\"\",\"rbxassetid://0\"],\"color\":[255,255,255,255]},\"rock\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[211,211,210,248]},\"corrodedmetal\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[206,177,163,180]},\"salt\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[249,249,249,255]},\"sand\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[218,216,210,240]},\"sandstone\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[241,234,230,246]},\"slate\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[235,234,235,254]},\"snow\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[239,240,240,255]},\"wood\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[217,209,208,255]},\"woodplanks\":{\"ids\":[\"rbxassetid://0\",\"rbxassetid://0\"],\"color\":[207,208,206,254]}}",
    ["FStringReconnectDisabledReason"] = "A-aah!~ Please!~ Rejoin f-faster...~ NNGGHH~~",
    ["FFlagOptimeizeServerTicketRate"] = "True",
    ["DFIntDebugFRMQualityLevelOverride"] = "1",
    ["DFFlagPhysicsMechanismCacheOptimizeAlloc"] = "True",
    ["FFlagUpdateHTTPCookieStorageFromWKWebView"] = "False",
    ["FFlagFixParticleAttachmentCulling"] = "False",
    ["SFFlagGroundControllerTurningResponsiveness"] = "2147483647",
    ["FFlagEnableIOSWebViewCookieSyncFix"] = "False",
    ["DFFlagSimSolverOptimizeGeometricStiffness4"] = "True",
    ["FIntRenderMeshOptimizeVertexBuffer"] = "0",
    ["FFlagUserFixLoadAnimationError"] = "True",
    ["FFlagEnableAudioEmitterDistanceAttenuation"] = "True",
    ["FFlagDebugSSAOForce"] = "False",
    ["FIntRenderGrassDetailStrands"] = "0",
    ["FIntSSAOMipLevels"] = "0",
    ["FFlagMouseGetPartOptimization"] = "True",
    ["DFFlagVisBugFixUnloadReadyMesh"] = "True",
    ["DFIntCullFactorPixelThresholdShadowMapHighQuality"] = "2147483647",
    ["FFlagRenderShadowSkipHugeCulling"] = "True",
    ["FFlagControlBetaBadgeWithGuac"] = "False",
    ["DFFlagTeleportClientAssetPreloadingEnabledIXP"] = "True",
    ["DFFlagAudioEnableVolumetricPanningForPolys"] = "True",
    ["FIntBloomFrmCutoff"] = "0",
    ["FIntGrassMovementReducedMotionFactor"] = "0",
    ["DFFlagDebugPerfMode"] = "True",
    ["FFlagSimAdaptiveTimesteppingDefault2"] = "True",
    ["FFlagDebugRenderingSetDeterministic"] = "True",
    ["FFlagMSRefactor5"] = "False",
    ["FIntFRMMaxGrassDistance"] = "0",
    ["FIntRenderGrassHeightScaler"] = "0",
    ["FFlagDebugGraphicsDisableVulkan"] = "True",
    ["FFlagDebugGraphicsDisableVulkan11"] = "True",
    ["FFlagDebugGraphicsDisableOpenGL"] = "True",
    ["FFlagDebugGraphicPreferD3D11"] = "True",
    ["FIntRobloxGuiBlurIntensity"] = "0",
    ["FFlagFastGPULightCulling3"] = "True",
    ["FFlagNewLightAttenuation"] = "True",
    ["FFlagDebugForceFutureIsBrightPhase2"] = "True",
    ["DFIntRakNetResendRttMultiple"] = "1",
    ["DFIntPlayerNetworkUpdateQueueSize"] = "20",
    ["DFIntPlayerNetworkUpdateRate"] = "60",
    ["DFIntServerPhysicsUpdateRate"] = "60",
    ["DFIntServerTickRate"] = "60",
    ["DFIntMaxFrameBufferSize"] = "4",
    ["DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent"] = "0",
    ["DFIntClientLightingEnvmapPlacementTelemetryHundredthsPercent"] = "100",
    ["FIntMockClientLightingTechnologyIxpExperimentMode"] = "0",
    ["FIntMockClientLightingTechnologyIxpExperimentQualityLevel"] = "7",
    ["FIntTextureCompositorLowResFactor"] = "4",
    ["FIntUnifiedLightingBlendZone"] = "1",
    ["DFIntDebugLimitMinTextureResolutionWhenSkipMips"] = "0",
    ["FFlagFixIGMBottomBarVisibility"] = "True",
    ["FFlagToastNotificationsReceivedAndDismissedSignals"] = "False",
    ["DFFlagSimOptimizeSetSize"] = "True",
    ["FFlagSelfViewTweaksPass"] = "False",
    ["FFlagGraphicsGLEnableSuperHQShadersExclusion"] = "False",
    ["FIntPreferredTextSizeSettingBetaFeatureRolloutPercent"] = "100",
    ["FFlagEnablePreferredTextSizeSettingInMenus2"] = "True",
    ["FIntSimDefaultFluidForceEnabled"] = "999",
    ["FFlagDontRerenderForBadTexture"] = "True",
    ["FFlagNewOptimizeNoCollisionPrimitiveInMidphase637"] = "True",
    ["FFlagInExperienceUpsellSelfViewFix"] = "False",
    ["FFlagDebugForceGenerateHSR"] = "True",
    ["FIntRenderMaxShadowAtlasUsageBeforeDownscale"] = "1",
    ["FFlagDebugSimDefaultPrimalSolver"] = "True",
    ["FFlagRenderNoLowFrmBloom"] = "False",
    ["FFlagDebugCodegenOptSize"] = "True",
    ["FFlagDebugSelfViewPerfBenchmark"] = "False",
    ["FIntUITextureMaxUpdateDepth"] = "-1",
    ["FFlagUserSoundsUseRelativeVelocity2"] = "True",
    ["FFlagToastNotificationsResendDisplayOnInit"] = "False",
    ["FFlagEnablePreferredTextSizeScale"] = "True",
    ["FFlagEnableAudioEmitterDistanceAttenuation"] = "True",
    ["FFlagSelfViewGetRidOfFalselyRenderedFaceDecal"] = "False",
    ["DFFlagAudioToggleVolumetricPanning"] = "True",
    ["FFlagDebugEnableDirectAudioOcclusion2"] = "True",
    ["FFlagGraphicsGLEnableHQShadersExclusion"] = "False",
    ["FFlagDebugGraphicsPreferD3D11"] = "True",
    ["FFlagSelfViewHumanoidNilCheck"] = "False",
    ["FFlagToastNotificationsProtocolEnabled2"] = "False",
    ["DFStringWebviewUrlAllowlist"] = "",
    ["FFlagSelfViewMoreNilChecks"] = "False",
    ["FFlagFixSettingsHubVRBackgroundError"] = "True",
    ["FFlagAXAAccessoryAdjustmentIXPEnabledForAll"] = "True",
    ["FFlagRenderLegacyShadowsQualityRefactor"] = "True",
    ["FFlagSignalRNotificationManagerMaybeStart"] = "False",
    ["DFIntVideoMaxNumberOfVideosPlaying"] = "0",
    ["FFlagViewCollisionFadeToBlackInVR"] = "False",
    ["FFlagFixParticleEmissionBias2"] = "False",
    ["DFFlagWindowsWebViewTelemetryEnabled"] = "False",
    ["FFlagVRFixCursorJitterLua"] = "True",
    ["DFIntVoiceChatMaxRecordedDataDeliveryIntervalMs"] = "2147483647",
    ["DFIntCSGLevelOfDetailSwitchingDistanceL34"] = "0",
    ["FFlagRenderCBRefactor2"] = "True",
    ["FFlagEnableBubbleChatFromChatService"] = "False",
    ["FFlagSelfViewRemoveVPFWhenClosed"] = "False",
    ["FFlagLuauCodegen"] = "True",
    ["FFlagFixSelfViewPopin"] = "False",
    ["FFlagEnableCommandAutocomplete"] = "False",
    ["FFlagEnablePreferredTextSizeStyleFixesInCaptureMenu"] = "True",
    ["DFIntNumAssetsMaxToPreload"] = "2147483647",
    ["FFlagAvatarChatIncludeSelfViewOnTelemetry"] = "False",
    ["FFlagEnableChromeFTUX"] = "True",
    ["FFlagVisBugChecksThreadYield"] = "True",
    ["FFlagFixExitDialogBlockVRView"] = "True",
    ["FFlagSettingsHubIndependentBackgroundVisibility"] = "True",
    ["FFlagSyncWebViewCookieToEngine2"] = "False",
    ["FFlagEnablePreferredTextSizeStyleFixesInExperienceMenu"] = "True",
    ["FFlagAssetPreloadingIXP"] = "True",
    ["FFlagEnablePreferredTextSizeStyleFixesInAppShell4"] = "True",
    ["FFlagLuaAppEnableToastNotificationsCoreScripts4"] = "False",
    ["DFFlagVoiceChatTurnOnMuteUnmuteNotificationHack"] = "False",
    ["FIntBloomFrmCutoff"] = "-1",
    ["FFlagPreloadTextureItemsOption4"] = "True",
    ["DFFlagJointIrregularityOptimization"] = "True",
    ["FFlagEnableCullableScene2OptimizeStep"] = "True",
    ["FFlagSquadToastNotificationsEnabled"] = "False",
    ["DFFlagEnableTexturePreloading"] = "True",
    ["DFIntMaxPhysicsStepsPerFrame"] = "4",
    ["FFlagEnableTextureCompression"] = "True",
    ["DFIntPhysicsSubSteps"] = "3",
    ["DFIntShadowDistance"] = "1500",
    ["DFIntMaxShaderComplexity"] = "10",
    ["FFlagEnableSoftShadows"] = "True",
    ["FFlagEnableAdaptiveResolution"] = "True",
    ["DFIntMinimumFrameRate"] = "30",
    ["DFStringAltHttpPointsReporterUrl"] = "null",
    ["FFlagEnableNewHeapSnapshots"] = "False",
    ["DFStringLightstepToken"] = "null",
    ["DFStringTelemetryV2Url"] = "null",
    ["FFlagNewNetworking"] = "False",
    ["FFlagGameBasicSettingsFramerateCap5"] = "False",
    ["FFlagRenderFixFog"] = "True",
    ["FFlagTweenOptimizations"] = "True",
    ["DFFlagDisableFastLogTelemetry"] = "True",
    ["FFlagEnableTerrainFoliageOptimizations"] = "True",
    ["DFStringHttpPointsReporterUrl"] = "null",
    ["DFIntCSGLevelOfDetailSwitchingDistanceL23"] = "0",
    ["DFIntMaxDynamicLights"] = "32",
    ["FFlagEnableRayTracing"] = "False",
    ["FFlagEnablePhysicsThrottle"] = "True",
    ["FFlagUseNewLightingSystem"] = "True",
    ["DFIntCharacterLodDistance"] = "500",
    ["FFlagEnableCloudRendering"] = "True",
    ["FFlagEnableDynamicShadowMapping"] = "False",
    ["DFIntMaxLightsPerScene"] = "64",
    ["FFlagEnableScreenSpaceReflections"] = "True",
    ["FFlagUseDX12"] = "False",
    ["DFIntFrameTimeLimit"] = "16",
    ["DFIntMaxAnisotropy"] = "16",
    ["FFlagEnableLensFlares"] = "True",
    ["DFIntMaxDecalsPerScene"] = "100",
    ["FFlagEnableParallaxMapping"] = "True",
    ["DFIntMaxReflectionProbes"] = "8",
    ["FFlagEnableMotionBlur"] = "False",
    ["FFlagEnableScreenSpaceGlobalIllumination"] = "False",
    ["FFlagUseParticlesV2"] = "False",
    ["DFStringCrashUploadToBacktraceWindowsPlayerToken"] = "null",
    ["FFlagEnableHumanoidLuaSideCaching"] = "False",
    ["FFlagEnableTerrainOptimizations"] = "True",
    ["DFIntRunningBaseOrientationP"] = "115",
    ["FFlagEnableLightAttachToPart"] = "False",
    ["FFlagLuaAppSystemBar"] = "False",
    ["FFlagAnimatePhysics"] = "False",
    ["FFlagUseDynamicSun"] = "False",
    ["DFIntDebugSimPrimalStiffness"] = "0",
    ["DFIntDebugSimPrimalLineSearch"] = "5",
    ["DFIntPrimalLinearSearch"] = "1"
}

local function InjectDaisyNRoses()
    if not fflagSupported then
        Rayfield:Notify({Title = "Daisy n Roses", Content = "❌ Your executor does not support FFlags", Duration = 5})
        return
    end
    Rayfield:Notify({Title = "Daisy n Roses", Content = "🌸 Applying FPS boost flags (Gray Sky included)...", Duration = 5})
    local count = 0
    for flag, value in pairs(daisyFFlags) do
        pcall(function()
            local clean = cleanFFlagName(flag)
            setfflag(clean, tostring(value))
            count = count + 1
        end)
        task.wait(0.065)
    end
    Rayfield:Notify({
        Title = "Daisy n Roses",
        Content = "✅ FPS boost applied! " .. count .. " flags injected (Gray Sky active)",
        Duration = 8
    })
end

-- ==================== MAIN HUB ====================
function loadMainUI()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Workspace = game:GetService("Workspace")
    local Lighting = game:GetService("Lighting")
    local plr = Players.LocalPlayer

    pcall(function()
        if getConnectionsSupported then
            for _, v in pairs(getconnections(game:GetService("LogService").MessageOut)) do
                pcall(function() v:Disable() end)
            end
        end
    end)

    local character = plr.Character or plr.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local head = character:WaitForChild("Head")

    -- ==================== NEW UNIVERSAL FEATURES ====================
    local flyEnabled = false
    local flySpeed = 50
    local noclipEnabled = false
    local infJumpEnabled = false
    local fovEnabled = false
    local customFOV = 90
    local fullbrightEnabled = false
    local espEnabled = false

    local flyConnection, noclipConnection, infJumpConnection

    local function toggleFly()
        if flyConnection then flyConnection:Disconnect() end
        if not flyEnabled then return end
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Parent = rootPart
        flyConnection = RunService.RenderStepped:Connect(function()
            if not flyEnabled or not rootPart then return end
            local cam = Workspace.CurrentCamera
            local dir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
            bv.Velocity = dir.Unit * flySpeed
        end)
    end

    local function toggleNoclip()
        if noclipConnection then noclipConnection:Disconnect() end
        if not noclipEnabled then return end
        noclipConnection = RunService.Stepped:Connect(function()
            if not noclipEnabled then return end
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end)
    end

    local function toggleInfJump()
        if infJumpConnection then infJumpConnection:Disconnect() end
        if not infJumpEnabled then return end
        infJumpConnection = UserInputService.JumpRequest:Connect(function()
            if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    end

    local function toggleFullbright()
        fullbrightEnabled = not fullbrightEnabled
        if fullbrightEnabled then
            Lighting.Brightness = 2
            Lighting.ClockTime = 12
            Lighting.FogEnd = 9e9
        end
    end

    local function serverHop()
        Rayfield:Notify({Title = "Server Hop", Content = "Teleporting to new server...", Duration = 3})
        task.wait(1.5)
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end

    -- ==================== DELTA HIDER (Manual) ====================
    local function activateDeltaHider()
        local hui = gethui and gethui()
        if not hui then
            Rayfield:Notify({Title = "Delta Hider", Content = "❌ gethui not supported", Duration = 5})
            return
        end
        for _, v in ipairs(hui:GetDescendants()) do
            if v:IsA("ScreenGui") then pcall(function() v:Destroy() end) end
        end
        hui.ChildAdded:Connect(function(c)
            if c:IsA("ScreenGui") then task.wait(); pcall(function() c:Destroy() end) end
        end)
        Rayfield:Notify({Title = "Delta Hider", Content = "✅ Delta Hider activated", Duration = 5})
    end

    -- ==================== FULL ORIGINAL MIDNIGHT HUB CODE ====================
    local smoothPullEnabled = false
    local isSmoothPulling = false
    local magnetSmoothness = 0.08
    local maxPullDistance = 35
    local autoDBEnabled = false
    local autoDBStrength = 0.5
    local autoDBTarget = nil
    local customName = ""
    local currentBannerID = "rbxassetid://13181356130"
    local processedObjects = {}
    local CurrentTrack = nil
    local boostEnabled = false
    local boostPower = 25
    local boostCooldown = {}
    local simpleBoostEnabled = false
    local simpleBoostPower = 25
    local simpleBoostCooldown = {}
    local jumpPowerEnabled = false
    local customJumpPower = 50
    local jumpConnection = nil
    local gravityEnabled = false
    local customGravity = 196
    local isParkMatch = Workspace:FindFirstChild("ParkMatchMap") ~= nil
    local hitboxEnabled = false
    local hitboxSize = 2
    local hitboxTransparency = 0.5
    local ballTeleportEnabled = false
    local teleportRange = 50
    local teleportConn = nil

    local loopSpeedEnabled = false
    local loopSpeedValue = 18
    local cframeSpeedEnabled = false
    local cframeSpeedValue = 0.2
    local boostManipEnabled = false
    local isBoosting = false
    local targetHead = nil
    local lastTargetTime = 0
    local hasSnapped = false
    local BOOST_RADIUS = 10
    local SNAP_DISTANCE = 4
    local HEAD_OFFSET_Y = 5.2
    local FOLLOW_LERP = 0.65
    local BOOST_COOLDOWN = 0.4
    local stickyHeadEnabled = false
    local stickyStrength = 5
    local currentStickyHead = nil
    local attachment = nil
    local alignPosition = nil
    local ttbEnabled = false
    local ttbPower = 5
    local lastBoostTime = 0
    local headManipEnabled = false
    local headStrength = 10
    local headFollowEnabled = false
    local lastYVel = 0

    -- GLOBAL FONT SYSTEM
    local currentFontId = 0
    local processedFontObjects = {}
    local function applyFontToLabel(obj)
        if processedFontObjects[obj] then return end
        if (obj:IsA("TextLabel") or obj:IsA("TextBox") or obj:IsA("TextButton")) and currentFontId ~= 0 then
            pcall(function()
                obj.FontFace = Font.fromId(currentFontId)
            end)
            processedFontObjects[obj] = true
        end
    end
    local function applyCustomFonts()
        for _, v in pairs(plr.PlayerGui:GetDescendants()) do pcall(applyFontToLabel, v) end
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
                for _, child in pairs(v:GetDescendants()) do pcall(applyFontToLabel, child) end
            end
            pcall(applyFontToLabel, v)
        end
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                for _, v in pairs(p.Character:GetDescendants()) do pcall(applyFontToLabel, v) end
            end
        end
    end
    plr.PlayerGui.DescendantAdded:Connect(function(v) pcall(applyFontToLabel, v) end)
    Workspace.DescendantAdded:Connect(function(v)
        if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
            task.defer(function() for _, child in pairs(v:GetDescendants()) do pcall(applyFontToLabel, child) end end)
        end
        pcall(applyFontToLabel, v)
    end)
    Players.PlayerAdded:Connect(function(p)
        p.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            for _, v in pairs(char:GetDescendants()) do pcall(applyFontToLabel, v) end
        end)
    end)

    -- OPTIMIZED NAME CHANGER
    local function applyToTextObject(obj)
        if processedObjects[obj] then return end
        if obj:IsA("TextLabel") or obj:IsA("TextBox") or obj:IsA("TextButton") then
            local lowerText = string.lower(obj.Text)
            if string.find(lowerText, string.lower(plr.Name)) or string.find(lowerText, string.lower(plr.DisplayName)) or (customName ~= "" and string.find(lowerText, string.lower(customName))) then
                if customName ~= "" then obj.Text = customName end
                processedObjects[obj] = true
                obj:GetPropertyChangedSignal("Text"):Connect(function()
                    if customName ~= "" and obj.Text ~= customName then obj.Text = customName end
                end)
            end
        end
    end
    local function applyNameChange()
        if customName == "" then return end
        for _, v in pairs(plr.PlayerGui:GetDescendants()) do pcall(applyToTextObject, v) end
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
                for _, child in pairs(v:GetDescendants()) do pcall(applyToTextObject, child) end
            end
            pcall(applyToTextObject, v)
        end
        if character and character.Parent then
            for _, v in pairs(character:GetDescendants()) do pcall(applyToTextObject, v) end
        end
    end
    plr.PlayerGui.DescendantAdded:Connect(function(v)
        if customName ~= "" then task.defer(function() pcall(applyToTextObject, v) end) end
    end)
    Workspace.DescendantAdded:Connect(function(v)
        if customName ~= "" then
            if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
                task.defer(function() for _, child in pairs(v:GetDescendants()) do pcall(applyToTextObject, child) end end)
            end
            task.defer(function() pcall(applyToTextObject, v) end)
        end
    end)
    plr.CharacterAdded:Connect(function(char)
        character = char
        humanoid = char:WaitForChild("Humanoid")
        rootPart = char:WaitForChild("HumanoidRootPart")
        head = char:WaitForChild("Head")
        boostCooldown = {}
        simpleBoostCooldown = {}
        applyNameChange()
    end)

    -- Gray Sky variables
    local graySkyEnabled = false
    local originalAmbient = nil
    local originalBrightness = nil
    local originalSky = nil
    local redSkyEnabled = false
    local originalAmbientRed = nil
    local originalBrightnessRed = nil
    local originalSkyRed = nil

    local function LoadTrack(id, speed)
        pcall(function()
            if CurrentTrack then CurrentTrack:Stop(0) end
            local animId = "rbxassetid://" .. tostring(id)
            local success = pcall(function()
                local result = game:GetObjects("rbxassetid://" .. tostring(id))
                if result and #result > 0 then
                    local anim = result[1]
                    if anim:IsA("Animation") and anim.AnimationId and anim.AnimationId ~= "" then
                        animId = anim.AnimationId
                    end
                end
            end)
            if not success then animId = "rbxassetid://" .. tostring(id) end
            local newAnim = Instance.new("Animation")
            newAnim.AnimationId = animId
            local success2, newTrack = pcall(function() return humanoid:LoadAnimation(newAnim) end)
            if not success2 or not newTrack then return nil end
            newTrack.Priority = Enum.AnimationPriority.Action4
            newTrack:Play(0.1, 1, speed or 1)
            CurrentTrack = newTrack
            CurrentTrack.Looped = true
            return newTrack
        end)
    end

    local function getFootball()
        local parkMap = Workspace:FindFirstChild("ParkMap")
        if parkMap and parkMap:FindFirstChild("Replicated") then
            local fields = parkMap.Replicated:FindFirstChild("Fields")
            if fields then
                local parkFields = { fields:FindFirstChild("LeftField"), fields:FindFirstChild("RightField"), fields:FindFirstChild("BLeftField"), fields:FindFirstChild("BRightField"), fields:FindFirstChild("HighField"), fields:FindFirstChild("TLeftField"), fields:FindFirstChild("TRightField") }
                for _, field in ipairs(parkFields) do
                    if field and field:FindFirstChild("Replicated") then
                        local football = field.Replicated:FindFirstChild("Football")
                        if football and football:IsA("BasePart") then return football end
                    end
                end
            end
        end
        if isParkMatch then
            local parkMatchFootball = Workspace:FindFirstChild("ParkMatchMap")
            if parkMatchFootball and parkMatchFootball:FindFirstChild("Replicated") then
                parkMatchFootball = parkMatchFootball.Replicated:FindFirstChild("Fields")
                if parkMatchFootball and parkMatchFootball:FindFirstChild("MatchField") then
                    parkMatchFootball = parkMatchFootball.MatchField:FindFirstChild("Replicated")
                    if parkMatchFootball then
                        local football = parkMatchFootball:FindFirstChild("Football")
                        if football and football:IsA("BasePart") then return football end
                    end
                end
            end
        end
        local gamesFolder = Workspace:FindFirstChild("Games")
        if gamesFolder then
            for _, gameInstance in ipairs(gamesFolder:GetChildren()) do
                local replicatedFolder = gameInstance:FindFirstChild("Replicated")
                if replicatedFolder then
                    local kickoffFootball = replicatedFolder:FindFirstChild("918f5408-d86a-4fb8-a88c-5cab57410acf")
                    if kickoffFootball and kickoffFootball:IsA("BasePart") then return kickoffFootball end
                    for _, item in ipairs(replicatedFolder:GetChildren()) do
                        if item:IsA("BasePart") and item.Name == "Football" then return item end
                    end
                end
            end
        end
        local miniGamesFolder = Workspace:FindFirstChild("MiniGames")
        if miniGamesFolder then
            for _, gameInstance in ipairs(miniGamesFolder:GetChildren()) do
                local replicatedFolder = gameInstance:FindFirstChild("Replicated")
                if replicatedFolder then
                    for _, item in ipairs(replicatedFolder:GetChildren()) do
                        if item:IsA("BasePart") and item.Name == "Football" then return item end
                    end
                end
            end
        end
        return nil
    end

    local function hasFootball()
        if not character then return false end
        for _, desc in ipairs(character:GetDescendants()) do
            if desc:IsA("Weld") or desc:IsA("Motor6D") or desc:IsA("WeldConstraint") then
                if desc.Part0 and desc.Part1 then
                    if (desc.Part0.Name == "Football" or desc.Part1.Name == "Football") then return true end
                end
            end
        end
        for _, child in ipairs(character:GetChildren()) do
            if child:IsA("Tool") then
                local handle = child:FindFirstChild("Handle")
                if handle and handle.Name == "Football" then return true end
            end
        end
        local football = getFootball()
        if football then
            for _, desc in ipairs(football:GetDescendants()) do
                if desc:IsA("Weld") or desc:IsA("Motor6D") or desc:IsA("WeldConstraint") then
                    if desc.Part0 and desc.Part1 then
                        local part0Parent = desc.Part0.Parent
                        local part1Parent = desc.Part1.Parent
                        if part0Parent == character or part1Parent == character then return true end
                    end
                end
            end
            if (football.Position - rootPart.Position).Magnitude < 5 then
                local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
                local leftHand = character:FindFirstChild("LeftHand") or character:FindFirstChild("Left Arm")
                if rightHand and (football.Position - rightHand.Position).Magnitude < 3 then return true end
                if leftHand and (football.Position - leftHand.Position).Magnitude < 3 then return true end
            end
        end
        return false
    end

    local function onPlayerTouch(otherPlayer)
        if not boostEnabled then return end
        if not hasFootball() then return end
        if boostCooldown[otherPlayer.Name] and tick() - boostCooldown[otherPlayer.Name] < 1 then return end
        if rootPart and humanoid then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            bv.Velocity = Vector3.new(0, boostPower, 0)
            bv.Parent = rootPart
            boostCooldown[otherPlayer.Name] = tick()
            task.delay(0.2, function() if bv and bv.Parent then bv:Destroy() end end)
        end
    end

    local function onSimplePlayerTouch(otherPlayer)
        if not simpleBoostEnabled then return end
        if simpleBoostCooldown[otherPlayer.Name] and tick() - simpleBoostCooldown[otherPlayer.Name] < 5 then return end
        if rootPart and humanoid then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            bv.Velocity = Vector3.new(0, simpleBoostPower, 0)
            bv.Parent = rootPart
            simpleBoostCooldown[otherPlayer.Name] = tick()
            task.delay(0.2, function() if bv and bv.Parent then bv:Destroy() end end)
        end
    end

    local function setupBoostDetection()
        if not rootPart then return end
        rootPart.Touched:Connect(function(hit)
            if not boostEnabled and not simpleBoostEnabled then return end
            local otherPlayer = Players:GetPlayerFromCharacter(hit.Parent)
            if otherPlayer and otherPlayer ~= plr then
                if boostEnabled then onPlayerTouch(otherPlayer) end
                if simpleBoostEnabled then onSimplePlayerTouch(otherPlayer) end
            end
        end)
    end
    setupBoostDetection()

    local function smoothTeleportToBall()
        local ball = getFootball()
        if ball and rootPart then
            if Workspace:FindFirstChild("ParkMap") then
                local distance = (ball.Position - rootPart.Position).Magnitude
                if distance > maxPullDistance then return end
            end
            local ballVelocity = ball.Velocity
            local ballSpeed = ballVelocity.Magnitude
            local offset = (ballSpeed > 0) and (ballVelocity.Unit * 15) or Vector3.new(0, 0, 0)
            local targetPosition = ball.Position + offset + Vector3.new(0, 3, 0)
            local lookDirection = (ball.Position - rootPart.Position).Unit
            rootPart.CFrame = rootPart.CFrame:Lerp(CFrame.new(targetPosition, targetPosition + lookDirection), magnetSmoothness)
        end
    end

    local function findNearestPlayer()
        local nearest = nil
        local shortest = math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= plr and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp and rootPart then
                    local dist = (hrp.Position - rootPart.Position).Magnitude
                    if dist < shortest then
                        shortest = dist
                        nearest = p
                    end
                end
            end
        end
        return nearest
    end

    task.spawn(function()
        while task.wait(2) do
            if autoDBEnabled then autoDBTarget = findNearestPlayer() end
        end
    end)

    task.spawn(function()
        while task.wait() do
            if autoDBEnabled and autoDBTarget and autoDBTarget.Character then
                pcall(function()
                    if not rootPart or not humanoid then return end
                    local hrp = autoDBTarget.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local dist = 5 - (autoDBStrength * 4)
                        local walkPos = (hrp.CFrame * CFrame.new(0, 0, dist)).Position
                        humanoid:MoveTo(walkPos)
                    end
                end)
            end
        end
    end)

    -- MESH ITEMS
    local MESH_ITEMS = {
        Coldstare = {mesh="rbxassetid://5028704943", tex="rbxassetid://5047708728", par="UpperTorso", scl=Vector3.new(1,1,1), off=CFrame.new(0,0.15,0.65)*CFrame.Angles(0,math.rad(180),0)},
        DesertVest = {mesh="rbxassetid://11755494017", tex="rbxassetid://11755494031", par="UpperTorso", scl=Vector3.new(0.73,1.13,0.75), off=CFrame.new(0,0,-0.05)},
        DRC = {mesh="rbxassetid://6541224713", tex="rbxassetid://7833727918", par="Head", scl=Vector3.new(1.01,1.01,1.01), off=CFrame.new(0,0.91,0.11)*CFrame.Angles(0,math.rad(90),0)},
        Keff = {mesh="rbxassetid://14156626934", tex="rbxassetid://14156781317", par="Head", scl=Vector3.new(0.9,0.9,0.9), off=CFrame.new(-0.06,0.38,0.1)*CFrame.Angles(0,math.rad(180),0)},
        PinkScene = {mesh="rbxassetid://73581570515279", tex="rbxassetid://86617487565011", par="Head", scl=Vector3.new(0.95,0.95,0.95), off=CFrame.new(0,0.18,0)*CFrame.Angles(0,math.rad(180),0)},
        SeeingStars = {mesh="rbxassetid://62139052", tex="rbxassetid://62139103", par="Head", scl=Vector3.new(1.05,1.05,1.05), off=CFrame.new(0,0.05,-0.45)},
        Subarctic = {mesh="rbxassetid://39200112", tex="rbxassetid://39200088", par="Head", scl=Vector3.new(1.02,1.02,1.02), off=CFrame.new(0,0.27,0)},
        TacticalVest = {mesh="rbxassetid://11754584493", tex="rbxassetid://11754584535", par="UpperTorso", scl=Vector3.new(0.73,1.13,0.75), off=CFrame.new(0,0,-0.05)},
        WhiteTowel = {mesh="rbxassetid://6919149797", tex="rbxassetid://6923948446", par="LowerTorso", scl=Vector3.new(1.1,1.2,0.7), off=CFrame.new(0.67,-0.50,-0.05)*CFrame.Angles(0,math.rad(204),math.rad(-7))},
        Ushanka = {mesh="rbxassetid://12710398184", tex="rbxassetid://12710399814", par="Head", scl=Vector3.new(1,1,1), off=CFrame.new(0,0.3,0)*CFrame.Angles(0,math.rad(180),0)},
        RedShades = {mesh="rbxassetid://132282961032642", tex="rbxassetid://112131332401032", par="Head", scl=Vector3.new(1.05,1.05,1.05), off=CFrame.new(0,0.27,-0.14)*CFrame.Angles(0,math.rad(180),0)},
        LavaScene = {mesh="rbxassetid://83490415", tex="rbxassetid://83491029", par="Head", scl=Vector3.new(1,1,1), off=CFrame.new(-0.09,0.09,0)},
        PoliceVest = {mesh="rbxassetid://10692364338", tex="rbxassetid://10691986674", par="UpperTorso", scl=Vector3.new(0.7,1.1,0.73), off=CFrame.new(0,-0.1,0.02)},
        DarkRubyCrown = {mesh="rbxassetid://439945661", tex="rbxassetid://439946249", par="Head", scl=Vector3.new(1,1,1), off=CFrame.new(0,0.65,0)},
        KingCrown = {mesh="rbxassetid://15535805562", tex="rbxassetid://15535805549", par="Head", scl=Vector3.new(1.1,1.1,1.1), off=CFrame.new(0,0.7,0)}
    }

    local CLOTHING_ITEMS = {
        ["all star shorts (pants)"] = {type="Pants", assetId=0},
        ["all star shirt (shirt)"] = {type="Shirt", assetId=0},
        ["king pants (pants)"] = {type="Pants", assetId=10725550576},
        ["king shirt (shirt)"] = {type="Shirt", assetId=6296265575},
        ["Black World Tour Shirt"] = {type="Shirt", assetId=15335037852},
        ["Pink World Tour Shirt"] = {type="Shirt", assetId=15334978300},
        ["Black Bandana Shorts"] = {type="Pants", assetId=15020463274},
    }

    local ACCESSORY_ITEMS = {
        ["White CW Set"] = {type="Accessory", assetId=97230132426750},
        ["Black CW Headphones"] = {type="Accessory", assetId=93874449800600},
        ["Black CW Shades"] = {type="Accessory", assetId=111757672542159},
        ["Star Chain"] = {type="Accessory", assetId=12269196297},
        ["ALL STAR 2025 SHIRT"] = {type="Accessory", assetId=0},
        ["ALL STAR 2025 SHORTS"] = {type="Accessory", assetId=0},
        ["LT ALL-STAR CLEATS"] = {type="Accessory", assetId=0},
    }

    local equipped = {}
    local origShirtTemplate = nil
    local origPantsTemplate = nil
    do
        local s = character:FindFirstChildOfClass("Shirt")
        local p = character:FindFirstChildOfClass("Pants")
        if s then origShirtTemplate = s.ShirtTemplate end
        if p then origPantsTemplate = p.PantsTemplate end
    end

    local function guessSlot(name)
        local nm = name:lower()
        if nm:find("face") or nm:find("shade") or nm:find("glass") then return "FaceAccessory" end
        if nm:find("hair") or nm:find("scene") or nm:find("wig") then return "HairAccessory" end
        if nm:find("neck") or nm:find("chain") or nm:find("necklace") then return "NeckAccessory" end
        if nm:find("back") or nm:find("cape") or nm:find("wing") then return "BackAccessory" end
        if nm:find("waist") or nm:find("belt") then return "WaistAccessory" end
        if nm:find("shoulder") then return "ShouldersAccessory" end
        if nm:find("front") then return "FrontAccessory" end
        if nm:find("headphone") then return "HatAccessory" end
        return "HatAccessory"
    end

    local function equipMeshItem(name)
        pcall(function()
            if equipped[name] then return end
            local d = MESH_ITEMS[name]
            if not d then return end
            local char = plr.Character
            if not char then return end
            local par = char:FindFirstChild(d.par)
            if not par and d.par == "UpperTorso" then par = char:FindFirstChild("Torso") end
            if not par and d.par == "LowerTorso" then par = char:FindFirstChild("Torso") end
            if not par then return end
            local part = Instance.new("Part")
            part.Name = name
            part.Size = Vector3.new(1,1,1)
            part.CanCollide = false
            part.Anchored = false
            part.Massless = true
            part.Parent = char
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshType = Enum.MeshType.FileMesh
            mesh.MeshId = d.mesh
            mesh.TextureId = d.tex
            mesh.Scale = d.scl
            mesh.Parent = part
            local weld = Instance.new("Motor6D")
            weld.Part0 = par
            weld.Part1 = part
            weld.C0 = d.off
            weld.Parent = par
            part.CFrame = par.CFrame * d.off
            equipped[name] = {part}
        end)
    end

    local function equipClothing(name)
        pcall(function()
            if equipped[name] then return end
            local d = CLOTHING_ITEMS[name]
            if not d then return end
            local char = plr.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local idStr = tostring(d.assetId)
            local applied = false
            local appliedParts = {}
            local function tryApplyObjects(objects)
                if not objects then return false end
                local allItems = {}
                for _, obj in pairs(objects) do
                    table.insert(allItems, obj)
                    pcall(function() for _, child in pairs(obj:GetDescendants()) do table.insert(allItems, child) end end)
                end
                for _, item in pairs(allItems) do
                    if item:IsA("Shirt") and (d.type == "Shirt" or d.type == "Accessory") then
                        local old = char:FindFirstChildOfClass("Shirt")
                        if old then old:Destroy() end
                        item.Parent = char
                        table.insert(appliedParts, item)
                        return true
                    end
                    if item:IsA("Pants") and (d.type == "Pants" or d.type == "Accessory") then
                        local old = char:FindFirstChildOfClass("Pants")
                        if old then old:Destroy() end
                        item.Parent = char
                        table.insert(appliedParts, item)
                        return true
                    end
                    if item:IsA("Accessory") or item:IsA("Accoutrement") then
                        item.Parent = char
                        if hum then pcall(function() hum:AddAccessory(item) end) end
                        table.insert(appliedParts, item)
                        return true
                    end
                end
                return false
            end
            if not applied then
                local ok, result = pcall(function() return game:GetObjects("rbxassetid://"..idStr) end)
                if ok and result and #result > 0 then applied = tryApplyObjects(result) end
            end
            if not applied then
                local ok2, model = pcall(function() return game:GetService("InsertService"):LoadAsset(d.assetId) end)
                if ok2 and model then
                    applied = tryApplyObjects({model})
                    if model and model.Parent then pcall(function() model:Destroy() end) end
                end
            end
            if not applied and d.type == "Accessory" then
                pcall(function()
                    local desc = Instance.new("HumanoidDescription")
                    local slot = guessSlot(name)
                    desc[slot] = idStr
                    local dummyModel = Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R15, Enum.AssetTypeVerification.ClientOnly)
                    desc:Destroy()
                    if dummyModel then
                        for _, child in pairs(dummyModel:GetChildren()) do
                            if child:IsA("Accessory") or child:IsA("Accoutrement") then
                                child.Parent = char
                                if hum then pcall(function() hum:AddAccessory(child) end) end
                                table.insert(appliedParts, child)
                                applied = true
                            end
                        end
                        dummyModel:Destroy()
                    end
                end)
            end
            if not applied and d.type == "Shirt" then
                local old = char:FindFirstChildOfClass("Shirt")
                if old then old:Destroy() end
                local s = Instance.new("Shirt")
                s.Name = name
                s.ShirtTemplate = "rbxassetid://"..idStr
                s.Parent = char
                table.insert(appliedParts, s)
                applied = true
            elseif not applied and d.type == "Pants" then
                local old = char:FindFirstChildOfClass("Pants")
                if old then old:Destroy() end
                local p = Instance.new("Pants")
                p.Name = name
                p.PantsTemplate = "rbxassetid://"..idStr
                p.Parent = char
                table.insert(appliedParts, p)
                applied = true
            end
            if #appliedParts > 0 then equipped[name] = appliedParts end
        end)
    end

    local function equipAccessory(name)
        pcall(function()
            if equipped[name] then return end
            local d = ACCESSORY_ITEMS[name]
            if not d then return end
            local char = plr.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local idStr = tostring(d.assetId)
            local applied = false
            local appliedParts = {}
            local function tryApplyObjects(objects)
                if not objects then return false end
                local allItems = {}
                for _, obj in pairs(objects) do
                    table.insert(allItems, obj)
                    pcall(function() for _, child in pairs(obj:GetDescendants()) do table.insert(allItems, child) end end)
                end
                for _, item in pairs(allItems) do
                    if item:IsA("Accessory") or item:IsA("Accoutrement") then
                        item.Parent = char
                        if hum then pcall(function() hum:AddAccessory(item) end) end
                        table.insert(appliedParts, item)
                        return true
                    end
                end
                return false
            end
            if not applied then
                local ok, result = pcall(function() return game:GetObjects("rbxassetid://"..idStr) end)
                if ok and result and #result > 0 then applied = tryApplyObjects(result) end
            end
            if not applied then
                local ok2, model = pcall(function() return game:GetService("InsertService"):LoadAsset(d.assetId) end)
                if ok2 and model then
                    applied = tryApplyObjects({model})
                    if model and model.Parent then pcall(function() model:Destroy() end) end
                end
            end
            if not applied then
                pcall(function()
                    local desc = Instance.new("HumanoidDescription")
                    local slot = guessSlot(name)
                    desc[slot] = idStr
                    local dummyModel = Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R15, Enum.AssetTypeVerification.ClientOnly)
                    desc:Destroy()
                    if dummyModel then
                        for _, child in pairs(dummyModel:GetChildren()) do
                            if child:IsA("Accessory") or child:IsA("Accoutrement") then
                                child.Parent = char
                                if hum then pcall(function() hum:AddAccessory(child) end) end
                                table.insert(appliedParts, child)
                                applied = true
                            end
                        end
                        dummyModel:Destroy()
                    end
                end)
            end
            if #appliedParts > 0 then equipped[name] = appliedParts end
        end)
    end

    local function unequipItem(name)
        pcall(function()
            if not equipped[name] then return end
            local parts = equipped[name]
            local hadShirt, hadPants = false, false
            for _, p in ipairs(parts) do
                if typeof(p) == "Instance" and p.Parent then
                    if p:IsA("Shirt") then hadShirt = true end
                    if p:IsA("Pants") then hadPants = true end
                    p:Destroy()
                end
            end
            equipped[name] = nil
            local char = plr.Character
            if not char then return end
            if hadShirt and origShirtTemplate then
                if not char:FindFirstChildOfClass("Shirt") then
                    local s = Instance.new("Shirt")
                    s.ShirtTemplate = origShirtTemplate
                    s.Parent = char
                end
            end
            if hadPants and origPantsTemplate then
                if not char:FindFirstChildOfClass("Pants") then
                    local p = Instance.new("Pants")
                    p.PantsTemplate = origPantsTemplate
                    p.Parent = char
                end
            end
        end)
    end

    -- SUN HUB FUNCTIONS
    local function findClosestHead()
        local char = plr.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
        local myRoot = char.HumanoidRootPart
        local closest, minDist = nil, BOOST_RADIUS
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= plr and p.Character then
                local h = p.Character:FindFirstChild("Head")
                if h then
                    local dist = (h.Position - myRoot.Position).Magnitude
                    if dist < minDist then minDist, closest = dist, h end
                end
            end
        end
        return closest
    end

    local function updateBoostManip()
        if not boostManipEnabled or not isBoosting then return end
        local myChar = plr.Character
        local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myHum or not myRoot then return end
        if not targetHead or (tick() - lastTargetTime > BOOST_COOLDOWN) then
            local newTarget = findClosestHead()
            if newTarget and newTarget ~= targetHead then
                targetHead = newTarget
                lastTargetTime = tick()
                hasSnapped = false
            end
        end
        if not targetHead or not targetHead.Parent then targetHead = nil hasSnapped = false return end
        local headPos = targetHead.Position
        local targetPos = headPos + Vector3.new(0, HEAD_OFFSET_Y, 0)
        local distToHead = (myRoot.Position - headPos).Magnitude
        if not hasSnapped then
            if distToHead <= SNAP_DISTANCE then
                hasSnapped = true
                local keepRot = myRoot.CFrame - myRoot.Position
                myRoot.CFrame = CFrame.new(targetPos) * keepRot
                myHum:ChangeState(Enum.HumanoidStateType.Jumping)
                myRoot.Velocity = Vector3.new(0, 18, 0)
            else
                myHum:MoveTo(headPos)
            end
        else
            local currentCF = myRoot.CFrame
            local targetCF = CFrame.new(targetPos) * (currentCF - currentCF.Position)
            myRoot.CFrame = currentCF:Lerp(targetCF, FOLLOW_LERP)
            if myHum:GetState() ~= Enum.HumanoidStateType.Jumping then
                myRoot.Velocity = Vector3.new(myRoot.Velocity.X, 10, myRoot.Velocity.Z)
            end
        end
    end

    local function stickToHead(head)
        if currentStickyHead then
            if attachment then attachment:Destroy() end
            if alignPosition then alignPosition:Destroy() end
            currentStickyHead = nil
        end
        currentStickyHead = head
        attachment = Instance.new("Attachment", rootPart)
        alignPosition = Instance.new("AlignPosition")
        alignPosition.Attachment0 = attachment
        alignPosition.Attachment1 = Instance.new("Attachment", head)
        alignPosition.MaxForce = 800 * stickyStrength
        alignPosition.Responsiveness = 80
        alignPosition.Parent = rootPart
        alignPosition.Position = head.Position + Vector3.new(0, head.Size.Y/2 + 1.2, 0)
    end

    local function detachSticky()
        if attachment then attachment:Destroy() end
        if alignPosition then alignPosition:Destroy() end
        currentStickyHead = nil
    end

    -- ==================== MAIN HEARTBEAT ====================
    RunService.Heartbeat:Connect(function()
        if loopSpeedEnabled then humanoid.WalkSpeed = loopSpeedValue else humanoid.WalkSpeed = 17 end
        if cframeSpeedEnabled and humanoid.MoveDirection.Magnitude > 0 then
            local moveDir = humanoid.MoveDirection * cframeSpeedValue
            rootPart.CFrame = rootPart.CFrame + moveDir
        end
        Workspace.Gravity = gravityEnabled and customGravity or 196

        updateBoostManip()
        if stickyHeadEnabled and currentStickyHead then
            local moving = humanoid.MoveDirection.Magnitude > 0.2
            local jumping = UserInputService:IsKeyDown(Enum.KeyCode.Space) or humanoid.Jump
            if moving or jumping or not currentStickyHead.Parent or (rootPart.Position - currentStickyHead.Position).Magnitude > 15 then
                detachSticky()
            end
        end
        if ttbEnabled and rootPart and humanoid then
            local now = tick()
            local stackedPlayer = nil
            for _, other in ipairs(Players:GetPlayers()) do
                if other ~= plr and other.Character then
                    local otherRoot = other.Character:FindFirstChild("HumanoidRootPart")
                    if otherRoot then
                        local dist = (rootPart.Position - otherRoot.Position).Magnitude
                        local yDiff = rootPart.Position.Y - otherRoot.Position.Y
                        if dist < 7 and yDiff > 0.8 and yDiff < 5.2 then
                            stackedPlayer = other
                            break
                        end
                    end
                end
            end
            if stackedPlayer then
                local otherRoot = stackedPlayer.Character:FindFirstChild("HumanoidRootPart")
                if otherRoot then
                    local directionToHead = (otherRoot.Position + Vector3.new(0, 3.2, 0)) - rootPart.Position
                    local distance = directionToHead.Magnitude
                    if distance > 0.5 and distance < 8 then
                        local stickVel = directionToHead.Unit * 18 * (1 - math.clamp(distance / 8, 0, 1))
                        local currentVel = rootPart.Velocity
                        rootPart.Velocity = Vector3.new(currentVel.X * 0.85 + stickVel.X * 0.15, currentVel.Y, currentVel.Z * 0.85 + stickVel.Z * 0.15)
                    end
                    if now - lastBoostTime > 0.18 + math.random() * 0.25 then
                        local vel = rootPart.Velocity
                        local extraUp = (ttbPower * 0.58) * (0.5 + math.random() * 0.85)
                        rootPart.Velocity = Vector3.new(vel.X, vel.Y + extraUp, vel.Z)
                        lastBoostTime = now
                    end
                    if math.random() < 0.15 then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
                end
            end
        end
        if headManipEnabled and rootPart.Velocity.Y <= 2 and lastYVel > 12 then
            local nearestHead, shortestDist = nil, math.huge
            for _, other in ipairs(Players:GetPlayers()) do
                if other ~= plr and other.Character then
                    local h = other.Character:FindFirstChild("Head")
                    if h then
                        local dist = (rootPart.Position - h.Position).Magnitude
                        if dist < shortestDist and dist < 25 then
                            shortestDist, nearestHead = dist, h
                        end
                    end
                end
            end
            if nearestHead then
                local targetPos = nearestHead.Position + Vector3.new(0, 2.5, 0)
                local dir = (targetPos - rootPart.Position).Unit
                local force = dir * (headStrength * 65)
                rootPart.Velocity = Vector3.new(rootPart.Velocity.X * 0.4 + force.X, rootPart.Velocity.Y, rootPart.Velocity.Z * 0.4 + force.Z)
            end
        end
        if headFollowEnabled then
            for _, other in ipairs(Players:GetPlayers()) do
                if other ~= plr and other.Character then
                    local otherRoot = other.Character:FindFirstChild("HumanoidRootPart")
                    local otherHum = other.Character:FindFirstChild("Humanoid")
                    if otherRoot and otherHum and otherHum:GetState() == Enum.HumanoidStateType.Jumping then
                        local dist = (rootPart.Position - otherRoot.Position).Magnitude
                        if dist < 30 then
                            local targetPos = otherRoot.Position + Vector3.new(0, 3, 0)
                            local dir = (targetPos - rootPart.Position).Unit
                            local force = dir * 120
                            rootPart.Velocity = Vector3.new(rootPart.Velocity.X * 0.3 + force.X, rootPart.Velocity.Y, rootPart.Velocity.Z * 0.3 + force.Z)
                            break
                        end
                    end
                end
            end
        end
        lastYVel = rootPart.Velocity.Y

        if character and character.Parent then
            for _, v in pairs(character:GetDescendants()) do
                if v:IsA("ImageLabel") and v.Visible and v.AbsoluteSize.X > v.AbsoluteSize.Y then
                    v.Image = currentBannerID
                end
            end
        end
        if hitboxEnabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    p.Character.HumanoidRootPart.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    p.Character.HumanoidRootPart.Transparency = hitboxTransparency
                end
            end
        end
    end)

    humanoid.Touched:Connect(function(hit)
        if not stickyHeadEnabled or currentStickyHead or hit.Parent == character or hit.Name ~= "Head" then return end
        local otherHum = hit.Parent:FindFirstChild("Humanoid")
        if otherHum and otherHum.Health > 0 and (rootPart.Position.Y - hit.Position.Y) > 0.8 then
            stickToHead(hit)
        end
    end)

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.R or input.KeyCode == Enum.KeyCode.ButtonR1 then
            isBoosting = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.R or input.KeyCode == Enum.KeyCode.ButtonR1 then
            isBoosting = false
        end
    end)

    -- ==================== RAYFIELD UI ====================
    local Window = Rayfield:CreateWindow({
        Name = "Midnight Hub",
        LoadingTitle = "Midnight Hub",
        LoadingSubtitle = "Universe Football • Private & Undetected",
        Theme = "Amethyst",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "MidnightHubConfig",
            FileName = "MidnightFootball"
        },
        KeySystem = false,
    })

    Rayfield:Notify({
        Title = "Midnight Hub",
        Content = "boi ts hub so tuff • All original tabs restored • Daisy n Roses added",
        Duration = 8,
        Image = 4483362458
    })

    -- ===================== ORIGINAL TABS =====================
    local ViciousTab = Window:CreateTab("Vicious", 4483362458)
    local HellTab = Window:CreateTab("Hell", 4483362458)
    local AnimationsTab = Window:CreateTab("Animations", 4483362458)
    local ItemsTab = Window:CreateTab("Items", 4483362458)
    local ClothingTab = Window:CreateTab("Clothing", 4483362458)
    local SpoofersTab = Window:CreateTab("Spoofers", 4483362458)
    local GraphicsTab = Window:CreateTab("Graphics", 4483362458)
    local JusticeTab = Window:CreateTab("Justice", 4483362458)
    local GreatnessTab = Window:CreateTab("Greatness", 4483362458)
    local BallManipulationTab = Window:CreateTab("Ball Manipulation", 4483362458)

    -- ===================== NEW RBF FLAG INJECTOR TAB =====================
    local RBFInjectorTab = Window:CreateTab("Flag Injector", 4483362458)

    RBFInjectorTab:CreateSection("🚀 /rbf MAX OVERRIDE INJECTOR")
    RBFInjectorTab:CreateButton({
        Name = "🌌 Launch /rbf Advanced Injector",
        Callback = function()
            Rayfield:Notify({
                Title = "/rbf Injector",
                Content = "Launching advanced flag injector...",
                Duration = 5
            })
            
            task.spawn(function()
                loadstring([[
                    local Players = game:GetService("Players")
                    local RunService = game:GetService("RunService")
                    local Settings = settings()
                    local UI_VISIBLE = true
                    local SAVE_FILE = "rbf_flags.txt"
                    local FORCE_ACTIVE = true

                    local function SaveFlags(content)
                        if writefile then pcall(function() writefile(SAVE_FILE, content) end) end
                    end

                    local function LoadSavedFlags()
                        if readfile and isfile and isfile(SAVE_FILE) then
                            return readfile(SAVE_FILE)
                        end
                        return ""
                    end

                    local function ExecuteInjection(content)
                        local count = 0
                        for line in content:gmatch("[^\r\n]+") do
                            local cleanLine = line:gsub("[\"{},]", "")
                            local f, v = cleanLine:match("([^:=]+)[:=](.+)")
                            if f and v then
                                local flagName = f:gsub("%s+", "")
                                local valStr = v:gsub("%s+", "")
                                pcall(function() setfflag(flagName, tostring(valStr)) end)
                                pcall(function() if setrenderproperty then setrenderproperty(flagName, valStr) end end)
                                pcall(function() Settings[flagName] = (valStr:lower() == "true") or tonumber(valStr) or valStr end)
                                if flagName:lower():find("fps") and setfpscap then
                                    pcall(function() setfpscap(tonumber(valStr) or 999) end)
                                end
                                count = count + 1
                            end
                        end
                        return count
                    end

                    local function GetSafeParent()
                        local success, target = pcall(function()
                            return gethui and gethui() or game:GetService("CoreGui"):FindFirstChild("RobloxGui") or game:GetService("CoreGui")
                        end)
                        return success and target or Players.LocalPlayer:WaitForChild("PlayerGui")
                    end

                    local function buildVisualReplica()
                        if not UI_VISIBLE then return end
                        local target = GetSafeParent()
                        if target:FindFirstChild("rbfInjector") then return end

                        local sg = Instance.new("ScreenGui")
                        sg.Name = "rbfInjector"
                        sg.DisplayOrder = 2147483647
                        sg.IgnoreGuiInset = true
                        sg.ResetOnSpawn = false
                        sg.Parent = target

                        local main = Instance.new("Frame", sg)
                        main.Name = "Main"
                        main.Size = UDim2.new(0, 480, 0, 320)
                        main.Position = UDim2.new(0.5, -240, 0.4, 0)
                        main.BackgroundColor3 = Color3.fromRGB(18, 8, 35)
                        main.BorderSizePixel = 2
                        main.BorderColor3 = Color3.fromRGB(180, 0, 255)
                        main.Active = true
                        main.Draggable = true

                        local titleBar = Instance.new("TextLabel", main)
                        titleBar.Size = UDim2.new(1, 0, 0, 24)
                        titleBar.Text = " [💜] /rbf INJECTOR - MAX OVERRIDE"
                        titleBar.TextColor3 = Color3.fromRGB(255, 180, 255)
                        titleBar.BackgroundColor3 = Color3.fromRGB(40, 15, 70)
                        titleBar.Font = Enum.Font.Code
                        titleBar.TextSize = 12
                        titleBar.TextXAlignment = Enum.TextXAlignment.Left

                        local xBtn = Instance.new("TextButton", main)
                        xBtn.Size = UDim2.new(0, 24, 0, 24)
                        xBtn.Position = UDim2.new(1, -24, 0, 0)
                        xBtn.BackgroundColor3 = Color3.fromRGB(140, 0, 180)
                        xBtn.Text = "X"
                        xBtn.TextColor3 = Color3.new(1, 1, 1)
                        xBtn.Font = Enum.Font.Code
                        xBtn.MouseButton1Click:Connect(function()
                            UI_VISIBLE = false
                            FORCE_ACTIVE = false
                            sg:Destroy()
                        end)

                        local btnFrame = Instance.new("Frame", main)
                        btnFrame.Size = UDim2.new(0.7, 0, 0, 60)
                        btnFrame.Position = UDim2.new(0.01, 0, 0.08, 0)
                        btnFrame.BackgroundTransparency = 1

                        local grid = Instance.new("UIGridLayout", btnFrame)
                        grid.CellSize = UDim2.new(0, 85, 0, 24)
                        grid.CellPadding = UDim2.new(0, 5, 0, 5)

                        local function createBtn(text, order)
                            local b = Instance.new("TextButton", btnFrame)
                            b.Text = text
                            b.LayoutOrder = order
                            b.TextColor3 = Color3.new(1, 1, 1)
                            b.BackgroundColor3 = Color3.fromRGB(50, 20, 80)
                            b.BorderColor3 = Color3.fromRGB(180, 0, 255)
                            b.Font = Enum.Font.Code
                            b.TextSize = 10
                            return b
                        end

                        local B2 = createBtn("[2] Clear", 2)
                        local B4 = createBtn("[4] Inject", 4)
                        local B5 = createBtn("[5] Reset", 5)

                        local statsLbl = Instance.new("TextLabel", main)
                        statsLbl.Size = UDim2.new(0.25, 0, 0, 24)
                        statsLbl.Position = UDim2.new(0.75, 0, 0.08, 0)
                        statsLbl.Text = "Success: 0"
                        statsLbl.TextColor3 = Color3.fromRGB(200, 120, 255)
                        statsLbl.BackgroundTransparency = 1
                        statsLbl.Font = Enum.Font.Code
                        statsLbl.TextSize = 10

                        local tableFrame = Instance.new("Frame", main)
                        tableFrame.Size = UDim2.new(0.98, 0, 0, 140)
                        tableFrame.Position = UDim2.new(0.01, 0, 0.3, 0)
                        tableFrame.BackgroundColor3 = Color3.fromRGB(25, 10, 45)
                        tableFrame.BorderColor3 = Color3.fromRGB(180, 0, 255)

                        local flagInput = Instance.new("TextBox", tableFrame)
                        flagInput.Size = UDim2.new(0.98, 0, 0.95, 0)
                        flagInput.Position = UDim2.new(0.01, 0, 0.02, 0)
                        flagInput.BackgroundTransparency = 1
                        flagInput.Text = LoadSavedFlags()
                        flagInput.PlaceholderText = "Paste Flags Here (One per line)\nExample: DFIntTaskSchedulerTargetFps=999"
                        flagInput.TextColor3 = Color3.fromRGB(220, 140, 255)
                        flagInput.TextWrapped = true
                        flagInput.TextXAlignment = Enum.TextXAlignment.Left
                        flagInput.TextYAlignment = Enum.TextYAlignment.Top
                        flagInput.ClearTextOnFocus = false
                        flagInput.Font = Enum.Font.Code

                        local logBox = Instance.new("TextLabel", main)
                        logBox.Size = UDim2.new(0.98, 0, 0, 40)
                        logBox.Position = UDim2.new(0.01, 0, 0.85, 0)
                        logBox.BackgroundColor3 = Color3.fromRGB(15, 5, 25)
                        logBox.TextColor3 = Color3.fromRGB(200, 120, 255)
                        logBox.Text = " [💜] /rbf INJECTOR READY"
                        logBox.Font = Enum.Font.Code
                        logBox.TextSize = 11
                        logBox.TextXAlignment = Enum.TextXAlignment.Left
                        logBox.BorderColor3 = Color3.fromRGB(140, 0, 180)

                        B4.MouseButton1Click:Connect(function()
                            local count = ExecuteInjection(flagInput.Text)
                            SaveFlags(flagInput.Text)
                            statsLbl.Text = "Applied: " .. count
                            logBox.Text = " [💜] INJECTED " .. count .. " FLAGS"
                        end)

                        B5.MouseButton1Click:Connect(function()
                            pcall(function() Settings:ResetSystemSettings() end)
                            if delfile then pcall(function() delfile(SAVE_FILE) end) end
                            logBox.Text = " [💜] RESET COMPLETE"
                        end)

                        B2.MouseButton1Click:Connect(function()
                            flagInput.Text = ""
                        end)

                        ExecuteInjection(flagInput.Text)
                    end

                    task.spawn(function()
                        while true do
                            if UI_VISIBLE then
                                local p = GetSafeParent()
                                if p and not p:FindFirstChild("rbfInjector") then
                                    pcall(buildVisualReplica)
                                end
                            end
                            if FORCE_ACTIVE then
                                local currentFlags = LoadSavedFlags()
                                if currentFlags ~= "" then
                                    ExecuteInjection(currentFlags)
                                end
                            end
                            task.wait(0.1)
                        end
                    end)
                ]])()
            end)
        end
    })

    RBFInjectorTab:CreateSection("Info")
    RBFInjectorTab:CreateLabel("Click the button above to open the purple /rbf injector window.")
    RBFInjectorTab:CreateLabel("It supports saving flags and auto re-injection.")

   
          

   

   

    -- Spoofers Tab
    SpoofersTab:CreateInput({
        Name = "Name Changer",
        PlaceholderText = "Enter new name...",
        RemoveTextAfterFocusLost = false,
        Callback = function(Value)
            customName = Value
            applyNameChange()
        end
    })
    local bannerOptions = {
        {Name = "TikTok Banner", ID = "14308515186"},
        {Name = "YT Banner", ID = "13181356130"},
        {Name = "Twitch Banner", ID = "13284240977"},
        {Name = "Staff Banner", ID = "13284239964"}
    }
    for _, banner in ipairs(bannerOptions) do
        SpoofersTab:CreateButton({
            Name = banner.Name,
            Callback = function() currentBannerID = "rbxassetid://" .. banner.ID end
        })
    end

    -- Vicious Tab
    ViciousTab:CreateSection("ball pull")
    ViciousTab:CreateToggle({Name = "legit pv", CurrentValue = false, Callback = function(Value) smoothPullEnabled = Value end})
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 and smoothPullEnabled then
            isSmoothPulling = true
            spawn(function()
                while isSmoothPulling do
                    smoothTeleportToBall()
                    wait(0.01)
                end
            end)
        end
    end)
    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isSmoothPulling = false
        end
    end)
    ViciousTab:CreateSlider({Name = "pull strength", Range = {0.01, 1}, Increment = 0.01, CurrentValue = 0.08, Callback = function(Value) magnetSmoothness = Value end})
    ViciousTab:CreateSlider({Name = "max range", Range = {1, 100}, Increment = 1, Suffix = " studs", CurrentValue = 35, Callback = function(Value) maxPullDistance = Value end})
    ViciousTab:CreateSection("auto db")
    ViciousTab:CreateToggle({Name = "auto db", CurrentValue = false, Callback = function(Value) autoDBEnabled = Value if Value then autoDBTarget = findNearestPlayer() end end})
    ViciousTab:CreateSlider({Name = "db intensity", Range = {0, 1}, Increment = 0.1, CurrentValue = 0.5, Callback = function(Value) autoDBStrength = Value end})
    ViciousTab:CreateSection("display name")
    ViciousTab:CreateInput({Name = "display name", PlaceholderText = "enter name", RemoveTextAfterFocusLost = false, Callback = function(Text) customName = Text applyNameChange() end})
    ViciousTab:CreateSection("--- Roblox Fonts (Bloxstrap Style) ---")
    local fontOptions = {
        "Default",
        "Starborn",
        "Silkscreen",
        "Akronim",
        "Audiowide",
        "Barlow",
        "Bungee Inline",
        "Are You Serious",
        "Barrio",
        "Blaka",
        "Builder Mono"
    }
    local fontIDs = {
        Default = 0,
        Starborn = 12187365994,
        Silkscreen = 12187365994,
        Akronim = 12187368317,
        Audiowide = 12187360881,
        Barlow = 12187372847,
        ["Bungee Inline"] = 12187370000,
        ["Are You Serious"] = 12187363616,
        Barrio = 12187371991,
        Blaka = 12187365104,
        ["Builder Mono"] = 16658246179
    }
    ViciousTab:CreateDropdown({Name = "Select Font", Options = fontOptions, CurrentOption = {"Default"}, Multiple = false, Callback = function(Option)
        local selected = Option[1]
        currentFontId = fontIDs[selected] or 0
        processedFontObjects = {}
        applyCustomFonts()
        Rayfield:Notify({Title = "Font Changed", Content = "✅ " .. selected .. " font is now active on ALL player names", Duration = 5})
    end})
    ViciousTab:CreateSection("--- Hitbox Expander ---")
    ViciousTab:CreateToggle({Name = "Hitbox Enabled", CurrentValue = false, Callback = function(Value) hitboxEnabled = Value end})
    ViciousTab:CreateSlider({Name = "Hitbox Size", Range = {2, 30}, Increment = 1, CurrentValue = 2, Callback = function(Value) hitboxSize = Value end})
    ViciousTab:CreateSection("--- Flag Injector (FFlags) ---")
    ViciousTab:CreateInput({Name = "Paste FFlags JSON", PlaceholderText = '{"FFlagName": true, "DFIntSetting": 100, "DFFlagExample": false}', RemoveTextAfterFocusLost = false, Callback = function(Value)
        local HttpService = game:GetService("HttpService")
        local success, decoded = pcall(function() return HttpService:JSONDecode(Value) end)
        if success and type(decoded) == "table" then
            local injectedCount = 0
            for k, v in pairs(decoded) do
                if ToggleFFlag(k, v) then injectedCount = injectedCount + 1 end
            end
            Rayfield:Notify({Title = "Flag Injector", Content = "✅ Injected " .. injectedCount .. " Fast Flags successfully!", Duration = 6})
        else
            Rayfield:Notify({Title = "Flag Injector", Content = "❌ Invalid JSON!", Duration = 6})
        end
    end})

    ViciousTab:CreateSection("--- Daisy n Roses FPS Boost ---")
    ViciousTab:CreateButton({
        Name = "🌸 Daisy n Roses (FPS Boost + Gray Sky)",
        Callback = InjectDaisyNRoses
    })

    ViciousTab:CreateSection("--- Configs ---")
    ViciousTab:CreateButton({Name = "Save Config", Callback = function() Rayfield:SaveConfig() Rayfield:Notify({Title = "Config Saved", Content = "✅ All settings saved!", Duration = 6}) end})
    ViciousTab:CreateButton({Name = "Load Config", Callback = function() Rayfield:LoadConfig() Rayfield:Notify({Title = "Config Loaded", Content = "✅ Settings loaded!", Duration = 6}) end})

    -- Hell Tab
    HellTab:CreateSection("jump power")
    HellTab:CreateToggle({Name = "jump power", CurrentValue = false, Callback = function(Value)
        jumpPowerEnabled = Value
        if Value then
            if jumpConnection then jumpConnection:Disconnect() end
            jumpConnection = humanoid.Jumping:Connect(function()
                if jumpPowerEnabled and rootPart then
                    rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 0, rootPart.Velocity.Z) + Vector3.new(0, customJumpPower, 0)
                end
            end)
        else
            if jumpConnection then jumpConnection:Disconnect() end
            jumpConnection = nil
        end
    end})
    HellTab:CreateSlider({Name = "jump power value", Range = {10, 200}, Increment = 1, CurrentValue = 50, Callback = function(Value) customJumpPower = Value end})
    HellTab:CreateSection("gravity")
    HellTab:CreateToggle({Name = "gravity", CurrentValue = false, Callback = function(Value)
        gravityEnabled = Value
        Workspace.Gravity = Value and customGravity or 196.2
    end})
    HellTab:CreateSlider({Name = "gravity value", Range = {10, 400}, Increment = 1, CurrentValue = 196, Callback = function(Value)
        customGravity = Value
        if gravityEnabled then Workspace.Gravity = Value end
    end})
    HellTab:CreateButton({Name = "reset gravity", Callback = function() customGravity = 196.2 Workspace.Gravity = 196.2 end})
    HellTab:CreateSection("--- Visuals ---")
    HellTab:CreateToggle({
        Name = "Gray Sky",
        CurrentValue = false,
        Callback = function(Value)
            graySkyEnabled = Value
            if Value then
                originalAmbient = Lighting.Ambient
                originalBrightness = Lighting.Brightness
                local sky = Lighting:FindFirstChildOfClass("Sky")
                if sky then originalSky = sky:Clone() sky:Destroy() end
                Lighting.Ambient = Color3.fromRGB(80, 80, 80)
                Lighting.Brightness = 0
            else
                if originalAmbient then Lighting.Ambient = originalAmbient end
                if originalBrightness then Lighting.Brightness = originalBrightness end
                if originalSky then originalSky.Parent = Lighting originalSky = nil end
            end
        end
    })
    HellTab:CreateSection("ball manipulation")
    HellTab:CreateToggle({Name = "ball manipulation", CurrentValue = false, Callback = function(Value)
        ballTeleportEnabled = Value
        if Value then
            if teleportConn then teleportConn:Disconnect() end
            teleportConn = RunService.Heartbeat:Connect(function()
                if not ballTeleportEnabled then return end
                local ball = getFootball()
                if ball and rootPart and character then
                    local dist = (ball.Position - rootPart.Position).Magnitude
                    if dist <= teleportRange then
                        local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
                        local leftHand = character:FindFirstChild("LeftHand") or character:FindFirstChild("Left Arm")
                        local targetHand = nil
                        local closestDist = math.huge
                        if rightHand then
                            local d = (ball.Position - rightHand.Position).Magnitude
                            if d < closestDist then closestDist = d targetHand = rightHand end
                        end
                        if leftHand then
                            local d = (ball.Position - leftHand.Position).Magnitude
                            if d < closestDist then closestDist = d targetHand = leftHand end
                        end
                        if targetHand then
                            local handOffset = CFrame.new(0, 0.35, -0.25)
                            local targetCFrame = targetHand.CFrame * handOffset
                            ball.CFrame = targetCFrame
                            ball.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            ball.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                        else
                            local targetPos = rootPart.Position + rootPart.CFrame.LookVector * 3 + Vector3.new(0, 2.5, 0)
                            ball.Position = targetPos
                            ball.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            ball.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                        end
                    end
                end
            end)
        else
            if teleportConn then teleportConn:Disconnect() teleportConn = nil end
        end
    end})
    HellTab:CreateSlider({Name = "teleport range", Range = {10, 200}, Increment = 5, Suffix = " studs", CurrentValue = 50, Callback = function(Value) teleportRange = Value end})
    HellTab:CreateSection("boost (with ball)")
    HellTab:CreateToggle({Name = "boost", CurrentValue = false, Callback = function(Value) boostEnabled = Value end})
    HellTab:CreateSlider({Name = "boost power", Range = {25, 135}, Increment = 1, CurrentValue = 25, Callback = function(Value) boostPower = Value end})
    HellTab:CreateSection("boost (no ball) - 5 second cooldown")
    HellTab:CreateToggle({Name = "boost", CurrentValue = false, Callback = function(Value) simpleBoostEnabled = Value end})
    HellTab:CreateSlider({Name = "boost power", Range = {25, 135}, Increment = 1, CurrentValue = 25, Callback = function(Value) simpleBoostPower = Value end})
    HellTab:CreateSection("--- Hitbox Transparency ---")
    HellTab:CreateSlider({Name = "Hitbox Transparency", Range = {0, 1}, Increment = 0.01, CurrentValue = 0.5, Callback = function(Value) hitboxTransparency = Value end})

    -- Animations Tab AnimationsTab:CreateSection("midnight Hub Emotes")
local senEmotes = {
    {Name = "Bop", Id = 8028669437},
    {Name = "BBS", Id = 2178463446},
    {Name = "Hackers", Id = 10714364213},
    {Name = "Ball Spin", Id = 14215798544},
    {Name = "Gronk Spike", Id = 13782932458},
    {Name = "Griddy", Id = 8028694339},
    {Name = "Smith Knicks", Id = 15312473847},
    {Name = "Head Dribble", Id = 133666867152446},
    {Name = "Sturdy", Id = 14215791622},
    {Name = "Mop", Id = 14215807283},
    {Name = "Samurai Slash", Id = 15249657798},
    {Name = "Dimension", Id = 5618747341},
    {Name = "Take The L", Id = 2293391158},
    {Name = "Goopie", Id = 5439090599},
    {Name = "Headless", Id = 5704065738},
    {Name = "Moon", Id = 14216002323},
    {Name = "Neighborly Hang", Id = 11006145037},
    {Name = "Worm", Id = 3471311681},
    {Name = "Hacky Sack", Id = 14220954146},
    {Name = "Goodnight", Id = 15375772247},
    {Name = "Head Spin", Id = 14920821886},
    {Name = "Keep It Hot", Id = 85267023718407},
    {Name = "Peanut Butter Jelly Time", Id = 5433555683},
    {Name = "Memphis Pregame", Id = 14138482621},
}

for _, emote in ipairs(senEmotes) do
    AnimationsTab:CreateButton({
        Name = emote.Name,
        Callback = function()
            LoadTrack(emote.Id, 1)
            Rayfield:Notify({Title = "Emote", Content = emote.Name .. " is now playing", Duration = 3})
        end
    })
end

AnimationsTab:CreateButton({Name = "Print Current Emote ID", Callback = function()
    local track = humanoid:GetPlayingAnimationTracks()[1]
    if track and track.Animation then
        print("CURRENT EMOTE ID: " .. track.Animation.AnimationId)
        Rayfield:Notify({Title = "Emote ID", Content = "Check F9 console", Duration = 6})
    end
end})

AnimationsTab:CreateButton({Name = "Stop Animation", Callback = function()
    if CurrentTrack then 
        CurrentTrack:Stop(0) 
        CurrentTrack = nil 
    end
    Rayfield:Notify({Title = "Emotes", Content = "All animations stopped", Duration = 3})
end})
   

    -- Items Tab
 

-- midnight Hats Data
local JapanHats = {
    {Name="Dark Ruby Crown", Id=7912127597},
    {Name="Ushanka", Id=12710415119},
    {Name="Midnight Commando", Id=259424866},
    {Name="Arctic Commando", Id=87396780155106},
    {Name="Blue Clockwork Headphones", Id=1743903423},
    {Name="White Clockwork Headphones", Id=97230132426750},
    {Name="Designer Keffiyeh", Id=14157118140},
    {Name="Black Clockwork Headphones", Id=93874449800600},
    {Name="Grey Evil", Id=14473922871},
    {Name="Cute Y2K White", Id=13871010686},
    {Name="LA Fitted", Id=112353733720226},
}

local HatOffsets = {
    [259424866]       = CFrame.new(0, 0.1, 0),
    [7912127597]      = CFrame.new(0, 0.8, 0.1) * CFrame.Angles(0, math.rad(90), 0),
    [87396780155106]  = CFrame.new(0, 0.1, 0) * CFrame.Angles(0, math.rad(180), 0),
    [13871010686]     = CFrame.new(0, 0.3, 0) * CFrame.Angles(0, math.rad(180), 0),
}

local EquippedJapanHats = {}

local function ResetJapanHats()
    for _, obj in ipairs(EquippedJapanHats) do
        if obj and obj.Parent then obj:Destroy() end
    end
    table.clear(EquippedJapanHats)
end

local function EquipJapanHat(assetId)
    local success, model = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(assetId))[1]
    end)
    
    if not success or not model then 
        Rayfield:Notify({Title = "Error", Content = "Failed to load hat", Duration = 3})
        return 
    end

    local head = plr.Character and plr.Character:FindFirstChild("Head")
    if not head then return end

    local offset = HatOffsets[assetId] or CFrame.new(0, 0.3, 0) * CFrame.Angles(0, math.rad(180), 0)

    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = false
            part.CanCollide = false
            part.Massless = true
            part.CFrame = head.CFrame * offset
            part.Parent = plr.Character

            local weld = Instance.new("WeldConstraint")
            weld.Part0 = head
            weld.Part1 = part
            weld.Parent = part

            table.insert(EquippedJapanHats, part)
        end
    end
    Rayfield:Notify({Title = "Japan Hat", Content = "Equipped!", Duration = 2})
end

-- Create buttons for each Japan Hat
for _, hat in ipairs(JapanHats) do
    ItemsTab:CreateButton({
        Name = " " .. hat.Name,
        Callback = function()
            EquipJapanHat(hat.Id)
        end
    })
end

ItemsTab:CreateButton({
    Name = "Reset All midnight Hats",
    Callback = function()
        ResetJapanHats()
        Rayfield:Notify({Title = "Hats", Content = "All Japan hats removed", Duration = 3})
    end
})   ItemsTab:CreateSection("mesh items")
    for name, _ in pairs(MESH_ITEMS) do
        ItemsTab:CreateToggle({Name = name, CurrentValue = false, Callback = function(Value)
            if Value then 
                equipMeshItem(name) 
                if name == "PinkScene" then
                    Rayfield:Notify({Title = "Pink Scene", Content = "✅ Pink Scene equipped (from Mockering Hub)", Duration = 4})
                end
            else 
                unequipItem(name) 
            end
        end})
    end
    ItemsTab:CreateSection("accessories")
    for name, _ in pairs(ACCESSORY_ITEMS) do
        ItemsTab:CreateToggle({Name = name, CurrentValue = false, Callback = function(Value)
            if Value then equipAccessory(name) else unequipItem(name) end
        end})
    end

    -- Clothing Tab
    ClothingTab:CreateSection("clothing items")
    for name, _ in pairs(CLOTHING_ITEMS) do
        ClothingTab:CreateToggle({Name = name, CurrentValue = false, Callback = function(Value)
            if Value then equipClothing(name) else unequipItem(name) end
        end})
    end

    -- Graphics Tab
    GraphicsTab:CreateSection("optimize")
    GraphicsTab:CreateButton({Name = "potato graphics", Callback = function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 0
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("BlurEffect") then effect.Size = 4
            elseif effect:IsA("SunRaysEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("BloomEffect") or effect:IsA("DepthOfFieldEffect") then
                effect.Enabled = false
            end
        end
        local terrain = Workspace.Terrain
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0
        terrain.WaterTransparency = 0
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("Part") or obj:IsA("MeshPart") then
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
            end
        end
    end})
    GraphicsTab:CreateSection("--- Visuals ---")
    GraphicsTab:CreateToggle({
        Name = "Red Sky (matches video)",
        CurrentValue = false,
        Callback = function(Value)
            redSkyEnabled = Value
            if Value then
                originalAmbientRed = Lighting.Ambient
                originalBrightnessRed = Lighting.Brightness
                local sky = Lighting:FindFirstChildOfClass("Sky")
                if sky then originalSkyRed = sky:Clone() sky:Destroy() end
                Lighting.Ambient = Color3.fromRGB(120, 10, 10)
                Lighting.Brightness = 0.3
                Lighting.FogEnd = 500
                Lighting.FogColor = Color3.fromRGB(100, 0, 0)
            else
                if originalAmbientRed then Lighting.Ambient = originalAmbientRed end
                if originalBrightnessRed then Lighting.Brightness = originalBrightnessRed end
                if originalSkyRed then originalSkyRed.Parent = Lighting originalSkyRed = nil end
                Lighting.FogEnd = 100000
                Lighting.FogColor = Color3.fromRGB(199, 199, 199)
            end
        end
    })

    -- Justice Tab
    JusticeTab:CreateSection("unload")
    JusticeTab:CreateButton({Name = "unload script", Callback = function()
        Rayfield:Notify({Title = "Midnight Hub", Content = "destroying midnight hub", Duration = 2})
        task.wait(0.5)
        if teleportConn then teleportConn:Disconnect() end
        Rayfield:Destroy()
        smoothPullEnabled = false
        boostEnabled = false
        simpleBoostEnabled = false
        jumpPowerEnabled = false
        gravityEnabled = false
        ballTeleportEnabled = false
        hitboxEnabled = false
        if jumpConnection then jumpConnection:Disconnect() end
        Workspace.Gravity = 196.2
        if graySkyEnabled then
            if originalAmbient then Lighting.Ambient = originalAmbient end
            if originalBrightness then Lighting.Brightness = originalBrightness end
            if originalSky then originalSky.Parent = Lighting end
        end
        if redSkyEnabled then
            if originalAmbientRed then Lighting.Ambient = originalAmbientRed end
            if originalBrightnessRed then Lighting.Brightness = originalBrightnessRed end
            if originalSkyRed then originalSkyRed.Parent = Lighting end
        end
        pcall(function()
            if getconnections then
                for _, v in pairs(getconnections(game:GetService("LogService").MessageOut)) do
                    pcall(function() v:Enable() end)
                end
            end
        end)
    end})

    JusticeTab:CreateSection("Extra Tools")
    JusticeTab:CreateButton({
        Name = "Activate Delta Hider",
        Callback = activateDeltaHider
    })

    -- ===================== ORIGINAL GREATNESS AND BALL MANIPULATION TABS (kept from your script) =====================
    GreatnessTab:CreateSection("Movement")
    GreatnessTab:CreateToggle({Name = "Enable Jump Power", CurrentValue = false, Callback = function(v) jumpPowerEnabled = v end})
    GreatnessTab:CreateSlider({Name = "Jump Power", Range = {51, 60}, Increment = 1, CurrentValue = 51, Callback = function(v) customJumpPower = v end})
    GreatnessTab:CreateToggle({Name = "Enable Loop Speed", CurrentValue = false, Callback = function(v) loopSpeedEnabled = v end})
    GreatnessTab:CreateSlider({Name = "Loop Speed", Range = {18, 25}, Increment = 1, CurrentValue = 18, Callback = function(v) loopSpeedValue = v end})
    GreatnessTab:CreateToggle({Name = "CFrame Speed", CurrentValue = false, Callback = function(v) cframeSpeedEnabled = v end})
    GreatnessTab:CreateSection("Gravity")
    GreatnessTab:CreateToggle({Name = "Enable Custom Gravity", CurrentValue = false, Callback = function(v) gravityEnabled = v end})
    GreatnessTab:CreateSlider({Name = "Custom Gravity", Range = {0, 300}, Increment = 1, CurrentValue = 196, Callback = function(v) customGravity = v end})

    BallManipulationTab:CreateSection("Advanced Boost")
    BallManipulationTab:CreateToggle({Name = "Boost Manipulator (hold R / R1)", CurrentValue = false, Callback = function(v) boostManipEnabled = v end})
    BallManipulationTab:CreateSlider({Name = "Boost Distance", Range = {5, 25}, Increment = 1, CurrentValue = 10, Callback = function(v) BOOST_RADIUS = v end})
    BallManipulationTab:CreateSlider({Name = "Boost Strength", Range = {0.1, 1}, Increment = 0.1, CurrentValue = 0.65, Callback = function(v) FOLLOW_LERP = v end})
    BallManipulationTab:CreateSection("Ball Control")
    BallManipulationTab:CreateToggle({Name = "Advanced Ball Manipulation", CurrentValue = false, Callback = function(v) ballTeleportEnabled = v end})
    BallManipulationTab:CreateSection("Sticky Head")
    BallManipulationTab:CreateToggle({Name = "Sticky Head", CurrentValue = false, Callback = function(v) stickyHeadEnabled = v end})
    BallManipulationTab:CreateSlider({Name = "Sticky Strength", Range = {1, 10}, Increment = 1, CurrentValue = 5, Callback = function(v) stickyStrength = v end})
    BallManipulationTab:CreateSection("TTB / Head Tech")
    BallManipulationTab:CreateToggle({Name = "TTB", CurrentValue = false, Callback = function(v) ttbEnabled = v end})
    BallManipulationTab:CreateSlider({Name = "TTB Power", Range = {1, 10}, Increment = 1, CurrentValue = 5, Callback = function(v) ttbPower = v end})
    BallManipulationTab:CreateToggle({Name = "Head Manipulation", CurrentValue = false, Callback = function(v) headManipEnabled = v end})
    BallManipulationTab:CreateSlider({Name = "Head Strength", Range = {1, 20}, Increment = 1, CurrentValue = 10, Callback = function(v) headStrength = v end})
    BallManipulationTab:CreateToggle({Name = "Head Follow", CurrentValue = false, Callback = function(v) headFollowEnabled = v end})

    -- ===================== NEW TABS AT THE END =====================
    local WagerBundleTab = Window:CreateTab("Wager Bundle", 4483362458)
    WagerBundleTab:CreateSection("High-Stakes Plays")
    WagerBundleTab:CreateToggle({Name = "Strong Magnet Pull", CurrentValue = false, Callback = function(Value) smoothPullEnabled = Value end})
    WagerBundleTab:CreateSlider({Name = "Magnet Smoothness", Range = {0.01, 0.3}, Increment = 0.01, CurrentValue = 0.08, Callback = function(Value) magnetSmoothness = Value end})
    WagerBundleTab:CreateToggle({Name = "Power Boost", CurrentValue = false, Callback = function(Value) boostEnabled = Value end})
    WagerBundleTab:CreateButton({Name = "Server Hop", Callback = serverHop})

    local ChampagneTab = Window:CreateTab("Champagne and Roses", 4483362458)
    ChampagneTab:CreateSection("Luxury & Flex")
    ChampagneTab:CreateToggle({Name = "Fly", CurrentValue = false, Callback = function(Value) flyEnabled = Value toggleFly() end})
    ChampagneTab:CreateSlider({Name = "Fly Speed", Range = {30, 120}, Increment = 5, CurrentValue = 50, Callback = function(Value) flySpeed = Value end})
    ChampagneTab:CreateToggle({Name = "Noclip", CurrentValue = false, Callback = function(Value) noclipEnabled = Value toggleNoclip() end})
    ChampagneTab:CreateToggle({Name = "Infinite Jump", CurrentValue = false, Callback = function(Value) infJumpEnabled = Value toggleInfJump() end})
    ChampagneTab:CreateToggle({Name = "FOV Changer", CurrentValue = false, Callback = function(Value) fovEnabled = Value end})
    ChampagneTab:CreateSlider({Name = "FOV Value", Range = {60, 120}, Increment = 1, CurrentValue = 90, Callback = function(Value) customFOV = Value end})
    ChampagneTab:CreateToggle({Name = "Fullbright", CurrentValue = false, Callback = toggleFullbright})
    ChampagneTab:CreateToggle({Name = "ESP (Name + Distance)", CurrentValue = false, Callback = function(Value) espEnabled = Value end})
    ChampagneTab:CreateButton({Name = "Server Hop", Callback = serverHop})
    ChampagneTab:CreateButton({Name = "Pop Champagne", Callback = function()
        Rayfield:Notify({Title = "Champagne and Roses", Content = "✨ You are now glowing different", Duration = 5})
    end})

    Rayfield:Notify({
        Title = "Midnight Hub",
        Content = "✅ Full original script loaded • Delta Hider in Justice tab • Wager Bundle & Champagne and Roses added",
        Duration = 8
    })
end

-- ==================== AUTO LOAD ====================
loadMainUI()
]==])

setSource("Overtime", [==[
-- Overtime
local Players    = game:GetService("Players")
local UIS        = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting   = game:GetService("Lighting")
local Workspace  = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Fresh-start guard: re-running deactivates the previous instance (its loops stop)
-- and closes the old menu, so nothing you had enabled carries over on relaunch.
local instance = {}
do
	local env = (getgenv and getgenv()) or _G
	local prev = env.Overtime
	if prev then
		prev.active = false
		pcall(function()
			local w = prev.window
			if w then (w.Destroy or w.Close)(w) end
		end)
	end
	env.Overtime = instance
end
instance.active = true
-- Forward-declare WindUI so every callback defined before the library loads
-- captures the same upvalue rather than falling through to a nil global.
local WindUI
local player = Players.LocalPlayer
repeat task.wait() until player and player:FindFirstChild("PlayerGui")
local S = {
	boostPower = 72,
	maxBoost = 750,
	walkSpeed = 21,
	maxWalkSpeed = 500,
	gravityValue = 196,
	gravityMax = 300,
	noclipEnabled = false,
	potatoEnabled = false,
	pullVecEnabled = false,
	pullVecHeld = false,
	pullVecStrength = 120,
	pullVecSmooth = 0.15,
	cfMagsEnabled = false,
	orbMagsEnabled = false,
	magsHeld = false,
	glovesEnabled = false,
	gloveSize = 6,
	glovesInvisible = false,
	originalHandSizes = {},
	orbEnabled = false,
	orbRadius = 20,
	orbColor = Color3.fromRGB(0, 140, 255),
	orbTransparency = 0.6,
	orbPart = nil,
	cachedBall = nil,
	ballSearchTimer = 0,
	noclipTimer = 0,
	ballMagEnabled = false,
	ballRangeEnabled = false,
	ballMagRange = 50,
	ballSpeedRange = 25,
	ballBoostedSpeed = 999,
	ballDefaultSpeed = 95,
	ballPullStrength = 110,
	ballJitterAmp = 14,
	ballJitterFreq = 22,
	ballSnapDist = 1.5,
	footballSpeed = nil,
	stickyHeadEnabled = false,
	stickyHeadSize = 35,
	stickyHeadZones = {},
	stickyHeadNotifs = true,
	rotationSmoothness = 0.08,
	airControlSmoothing = 0.16,
	stickyPullStrength = 2.0,
	stickyStickiness = 2.0,
	rocketSpeed = 9999,
	rocketDuration = 0.5,
	rocketActive = false,
	rocketCooldown = false,
	divePower = 50,
	walkSpeedLock = true,
	headManipEnabled = false,
	headStrength = 2.0,
	jumpPullEnabled = false,
	jumpPullActive = false,
}

-- Forward-declare functions/state referenced before their definitions (e.g. in the
-- master Heartbeat) so early callbacks capture the shared upvalue, not a nil global.
local getHands, claimBallOwnership, catchBall, applyGloves, applyPixelFaces
local boostAmpEnabled, boostAmpMultiplier, lastYVelocity, boostAmpFired, pixelFacesEnabled
-- ─────────────────────────────────────────────────────────────────────────────
local char = player.Character or player.CharacterAdded:Wait()
local hrp  = char:WaitForChild("HumanoidRootPart")
local hum  = char:WaitForChild("Humanoid")
player.CharacterAdded:Connect(function(c)
char = c
hrp  = c:WaitForChild("HumanoidRootPart")
hum  = c:WaitForChild("Humanoid")
hum.WalkSpeed = S.walkSpeed
if S.noclipEnabled then
for _, p in pairs(c:GetDescendants()) do
if p:IsA("BasePart") then p.CanCollide = false end
end
end
end)
local originalProps = {}
local function applyPotato()
originalProps.QualityLevel             = settings().Rendering.QualityLevel
originalProps.Ambient                  = Lighting.Ambient
originalProps.Brightness               = Lighting.Brightness
originalProps.GlobalShadows            = Lighting.GlobalShadows
originalProps.FogEnd                   = Lighting.FogEnd
originalProps.FogStart                 = Lighting.FogStart
originalProps.ClockTime                = Lighting.ClockTime
originalProps.ShadowSoftness           = Lighting.ShadowSoftness
originalProps.EnvironmentDiffuseScale  = Lighting.EnvironmentDiffuseScale
originalProps.EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale
Lighting.Ambient                  = Color3.fromRGB(255, 255, 255)
	Lighting.Brightness               = 0.8
	Lighting.GlobalShadows            = false
	Lighting.FogEnd                   = 9e9
	Lighting.FogStart                 = 9e9
	Lighting.ShadowSoftness           = 0
	Lighting.ClockTime                = 14
	Lighting.EnvironmentDiffuseScale  = 0
	Lighting.EnvironmentSpecularScale = 0

	for _, effect in pairs(Lighting:GetChildren()) do
		if effect:IsA("Atmosphere") or effect:IsA("Sky")
			or effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect")
			or effect:IsA("ColorCorrectionEffect") or effect:IsA("DepthOfFieldEffect")
			or effect:IsA("BloomEffect") then
			effect:Destroy()
		end
	end

	settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

	for _, obj in pairs(Workspace:GetDescendants()) do
		local t = obj.ClassName
		if t == "ParticleEmitter" or t == "Trail" or t == "Beam"
			or t == "Fire" or t == "Smoke" or t == "Sparkles"
			or t == "Texture" then
			obj:Destroy()
		end
	end

	if char then
		for _, obj in pairs(char:GetDescendants()) do
			local t = obj.ClassName
			if t == "ParticleEmitter" or t == "Trail" or t == "Beam"
				or t == "Fire" or t == "Smoke" or t == "Sparkles" then
				obj:Destroy()
			end
		end
	end
end
local function removePotato()
if originalProps.Ambient then
settings().Rendering.QualityLevel    = originalProps.QualityLevel or Enum.QualityLevel.Automatic
Lighting.EnvironmentDiffuseScale      = originalProps.EnvironmentDiffuseScale  or 1
Lighting.EnvironmentSpecularScale     = originalProps.EnvironmentSpecularScale or 1
Lighting.Ambient                      = originalProps.Ambient
Lighting.Brightness                   = originalProps.Brightness
Lighting.GlobalShadows                = originalProps.GlobalShadows
Lighting.FogEnd                       = originalProps.FogEnd
Lighting.ShadowSoftness               = originalProps.ShadowSoftness or 0.5
Lighting.ClockTime                    = originalProps.ClockTime or 14
end
end
-- ── Sky Presets ───────────────────────────────────────────────────────────────
local originalLighting = {
Brightness           = Lighting.Brightness,
Ambient              = Lighting.Ambient,
OutdoorAmbient       = Lighting.OutdoorAmbient,
FogEnd               = Lighting.FogEnd,
FogColor             = Lighting.FogColor,
ClockTime            = Lighting.ClockTime,
ExposureCompensation = Lighting.ExposureCompensation,
}
local currentSkyPreset = "Default"
local function cleanSkyEffects()
for _, obj in pairs(Lighting:GetChildren()) do
if obj.Name == "Overtime_Sky" or obj.Name == "Overtime_Effect" then
obj:Destroy()
end
end
end
local SKY_BK = "http://www.roblox.com/asset/?id=2670643365"
local function makeSky(stars)
local sky = Instance.new("Sky")
sky.Name = "Overtime_Sky"
sky.SkyboxBk = SKY_BK; sky.SkyboxDn = SKY_BK; sky.SkyboxFt = SKY_BK
sky.SkyboxLf = SKY_BK; sky.SkyboxRt = SKY_BK; sky.SkyboxUp = SKY_BK
sky.StarCount = stars or 0
sky.Parent    = Lighting
return sky
end
local function makeCC(tint, brightness, saturation)
local cc = Instance.new("ColorCorrectionEffect")
cc.Name       = "Overtime_Effect"
cc.TintColor  = tint
cc.Brightness = brightness or 0
cc.Saturation = saturation or 0
cc.Parent     = Lighting
end
local function makeBloom(intensity, size, threshold)
local b = Instance.new("BloomEffect")
b.Name      = "Overtime_Effect"
b.Intensity = intensity
b.Size      = size
b.Threshold = threshold
b.Parent    = Lighting
end
local function makeSunRays(intensity, spread)
local s = Instance.new("SunRaysEffect")
s.Name      = "Overtime_Effect"
s.Intensity = intensity
s.Spread    = spread
s.Parent    = Lighting
end
local function ApplySky(preset)
currentSkyPreset = preset
cleanSkyEffects()
task.wait(0.05)
if preset == "Default" then
		Lighting.Brightness           = originalLighting.Brightness
		Lighting.Ambient              = originalLighting.Ambient
		Lighting.OutdoorAmbient       = originalLighting.OutdoorAmbient
		Lighting.FogEnd               = originalLighting.FogEnd
		Lighting.ClockTime            = originalLighting.ClockTime
		Lighting.ExposureCompensation = originalLighting.ExposureCompensation

	elseif preset == "Sunset Paradise" then
		Lighting.Brightness = 2.5; Lighting.ClockTime = 18.5; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(255, 140, 70); Lighting.OutdoorAmbient = Color3.fromRGB(255, 160, 100)
		makeSky(1000); makeSunRays(0.15, 0.6); makeBloom(0.6, 24, 0.8)

	elseif preset == "Golden Hour" then
		Lighting.Brightness = 3; Lighting.ClockTime = 17; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(255, 200, 120); Lighting.OutdoorAmbient = Color3.fromRGB(255, 180, 100)
		local sky = makeSky(0); sky.SunAngularSize = 18
		makeCC(Color3.fromRGB(255, 220, 180), 0.1, 0.2)

	elseif preset == "Warm Summer" then
		Lighting.Brightness = 2.8; Lighting.ClockTime = 14; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(255, 220, 180); Lighting.OutdoorAmbient = Color3.fromRGB(255, 200, 150)
		makeSky(0); makeSunRays(0.12, 0.5)

	elseif preset == "Pink Dream" then
		Lighting.Brightness = 2.5; Lighting.ClockTime = 17.5; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(255, 180, 220); Lighting.OutdoorAmbient = Color3.fromRGB(255, 150, 200)
		makeSky(2000); makeCC(Color3.fromRGB(255, 200, 220), 0.05, 0.2)

	elseif preset == "Orange Glow" then
		Lighting.Brightness = 2.6; Lighting.ClockTime = 18; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(255, 180, 100); Lighting.OutdoorAmbient = Color3.fromRGB(255, 160, 80)
		makeSky(0); makeBloom(0.5, 28, 0.7)

	elseif preset == "Coral Sunset" then
		Lighting.Brightness = 2.7; Lighting.ClockTime = 19; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(255, 140, 140); Lighting.OutdoorAmbient = Color3.fromRGB(255, 120, 120)
		makeSky(0); makeCC(Color3.fromRGB(255, 180, 180), 0.08, 0.25)

	elseif preset == "Clear Day" then
		Lighting.Brightness = 3; Lighting.ClockTime = 14; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(200, 200, 200); Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
		makeSunRays(0.1, 0.5)

	elseif preset == "Vaporwave Dream" then
		Lighting.Brightness = 2.2; Lighting.ClockTime = 16; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(255, 150, 255); Lighting.OutdoorAmbient = Color3.fromRGB(200, 120, 200)
		makeSky(3000); makeCC(Color3.fromRGB(255, 180, 255), 0.05, 0.4)

	elseif preset == "Midnight Blue" then
		Lighting.Brightness = 1.2; Lighting.ClockTime = 0; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(80, 80, 140); Lighting.OutdoorAmbient = Color3.fromRGB(60, 60, 120)
		local sky = Instance.new("Sky")
		sky.Name = "Overtime_Sky"
		sky.SkyboxBk = "http://www.roblox.com/asset/?id=159454299"
		sky.SkyboxDn = "http://www.roblox.com/asset/?id=159454296"
		sky.SkyboxFt = "http://www.roblox.com/asset/?id=159454293"
		sky.SkyboxLf = "http://www.roblox.com/asset/?id=159454286"
		sky.SkyboxRt = "http://www.roblox.com/asset/?id=159454300"
		sky.SkyboxUp = "http://www.roblox.com/asset/?id=159454288"
		sky.StarCount = 5000; sky.Parent = Lighting
		makeBloom(0.8, 24, 0.8)
	end
end
local skyLoopEnabled = false
local skyLoopIndex   = 1
local SKY_LOOP_LIST  = {
"Sunset Paradise", "Golden Hour", "Warm Summer", "Pink Dream",
"Orange Glow", "Coral Sunset", "Clear Day", "Vaporwave Dream", "Midnight Blue",
}
-- Re-apply / cycle skies every second
task.spawn(function()
while task.wait(1) do
if not instance.active then break end
if skyLoopEnabled then
ApplySky(SKY_LOOP_LIST[skyLoopIndex])
skyLoopIndex = skyLoopIndex % #SKY_LOOP_LIST + 1
elseif currentSkyPreset ~= "Default" then
if not Lighting:FindFirstChild("Overtime_Sky") then
ApplySky(currentSkyPreset)
end
end
end
end)
-- ─────────────────────────────────────────────────────────────────────────────
local function clipEnhanceObj(obj)
if not S.potatoEnabled then return end
local t = obj.ClassName
if t == "ParticleEmitter" or t == "Trail" or t == "Beam"
or t == "Fire" or t == "Smoke" or t == "Sparkles"
or t == "Texture" then
obj:Destroy()
end
end
workspace.DescendantAdded:Connect(function(obj)
task.defer(function() clipEnhanceObj(obj) end)
end)
-- Scans workspace for the nearest Football — called at most every 0.3 s
local function refreshBallCache()
local nearest, nearestDist = nil, math.huge
if not hrp then return end
for _, obj in pairs(workspace:GetDescendants()) do
if obj.Name == "Football" and obj:IsA("BasePart") then
local dist = (obj.Position - hrp.Position).Magnitude
if dist < nearestDist then
nearest     = obj
nearestDist = dist
end
end
end
S.cachedBall = nearest
end
-- ── Ball Manipulation helpers ─────────────────────────────────────────────────
local function characterHasFootball(c, football)
if not c then return false end
for _, desc in ipairs(c:GetDescendants()) do
if desc:IsA("Weld") or desc:IsA("Motor6D") or desc:IsA("WeldConstraint") then
if desc.Part0 and desc.Part1 then
if desc.Part0.Name == "Football" or desc.Part1.Name == "Football" then
return true
end
end
end
end
for _, child in ipairs(c:GetChildren()) do
if child:IsA("Tool") then
local handle = child:FindFirstChild("Handle")
if handle and handle.Name == "Football" then return true end
end
end
if football then
for _, desc in ipairs(football:GetDescendants()) do
if desc:IsA("Weld") or desc:IsA("Motor6D") or desc:IsA("WeldConstraint") then
if desc.Part0 and desc.Part1 then
if desc.Part0.Parent == c or desc.Part1.Parent == c then
return true
end
end
end
end
end
return false
end
local function localHasFootball()
return characterHasFootball(char, S.cachedBall)
end
local function anyOtherHasFootball(football)
for _, plr in ipairs(Players:GetPlayers()) do
if plr ~= player then
local c = plr.Character
if c and characterHasFootball(c, football) then return true end
end
end
return false
end
local function findFootballSpeed()
for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
if v.Name == "FootballSpeed" and v:IsA("NumberValue") then
S.footballSpeed = v; return
end
end
end
findFootballSpeed()
ReplicatedStorage.DescendantAdded:Connect(function(v)
if not S.footballSpeed and v.Name == "FootballSpeed" and v:IsA("NumberValue") then
S.footballSpeed = v
end
end)
-- ─────────────────────────────────────────────────────────────────────────────
RunService.Stepped:Connect(function(_, dt)
if not instance.active then return end
-- Noclip: throttled to every 0.1 s — was running every physics step
if S.noclipEnabled and char then
S.noclipTimer = S.noclipTimer + dt
if S.noclipTimer >= 0.1 then
S.noclipTimer = 0
for _, p in pairs(char:GetDescendants()) do
if p:IsA("BasePart") then p.CanCollide = false end
end
end
end
-- Ball cache: only scan workspace when the ball is gone or every 0.3 s
	local needsBall = (S.pullVecEnabled and S.pullVecHeld) or S.orbEnabled
		or (S.cfMagsEnabled and S.magsHeld) or S.orbMagsEnabled
	if needsBall then
		if not S.cachedBall or not S.cachedBall.Parent then
			refreshBallCache()
			S.ballSearchTimer = 0.3
		else
			S.ballSearchTimer = S.ballSearchTimer - dt
			if S.ballSearchTimer <= 0 then
				refreshBallCache()
				S.ballSearchTimer = 0.3
			end
		end
	end

	local nearest     = S.cachedBall
	local nearestDist = (nearest and hrp) and (nearest.Position - hrp.Position).Magnitude or math.huge

	-- Frame-rate-independent lerp alpha (same feel at any FPS)
	local alpha = 1 - (1 - math.clamp(S.pullVecSmooth, 0.01, 0.99)) ^ (dt * 60)

	-- Pull Orb visuals + orb pull
	if S.orbEnabled and nearest then
		if not S.orbPart or not S.orbPart.Parent then
			S.orbPart              = Instance.new("Part")
			S.orbPart.Name         = "NexusOrb"
			S.orbPart.Shape        = Enum.PartType.Ball
			S.orbPart.Anchored     = true
			S.orbPart.CanCollide   = false
			S.orbPart.CastShadow   = false
			S.orbPart.Massless     = true
			S.orbPart.Color        = S.orbColor
			S.orbPart.Transparency = S.orbTransparency
			S.orbPart.Material     = Enum.Material.ForceField
			S.orbPart.Size         = Vector3.new(S.orbRadius * 2, S.orbRadius * 2, S.orbRadius * 2)
			S.orbPart.Parent       = workspace
		end
		S.orbPart.CFrame       = CFrame.new(nearest.Position)
		S.orbPart.Color        = S.orbColor
		S.orbPart.Transparency = S.orbTransparency
		S.orbPart.Size         = Vector3.new(S.orbRadius * 2, S.orbRadius * 2, S.orbRadius * 2)

		if hrp and nearestDist <= S.orbRadius then
			local headHeight  = 3
			local forwardBias = 15
			local ballVel = nearest.AssemblyLinearVelocity
			local flatVel = Vector3.new(ballVel.X, 0, ballVel.Z)
			local target
			if flatVel.Magnitude > 2 then
				target = nearest.Position + Vector3.new(0, -headHeight, 0) + flatVel.Unit * forwardBias
			else
				target = nearest.Position - Vector3.new(0, headHeight, 0)
			end
			hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity:Lerp(
				(target - hrp.Position).Unit * S.pullVecStrength, alpha)
		end
	elseif S.orbPart and S.orbPart.Parent then
		S.orbPart:Destroy()
		S.orbPart = nil
	end

	-- CFrame Mags (reuses cached ball — no extra scan)
	-- CFrame Mags — claim ownership every held frame so writes are authoritative
	if S.cfMagsEnabled and S.magsHeld and hrp and nearest then
		local head = char and char:FindFirstChild("Head")
		if head then
			claimBallOwnership(nearest)
			nearest.CFrame                  = CFrame.new(head.Position)
			nearest.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
			nearest.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			nearest.CanCollide              = false
		end
	end

	-- Orb Mags — same ownership treatment
	if S.orbMagsEnabled and S.orbEnabled and hrp and nearest then
		local head = char and char:FindFirstChild("Head")
		if nearestDist <= S.orbRadius and head then
			claimBallOwnership(nearest)
			nearest.CFrame                  = CFrame.new(head.Position)
			nearest.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
			nearest.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			nearest.CanCollide              = false
		end
	end

	-- Pull Vec
	if S.pullVecEnabled and S.pullVecHeld and hrp and nearest then
		local headHeight  = 3
		local forwardBias = 15
		local ballVel = nearest.AssemblyLinearVelocity
		local flatVel = Vector3.new(ballVel.X, 0, ballVel.Z)
		local target
		if flatVel.Magnitude > 2 then
			target = nearest.Position + Vector3.new(0, -headHeight, 0) + flatVel.Unit * forwardBias
		else
			target = nearest.Position - Vector3.new(0, headHeight, 0)
		end
		local toTarget = target - hrp.Position
		local dist     = toTarget.Magnitude
		if dist > 2 then
			hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity:Lerp(
				toTarget.Unit * S.pullVecStrength, alpha)
		else
			hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
		end
	end
end)
local function rocketBoost()
if S.rocketActive or S.rocketCooldown or not hum then return end
S.rocketActive   = true
S.rocketCooldown = true
local conn = RunService.RenderStepped:Connect(function()
if hum then hum.WalkSpeed = S.rocketSpeed end
end)
task.delay(S.rocketDuration, function()
conn:Disconnect()
if hum then hum.WalkSpeed = S.walkSpeed end
S.rocketActive = false
task.delay(0.25, function() S.rocketCooldown = false end)
end)
end
RunService.RenderStepped:Connect(function()
if not instance.active then return end
if hum and not S.rocketActive then
if S.walkSpeedLock and hum.WalkSpeed ~= S.walkSpeed then
hum.WalkSpeed = S.walkSpeed
end
end
end)
local followEnabled  = false
local followTarget   = nil
local ctrlFollow     = Enum.KeyCode.DPadRight
local followKey      = Enum.KeyCode.F
-- ── Sticky Head keybinds ──────────────────────────────────────────────────────
local ctrlStickyHead = Enum.KeyCode.ButtonR1
local stickyHeadKey  = Enum.KeyCode.Unknown
-- ─────────────────────────────────────────────────────────────────────────────
local function getNearestPlayer()
local nearest, nearestDist = nil, math.huge
for _, plr in pairs(Players:GetPlayers()) do
if plr == player then continue end
local c = plr.Character
local root = c and c:FindFirstChild("HumanoidRootPart")
if not root then continue end
local dist = (root.Position - hrp.Position).Magnitude
if dist < nearestDist then
nearest = plr
nearestDist = dist
end
end
return nearest
end
local function toggleFollow()
if followEnabled then
followEnabled = false
followTarget  = nil
if hum then hum:MoveTo(hrp.Position) end
WindUI:Notify({ Title = "Overtime", Content = "Follow off", Duration = 2, Icon = "flame" })
else
followTarget = getNearestPlayer()
if followTarget then
followEnabled = true
WindUI:Notify({ Title = "Overtime", Content = "Following: " .. followTarget.Name, Duration = 2, Icon = "flame" })
else
WindUI:Notify({ Title = "Overtime", Content = "No players found", Duration = 2, Icon = "flame" })
end
end
end
-- ── Master Heartbeat ─────────────────────────────────────────────────────────
-- All per-frame logic in ONE connection — avoids firing 5 separate loops at 60fps
-- and computes isBeingBoosted() once, shared across all boost features.
local gloveRefreshTimer = 0
local greyPixelTimer    = 0
RunService.Heartbeat:Connect(function(dt)
if not instance.active then return end
-- ── Follow ──────────────────────────────────────────────────────────────
if followEnabled and followTarget and hrp and hum then
local c    = followTarget.Character
local root = c and c:FindFirstChild("HumanoidRootPart")
if not root then
followEnabled = false
followTarget  = nil
WindUI:Notify({ Title = "Overtime", Content = "Follow target lost", Duration = 2, Icon = "user-x" })
else
hum:MoveTo(root.Position)
end
end
if not hrp then return end

	-- ── Boost Amp (delta-based, no player scan needed) ──────────────────────
	local currentY = hrp.AssemblyLinearVelocity.Y
	local delta    = currentY - lastYVelocity

	if boostAmpEnabled and delta > 10 and not boostAmpFired then
		boostAmpFired = true
		hrp.AssemblyLinearVelocity = Vector3.new(
			hrp.AssemblyLinearVelocity.X,
			currentY * boostAmpMultiplier,
			hrp.AssemblyLinearVelocity.Z)
		task.delay(0.3, function() boostAmpFired = false end)
	end

	lastYVelocity = currentY

	-- ── Gloves: enforce size every 0.5 s only ───────────────────────────────
	-- Catching is handled on RenderStepped (before physics) below
	if S.glovesEnabled then
		gloveRefreshTimer = gloveRefreshTimer + dt
		if gloveRefreshTimer >= 0.5 then
			gloveRefreshTimer = 0
			applyGloves()
		end
	end

	-- ── Pixel Faces: throttled to every 5 s ────────────────────────────────
	if pixelFacesEnabled then
		greyPixelTimer = greyPixelTimer + dt
		if greyPixelTimer >= 5 then
			greyPixelTimer = 0
			applyPixelFaces()
		end
	end

	-- ── Ball Manipulation ────────────────────────────────────────────────────
	if (S.ballMagEnabled or S.ballRangeEnabled) and hrp then
		local ball = S.cachedBall
		if ball and ball.Parent then
			local dist = (hrp.Position - ball.Position).Magnitude

			if S.ballRangeEnabled and S.footballSpeed then
				S.footballSpeed.Value = dist <= S.ballSpeedRange and S.ballBoostedSpeed or S.ballDefaultSpeed
			end

			if S.ballMagEnabled and not localHasFootball() and not anyOtherHasFootball(ball) then
				if dist <= S.ballMagRange then
					ball.CanCollide              = false
					ball.AssemblyAngularVelocity = Vector3.zero
					claimBallOwnership(ball)

					local targetHand, bestDist = nil, math.huge
					for _, name in ipairs({ "RightHand", "LeftHand", "Right Arm", "Left Arm" }) do
						local hand = char and char:FindFirstChild(name)
						if hand then
							local d = (ball.Position - hand.Position).Magnitude
							if d < bestDist then bestDist = d; targetHand = hand end
						end
					end

					local targetPos = targetHand
						and (targetHand.CFrame * CFrame.new(0, 0.35, -0.25)).Position
						or  (hrp.Position + hrp.CFrame.LookVector * 3 + Vector3.new(0, 2.5, 0))

					local toTarget = targetPos - ball.Position
					if toTarget.Magnitude < S.ballSnapDist then
						ball.CFrame                 = CFrame.new(targetPos)
						ball.AssemblyLinearVelocity = Vector3.zero
					else
						local t      = tick()
						local jitter = Vector3.new(
							math.sin(t * S.ballJitterFreq * 1.6) * S.ballJitterAmp * 0.2,
							math.sin(t * S.ballJitterFreq)       * S.ballJitterAmp,
							math.cos(t * S.ballJitterFreq * 1.3) * S.ballJitterAmp * 0.2
						)
						ball.AssemblyLinearVelocity = toTarget.Unit * S.ballPullStrength + jitter
					end
				end
			end
		end
	end

	-- ── Head Manipulation ────────────────────────────────────────────────────
	-- When falling from a high jump (Y crosses from > 12 down to ≤ 2),
	-- steer horizontally toward the nearest head within 25 studs
	if S.headManipEnabled and hrp then
		local curY = hrp.AssemblyLinearVelocity.Y
		if curY <= 2 and lastYVelocity > 12 then
			local nearestHead, shortestDist = nil, math.huge
			for _, other in ipairs(Players:GetPlayers()) do
				if other ~= player and other.Character then
					local h = other.Character:FindFirstChild("Head")
					if h then
						local dist = (hrp.Position - h.Position).Magnitude
						if dist < shortestDist and dist < 25 then
							shortestDist = dist; nearestHead = h
						end
					end
				end
			end
			if nearestHead then
				local targetPos = nearestHead.Position + Vector3.new(0, 2.5, 0)
				local dir       = (targetPos - hrp.Position).Unit
				local force     = dir * (S.headStrength * 65)
				hrp.AssemblyLinearVelocity = Vector3.new(
					hrp.AssemblyLinearVelocity.X * 0.4 + force.X,
					hrp.AssemblyLinearVelocity.Y,
					hrp.AssemblyLinearVelocity.Z * 0.4 + force.Z
				)
			end
		end
	end

	-- ── Jump Pull Vec ────────────────────────────────────────────────────────
	-- Auto-holds pull vec while the player is airborne and rising after a jump
	if S.jumpPullEnabled and S.pullVecEnabled and hrp and hum then
		local inAir = hum.FloorMaterial == Enum.Material.Air
		if inAir and hrp.AssemblyLinearVelocity.Y > 3 and not S.jumpPullActive then
			S.jumpPullActive = true
			S.pullVecHeld    = true
		elseif not inAir and S.jumpPullActive then
			S.jumpPullActive = false
			S.pullVecHeld    = false
		end
	end
end)
-- ─────────────────────────────────────────────────────────────────────────────
boostAmpEnabled    = false
boostAmpMultiplier = 2
lastYVelocity      = 0
boostAmpFired      = false
-- ── Fling / Auto Boost / Fling Up — Touched-event head detection ─────────────
local flingEnabled     = false
local flingPower       = 150
local autoBoostEnabled = false
local autoBoostFired   = false
local flingUpEnabled   = false
local flingUpFired     = false
local headConnections  = {}
local function connectHeadTouch(head)
if not head or not head:IsA("BasePart") then return end
if headConnections[head] then return end
local conn = head.Touched:Connect(function(hit)
		if not hrp or hit ~= hrp then return end
		if hrp.Position.Y <= head.Position.Y + 0.3 then return end

		-- Auto Boost: straight up using S.boostPower
		if autoBoostEnabled and not autoBoostFired then
			autoBoostFired = true
			hrp.AssemblyLinearVelocity = Vector3.new(
				hrp.AssemblyLinearVelocity.X, S.boostPower, hrp.AssemblyLinearVelocity.Z)
			task.delay(0.3, function() autoBoostFired = false end)
		end

		-- Fling: diagonal — upward + away from the head
		if flingEnabled then
			local flat = Vector3.new(
				hrp.Position.X - head.Position.X, 0, hrp.Position.Z - head.Position.Z)
			local dir = flat.Magnitude > 0 and flat.Unit or Vector3.new(1, 0, 0)
			hrp.AssemblyLinearVelocity = Vector3.new(
				dir.X * flingPower, flingPower * 0.8, dir.Z * flingPower)
		end

		-- Fling Up (Kickup): boost up + single fast spin
		if flingUpEnabled and not flingUpFired then
			flingUpFired = true
			hrp.AssemblyLinearVelocity = Vector3.new(
				hrp.AssemblyLinearVelocity.X, S.boostPower, hrp.AssemblyLinearVelocity.Z)
			local rotated = 0
			local spinConn
			spinConn = RunService.RenderStepped:Connect(function(dt2)
				if not hrp or rotated >= math.pi * 2 then
					spinConn:Disconnect()
					if hrp then hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0) end
					task.delay(0.3, function() flingUpFired = false end)
					return
				end
				local step = math.pi * 16 * dt2
				rotated    = rotated + step
				hrp.AssemblyAngularVelocity = Vector3.new(0, 200, 0)
				hrp.CFrame = hrp.CFrame * CFrame.Angles(0, step, 0)
			end)
		end
	end)

	headConnections[head] = conn
	head.AncestryChanged:Connect(function(_, parent)
		if not parent and headConnections[head] then
			headConnections[head]:Disconnect()
			headConnections[head] = nil
		end
	end)
end
local function setupHeadBoosts()
for _, plr in pairs(Players:GetPlayers()) do
if plr ~= player and plr.Character then
local head = plr.Character:FindFirstChild("Head")
if head then connectHeadTouch(head) end
plr.CharacterAdded:Connect(function(c)
task.wait(0.5)
local newHead = c:FindFirstChild("Head")
if newHead then connectHeadTouch(newHead) end
end)
end
end
end
setupHeadBoosts()
Players.PlayerAdded:Connect(function(plr)
plr.CharacterAdded:Connect(function()
task.wait(0.5)
setupHeadBoosts()
end)
end)
-- ─────────────────────────────────────────────────────────────────────────────
-- ── Gloves — RenderStepped catcher (runs BEFORE physics each frame) ───────────
-- Heartbeat fires after physics so fast balls skip past. RenderStepped catches
-- them before they move. Also does predictive interception for far/fast throws.
local PRE_CLAIM_RADIUS = 22   -- studs — start asserting ownership early
local SNAP_RADIUS_MULT = 1.2  -- multiplier on S.gloveSize for final snap
local PREDICT_SECS     = 0.35 -- how far ahead (seconds) to look for intercept
RunService.RenderStepped:Connect(function()
if not instance.active then return end
if not S.glovesEnabled or not char or not hrp then return end
local ball = S.cachedBall
if not ball or not ball.Parent then return end
local ballPos  = ball.Position
	local ballVel  = ball.AssemblyLinearVelocity
	local speed    = ballVel.Magnitude
	-- Faster balls get a bigger snap window
	local snapR    = S.gloveSize * SNAP_RADIUS_MULT + speed * 0.05
	local hands    = getHands(char)

	-- Find the closest hand once (used for steering)
	local closestHand, closestDist = nil, math.huge
	for _, hand in ipairs(hands) do
		if hand:IsA("BasePart") then
			local d = (ballPos - hand.Position).Magnitude
			if d < closestDist then closestHand = hand; closestDist = d end
		end
	end
	if not closestHand then return end

	-- Pre-claim zone: assert ownership, disable CanCollide,
	-- and gently steer + dampen the ball toward the hand
	if closestDist <= PRE_CLAIM_RADIUS then
		claimBallOwnership(ball)
		pcall(function() ball.CanCollide = false end)

		if closestDist > snapR and speed > 1 then
			local toHand   = (closestHand.Position - ballPos).Unit
			-- Blend velocity toward hand direction (15 % per frame) — subtle guide
			local steered  = ballVel:Lerp(toHand * speed, 0.15)
			-- Dampen speed slightly so there's more time to register the catch
			local damped   = steered * 0.97
			pcall(function() ball.AssemblyLinearVelocity = damped end)
		end
	end

	-- Current-position snap
	if closestDist <= snapR then
		catchBall(ball, closestHand)
		return
	end

	-- Predictive intercept along trajectory
	if speed > 2 then
		local toHand = closestHand.Position - ballPos
		local t      = math.clamp(toHand:Dot(ballVel) / (speed * speed), 0, PREDICT_SECS)
		local future = ballPos + ballVel * t
		if (future - closestHand.Position).Magnitude <= snapR * 1.4 then
			catchBall(ball, closestHand)
		end
	end
end)
-- ─────────────────────────────────────────────────────────────────────────────
local hitboxSize         = 2
local hitboxTransparency = 0.5
local originalHitboxes   = {}
local function applyHitbox(otherPlayer)
if not otherPlayer.Character then return end
local otherHRP = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
if not otherHRP then return end
if not originalHitboxes[otherPlayer.UserId] then
originalHitboxes[otherPlayer.UserId] = {
Size         = otherHRP.Size,
Transparency = otherHRP.Transparency,
}
end
otherHRP.Size         = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
otherHRP.Transparency = hitboxTransparency
end
local function restoreHitbox(otherPlayer)
if not otherPlayer.Character then return end
local otherHRP = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
if otherHRP and originalHitboxes[otherPlayer.UserId] then
local orig = originalHitboxes[otherPlayer.UserId]
otherHRP.Size         = orig.Size
otherHRP.Transparency = orig.Transparency
end
end
local function refreshAllHitboxes()
for _, plr in pairs(Players:GetPlayers()) do
if plr ~= player then
if hitboxEnabled then applyHitbox(plr) else restoreHitbox(plr) end
end
end
end
Players.PlayerAdded:Connect(function(plr)
plr.CharacterAdded:Connect(function()
task.wait(1)
if hitboxEnabled then applyHitbox(plr) end
end)
end)
for _, plr in pairs(Players:GetPlayers()) do
if plr ~= player then
plr.CharacterAdded:Connect(function()
task.wait(1)
if hitboxEnabled then applyHitbox(plr) end
end)
end
end
function getHands(c)
if c:FindFirstChild("RightHand") then
return { c.RightHand, c.LeftHand }
elseif c:FindFirstChild("Right Arm") then
return { c["Right Arm"], c["Left Arm"] }
end
return {}
end
local cachedPlayer = nil
local function setOwner(hand, player)
local ok = pcall(hand.SetNetworkOwner, hand, player)
if not ok then
pcall(hand.SetNetworkOwner, hand, nil)
end
end
-- ── Gloves — Network Ownership ───────────────────────────────────────────────
-- Claims physics authority over the ball so THIS client moves it, not the server.
-- Without ownership the CFrame writes race against the server and lose.
function claimBallOwnership(ball)
if not ball or not ball.Parent then return end
-- Try to take ownership; fall back to server-owned (nil) if the game blocks it
local ok = pcall(function() ball:SetNetworkOwner(player) end)
if not ok then pcall(function() ball:SetNetworkOwner(nil) end) end
end
function catchBall(ball, hand)
claimBallOwnership(ball)
task.defer(function()
if not ball or not ball.Parent then return end
-- Use head position if available — game registers catches via head contact
local head   = char and char:FindFirstChild("Head")
local target = head and head.Position or hand.Position
ball.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
ball.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
ball.CanCollide              = false
ball.CFrame                  = CFrame.new(target)
-- Re-assert ownership + position for 4 frames so the server can't take it back
for i = 1, 4 do
task.delay(i / 60, function()
if not ball or not ball.Parent then return end
claimBallOwnership(ball)
ball.CFrame                  = CFrame.new(target)
ball.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
ball.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
ball.CanCollide              = false
end)
end
end)
end
local gloveConnections = {}
local function disconnectGloveConnections()
for _, conn in pairs(gloveConnections) do pcall(conn.Disconnect, conn) end
gloveConnections = {}
end
local function connectGloveTouched(hand)
if gloveConnections[hand] then
pcall(gloveConnections[hand].Disconnect, gloveConnections[hand])
end
gloveConnections[hand] = hand.Touched:Connect(function(hit)
if not S.glovesEnabled then return end
if hit.Name == "Football" and hit:IsA("BasePart") then
catchBall(hit, hand)
end
end)
end
function applyGloves()
if not char then return end
for _, hand in ipairs(getHands(char)) do
if hand:IsA("BasePart") then
if not S.originalHandSizes[hand] then
S.originalHandSizes[hand] = {
Size         = hand.Size,
Material     = hand.Material,
Color        = hand.Color,
Transparency = hand.Transparency,
CanCollide   = hand.CanCollide,
Massless     = hand.Massless,
}
end
hand.Size         = Vector3.new(S.gloveSize, S.gloveSize, S.gloveSize)
hand.Material     = Enum.Material.ForceField
hand.Color        = Color3.fromRGB(255, 70, 70)
hand.Transparency = S.glovesInvisible and 1 or 0.4
hand.CanCollide   = false
hand.Massless     = true
hand.CanTouch     = true
-- Re-assert ownership of the hand every refresh
pcall(function() hand:SetNetworkOwner(player) end)
connectGloveTouched(hand)
end
end
end
Players.PlayerAdded:Connect(function(plr)
cachedPlayer = plr
plr.CharacterAdded:Connect(function(character)
for _, name in ipairs({ "LeftHand", "RightHand", "Left Arm", "Right Arm" }) do
local part = character:FindFirstChild(name)
if part then pcall(function() part:SetNetworkOwner(plr) end) end
end
end)
end)
local function removeGloves()
disconnectGloveConnections()
if not char then return end
for _, hand in ipairs(getHands(char)) do
if not hand:IsA("BasePart") then continue end
local original = S.originalHandSizes[hand]
if not original then continue end
hand.Size         = original.Size
hand.Material     = original.Material
hand.Color        = original.Color
hand.Transparency = original.Transparency
hand.CanCollide   = original.CanCollide
hand.Massless     = original.Massless
pcall(function() hand:SetNetworkOwner(nil) end)
end
end
-- ─────────────────────────────────────────────────────────────────────────────
player.CharacterAdded:Connect(function()
task.wait(1)
S.originalHandSizes = {}
if S.glovesEnabled then applyGloves() end
end)
local divePowerConn = nil
local function updateDivePower(power)
local gameId = player:FindFirstChild("Replicated") and player.Replicated:FindFirstChild("GameID")
if not gameId then return end
local gid = gameId.Value
for _, folderName in ipairs({ "Games", "MiniGames" }) do
local mainFolder = ReplicatedStorage:FindFirstChild(folderName)
if mainFolder then
local gameFolder = mainFolder:FindFirstChild(gid)
if gameFolder then
local gameParams = gameFolder:FindFirstChild("GameParams")
if gameParams then
local dp = gameParams:FindFirstChild("DivePower")
if dp and dp:IsA("NumberValue") then
dp.Value = power
if divePowerConn then divePowerConn:Disconnect() end
divePowerConn = dp:GetPropertyChangedSignal("Value"):Connect(function()
if dp.Value ~= power then dp.Value = power end
end)
end
end
end
end
end
end
local currentAnimTrack = nil
local EMOTES = {
{ name = "BBS",         id = "rbxassetid://83690407262789",  speed = 1.25 },
{ name = "BOP",         id = "rbxassetid://8028669437",      speed = 1    },
{ name = "Hackers",     id = "rbxassetid://10714364213",     speed = 1    },
{ name = "HD",          id = "rbxassetid://133666867152446", speed = 1    },
{ name = "TTL",         id = "rbxassetid://125578981255289", speed = 1    },
{ name = "NH",          id = "rbxassetid://83345430870757",  speed = 1    },
{ name = "CCL",         id = "rbxassetid://107875941017127", speed = 1    },
{ name = "Penguin",     id = "rbxassetid://5439075558",      speed = 1    },
{ name = "Worm",        id = "rbxassetid://133640711863790", speed = 1    },
{ name = "Griddy",      id = "rbxassetid://8028694339",      speed = 1    },
{ name = "Sam Slash",   id = "rbxassetid://15249657798",     speed = 1    },
{ name = "Dimension",   id = "rbxassetid://5618747341",      speed = 1    },
{ name = "Ballspin",    id = "rbxassetid://14215798544",     speed = 1    },
{ name = "Thug",        id = "rbxassetid://13550466835",     speed = 1    },
{ name = "Inner Child", id = "rbxassetid://14215788817",     speed = 1    },
{ name = "Sturdy",      id = "rbxassetid://14215791622",     speed = 1    },
{ name = "Smith Knicks",id = "rbxassetid://15312473847",     speed = 1    },
{ name = "Mop",         id = "rbxassetid://14215807283",     speed = 1    },
{ name = "MPG",         id = "rbxassetid://14138482621",     speed = 1    },
{ name = "Moon",        id = "rbxassetid://14216002323",     speed = 1    },
{ name = "Eagle Flap",  id = "rbxassetid://2293380203",      speed = 1    },
{ name = "PPJT",        id = "rbxassetid://5433555683",      speed = 1    },
{ name = "Headless",    id = "rbxassetid://5704065738",      speed = 1    },
{ name = "Druski",      id = "rbxassetid://14901504235",     speed = 1    },
{ name = "Keep it hot", id = "http://www.roblox.com/asset/?id=85267023718407", speed = 1 },
{ name = "Silencer",    id = "rbxassetid://15249654202",     speed = 1    },
{ name = "Reanimated",  id = "rbxassetid://2293388847",      speed = 1    },
{ name = "Money Hop Switch", id = "rbxassetid://132555082396072", speed = 1 },
{ name = "Turbulence",  id = "rbxassetid://13643188123",     speed = 1    },
}
local function stopEmote()
if currentAnimTrack then
currentAnimTrack:Stop()
currentAnimTrack:Destroy()
currentAnimTrack = nil
end
end
local function playEmote(id, speed)
stopEmote()
if not hum then return end
local anim = Instance.new("Animation")
anim.AnimationId = id
local ok, track = pcall(function() return hum:LoadAnimation(anim) end)
if ok and track then
currentAnimTrack = track
track.Looped = true
track:Play()
track:AdjustSpeed(speed or 1)
end
end
local equippedItems = {}
local ITEMS = {
Coldstare    = { mesh = "rbxassetid://5028704943",     texture = "rbxassetid://5047708728",     parent = "UpperTorso", scale = Vector3.new(1,1,1),          offset = CFrame.new(0,0.15,0.65)    * CFrame.Angles(0,math.rad(180),0) },
DesertVest   = { mesh = "rbxassetid://11755494017",    texture = "rbxassetid://11755494031",    parent = "UpperTorso", scale = Vector3.new(0.73,1.13,0.75),  offset = CFrame.new(0,0,-0.05) },
DRC          = { mesh = "rbxassetid://6541224713",     texture = "rbxassetid://7833727918",     parent = "Head",       scale = Vector3.new(1.01,1.01,1.01),  offset = CFrame.new(0,0.8,0.15)     * CFrame.Angles(0,math.rad(90),0)  },
DesignerKeff = { mesh = "rbxassetid://14156626934", texture = "rbxassetid://14156781317", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(-0.05,0.41,0.15) * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)) },
PinkScene    = { mesh = "rbxassetid://73581570515279", texture = "rbxassetid://86617487565011", parent = "Head",       scale = Vector3.new(0.95,0.95,0.95),  offset = CFrame.new(-0.1,0.1,0.2)   * CFrame.Angles(0,math.rad(180),0) },
SeeingStars  = { mesh = "rbxassetid://62139052",       texture = "rbxassetid://62139103",       parent = "Head",       scale = Vector3.new(1.05,1.05,1.05),  offset = CFrame.new(0,0.05,-0.45) },
SubarcticCommando = { mesh = "http://www.roblox.com/asset/?id=39200112", texture = "http://www.roblox.com/asset/?id=39200088", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0.15,0) },
TacticalVest = { mesh = "rbxassetid://11754584493",    texture = "rbxassetid://11754584535",    parent = "UpperTorso", scale = Vector3.new(0.73,1.13,0.75),  offset = CFrame.new(0,0,-0.05)      * CFrame.Angles(0,math.rad(180),0) },
WhiteTowel   = { mesh = "rbxassetid://6919149797",     texture = "rbxassetid://6923948446",     parent = "LowerTorso", scale = Vector3.new(1,1,1),           offset = CFrame.new(0.55,-0.65,-0.15)*CFrame.Angles(0,math.rad(90),0) },
LavaScene    = { mesh = "http://www.roblox.com/asset/?id=83490415", texture = "http://www.roblox.com/asset/?id=83491029", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(-0.1,0.1,0.2) },
KingCape     = { mesh = "rbxassetid://7547683590",     texture = "rbxassetid://7547692544",     parent = "UpperTorso", scale = Vector3.new(1,1,1),           offset = CFrame.new(0,-0.85,0.7) },
KingCrown    = { mesh = "rbxassetid://2180251969",     texture = "rbxassetid://2180251094",     parent = "Head",       scale = Vector3.new(1,1,1),           offset = CFrame.new(0,1,0) },
GravBeanie   = { mesh = "rbxassetid://14310737075",    texture = "rbxassetid://15591009630",    parent = "Head",       scale = Vector3.new(1,1,1),           offset = CFrame.new(0,0.6,0)        * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0.05)) },
LAchrome     = { mesh = "rbxassetid://15498987026",    texture = "rbxassetid://15498997319",    parent = "Head",       scale = Vector3.new(1,1,1),           offset = CFrame.new(0,0.6,-0.2) },
Ush          = { mesh = "rbxassetid://12710398184",    texture = "rbxassetid://12710399814",    parent = "Head",       scale = Vector3.new(1,1,1),           offset = CFrame.new(0,0.3,0)        * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)) },
RedCW        = { mesh = "http://www.roblox.com/asset/?id=1577360", texture = "rbxassetid://1143320126",  parent = "Head", scale = Vector3.new(1,1.3,1),      offset = CFrame.new(0,0.25,-0.19)   * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0.05)) },
BlackCW      = { mesh = "http://www.roblox.com/asset/?id=1577360", texture = "http://www.roblox.com/asset/?id=1577349", parent = "Head", scale = Vector3.new(1,1.3,1), offset = CFrame.new(0,0.25,-0.19) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0.05)) },
PurpleCW     = { mesh = "http://www.roblox.com/asset/?id=1577360", texture = "rbxassetid://14296191274", parent = "Head", scale = Vector3.new(1,1.3,1),      offset = CFrame.new(0,0.25,-0.19)   * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0.05)) },
PoliceVest = { mesh = "rbxassetid://10692364338", texture = "rbxassetid://10691986674", parent = "UpperTorso", scale = Vector3.new(0.8,1.1,0.8), offset = CFrame.new(0,-0.05,0) * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)) },
ArcTacVest = { mesh = "rbxassetid://10714316724", texture = "rbxassetid://10714600858", parent = "UpperTorso", scale = Vector3.new(0.7,1,0.8), offset = CFrame.new(0,0,-0.1) },
ArticCommando = { mesh = "http://www.roblox.com/asset/?id=38965549", texture = "http://www.roblox.com/asset/?id=38965529", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0,0) },
GreyEvil = { mesh = "rbxassetid://14470653457", texture = "rbxassetid://14473920427", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0.41,0.1) * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)) },
PilgrimHat = { mesh = "http://www.roblox.com/asset/?id=1223118", texture = "http://www.roblox.com/asset/?id=5671898", parent = "Head", scale = Vector3.new(1.7,1.7,1.7), offset = CFrame.new(0,1,0) },
y2kbluebeanie = { mesh = "rbxassetid://13870642930", texture = "rbxassetid://13870661669", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0.9,0) },
MonochromeMilitary = { mesh = "http://www.roblox.com/asset/?id=192571937 ", texture = "http://www.roblox.com/asset/?id=192571951 ", parent = "Head", scale = Vector3.new(1.4,1.4,1.4), offset = CFrame.new(0,0.4,0) },
MidnightCommando = { mesh = "http://www.roblox.com/asset/?id=38965549", texture = "http://www.roblox.com/asset/?id=259417739", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0,0) },
GasMask = { mesh = "rbxassetid://8928474817", texture = "rbxassetid://8927755382", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0,0) },
Snorkel = { mesh = "http://www.roblox.com/asset/?id=10547596", texture = "http://www.roblox.com/asset/?id=10517820", parent = "Head", scale = Vector3.new(1.05,1.05,1.05), offset = CFrame.new(0,0.2,0) },
}
local function equipItem(name)
if equippedItems[name] then return end
local data = ITEMS[name]
if not data then return end
local c = char
local parentPart = c and c:FindFirstChild(data.parent)
if not parentPart then return end
local part = Instance.new("Part")
part.Name = name; part.Size = Vector3.new(1,1,1)
part.CanCollide = false; part.Massless = true; part.Parent = c
local mesh = Instance.new("SpecialMesh")
mesh.MeshType = Enum.MeshType.FileMesh
mesh.MeshId = data.mesh; mesh.TextureId = data.texture
mesh.Scale = data.scale; mesh.Parent = part
local weld = Instance.new("Motor6D")
weld.Part0 = parentPart; weld.Part1 = part
weld.C0 = data.offset; weld.Parent = parentPart
part.CFrame = parentPart.CFrame * data.offset
equippedItems[name] = part
end
local function unequipItem(name)
if equippedItems[name] then
equippedItems[name]:Destroy()
equippedItems[name] = nil
end
end
player.CharacterAdded:Connect(function(c)
task.wait(1)
for name in pairs(equippedItems) do
equippedItems[name] = nil
equipItem(name)
end
end)
local CLOTHES = {
{ name = "All Star Shirt",  type = "shirt", id = "rbxassetid://104603634169771" },
{ name = "All Star Shorts", type = "pants", id = "rbxassetid://73939866847703"  },
{ name = "Black World Tour Shirt", type = "shirt", id = "rbxassetid://15335037852" },
{ name = "Pink World Tour Shirt", type = "shirt", id = "rbxassetid://15334978300" },
{ name = "King Shirt", type = "shirt", id = "rbxassetid://6296265575" },
{ name = "King Pants", type = "pants", id = "rbxassetid://10725550576" },
{ name = "Grey Flare", type = "shirt", id = "rbxassetid://15345367906" },
{ name = "Black Flare", type = "shirt", id = "rbxassetid://15345348842" },
{ name = "Red Flare", type = "shirt", id = "rbxassetid://15345347397" },
{ name = "Acid Flare", type = "shirt", id = "rbxassetid://15345352095" },
{ name = "Pastel Flare", type = "shirt", id = "rbxassetid://15345355082" },
{ name = "Orange Flare", type = "shirt", id = "rbxassetid://15345357354" },
{ name = "White World Tour", type = "shirt", id = "rbxassetid://15334975460" },
{ name = "Hooded Jean Jacket", type = "shirt", id = "rbxassetid://15334917844" },
}
local originalShirtTemplate  = ""
local originalPantsTemplate2 = ""
local shirtWatchConn         = nil
local pantsWatchConn         = nil
local activeShirtId          = nil
local activePantsId          = nil
local templateCache = {}
local function resolveTemplate(rawId, clothType)
local idNum = tostring(rawId):match("%d+")
if not idNum then return nil end
local cacheKey = clothType .. ":" .. idNum
	if templateCache[cacheKey] then
		return templateCache[cacheKey]
	end

	local wanted = (clothType == "shirt") and "Shirt" or "Pants"

	local ok, objects = pcall(function()
		return game:GetObjects("rbxassetid://" .. idNum)
	end)

	local resolved = "rbxassetid://" .. idNum
	if ok and objects and objects[1] then
		local asset = objects[1]
		local obj = asset:IsA(wanted) and asset or asset:FindFirstChildWhichIsA(wanted, true)
		if obj then
			resolved = (clothType == "shirt") and obj.ShirtTemplate or obj.PantsTemplate
		end
	end

	templateCache[cacheKey] = resolved
	return resolved
end
local function getShirt()
local username = player.Name
local ok, shirt = pcall(function() return workspace[username].SHIRT_WhiteTShirt end)
if ok and shirt then return shirt end
return nil
end
local function getJeans()
local username = player.Name
local ok, pants = pcall(function() return workspace[username].PANTS_STARTERGrayJeans end)
if ok and pants then return pants end
return nil
end
local function applyCloth(clothType, assetId)
local template = resolveTemplate(assetId, clothType)
if not template then
WindUI:Notify({ Title = "Overtime", Content = "Could not resolve template id", Duration = 3, Icon = "flame" })
return false
end
if clothType == "shirt" then
		local shirt = getShirt()
		if not shirt then
			WindUI:Notify({ Title = "Overtime", Content = "Shirt object not found", Duration = 3, Icon = "flame" })
			return false
		end
		if originalShirtTemplate == "" then originalShirtTemplate = shirt.ShirtTemplate end
		shirt.ShirtTemplate = template
		activeShirtId = template
		if shirtWatchConn then shirtWatchConn:Disconnect() end
		shirtWatchConn = shirt:GetPropertyChangedSignal("ShirtTemplate"):Connect(function()
			if activeShirtId and shirt.ShirtTemplate ~= activeShirtId then
				shirt.ShirtTemplate = activeShirtId
			end
		end)
		return true

	elseif clothType == "pants" then
		local pants = getJeans()
		if not pants then
			WindUI:Notify({ Title = "Overtime", Content = "Pants object not found", Duration = 3, Icon = "flame" })
			return false
		end
		if originalPantsTemplate2 == "" then originalPantsTemplate2 = pants.PantsTemplate end
		pants.PantsTemplate = template
		activePantsId = template
		if pantsWatchConn then pantsWatchConn:Disconnect() end
		pantsWatchConn = pants:GetPropertyChangedSignal("PantsTemplate"):Connect(function()
			if activePantsId and pants.PantsTemplate ~= activePantsId then
				pants.PantsTemplate = activePantsId
			end
		end)
		return true
	end
end
local function resetCloth(clothType)
if clothType == "shirt" then
activeShirtId = nil
if shirtWatchConn then shirtWatchConn:Disconnect(); shirtWatchConn = nil end
local shirt = getShirt()
if shirt and originalShirtTemplate ~= "" then shirt.ShirtTemplate = originalShirtTemplate end
originalShirtTemplate = ""
elseif clothType == "pants" then
activePantsId = nil
if pantsWatchConn then pantsWatchConn:Disconnect(); pantsWatchConn = nil end
local pants = getJeans()
if pants and originalPantsTemplate2 ~= "" then pants.PantsTemplate = originalPantsTemplate2 end
originalPantsTemplate2 = ""
end
end
player.CharacterAdded:Connect(function()
task.wait(2)
originalShirtTemplate = ""
originalPantsTemplate2 = ""
if activeShirtId then applyCloth("shirt", activeShirtId) end
if activePantsId then applyCloth("pants", activePantsId) end
end)
local BANNERS = {
{ name = "50M Banner", id = "rbxassetid://13200847176" },
{ name = "Global",     id = "rbxassetid://13223858189" },
{ name = "Twitch CC",  id = "rbxassetid://13284240977" },
{ name = "YT CC",      id = "rbxassetid://13181356130" },
{ name = "Staff",      id = "rbxassetid://13284239964" },
{ name = "CC",         id = "rbxassetid://14308515186" },
}
local activeBannerId  = nil
local bannerWatchConn = nil
local function getBannerImage()
local ok, bi = pcall(function() return workspace[player.Name].StreetTag.BaseImage end)
return (ok and bi) or nil
end
local function applyBanner(assetId)
activeBannerId = assetId
local baseImage = getBannerImage()
if not baseImage then
WindUI:Notify({ Title = "Overtime", Content = "StreetTag not found", Duration = 3, Icon = "flame" })
return
end
pcall(function() baseImage.Texture = assetId end)
pcall(function() baseImage.Image   = assetId end)
pcall(function() baseImage.Value   = assetId end)
-- Watch for the game resetting the banner — throttled to every 2 s
	if bannerWatchConn then bannerWatchConn:Disconnect() end
	local bannerTimer = 0
	bannerWatchConn = RunService.Heartbeat:Connect(function(dt)
		if not activeBannerId then bannerWatchConn:Disconnect(); return end
		bannerTimer = bannerTimer + dt
		if bannerTimer < 2 then return end
		bannerTimer = 0
		local bi = getBannerImage()
		if not bi then return end
		local cur = ""; pcall(function() cur = bi.Texture end)
		if cur ~= activeBannerId then
			pcall(function() bi.Texture = activeBannerId end)
			pcall(function() bi.Image   = activeBannerId end)
			pcall(function() bi.Value   = activeBannerId end)
		end
	end)
end
local function removeBanner()
activeBannerId = nil
if bannerWatchConn then bannerWatchConn:Disconnect(); bannerWatchConn = nil end
local baseImage = getBannerImage()
if baseImage then
pcall(function() baseImage.Texture = "" end)
pcall(function() baseImage.Image   = "" end)
pcall(function() baseImage.Value   = "" end)
end
end
player.CharacterAdded:Connect(function()
task.wait(2)
if activeBannerId then applyBanner(activeBannerId) end
end)
local INF_BANDANA_ID        = "rbxassetid://13604810806"
local bandanaActive         = false
local bandanaWatchConn      = nil
local originalPantsTemplate = ""
local function getPants()
local username = player.Name
local ok, pants = pcall(function() return workspace[username].PANTS_STARTERGrayJeans end)
if ok and pants then return pants end
return nil
end
local function applyInfBandana()
local pants = getPants()
if not pants then
WindUI:Notify({ Title = "Overtime", Content = "Pants not found", Duration = 3, Icon = "flame" })
return false
end
if originalPantsTemplate == "" then
originalPantsTemplate = pants.PantsTemplate
end
pants.PantsTemplate = INF_BANDANA_ID
if bandanaWatchConn then bandanaWatchConn:Disconnect() end
bandanaWatchConn = pants:GetPropertyChangedSignal("PantsTemplate"):Connect(function()
if bandanaActive and pants.PantsTemplate ~= INF_BANDANA_ID then
pants.PantsTemplate = INF_BANDANA_ID
end
end)
return true
end
local function removeInfBandana()
bandanaActive = false
if bandanaWatchConn then bandanaWatchConn:Disconnect(); bandanaWatchConn = nil end
local pants = getPants()
if pants and originalPantsTemplate ~= "" then
pants.PantsTemplate = originalPantsTemplate
end
originalPantsTemplate = ""
end
player.CharacterAdded:Connect(function()
task.wait(2)
originalPantsTemplate = ""
if bandanaActive then applyInfBandana() end
end)
local shaderObjects  = {}
local shaderSkyColor = Color3.fromRGB(180, 210, 255)
local function removeShaders()
for _, obj in ipairs(shaderObjects) do pcall(function() obj:Destroy() end) end
shaderObjects = {}
end
local function removeAllStickyZones() S.stickyHeadZones = {} end
-- ── Sticky Head (obi_stick v2) ────────────────────────────────────────────────
local function stickyClosestPlayer()
local nearest
local dist = S.stickyHeadSize
for _, p in pairs(Players:GetPlayers()) do
if p ~= player and p.Character then
local phrp = p.Character:FindFirstChild("HumanoidRootPart")
local phum = p.Character:FindFirstChild("Humanoid")
if phrp and phum and phum.Health > 0 then
local d = (phrp.Position - hrp.Position).Magnitude
if d < dist then dist = d; nearest = p end
end
end
end
return nearest
end
RunService.RenderStepped:Connect(function(dt)
if not instance.active then return end
pcall(function()
if not S.stickyHeadEnabled or not hrp or not hum then return end
local target = stickyClosestPlayer()
if not target or not target.Character then return end
local head = target.Character:FindFirstChild("Head")
if not head then return end
if hum.FloorMaterial == Enum.Material.Air then
		local headPos = head.Position + Vector3.new(0, 1.6, 0)
		local offset  = headPos - hrp.Position
		local dist    = offset.Magnitude
		local vel     = hrp.AssemblyLinearVelocity

		local flatTarget = Vector3.new(headPos.X, hrp.Position.Y, headPos.Z)
		local targetCF   = CFrame.lookAt(hrp.Position, flatTarget)
		local alpha      = math.clamp(S.rotationSmoothness * 60 * dt, 0, 1)
		hrp.CFrame       = hrp.CFrame:Lerp(targetCF, alpha)

		if dist > 2.5 then
			local multiplier     = S.stickyPullStrength * 18
			local desired        = offset.Unit * multiplier
			local targetVelocity = Vector3.new(desired.X, vel.Y, desired.Z)
			hrp.AssemblyLinearVelocity = vel:Lerp(targetVelocity, S.airControlSmoothing)
		end

		if dist <= 3 then
			local centerDir  = headPos - hrp.Position
			local horizontal = Vector3.new(centerDir.X, 0, centerDir.Z)
			if horizontal.Magnitude > 0 then
				local added = horizontal.Unit * (S.stickyStickiness * 5)
				hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity:Lerp(
					hrp.AssemblyLinearVelocity + added, 0.12)
			end
		end

		if dist <= 2 then
			local boostOffset = headPos - hrp.Position
			local boostVel = Vector3.new(
				boostOffset.X * (S.stickyStickiness * 5),
				hrp.AssemblyLinearVelocity.Y,
				boostOffset.Z * (S.stickyStickiness * 5)
			)
			hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity:Lerp(boostVel, 0.18)
		end

		if dist <= 1.2 then
			local lock = headPos - hrp.Position
			local lockVel = Vector3.new(
				lock.X * (S.stickyStickiness * 6),
				hrp.AssemblyLinearVelocity.Y,
				lock.Z * (S.stickyStickiness * 6)
			)
			hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity:Lerp(lockVel, 0.15)
		end
	end
end)
end)
-- ── GUI library (shit-lib by xz#1111 / ozz#4703) ─ embedded + patched for scrolling tabs/pages ──
local lib = (function()
-- // shitlib ... xz#1111 no need for credits jst dont claim its yours :sob:
local Library = {}

local Player = game:GetService("Players").LocalPlayer
local TS, UIS, mouse = game:GetService("TweenService"), game:GetService("UserInputService"), Player:GetMouse()

local shit = {
	togglebind = Enum.KeyCode.RightShift,
	accent = Color3.fromRGB(106,90,205)
	
}


function Library:Create(name,subname,keybind)
	if game.CoreGui:FindFirstChild(name) then
		game.CoreGui:FindFirstChild(name):Destroy()
	end
	local xz = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local SubTitle = Instance.new("TextLabel")
	local TabsHolder = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local PageHolder = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UICorner_2 = Instance.new("UICorner")
	xz.Name = name
	xz.Parent = game.CoreGui
	xz.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Main.Name = "Main"
	Main.Parent = xz
	Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0, 192, 0, 224)
	Main.Size = UDim2.new(0, 645, 0, 366)
	Title.Name = "Title"
	Title.Parent = Main
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.00930232555, 0, 0, 0)
	Title.Size = UDim2.new(0, 179, 0, 34)
	Title.Font = Enum.Font.GothamBold
	Title.Text = name
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 24.000
	Title.TextXAlignment = Enum.TextXAlignment.Left
	SubTitle.Name = "SubTitle"
	SubTitle.Parent = Main
	SubTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SubTitle.BackgroundTransparency = 1.000
	SubTitle.Position = UDim2.new(0.00930232555, 0, 0.0928961784, 0)
	SubTitle.Size = UDim2.new(0, 179, 0, 18)
	SubTitle.Font = Enum.Font.Gotham
	SubTitle.Text = subname
	SubTitle.TextColor3 = Color3.fromRGB(157, 157, 157)
	SubTitle.TextSize = 12.000
	SubTitle.TextXAlignment = Enum.TextXAlignment.Left
	TabsHolder.Name = "TabsHolder"
	TabsHolder.Parent = Main
	TabsHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabsHolder.BackgroundTransparency = 1.000
	TabsHolder.BorderSizePixel = 0
	TabsHolder.Position = UDim2.new(0.00930232555, 0, 0.158469945, 0)
	TabsHolder.Size = UDim2.new(0, 179, 0, 302)
	TabsHolder.Active = true
	TabsHolder.ScrollBarThickness = 3
	TabsHolder.ScrollingDirection = Enum.ScrollingDirection.Y
	TabsHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabsHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
	UIListLayout.Parent = TabsHolder
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 8)
	PageHolder.Name = "PageHolder"
	PageHolder.Parent = Main
	PageHolder.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
	PageHolder.BorderSizePixel = 0
	PageHolder.Position = UDim2.new(0.297674417, 0, 0.0191256832, 0)
	PageHolder.Size = UDim2.new(0, 447, 0, 353)
	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = PageHolder
	UICorner_2.CornerRadius = UDim.new(0, 4)
	UICorner_2.Parent = Main
	
	function dragify(Frame)
		dragToggle = nil
		local dragSpeed = 0
		dragInput = nil
		dragStart = nil
		local dragPos = nil
		function updateInput(input)
			local Delta = input.Position - dragStart
			local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.25), {Position = Position}):Play()
		end
		Frame.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
				dragToggle = true
				dragStart = input.Position
				startPos = Frame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)
		Frame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if input == dragInput and dragToggle then
				updateInput(input)
			end
		end)
	end
	
	dragify(Main)
	UIS.InputBegan:Connect(function(key,gp)
		if not gp then
			if key == Enum.KeyCode.RightShift then
				Main.Visible = not Main.Visible
			end
		end
	end)
	
	local Window = {}

	-- Live theming: registered instances get recoloured by Window:SetTheme.
	local themed = {}
	local function reg(obj, prop, key) themed[#themed + 1] = {obj, prop, key} end
	reg(Main, "BackgroundColor3", "bg")
	reg(PageHolder, "BackgroundColor3", "panel")
	reg(Title, "TextColor3", "accent")
	reg(SubTitle, "TextColor3", "subtext")
	reg(TabsHolder, "ScrollBarImageColor3", "accent")
	function Window:SetTheme(t)
		for _, e in ipairs(themed) do
			local c = t[e[3]]
			if c then pcall(function() e[1][e[2]] = c end) end
		end
	end
	
	function Window:tab(tabname,showonstartup)
		local Tab = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		Tab.Name = "Tab"
		Tab.Parent = TabsHolder
		Tab.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
		Tab.BorderSizePixel = 0
		Tab.Size = UDim2.new(0, 179, 0, 26)
		Tab.Font = Enum.Font.Gotham
		Tab.Text = tabname
		Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
		Tab.TextSize = 14.000
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Tab
		reg(Tab, "BackgroundColor3", "panel")
		reg(Tab, "TextColor3", "text")
		
		local Page = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local PageContainer = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		Page.Name = tabname
		Page.Parent = PageHolder
		Page.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
		Page.BorderSizePixel = 0
		Page.Size = UDim2.new(0, 447, 0, 353)
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Page
		PageContainer.Name = "PageContainer"
		PageContainer.Parent = Page
		PageContainer.Active = true
		PageContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		PageContainer.BackgroundTransparency = 1.000
		PageContainer.BorderSizePixel = 0
		PageContainer.Position = UDim2.new(0.0134228189, 0, 0.0198300276, 0)
		PageContainer.Size = UDim2.new(0, 435, 0, 339)
		PageContainer.ScrollBarThickness = 3
		PageContainer.ScrollingDirection = Enum.ScrollingDirection.Y
		PageContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
		PageContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
		UIListLayout.Parent = PageContainer
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 8)
		reg(Page, "BackgroundColor3", "panel")
		reg(PageContainer, "ScrollBarImageColor3", "accent")
		
		if showonstartup then
			Page.Visible = true
			Tab.TextTransparency = 0
		else
			Page.Visible = false
			Tab.TextTransparency = 0.5
		end
		
		Tab.MouseButton1Click:Connect(function()
			for i,v in pairs(PageHolder:GetChildren()) do
				if v:IsA("Frame") then
					v.Visible = false
				end
			end
			for x,z in pairs(TabsHolder:GetChildren()) do
				if z:IsA("TextButton") then
					z.TextTransparency = 0.5
				end
			end
			Page.Visible = true
			Tab.TextTransparency = 0
		end)
		
		local pageitems = {}
		
		function pageitems:label(text)
			local Label = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local LabelText = Instance.new("TextLabel")
			Label.Name = text
			Label.Parent = PageContainer
			Label.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Label.BorderSizePixel = 0
			Label.Size = UDim2.new(0, 435, 0, 32)
			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Label
			LabelText.Name = "LabelText"
			LabelText.Text = tostring(text)
			LabelText.Parent = Label
			LabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			LabelText.BackgroundTransparency = 1.000
			LabelText.Position = UDim2.new(0.0137931034, 0, 0, 0)
			LabelText.Size = UDim2.new(0, 423, 0, 32)
			LabelText.Font = Enum.Font.Gotham
			LabelText.TextColor3 = Color3.fromRGB(255, 255, 255)
			LabelText.TextSize = 14.000
			LabelText.TextXAlignment = Enum.TextXAlignment.Left
			reg(Label, "BackgroundColor3", "panel")
			reg(LabelText, "TextColor3", "text")
		end
		
		function pageitems:button(text,callback)
			local callback = callback or function() end
			
			local Button = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Button_2 = Instance.new("TextButton")
			Button.Name = text
			Button.Parent = PageContainer
			Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Button.BorderSizePixel = 0
			Button.Size = UDim2.new(0, 435, 0, 32)
			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Button
			Button_2.Name = "Button"
			Button_2.Parent = Button
			Button_2.Text = text
			Button_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Button_2.BackgroundTransparency = 1.000
			Button_2.Position = UDim2.new(0.0140000004, 0, 0, 0)
			Button_2.Size = UDim2.new(0, 423, 0, 32)
			Button_2.Font = Enum.Font.Gotham
			Button_2.TextColor3 = Color3.fromRGB(255, 255, 255)
			Button_2.TextSize = 14.000
			Button_2.TextXAlignment = Enum.TextXAlignment.Left
			
			reg(Button, "BackgroundColor3", "panel")
			reg(Button_2, "TextColor3", "text")
			Button_2.MouseButton1Click:Connect(function()
				pcall(callback)
			end)
		end
		
		function pageitems:toggle(text,state,callback)
			local callback = callback or function() end
			
			local toggled = state
			
			local Toggle = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Button = Instance.new("TextButton")
			local Toggle_2 = Instance.new("ImageLabel")
			local UICorner_2 = Instance.new("UICorner")
			Toggle.Name = text
			Toggle.Parent = PageContainer
			Toggle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Toggle.BorderSizePixel = 0
			Toggle.Size = UDim2.new(0, 435, 0, 32)
			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Toggle
			Button.Name = "Button"
			Button.Parent = Toggle
			Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Button.BackgroundTransparency = 1.000
			Button.Position = UDim2.new(0.0140000004, 0, 0, 0)
			Button.Size = UDim2.new(0, 423, 0, 32)
			Button.Font = Enum.Font.Gotham
			Button.Text = text
			Button.TextColor3 = Color3.fromRGB(255, 255, 255)
			Button.TextSize = 14.000
			Button.TextXAlignment = Enum.TextXAlignment.Left
			Toggle_2.Name = "Toggle"
			Toggle_2.Parent = Toggle
			Toggle_2.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
			Toggle_2.Position = UDim2.new(0.935000002, 0, 0.125, 0)
			Toggle_2.Size = UDim2.new(0, 24, 0, 24)
			Toggle_2.Image = "rbxassetid://10449228819"
			Toggle_2.ImageTransparency = 1

			UICorner_2.CornerRadius = UDim.new(0, 4)
			UICorner_2.Parent = Toggle_2
			reg(Toggle, "BackgroundColor3", "panel")
			reg(Button, "TextColor3", "text")
			reg(Toggle_2, "BackgroundColor3", "accent")
			
			if toggled == true then
				Toggle_2.ImageTransparency = 0
			elseif toggled == false then
				Toggle_2.ImageTransparency = 1
			end
			
			Button.MouseButton1Click:Connect(function()
				toggled = not toggled
				if toggled == true then
					Toggle_2.ImageTransparency = 0
				elseif toggled == false then
					Toggle_2.ImageTransparency = 1
				end
				pcall(callback, toggled)
			end)
		end
		
		function pageitems:input(text,placeholder,clearonreturn,callback)
			local callback = callback or function() end
			
			local Input = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local LabelText = Instance.new("TextLabel")
			local Input_2 = Instance.new("TextBox")
			local UICorner_2 = Instance.new("UICorner")
			Input.Name = text
			Input.Parent = PageContainer
			Input.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Input.BorderSizePixel = 0
			Input.Size = UDim2.new(0, 435, 0, 32)
			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Input
			LabelText.Name = "LabelText"
			LabelText.Parent = Input
			LabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			LabelText.BackgroundTransparency = 1.000
			LabelText.Position = UDim2.new(0.0137931034, 0, 0, 0)
			LabelText.Size = UDim2.new(0, 290, 0, 32)
			LabelText.Font = Enum.Font.Gotham
			LabelText.Text = text
			LabelText.TextColor3 = Color3.fromRGB(255, 255, 255)
			LabelText.TextSize = 14.000
			LabelText.TextXAlignment = Enum.TextXAlignment.Left
			Input_2.Name = "Input"
			Input_2.Parent = Input
			Input_2.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
			Input_2.Position = UDim2.new(0.680459797, 0, 0.125, 0)
			Input_2.Size = UDim2.new(0, 134, 0, 24)
			Input_2.Font = Enum.Font.Gotham
			Input_2.Text = ""
			Input_2.PlaceholderText = placeholder or ""
			Input_2.ClearTextOnFocus = false
			Input_2.TextColor3 = Color3.fromRGB(255, 255, 255)
			Input_2.TextSize = 14.000
			UICorner_2.CornerRadius = UDim.new(0, 4)
			UICorner_2.Parent = Input_2
			reg(Input, "BackgroundColor3", "panel")
			reg(LabelText, "TextColor3", "text")
			reg(Input_2, "BackgroundColor3", "bg")
			reg(Input_2, "TextColor3", "text")
			Input_2.FocusLost:Connect(function()
				pcall(callback, tostring(Input_2.Text))
				if clearonreturn then
					Input_2.Text = ""
				end
			end)
			
			
		end
		return pageitems

	end

	return Window

end

return Library

end)()
if type(lib) ~= "table" then
	warn("[Overtime] GUI library failed to initialise. Aborting.")
	return
end


-- ── WindUI-compatible shim over shit-lib ──────────────────────────────────────
-- shit-lib only provides tab/label/button/toggle/input, so Section/Paragraph map
-- to labels and Slider/Dropdown/Keybind/Colorpicker are emulated with text inputs.
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")

local function shimNotify(_, o)
	o = o or {}
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title    = tostring(o.Title or "Overtime"),
			Text     = tostring(o.Content or ""),
			Duration = o.Duration or 3,
		})
	end)
end

local function makeTabShim(page)
	local t = {}
	function t:Select() end
	function t:Section(o)   page:label("— " .. tostring((o and o.Title) or "") .. " —") end
	function t:Paragraph(o)
		o = o or {}
		page:label(tostring(o.Title or ""))
		if o.Content then page:label(tostring(o.Content)) end
	end
	function t:Button(o)
		o = o or {}
		page:button(tostring(o.Title or "Button"), o.Callback or function() end)
	end
	function t:Toggle(o)
		o = o or {}
		page:toggle(tostring(o.Title or "Toggle"), o.Value and true or false, o.Callback or function() end)
	end
	function t:Input(o)
		o = o or {}
		page:input(tostring(o.Title or "Input"), tostring(o.Placeholder or ""), false, o.Callback or function() end)
	end
	function t:Keybind(o)
		o = o or {}
		local cb = o.Callback or function() end
		page:input(tostring(o.Title or "Keybind") .. " (key name)", tostring(o.Value or "Unknown"), false, function(v)
			if v and v ~= "" then cb(v) end
		end)
	end
	function t:Dropdown(o)
		o = o or {}
		local cb = o.Callback or function() end
		page:input(tostring(o.Title or "Dropdown"), tostring(o.Value or ""), false, function(v)
			if v and v ~= "" then cb(v) end
		end)
		if type(o.Values) == "table" and #o.Values > 0 then
			page:label("Options: " .. table.concat(o.Values, ", "))
		end
		return { Refresh = function() end, Select = function() end }
	end
	function t:Slider(o)
		o = o or {}
		local val = o.Value or {}
		local cb  = o.Callback or function() end
		local mn, mx = val.Min or 0, val.Max or 100
		page:input(
			tostring(o.Title or "Slider") .. " (" .. tostring(mn) .. "-" .. tostring(mx) .. ")",
			tostring(val.Default or ""),
			false,
			function(v)
				local n = tonumber(v)
				if n then cb(math.clamp(n, mn, mx)) end
			end
		)
	end
	function t:Colorpicker(o)
		o = o or {}
		local cb = o.Callback or function() end
		local ph = "255,255,255"
		local d = o.Default
		if typeof and typeof(d) == "Color3" then
			ph = math.floor(d.R * 255) .. "," .. math.floor(d.G * 255) .. "," .. math.floor(d.B * 255)
		end
		page:input(tostring(o.Title or "Colour") .. " (R,G,B)", ph, false, function(v)
			local r, g, b = string.match(tostring(v or ""), "(%d+)%s*,%s*(%d+)%s*,%s*(%d+)")
			if r then cb(Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))) end
		end)
	end
	return t
end

-- ConfigManager shim: best-effort save/load of primitive fields of the S table.
local function hasFileApi()
	return (writefile ~= nil and readfile ~= nil and isfile ~= nil)
end
local function makeConfig(name)
	local cfgo = {}
	local path = "Overtime_" .. tostring(name) .. ".json"
	function cfgo:Save()
		if not hasFileApi() then return end
		local flat = {}
		for k, val in pairs(S) do
			local ty = type(val)
			if ty == "number" or ty == "boolean" or ty == "string" then flat[k] = val end
		end
		pcall(function() writefile(path, HttpService:JSONEncode(flat)) end)
	end
	function cfgo:Load()
		if not hasFileApi() or not isfile(path) then return end
		local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
		if ok and type(data) == "table" then
			for k, val in pairs(data) do S[k] = val end
		end
	end
	return cfgo
end
local ConfigManagerShim = {}
function ConfigManagerShim:CreateConfig(name) return makeConfig(name) end
function ConfigManagerShim:GetConfig(name)    return makeConfig(name) end
function ConfigManagerShim:AllConfigs()
	local list = {}
	if listfiles then
		pcall(function()
			for _, f in ipairs(listfiles("")) do
				local nm = string.match(tostring(f), "Overtime_(.+)%.json$")
				if nm then table.insert(list, nm) end
			end
		end)
	end
	return list
end

WindUI = {}
function WindUI:AddTheme() end
function WindUI:Gradient() return {} end
WindUI.Notify = shimNotify
function WindUI:CreateWindow(o)
	o = o or {}
	local win = lib:Create(tostring(o.Title or "Overtime"), tostring(o.Author or ""), Enum.KeyCode.RightShift)
	WindUI._activeWin = win
	local W = { ConfigManager = ConfigManagerShim, _tabCount = 0 }
	function W:Tab(t)
		t = t or {}
		self._tabCount = self._tabCount + 1
		local page = win:tab(tostring(t.Title or ("Tab " .. self._tabCount)), self._tabCount == 1)
		return makeTabShim(page)
	end
	function W:Tag() end
	function W:Toggle() end        -- RightShift toggles the menu natively in shit-lib
	function W:SetToggleKey() end
	function W:Select() end
	return W
end

WindUI._themeIndex = 1
WindUI._themes = {
	{ name = "Overtime", bg = Color3.fromRGB(18, 20, 26), panel = Color3.fromRGB(26, 30, 40), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(45, 130, 235) },
	{ name = "Midnight", bg = Color3.fromRGB(12, 14, 22), panel = Color3.fromRGB(22, 26, 38), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(70, 90, 200) },
	{ name = "Crimson", bg = Color3.fromRGB(22, 14, 16), panel = Color3.fromRGB(34, 20, 24), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(220, 50, 60) },
	{ name = "Ember", bg = Color3.fromRGB(24, 16, 12), panel = Color3.fromRGB(36, 24, 18), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(240, 120, 40) },
	{ name = "Amber", bg = Color3.fromRGB(24, 20, 10), panel = Color3.fromRGB(38, 32, 16), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(245, 190, 40) },
	{ name = "Forest", bg = Color3.fromRGB(12, 20, 14), panel = Color3.fromRGB(20, 32, 24), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(60, 180, 90) },
	{ name = "Emerald", bg = Color3.fromRGB(10, 22, 18), panel = Color3.fromRGB(18, 34, 28), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(30, 200, 140) },
	{ name = "Teal", bg = Color3.fromRGB(10, 22, 24), panel = Color3.fromRGB(18, 34, 38), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(30, 190, 190) },
	{ name = "Ocean", bg = Color3.fromRGB(10, 18, 28), panel = Color3.fromRGB(18, 30, 46), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(40, 130, 210) },
	{ name = "Sky", bg = Color3.fromRGB(14, 22, 30), panel = Color3.fromRGB(24, 36, 48), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(90, 180, 245) },
	{ name = "Indigo", bg = Color3.fromRGB(16, 16, 30), panel = Color3.fromRGB(26, 26, 48), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(95, 95, 220) },
	{ name = "Violet", bg = Color3.fromRGB(20, 14, 30), panel = Color3.fromRGB(32, 24, 48), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(150, 90, 235) },
	{ name = "Grape", bg = Color3.fromRGB(22, 14, 28), panel = Color3.fromRGB(34, 22, 44), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(170, 70, 210) },
	{ name = "Magenta", bg = Color3.fromRGB(26, 12, 26), panel = Color3.fromRGB(40, 20, 40), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(225, 60, 200) },
	{ name = "Rose", bg = Color3.fromRGB(26, 14, 20), panel = Color3.fromRGB(40, 24, 32), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(240, 90, 140) },
	{ name = "Bubblegum", bg = Color3.fromRGB(28, 18, 24), panel = Color3.fromRGB(44, 30, 38), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(255, 120, 180) },
	{ name = "Coral", bg = Color3.fromRGB(26, 16, 16), panel = Color3.fromRGB(40, 26, 26), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(255, 110, 100) },
	{ name = "Sunset", bg = Color3.fromRGB(24, 16, 20), panel = Color3.fromRGB(38, 26, 32), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(255, 100, 130) },
	{ name = "Lime", bg = Color3.fromRGB(16, 22, 10), panel = Color3.fromRGB(26, 34, 18), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(170, 220, 40) },
	{ name = "Mint", bg = Color3.fromRGB(12, 24, 20), panel = Color3.fromRGB(20, 36, 30), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(100, 230, 170) },
	{ name = "Aqua", bg = Color3.fromRGB(10, 24, 26), panel = Color3.fromRGB(18, 36, 40), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(60, 220, 220) },
	{ name = "Gold", bg = Color3.fromRGB(22, 18, 8), panel = Color3.fromRGB(36, 30, 14), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(230, 190, 70) },
	{ name = "Bronze", bg = Color3.fromRGB(22, 16, 10), panel = Color3.fromRGB(34, 26, 18), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(200, 140, 80) },
	{ name = "Slate", bg = Color3.fromRGB(18, 20, 24), panel = Color3.fromRGB(30, 34, 40), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(120, 140, 160) },
	{ name = "Graphite", bg = Color3.fromRGB(16, 16, 18), panel = Color3.fromRGB(28, 28, 32), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(150, 150, 160) },
	{ name = "Carbon", bg = Color3.fromRGB(10, 10, 12), panel = Color3.fromRGB(20, 20, 24), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(90, 200, 255) },
	{ name = "Onyx", bg = Color3.fromRGB(8, 8, 8), panel = Color3.fromRGB(18, 18, 18), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(200, 200, 200) },
	{ name = "Neon Green", bg = Color3.fromRGB(8, 12, 8), panel = Color3.fromRGB(16, 22, 16), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(60, 255, 120) },
	{ name = "Neon Pink", bg = Color3.fromRGB(14, 8, 14), panel = Color3.fromRGB(24, 16, 24), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(255, 60, 180) },
	{ name = "Neon Blue", bg = Color3.fromRGB(8, 10, 16), panel = Color3.fromRGB(16, 20, 30), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(60, 160, 255) },
	{ name = "Cyberpunk", bg = Color3.fromRGB(14, 8, 18), panel = Color3.fromRGB(26, 14, 32), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(255, 220, 40) },
	{ name = "Vaporwave", bg = Color3.fromRGB(18, 12, 26), panel = Color3.fromRGB(30, 20, 42), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(255, 120, 220) },
	{ name = "Dracula", bg = Color3.fromRGB(16, 16, 22), panel = Color3.fromRGB(26, 26, 36), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(189, 147, 249) },
	{ name = "Nord", bg = Color3.fromRGB(14, 18, 24), panel = Color3.fromRGB(24, 30, 40), text = Color3.fromRGB(240, 240, 240), subtext = Color3.fromRGB(150, 150, 150), accent = Color3.fromRGB(136, 192, 208) },
	{ name = "Solarized", bg = Color3.fromRGB(0, 24, 30), panel = Color3.fromRGB(7, 36, 44), text = Color3.fromRGB(200, 210, 200), subtext = Color3.fromRGB(110, 130, 130), accent = Color3.fromRGB(38, 160, 190) },
	{ name = "Light", bg = Color3.fromRGB(235, 236, 240), panel = Color3.fromRGB(250, 250, 252), text = Color3.fromRGB(25, 25, 25), subtext = Color3.fromRGB(110, 110, 110), accent = Color3.fromRGB(45, 130, 235) },
	{ name = "Cream", bg = Color3.fromRGB(240, 236, 226), panel = Color3.fromRGB(252, 249, 240), text = Color3.fromRGB(25, 25, 25), subtext = Color3.fromRGB(110, 110, 110), accent = Color3.fromRGB(210, 140, 60) },
}

function WindUI:ThemeNames()
	local names = {}
	for _, th in ipairs(self._themes) do names[#names + 1] = th.name end
	return names
end
function WindUI:ApplyTheme(name)
	for i, th in ipairs(self._themes) do
		if th.name == name then
			self._themeIndex = i
			if self._activeWin and self._activeWin.SetTheme then self._activeWin:SetTheme(th) end
			return th.name
		end
	end
end
function WindUI:CycleTheme(dir)
	local n = #self._themes
	if n == 0 then return end
	self._themeIndex = ((self._themeIndex - 1 + dir) % n) + 1
	local th = self._themes[self._themeIndex]
	if self._activeWin and self._activeWin.SetTheme then self._activeWin:SetTheme(th) end
	return th.name
end

WindUI:AddTheme({
Name = "Nexus",
Background = WindUI:Gradient({ ["0"] = { Color = Color3.fromHex("#ffa500"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#dc2626"), Transparency = 0 } }, { Rotation = 135 }),
Section    = WindUI:Gradient({ ["0"] = { Color = Color3.fromHex("#991b1b"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#991b1b"), Transparency = 0 } }, { Rotation = 90  }),
Accent     = WindUI:Gradient({ ["0"] = { Color = Color3.fromHex("#ff3b30"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#ff6b35"), Transparency = 0 } }, { Rotation = 0   }),
Button     = WindUI:Gradient({ ["0"] = { Color = Color3.fromHex("#ef4444"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#f87171"), Transparency = 0 } }, { Rotation = 0   }),
Toggle     = WindUI:Gradient({ ["0"] = { Color = Color3.fromHex("#ff3b30"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#ff6b35"), Transparency = 0 } }, { Rotation = 0   }),
Text       = WindUI:Gradient({ ["0"] = { Color = Color3.fromHex("#ffffff"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#ffffff"), Transparency = 0 } }, { Rotation = 0   }),
Icon       = WindUI:Gradient({ ["0"] = { Color = Color3.fromHex("#ffffff"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#ffffff"), Transparency = 0 } }, { Rotation = 0   }),
})
local Window = WindUI:CreateWindow({
Title       = "Overtime",
Icon        = "flame",
Author      = "Football Universe",
Folder      = "NexusHub",
Size        = UDim2.fromOffset(580, 460),
Transparent = true,
Theme       = "Nexus",
User        = { Enabled = true, Anonymous = false },
})
instance.window = Window
Window:Tag({
Title  = "v1.3.0",
Icon   = "flame",
Color  = Color3.fromHex("#60a5fa"),
Radius = 4,
})
local ConfigManager = Window.ConfigManager
local cfg = ConfigManager:CreateConfig("nexus_config")
UIS.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.RightShift then Window:Toggle() end
end)
local boostKey   = Enum.KeyCode.LeftShift
local rocketKey  = Enum.KeyCode.Unknown
local pullVecKey = Enum.KeyCode.Unknown
local magsKey    = Enum.KeyCode.Unknown
local ctrlBoost   = Enum.KeyCode.ButtonL1
local ctrlRocket  = Enum.KeyCode.DPadLeft
local ctrlPullVec = Enum.KeyCode.ButtonR2
local ctrlMags    = Enum.KeyCode.ButtonL2
local CTRL_BUTTONS = {
"ButtonA", "ButtonB", "ButtonX", "ButtonY",
"ButtonL1", "ButtonR1", "ButtonL2", "ButtonR2",
"DPadUp", "DPadDown", "DPadLeft", "DPadRight",
"ButtonSelect", "ButtonStart",
}
local function toKeyCode(str)
local ok, kc = pcall(function() return Enum.KeyCode[str] end)
return (ok and kc) or Enum.KeyCode.Unknown
end
local Tabs = {
Movement = Window:Tab({ Title = "Movement", Icon = "person-standing"    }),
Boost    = Window:Tab({ Title = "Boost",    Icon = "rocket"             }),
Catching = Window:Tab({ Title = "Catching", Icon = "target"             }),
Hitbox   = Window:Tab({ Title = "Hitbox",   Icon = "box"                }),
Wager    = Window:Tab({ Title = "Wager",    Icon = "trophy"             }),
Emotes   = Window:Tab({ Title = "Emotes",   Icon = "music"              }),
Items    = Window:Tab({ Title = "Items",    Icon = "shirt"              }),
Clothes  = Window:Tab({ Title = "Clothes",  Icon = "shopping-bag"       }),
Shaders  = Window:Tab({ Title = "Shaders",  Icon = "sparkles"           }),
Graphics = Window:Tab({ Title = "Graphics", Icon = "monitor"            }),
Keybinds = Window:Tab({ Title = "Keybinds", Icon = "keyboard"           }),
Namelock = Window:Tab({ Title = "Name Lock",Icon = "lock"               }),
Settings = Window:Tab({ Title = "Settings", Icon = "sliders-horizontal" }),
}
Tabs.Movement:Select()
Tabs.Movement:Section({ Title = "Speed" })
Tabs.Movement:Slider({
Title = "WalkSpeed", Flag = "WalkSpeed",
Step = 1, Value = { Min = 1, Max = S.maxWalkSpeed, Default = S.walkSpeed },
Callback = function(v) S.walkSpeed = v; if hum and not S.rocketActive then hum.WalkSpeed = S.walkSpeed end end,
})
Tabs.Movement:Toggle({
Title = "WalkSpeed Lock",
Flag = "WalkSpeedLock", Value = true,
Callback = function(v)
S.walkSpeedLock = v
if v and hum and not S.rocketActive then hum.WalkSpeed = S.walkSpeed end
WindUI:Notify({ Title = "Overtime", Content = v and "WalkSpeed locked" or "WalkSpeed unlocked", Duration = 2, Icon = v and "lock" or "unlock" })
end,
})
Tabs.Movement:Section({ Title = "Physics" })
Tabs.Movement:Slider({
Title = "Gravity", Flag = "Gravity",
Step = 1, Value = { Min = 10, Max = S.gravityMax, Default = S.gravityValue },
Callback = function(v) S.gravityValue = v; Workspace.Gravity = S.gravityValue end,
})
Tabs.Boost:Slider({
Title = "Boost Power", Flag = "BoostPower",
Step = 1, Value = { Min = 1, Max = S.maxBoost, Default = S.boostPower },
Callback = function(v) S.boostPower = v end,
})
Tabs.Movement:Slider({
Title = "Dive Power", Flag = "DivePower",
Step = 1, Value = { Min = 10, Max = 200, Default = S.divePower },
Callback = function(v) S.divePower = v; updateDivePower(v) end,
})
Tabs.Movement:Section({ Title = "Actions" })
Tabs.Boost:Button({
Title = "Rocket Boost", Desc = "DPad ← by default  |  Instant burst of speed",
Callback = function()
rocketBoost()
WindUI:Notify({ Title = "Overtime", Content = "Rocket Boost!", Duration = 1 })
end,
})
Tabs.Movement:Section({ Title = "Follow" })
Tabs.Movement:Button({
Title = "Toggle Follow", Desc = "Follows the nearest player — press F or DPad → to toggle",
Callback = function() toggleFollow() end,
})
Tabs.Movement:Dropdown({
Title = "Follow Controller Button",
Values = CTRL_BUTTONS, Value = "DPadRight",
Callback = function(v) ctrlFollow = toKeyCode(v) end,
})
Tabs.Movement:Section({ Title = "Boost Amplifier" })
Tabs.Boost:Toggle({
Title = "TTB Amplifier",
Flag = "BoostAmp", Value = false,
Callback = function(v)
boostAmpEnabled = v
WindUI:Notify({ Title = "Overtime", Content = v and "TTB Amplifier on" or "TTB Amplifier off", Duration = 2 })
end,
})
Tabs.Boost:Slider({
Title = "TTB Multiplier",
Flag = "BoostAmpMult", Step = 0.5,
Value = { Min = 1.5, Max = 10, Default = 2 },
Callback = function(v) boostAmpMultiplier = v end,
})
Tabs.Boost:Section({ Title = "Fling" })
Tabs.Boost:Toggle({
Title = "Fling",
Flag = "Fling", Value = false,
Callback = function(v)
flingEnabled = v
WindUI:Notify({ Title = "Overtime", Content = v and "Fling on" or "Fling off", Duration = 2 })
end,
})
Tabs.Boost:Slider({
Title = "Fling Power",
Flag = "FlingPower", Step = 5, Value = { Min = 50, Max = 500, Default = flingPower },
Callback = function(v) flingPower = v end,
})
Tabs.Boost:Section({ Title = "Auto Boost" })
Tabs.Boost:Toggle({
Title = "Auto Boost",
Flag = "AutoBoost", Value = false,
Callback = function(v)
autoBoostEnabled = v
WindUI:Notify({ Title = "Overtime", Content = v and "Auto Boost on" or "Auto Boost off", Duration = 2 })
end,
})
Tabs.Boost:Section({ Title = "Fling Up Boost" })
Tabs.Boost:Toggle({
Title = "Fling Up Boost",
Flag = "FlingUpBoost", Value = false,
Callback = function(v)
flingUpEnabled = v
WindUI:Notify({ Title = "Overtime", Content = v and "Fling Up Boost on" or "Fling Up Boost off", Duration = 2 })
end,
})
Tabs.Catching:Section({ Title = "Pull Vector" })
Tabs.Catching:Toggle({
Title = "Pull Vec",
Flag = "PullVec", Value = false,
Callback = function(v)
S.pullVecEnabled = v
WindUI:Notify({ Title = "Overtime", Content = v and "Pull Vec on — hold RT / RMB" or "Pull Vec off", Duration = 2 })
end,
})
Tabs.Catching:Section({ Title = "Tuning" })
Tabs.Catching:Slider({
Title = "Pull Speed", Flag = "PullSpeed",
Step = 0.1, Value = { Min = 10, Max = 500, Default = S.pullVecStrength },
Callback = function(v) S.pullVecStrength = v end,
})
Tabs.Catching:Slider({
Title = "Pull Smoothness", Flag = "PullSmooth",
Step = 0.1, Value = { Min = 0.1, Max = 0.9, Default = S.pullVecSmooth },
Callback = function(v) S.pullVecSmooth = v end,
})
Tabs.Catching:Section({ Title = "Mags" })
Tabs.Catching:Toggle({
Title = "CFrame Mags",
Flag = "CfMags", Value = false,
Callback = function(v)
S.cfMagsEnabled = v
WindUI:Notify({ Title = "Overtime", Content = v and "CFrame Mags on — hold LMB" or "CFrame Mags off", Duration = 2 })
end,
})
Tabs.Catching:Toggle({
Title = "Orb Mags",
Flag = "OrbMags", Value = false,
Callback = function(v)
S.orbMagsEnabled = v
WindUI:Notify({ Title = "Overtime", Content = v and "Orb Mags on" or "Orb Mags off", Duration = 2 })
end,
})
Tabs.Catching:Section({ Title = "Pull Orb" })
Tabs.Catching:Toggle({
Title = "Enable Pull Orb",
Flag = "OrbEnabled", Value = false,
Callback = function(v)
S.orbEnabled = v
if not v and S.orbPart and S.orbPart.Parent then S.orbPart:Destroy(); S.orbPart = nil end
WindUI:Notify({ Title = "Overtime", Content = v and "Pull Orb active" or "Pull Orb off", Duration = 2 })
end,
})
Tabs.Catching:Slider({
Title = "Orb Radius", Flag = "OrbRadius",
Step = 1, Value = { Min = 5, Max = 100, Default = S.orbRadius },
Callback = function(v) S.orbRadius = v end,
})
Tabs.Catching:Colorpicker({
Title = "Orb Colour", Default = S.orbColor,
Callback = function(color) S.orbColor = color; if S.orbPart then S.orbPart.Default = color end end,
})
Tabs.Catching:Slider({
Title = "Orb Transparency", Flag = "OrbTransparency",
Step = 1, Value = { Min = 0, Max = 10, Default = math.floor(S.orbTransparency * 10) },
Callback = function(v) S.orbTransparency = v / 10; if S.orbPart then S.orbPart.Transparency = S.orbTransparency end end,
})
-- ── Wager Tab ─────────────────────────────────────────────────────────────────
Tabs.Wager:Section({ Title = "Head Manipulation" })
Tabs.Wager:Toggle({
Title = "Head Manipulation", Desc = "Steers you horizontally toward nearest head when descending from a jump",
Flag = "HeadManip", Value = false,
Callback = function(v)
S.headManipEnabled = v
WindUI:Notify({ Title = "Overtime", Content = v and "Head Manip on" or "Head Manip off", Duration = 2, Icon = "user" })
end,
})
Tabs.Wager:Slider({
Title = "Head Strength", Desc = "How hard you get steered toward the head",
Flag = "HeadStrength", Step = 0.1, Value = { Min = 0.5, Max = 6, Default = S.headStrength },
Callback = function(v) S.headStrength = v end,
})
Tabs.Wager:Section({ Title = "Jump Pull Vec" })
Tabs.Wager:Toggle({
Title = "Jump Pull Vec", Desc = "Auto-holds pull vec while you are airborne — no button needed",
Flag = "JumpPull", Value = false,
Callback = function(v)
S.jumpPullEnabled = v
if not v then S.jumpPullActive = false; S.pullVecHeld = false end
WindUI:Notify({ Title = "Overtime", Content = v and "Jump Pull on" or "Jump Pull off", Duration = 2, Icon = "arrow-up" })
end,
})
Tabs.Wager:Paragraph({
Title   = "Jump Pull Vec note",
Content = "Pull Vec must also be enabled in the Catching tab. This just removes the need to hold the button — it activates automatically when you leave the ground.",
})
Tabs.Wager:Section({ Title = "Ball Manipulation" })
Tabs.Wager:Toggle({
Title = "Ball Magnet", Desc = "Pulls the ball toward your hand with jitter effect",
Flag = "BallMag", Value = false,
Callback = function(v)
S.ballMagEnabled = v
WindUI:Notify({ Title = "Overtime", Content = v and "Ball Magnet on" or "Ball Magnet off", Duration = 2, Icon = "magnet" })
end,
})
Tabs.Wager:Toggle({
Title = "Range Boost", Desc = "Boosts ball speed when you are within range",
Flag = "BallRangeBoost", Value = false,
Callback = function(v)
S.ballRangeEnabled = v
WindUI:Notify({ Title = "Overtime", Content = v and "Range Boost on" or "Range Boost off", Duration = 2, Icon = "zap" })
end,
})
Tabs.Wager:Slider({
Title = "Magnet Range", Desc = "Max distance to activate the magnet",
Flag = "BallMagRange", Step = 1, Value = { Min = 5, Max = 200, Default = S.ballMagRange },
Callback = function(v) S.ballMagRange = v end,
})
Tabs.Wager:Slider({
Title = "Speed Range", Desc = "Distance within which ball gets boosted speed",
Flag = "BallSpeedRange", Step = 1, Value = { Min = 5, Max = 200, Default = S.ballSpeedRange },
Callback = function(v) S.ballSpeedRange = v end,
})
Tabs.Wager:Slider({
Title = "Boosted Speed", Desc = "Ball speed when inside range",
Flag = "BallBoostedSpeed", Step = 1, Value = { Min = 1, Max = 9999, Default = S.ballBoostedSpeed },
Callback = function(v) S.ballBoostedSpeed = v end,
})
Tabs.Wager:Slider({
Title = "Pull Strength", Desc = "How hard the ball flies toward your hand",
Flag = "BallPullStr", Step = 1, Value = { Min = 10, Max = 500, Default = S.ballPullStrength },
Callback = function(v) S.ballPullStrength = v end,
})
Tabs.Wager:Slider({
Title = "Jitter Amplitude", Desc = "How wild the shake is while pulling",
Flag = "BallJitterAmp", Step = 1, Value = { Min = 0, Max = 50, Default = S.ballJitterAmp },
Callback = function(v) S.ballJitterAmp = v end,
})
Tabs.Wager:Slider({
Title = "Jitter Frequency", Desc = "How frantic the oscillations are",
Flag = "BallJitterFreq", Step = 1, Value = { Min = 1, Max = 60, Default = S.ballJitterFreq },
Callback = function(v) S.ballJitterFreq = v end,
})
Tabs.Wager:Slider({
Title = "Snap Distance", Desc = "Studs from hand at which ball locks cleanly",
Flag = "BallSnapDist", Step = 0.1, Value = { Min = 0.5, Max = 5, Default = S.ballSnapDist },
Callback = function(v) S.ballSnapDist = v end,
})
-- ─────────────────────────────────────────────────────────────────────────────
Tabs.Hitbox:Section({ Title = "Navigation" })
Tabs.Catching:Button({
Title = "Teleport to Ball", Desc = "Instantly moves you to the football",
Callback = function()
if not hrp then return end
local nearest, nearestDist = nil, math.huge
for _, obj in pairs(workspace:GetDescendants()) do
if obj.Title == "Football" and obj:IsA("BasePart") then
local dist = (obj.Position - hrp.Position).Magnitude
if dist < nearestDist then nearest = obj; nearestDist = dist end
end
end
if nearest then
hrp.CFrame = CFrame.new(nearest.Position + Vector3.new(0, 5, 0))
WindUI:Notify({ Title = "Overtime", Content = "Teleported to ball", Duration = 2 })
else
WindUI:Notify({ Title = "Overtime", Content = "No ball found", Duration = 2, Icon = "flame" })
end
end,
})
Tabs.Hitbox:Toggle({
Title = "Noclip", Flag = "Noclip", Value = false,
Callback = function(v)
S.noclipEnabled = v
WindUI:Notify({ Title = "Overtime", Content = v and "Noclip on" or "Noclip off", Duration = 2 })
end,
})
Tabs.Hitbox:Section({ Title = "Hitbox" })
Tabs.Hitbox:Toggle({
Title = "Expand Player Hitboxes",
Flag = "Hitbox", Value = false,
Callback = function(v) hitboxEnabled = v; refreshAllHitboxes(); WindUI:Notify({ Title = "Overtime", Content = v and "Hitboxes expanded" or "Hitboxes restored", Duration = 2 }) end,
})
Tabs.Hitbox:Slider({
Title = "Hitbox Size", Flag = "HitboxSize",
Step = 0.5, Value = { Min = 1, Max = 10, Default = hitboxSize },
Callback = function(v) hitboxSize = v; if hitboxEnabled then refreshAllHitboxes() end end,
})
Tabs.Hitbox:Slider({
Title = "Hitbox Transparency", Flag = "HitboxTransp",
Step = 0.1, Value = { Min = 0, Max = 1, Default = hitboxTransparency },
Callback = function(v) hitboxTransparency = v; if hitboxEnabled then refreshAllHitboxes() end end,
})
Tabs.Catching:Section({ Title = "Gloves / Ball tp" })
Tabs.Catching:Toggle({
Title = "Gloves V2",
Flag = "Gloves", Value = false,
Callback = function(v)
S.glovesEnabled = v
if v then applyGloves() else removeGloves() end
WindUI:Notify({ Title = "Overtime", Content = v and "Gloves on" or "Gloves off", Duration = 2 })
end,
})
Tabs.Catching:Slider({
Title = "Glove Size", Flag = "GloveSize",
Step = 0.5, Value = { Min = 2, Max = 12, Default = S.gloveSize },
Callback = function(v) S.gloveSize = v; if S.glovesEnabled then applyGloves() end end,
})
Tabs.Catching:Toggle({
Title = "Invisible Gloves",
Flag = "GlovesInvis", Value = false,
Callback = function(v) S.glovesInvisible = v; if S.glovesEnabled then applyGloves() end end,
})
Tabs.Hitbox:Section({ Title = "Sticky Head" })
Tabs.Hitbox:Toggle({
Title = "Sticky Head",
Flag = "StickyHead", Value = false,
Callback = function(v)
S.stickyHeadEnabled = v
if not v then removeAllStickyZones() end
if S.stickyHeadNotifs then
WindUI:Notify({ Title = "Overtime", Content = v and "Sticky Head on" or "Sticky Head off", Duration = 2 })
end
end,
})
Tabs.Hitbox:Toggle({
Title = "Sticky Head Notifications",
Flag = "StickyHeadNotifs", Value = true,
Callback = function(v) S.stickyHeadNotifs = v end,
})
Tabs.Hitbox:Slider({
Title = "Sticky Search Range",
Flag = "StickyHeadSize", Step = 1, Value = { Min = 5, Max = 80, Default = S.stickyHeadSize },
Callback = function(v) S.stickyHeadSize = v end,
})
Tabs.Hitbox:Slider({
Title = "Pull Strength",
Flag = "StickyPull", Step = 1, Value = { Min = 10, Max = 40, Default = math.floor(S.stickyPullStrength * 10) },
Callback = function(v) S.stickyPullStrength = v / 10 end,
})
Tabs.Hitbox:Slider({
Title = "Stickiness",
Flag = "StickyStick", Step = 1, Value = { Min = 10, Max = 40, Default = math.floor(S.stickyStickiness * 10) },
Callback = function(v) S.stickyStickiness = v / 10 end,
})
Tabs.Hitbox:Slider({
Title = "Rotation Smoothness",
Flag = "StickyRotSmooth", Step = 1, Value = { Min = 1, Max = 20, Default = math.floor(S.rotationSmoothness * 100) },
Callback = function(v) S.rotationSmoothness = v / 100 end,
})
Tabs.Hitbox:Slider({
Title = "Air Control Smoothing",
Flag = "StickyAirSmooth", Step = 1, Value = { Min = 1, Max = 30, Default = math.floor(S.airControlSmoothing * 100) },
Callback = function(v) S.airControlSmoothing = v / 100 end,
})
Tabs.Hitbox:Section({ Title = "Performance" })
Tabs.Hitbox:Paragraph({
Title   = "Graphics moved",
Content = "Potato Graphics and other visual options are now in the Graphics tab.",
})
local greyPlayersEnabled   = false
pixelFacesEnabled    = false
local originalFaceIds      = {}
function applyPixelFaces()
pcall(function() settings():GetService("Studio") end)
pcall(function() UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel01 end)
pcall(function() game:GetService("ContentProvider"):SetThreadPool(1) end)
for _, plr in pairs(Players:GetPlayers()) do
local c = plr.Character
if not c then continue end
local head = c:FindFirstChild("Head")
if not head then continue end
local face = head:FindFirstChild("face")
if face and face:IsA("Decal") then
if not originalFaceIds[plr.UserId] then originalFaceIds[plr.UserId] = face.Texture end
local stored = face.Texture
face.Texture = ""
task.defer(function() if face and face.Parent then face.Texture = stored end end)
end
end
pcall(function() game:GetService("RenderSettings").QualityLevel = Enum.QualityLevel.Level01 end)
end
local function removePixelFaces()
for _, plr in pairs(Players:GetPlayers()) do
local c = plr.Character
if not c or not originalFaceIds[plr.UserId] then continue end
local head = c:FindFirstChild("Head")
if not head then continue end
local face = head:FindFirstChild("face")
if face and originalFaceIds[plr.UserId] ~= "NONE" then face.Texture = originalFaceIds[plr.UserId] end
end
originalFaceIds = {}
end
local function applyFFlags(flags)
for name, value in pairs(flags) do
pcall(function() game:GetService("RbxAnalyticsService"):SetRBXEventStream(name, tostring(value)) end)
pcall(function() settings()[name] = value end)
end
end
local FFLAG_PRESETS = {
["Max FPS Boost"] = {
FFlagDebugDisableTelemetry = true,
DFIntTaskSchedulerTargetFps = 9999,
FFlagRenderGrassMotion = false,
FFlagRenderShadowIntensity = false,
},
["Low Quality Rendering"] = {
FFlagCommitToGraphicsQualityFix = true,
FFlagFixGraphicsQuality = true,
DFIntDebugFRMQualityLevelOverride = 1,
},
["Disable Shadows"] = {
FFlagDebugForceFastGBuffer = false,
DFFlagDebugRenderForceTechnologyVoxel = true,
},
}
Players.PlayerAdded:Connect(function(plr)
plr.CharacterAdded:Connect(function()
task.wait(1)
if pixelFacesEnabled then applyPixelFaces() end
end)
end)
Tabs.Graphics:Section({ Title = "Player Visuals" })
Tabs.Graphics:Toggle({
Title = "Pixel Faces",
Flag = "PixelFaces", Value = false,
Callback = function(v)
pixelFacesEnabled = v
if v then applyPixelFaces() else removePixelFaces() end
WindUI:Notify({ Title = "Overtime", Content = v and "Pixel Faces on" or "Pixel Faces off", Duration = 2 })
end,
})
Tabs.Graphics:Section({ Title = "FastFlag Launcher" })
Tabs.Graphics:Paragraph({
Title   = "Presets",
Content = "Click a preset to apply it instantly.",
})
local presetNames = {}
for name in pairs(FFLAG_PRESETS) do table.insert(presetNames, name) end
table.sort(presetNames)
for _, name in ipairs(presetNames) do
Tabs.Graphics:Button({
Title = name,
Callback = function()
applyFFlags(FFLAG_PRESETS[name])
WindUI:Notify({ Title = "Overtime", Content = "Applied: " .. name, Duration = 2 })
end,
})
end
local fflagInput = ""
Tabs.Graphics:Input({
Title = "Custom FFlags", Desc = 'Paste JSON e.g. {"FFlagName":true,"DFIntName":1}',
Placeholder = '{"FFlagExample":true}', Callback = function(v) fflagInput = v end,
})
Tabs.Graphics:Button({
Title = "Apply Custom FFlags",
Callback = function()
if fflagInput == "" then
WindUI:Notify({ Title = "Overtime", Content = "Paste flags first", Duration = 2 })
return
end
local ok, flags = pcall(function()
return game:GetService("HttpService"):JSONDecode(fflagInput)
end)
if not ok or type(flags) ~= "table" then
WindUI:Notify({ Title = "Overtime", Content = "Invalid JSON", Duration = 2, Icon = "flame" })
return
end
applyFFlags(flags)
WindUI:Notify({ Title = "Overtime", Content = "FFlags applied", Duration = 2, Icon = "flame" })
end,
})
Tabs.Graphics:Section({ Title = "Performance" })
Tabs.Graphics:Toggle({
Title = "Potato Graphics",
Flag = "PotatoGraphics2", Value = false,
Callback = function(v)
S.potatoEnabled = v
if v then applyPotato() else removePotato() end
WindUI:Notify({ Title = "Overtime", Content = v and "Potato Graphics on" or "Potato Graphics off", Duration = 2, Icon = v and "cpu" or "monitor" })
end,
})
Tabs.Emotes:Section({ Title = "Search" })
Tabs.Emotes:Input({
Title = "Search & Play", Desc = "Type an emote name and press Enter to play it",
Placeholder = "e.g. BBS", Callback = function(v)
if not v or v == "" then return end
local query = v:lower():gsub("%s+", "")
for _, emote in ipairs(EMOTES) do
if emote.name:lower():gsub("%s+",""):find(query, 1, true) then
playEmote(emote.id, emote.speed)
WindUI:Notify({ Title = "Overtime", Content = "Playing: " .. emote.name, Duration = 2 })
return
end
end
WindUI:Notify({ Title = "Overtime", Content = "No emote found: " .. v, Duration = 2, Icon = "flame" })
end,
})
Tabs.Emotes:Section({ Title = "Emotes" })
for _, emote in ipairs(EMOTES) do
Tabs.Emotes:Button({
Title = emote.name,
Callback = function()
playEmote(emote.id, emote.speed)
WindUI:Notify({ Title = "Overtime", Content = "Playing: " .. emote.name, Duration = 2 })
end,
})
end
Tabs.Emotes:Section({ Title = "Playback" })
Tabs.Emotes:Slider({
Title = "Emote Speed",
Step = 1, Value = { Min = 1, Max = 30, Default = 10 },
Callback = function(v)
local speed = v / 10
if currentAnimTrack then currentAnimTrack:AdjustSpeed(speed) end
end,
})
Tabs.Emotes:Button({
Title = "Stop Emote", Desc = "Stop the currently playing emote",
Callback = function()
stopEmote()
WindUI:Notify({ Title = "Overtime", Content = "Emote stopped", Duration = 2 })
end,
})
Tabs.Emotes:Section({ Title = "Custom" })
local customAnimId = ""
Tabs.Emotes:Input({
Title = "Animation ID", Desc = "Enter a numeric Roblox animation ID",
Placeholder = "e.g. 10714364213", Callback = function(v) customAnimId = v end,
})
Tabs.Emotes:Button({
Title = "Play Custom",
Callback = function()
if customAnimId == "" then
WindUI:Notify({ Title = "Overtime", Content = "Enter an animation ID first", Duration = 2 })
return
end
playEmote("rbxassetid://" .. customAnimId, 1)
WindUI:Notify({ Title = "Overtime", Content = "Playing custom animation", Duration = 2, Icon = "flame" })
end,
})
Tabs.Items:Section({ Title = "Accessories" })
local sortedItemNames = {}
for k in pairs(ITEMS) do table.insert(sortedItemNames, k) end
table.sort(sortedItemNames)
for _, itemName in ipairs(sortedItemNames) do
Tabs.Items:Toggle({
Title = itemName, Value = false,
Callback = function(v)
if v then
equipItem(itemName)
WindUI:Notify({ Title = "Overtime", Content = "Equipped: " .. itemName, Duration = 2 })
else
unequipItem(itemName)
WindUI:Notify({ Title = "Overtime", Content = "Unequipped: " .. itemName, Duration = 2, Icon = "flame" })
end
end,
})
end
Tabs.Items:Button({
Title = "Unequip All", Desc = "Remove every equipped accessory",
Callback = function()
for name in pairs(ITEMS) do unequipItem(name) end
WindUI:Notify({ Title = "Overtime", Content = "All items removed", Duration = 2 })
end,
})
Tabs.Items:Section({ Title = "Banners" })
for _, banner in ipairs(BANNERS) do
Tabs.Items:Button({
Title = banner.name,
Callback = function()
applyBanner(banner.id)
WindUI:Notify({ Title = "Overtime", Content = "Banner: " .. banner.name, Duration = 2 })
end,
})
end
Tabs.Items:Button({
Title = "Clear Banner", Desc = "Removes your current banner",
Callback = function()
removeBanner()
WindUI:Notify({ Title = "Overtime", Content = "Banner cleared", Duration = 2 })
end,
})
Tabs.Clothes:Section({ Title = "Outfits" })
for _, cloth in ipairs(CLOTHES) do
Tabs.Clothes:Button({
Title = cloth.name,
Callback = function()
local success = applyCloth(cloth.type, cloth.id)
if success then
WindUI:Notify({ Title = "Overtime", Content = "Wearing: " .. cloth.name, Duration = 2 })
end
end,
})
end
Tabs.Clothes:Button({
Title = "Reset Shirt", Desc = "Restore original shirt",
Callback = function()
resetCloth("shirt")
WindUI:Notify({ Title = "Overtime", Content = "Shirt reset", Duration = 2 })
end,
})
Tabs.Clothes:Button({
Title = "Reset Shorts", Desc = "Restore original pants",
Callback = function()
resetCloth("pants")
WindUI:Notify({ Title = "Overtime", Content = "Pants reset", Duration = 2 })
end,
})
Tabs.Clothes:Section({ Title = "Cosmetics" })
Tabs.Clothes:Toggle({
Title = "Inf Bandana",
Flag = "InfBandana", Value = false,
Callback = function(v)
bandanaActive = v
if v then
local success = applyInfBandana()
if success then
WindUI:Notify({ Title = "Overtime", Content = "Inf Bandana on", Duration = 2 })
else
bandanaActive = false
end
else
removeInfBandana()
WindUI:Notify({ Title = "Overtime", Content = "Inf Bandana off", Duration = 2, Icon = "flame" })
end
end,
})
Tabs.Shaders:Section({ Title = "Sky Presets" })
Tabs.Shaders:Paragraph({
Title   = "Sky Presets",
Content = "Pick a preset or enable Loop to cycle through all skies every second.",
})
Tabs.Shaders:Toggle({
Title = "Loop Skies", Desc = "Automatically cycles through every preset every 1 second",
Flag = "SkyLoop", Value = false,
Callback = function(v)
skyLoopEnabled = v
if not v then skyLoopIndex = 1 end
WindUI:Notify({ Title = "Overtime", Content = v and "Sky loop on" or "Sky loop off", Duration = 2, Icon = "sparkles" })
end,
})
local SKY_PRESETS = {
"Default", "Sunset Paradise", "Golden Hour", "Warm Summer",
"Pink Dream", "Orange Glow", "Coral Sunset", "Clear Day",
"Vaporwave Dream", "Midnight Blue",
}
for _, preset in ipairs(SKY_PRESETS) do
Tabs.Shaders:Button({
Title = preset,
Callback = function()
ApplySky(preset)
WindUI:Notify({ Title = "Overtime", Content = "Sky: " .. preset, Duration = 2, Icon = "cloud" })
end,
})
end
Tabs.Shaders:Section({ Title = "Sky Colour" })
Tabs.Shaders:Colorpicker({
Title = "Sky Colour",
Default = shaderSkyColor,
Callback = function(color)
shaderSkyColor = color
local cc   = Lighting:FindFirstChild("NexusCC")
local atmo = Lighting:FindFirstChild("NexusAtmo")
if cc   then cc.TintColor = color end
if atmo then atmo.Default = color end
if not atmo then
local a = Instance.new("Atmosphere")
a.Title = "NexusAtmo"; a.Default = color; a.Density = 0.35
a.Offset = 0.1; a.Haze = 1.5; a.Glare = 0.2; a.Parent = Lighting
table.insert(shaderObjects, a)
end
if not cc then
local c2 = Instance.new("ColorCorrectionEffect")
c2.Title = "NexusCC"; c2.TintColor = color; c2.Parent = Lighting
table.insert(shaderObjects, c2)
end
WindUI:Notify({ Title = "Overtime", Content = "Sky colour updated", Duration = 2 })
end,
})
Tabs.Shaders:Section({ Title = "Shadows" })
Tabs.Shaders:Toggle({
Title = "Global Shadows",
Value = Lighting.GlobalShadows,
Callback = function(v)
Lighting.GlobalShadows = v
WindUI:Notify({ Title = "Overtime", Content = v and "Shadows on" or "Shadows off", Duration = 2 })
end,
})
Tabs.Shaders:Slider({
Title = "Shadow Softness",
Step = 1, Value = { Min = 0, Max = 10, Default = math.floor(Lighting.ShadowSoftness * 10) },
Callback = function(v) Lighting.ShadowSoftness = v / 10 end,
})
Tabs.Keybinds:Section({ Title = "Keyboard" })
Tabs.Keybinds:Keybind({
Title = "Boost Jump",
Flag = "BoostKey", Value = "LeftShift",
Callback = function(v) boostKey = toKeyCode(v) end,
})
Tabs.Keybinds:Keybind({
Title = "Rocket Boost", Desc = "Press to trigger Rocket Boost (keyboard)",
Flag = "RocketKey", Value = "Unknown",
Callback = function(v) rocketKey = toKeyCode(v) end,
})
Tabs.Keybinds:Keybind({
Title = "Pull Vec Hold",
Flag = "PullVecKey", Value = "E",
Callback = function(v) pullVecKey = toKeyCode(v) end,
})
Tabs.Keybinds:Keybind({
Title = "CFrame Mags Hold", Desc = "Hold to activate mags (keyboard only)",
Flag = "MagsKey", Value = "Unknown",
Callback = function(v) magsKey = toKeyCode(v) end,
})
Tabs.Keybinds:Keybind({
Title = "Sticky Head Toggle",
Flag = "StickyHeadKey", Value = "Unknown",
Callback = function(v) stickyHeadKey = toKeyCode(v) end,
})
Tabs.Keybinds:Keybind({
Title = "Toggle UI",
Value = "RightShift",
Callback = function(v)
local ok, kc = pcall(function() return Enum.KeyCode[v] end)
if ok and kc then Window:SetToggleKey(kc) end
end,
})
Tabs.Keybinds:Section({ Title = "Controller" })
Tabs.Keybinds:Paragraph({
Title   = "Controller Support",
Content = "WindUI doesn't detect gamepad inputs for keybinds so remapping is done with dropdowns below.",
})
Tabs.Keybinds:Dropdown({
Title = "Boost Button",
Values = CTRL_BUTTONS, Value = "ButtonL1",
Callback = function(v) ctrlBoost = toKeyCode(v); WindUI:Notify({ Title = "Overtime", Content = "Boost → " .. v, Duration = 2 }) end,
})
Tabs.Keybinds:Dropdown({
Title = "Rocket Boost Button",
Values = CTRL_BUTTONS, Value = "DPadLeft",
Callback = function(v) ctrlRocket = toKeyCode(v); WindUI:Notify({ Title = "Overtime", Content = "Rocket → " .. v, Duration = 2 }) end,
})
Tabs.Keybinds:Dropdown({
Title = "Pull Vec Button",
Values = CTRL_BUTTONS, Value = "ButtonR2",
Callback = function(v) ctrlPullVec = toKeyCode(v); WindUI:Notify({ Title = "Overtime", Content = "Pull Vec → " .. v, Duration = 2 }) end,
})
Tabs.Keybinds:Dropdown({
Title = "Sticky Head Button",
Values = CTRL_BUTTONS, Value = "ButtonR1",
Callback = function(v)
ctrlStickyHead = toKeyCode(v)
WindUI:Notify({ Title = "Overtime", Content = "Sticky Head → " .. v, Duration = 2 })
end,
})
Tabs.Keybinds:Dropdown({
Title = "CFrame Mags Button", Desc = "Hold this controller button to activate mags",
Values = CTRL_BUTTONS, Value = "ButtonL2",
Callback = function(v)
ctrlMags = toKeyCode(v)
WindUI:Notify({ Title = "Overtime", Content = "Mags → " .. v, Duration = 2 })
end,
})
local nlLatched    = nil
local nlLatchType  = nil
local nlLockConn   = nil
local nlWatchConn  = nil
local nlAddedConns = {}
local nlIsLocked   = false
local nlFakeName   = ""
local nlRealInput  = ""
local nlFakeInput  = ""
local function nlEnforce()
if not nlLatched or nlFakeName == "" then return end
if nlLatchType == "Text" then
if nlLatched.Text ~= nlFakeName then nlLatched.Text = nlFakeName end
else
if nlLatched.Value ~= nlFakeName then nlLatched.Value = nlFakeName end
end
end
-- Hooks property-changed on a specific object; safe to call multiple times
local function nlRelatch(obj, latchType)
nlLatched   = obj
nlLatchType = latchType
if nlLockConn then nlLockConn:Disconnect() end
local prop = latchType == "Text" and "Text" or "Value"
nlLockConn = obj:GetPropertyChangedSignal(prop):Connect(function()
if nlIsLocked then nlEnforce() end
end)
nlEnforce()
end
-- Scans workspace + PlayerGui for an object still showing nlRealInput
local function nlScanAndRelatch()
for _, root in ipairs({ workspace, player.PlayerGui }) do
for _, obj in ipairs(root:GetDescendants()) do
if (obj:IsA("TextLabel") or obj:IsA("TextBox")) and obj.Text == nlRealInput then
nlRelatch(obj, "Text"); return
elseif obj:IsA("StringValue") and obj.Value == nlRealInput then
nlRelatch(obj, "Value"); return
end
end
end
end
local function nlAttach(fakeName)
nlFakeName = fakeName
-- Hook the current target
	nlRelatch(nlLatched, nlLatchType)

	-- Heartbeat: enforce every 0.5 s (property-changed signal handles instant re-lock);
	-- if target dies, re-scan every 0.5 s
	if nlWatchConn then nlWatchConn:Disconnect() end
	local scanTimer    = 0
	local enforceTimer = 0
	nlWatchConn = RunService.Heartbeat:Connect(function(dt)
		if not nlIsLocked then return end
		if nlLatched and nlLatched.Parent then
			enforceTimer = enforceTimer + dt
			if enforceTimer >= 0.5 then
				enforceTimer = 0
				nlEnforce()
			end
		else
			scanTimer = scanTimer - dt
			if scanTimer <= 0 then
				nlScanAndRelatch()
				scanTimer = 0.5
			end
		end
	end)

	-- DescendantAdded watchers — fire the moment a matching object is created
	for _, c in ipairs(nlAddedConns) do c:Disconnect() end
	nlAddedConns = {}
	local function onAdded(obj)
		if not nlIsLocked then return end
		if nlLatched and nlLatched.Parent then return end
		if (obj:IsA("TextLabel") or obj:IsA("TextBox")) and obj.Text == nlRealInput then
			nlRelatch(obj, "Text")
		elseif obj:IsA("StringValue") and obj.Value == nlRealInput then
			nlRelatch(obj, "Value")
		end
	end
	table.insert(nlAddedConns, workspace.DescendantAdded:Connect(onAdded))
	table.insert(nlAddedConns, player.PlayerGui.DescendantAdded:Connect(onAdded))

	nlIsLocked = true
	WindUI:Notify({ Title = "Overtime", Content = "Locked: " .. nlLatched.Name, Duration = 3, Icon = "flame" })
end
local function nlFindAndLatch(realName, fakeName)
for _, root in ipairs({ workspace, player.PlayerGui }) do
for _, obj in ipairs(root:GetDescendants()) do
if (obj:IsA("TextLabel") or obj:IsA("TextBox")) and obj.Text == realName then
nlLatched = obj; nlLatchType = "Text"; break
elseif obj:IsA("StringValue") and obj.Value == realName then
nlLatched = obj; nlLatchType = "Value"; break
end
end
if nlLatched then break end
end
if nlLatched then nlEnforce(); nlAttach(fakeName); return true end
return false
end
-- Start watching even before the object exists — nlAttach's DescendantAdded
-- handles re-latching once found, so this just seeds the state
local function nlStartWatching(realName, fakeName)
nlFakeName  = fakeName
nlIsLocked  = true
for _, c in ipairs(nlAddedConns) do c:Disconnect() end
nlAddedConns = {}
local function onAdded(obj)
if not nlIsLocked then return end
if nlLatched and nlLatched.Parent then return end
if (obj:IsA("TextLabel") or obj:IsA("TextBox")) and obj.Text == realName then
nlLatched = obj; nlLatchType = "Text"
elseif obj:IsA("StringValue") and obj.Value == realName then
nlLatched = obj; nlLatchType = "Value"
end
if nlLatched then nlAttach(fakeName) end
end
table.insert(nlAddedConns, workspace.DescendantAdded:Connect(onAdded))
table.insert(nlAddedConns, player.PlayerGui.DescendantAdded:Connect(onAdded))
end
Tabs.Namelock:Input({ Title = "Real Username", Desc = "The exact name shown in-game", Placeholder = "e.g. PlayerName123", Callback = function(v) nlRealInput = v end })
Tabs.Namelock:Input({ Title = "Fake Name", Desc = "What you want it to show instead", Placeholder = "e.g. Anonymous", Callback = function(v) nlFakeInput = v end })
Tabs.Namelock:Button({ Title = "Lock Name", Desc = "Searches and latches — watches if not found yet",
Callback = function()
if nlIsLocked then WindUI:Notify({ Title = "Overtime", Content = "Already locked", Duration = 3 }); return end
if nlRealInput == "" or nlFakeInput == "" then WindUI:Notify({ Title = "Overtime", Content = "Fill both fields first", Duration = 3, Icon = "flame" }); return end
local found = nlFindAndLatch(nlRealInput, nlFakeInput)
if not found then
WindUI:Notify({ Title = "Overtime", Content = "Watching for it...", Duration = 3, Icon = "flame" })
nlStartWatching(nlRealInput, nlFakeInput)
end
end,
})
Tabs.Namelock:Button({ Title = "Unlock",
Callback = function()
if nlLockConn  then nlLockConn:Disconnect()  end
if nlWatchConn then nlWatchConn:Disconnect() end
for _, c in ipairs(nlAddedConns) do c:Disconnect() end
nlAddedConns = {}
nlLatched = nil; nlLatchType = nil; nlIsLocked = false; nlFakeName = ""
WindUI:Notify({ Title = "Overtime", Content = "Name lock released", Duration = 2 })
end,
})
Tabs.Namelock:Section({ Title = "Banners" })
for _, banner in ipairs(BANNERS) do
Tabs.Namelock:Button({
Title = banner.name,
Callback = function()
applyBanner(banner.id)
WindUI:Notify({ Title = "Overtime", Content = "Banner: " .. banner.name, Duration = 2 })
end,
})
end
Tabs.Namelock:Button({
Title = "Clear Banner", Desc = "Removes your current banner",
Callback = function()
removeBanner()
WindUI:Notify({ Title = "Overtime", Content = "Banner cleared", Duration = 2, Icon = "flame" })
end,
})
Tabs.Settings:Section({ Title = "Config" })
local saveName        = "nexus_config"
local selectedConfig  = nil
local configDropdown  = nil

Tabs.Settings:Input({
Title = "Config Name", Desc = "Name used when you press Save",
Placeholder = "nexus_config",
Callback = function(v) if v and v ~= "" then saveName = v end end,
})
Tabs.Settings:Button({
Title = "Save Config", Desc = "Save all current settings under the name above",
Callback = function()
local target = ConfigManager:GetConfig(saveName) or ConfigManager:CreateConfig(saveName)
local ok, err = pcall(function() return target:Save() end)
if ok then
WindUI:Notify({ Title = "Overtime", Content = "Saved config: " .. saveName, Duration = 2, Icon = "flame" })
if configDropdown then configDropdown:Refresh(ConfigManager:AllConfigs()) end
else
WindUI:Notify({ Title = "Overtime", Content = "Save failed: " .. tostring(err), Duration = 4, Icon = "flame" })
end
end,
})

Tabs.Settings:Section({ Title = "Load Config" })
configDropdown = Tabs.Settings:Dropdown({
Title = "Saved Configs", Desc = "Pick one of your saved configs",
Values = ConfigManager:AllConfigs(),
Value = ConfigManager:AllConfigs()[1],
Callback = function(v) selectedConfig = v end,
})
Tabs.Settings:Button({
Title = "Refresh List", Desc = "Rescan saved config files",
Callback = function()
configDropdown:Refresh(ConfigManager:AllConfigs())
WindUI:Notify({ Title = "Overtime", Content = "Config list refreshed", Duration = 2, Icon = "refresh-cw" })
end,
})
Tabs.Settings:Button({
Title = "Load Selected Config", Desc = "Apply the selected saved config",
Callback = function()
if not selectedConfig or selectedConfig == "" then
WindUI:Notify({ Title = "Overtime", Content = "Select a config first", Duration = 3, Icon = "flame" })
return
end
local target = ConfigManager:GetConfig(selectedConfig) or ConfigManager:CreateConfig(selectedConfig)
local ok, err = pcall(function() return target:Load() end)
WindUI:Notify({
Title = "Overtime",
Content = ok and ("Loaded config: " .. selectedConfig) or ("Load failed: " .. tostring(err)),
Duration = 3, Icon = "flame",
})
end,
})
UIS.InputBegan:Connect(function(input, processed)
if processed then return end
if input.UserInputType == Enum.UserInputType.MouseButton2 then S.pullVecHeld = true end
if input.UserInputType == Enum.UserInputType.MouseButton1 then S.magsHeld = true end
if input.UserInputType == Enum.UserInputType.Gamepad1 then
if input.KeyCode == ctrlPullVec then S.pullVecHeld = true end
if input.KeyCode == ctrlMags    then S.magsHeld    = true end
end
if S.pullVecEnabled and pullVecKey ~= Enum.KeyCode.Unknown and input.KeyCode == pullVecKey then
S.pullVecHeld = true
end
if magsKey ~= Enum.KeyCode.Unknown and input.KeyCode == magsKey then
S.magsHeld = true
end
end)
UIS.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton2 then S.pullVecHeld = false end
if input.UserInputType == Enum.UserInputType.MouseButton1 then S.magsHeld = false end
if input.UserInputType == Enum.UserInputType.Gamepad1 then
if input.KeyCode == ctrlPullVec then S.pullVecHeld = false end
if input.KeyCode == ctrlMags    then S.magsHeld    = false end
end
if pullVecKey ~= Enum.KeyCode.Unknown and input.KeyCode == pullVecKey then S.pullVecHeld = false end
if magsKey    ~= Enum.KeyCode.Unknown and input.KeyCode == magsKey    then S.magsHeld    = false end
end)
UIS.InputBegan:Connect(function(input, processed)
if processed then return end
if input.UserInputType == Enum.UserInputType.Keyboard then
if input.KeyCode == boostKey and hrp then
hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, S.boostPower, hrp.AssemblyLinearVelocity.Z)
elseif rocketKey ~= Enum.KeyCode.Unknown and input.KeyCode == rocketKey then
rocketBoost()
elseif input.KeyCode == followKey then
toggleFollow()
elseif stickyHeadKey ~= Enum.KeyCode.Unknown and input.KeyCode == stickyHeadKey then
S.stickyHeadEnabled = not S.stickyHeadEnabled
if not S.stickyHeadEnabled then removeAllStickyZones() end
if S.stickyHeadNotifs then
WindUI:Notify({ Title = "Overtime", Content = S.stickyHeadEnabled and "Sticky Head on" or "Sticky Head off", Duration = 2, Icon = "flame" })
end
end
end
if input.UserInputType == Enum.UserInputType.Gamepad1 then
if input.KeyCode == ctrlBoost and hrp then
hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, S.boostPower, hrp.AssemblyLinearVelocity.Z)
elseif input.KeyCode == ctrlRocket then
rocketBoost()
elseif input.KeyCode == ctrlFollow then
toggleFollow()
elseif input.KeyCode == ctrlStickyHead then
S.stickyHeadEnabled = not S.stickyHeadEnabled
if not S.stickyHeadEnabled then removeAllStickyZones() end
if S.stickyHeadNotifs then
WindUI:Notify({ Title = "Overtime", Content = S.stickyHeadEnabled and "Sticky Head on" or "Sticky Head off", Duration = 2, Icon = "flame" })
end
end
end
end)
WindUI:Notify({
Title = "Overtime", Content = "Loaded  —  Universe Football",
Duration = 4,
})
-- ── Theme selector (Settings tab) ─────────────────────────────────────────────
Tabs.Settings:Section({ Title = "Themes (30+)" })
Tabs.Settings:Paragraph({
Title   = "Theme",
Content = "Type a theme name below and press Enter, or use Next/Prev to cycle. Full list is under Options.",
})
Tabs.Settings:Dropdown({
Title = "Theme", Values = WindUI:ThemeNames(), Value = WindUI._themes[1].name,
Callback = function(v)
local applied = WindUI:ApplyTheme(v)
if applied then WindUI:Notify({ Title = "Overtime", Content = "Theme: " .. applied, Duration = 2 }) end
end,
})
Tabs.Settings:Button({
Title = "Next Theme",
Callback = function() WindUI:Notify({ Title = "Overtime", Content = "Theme: " .. tostring(WindUI:CycleTheme(1)), Duration = 2 }) end,
})
Tabs.Settings:Button({
Title = "Previous Theme",
Callback = function() WindUI:Notify({ Title = "Overtime", Content = "Theme: " .. tostring(WindUI:CycleTheme(-1)), Duration = 2 }) end,
})
-- Apply the default theme once the whole UI (all registered elements) exists.
WindUI:ApplyTheme(WindUI._themes[1].name)
]==])

setSource("Inferno Hub", [==[
--inferno on top
local Players    = game:GetService("Players")
local UIS        = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting   = game:GetService("Lighting")
local Workspace  = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Fresh-start guard: re-running deactivates the previous instance (its loops stop)
-- and closes the old menu, so nothing you had enabled carries over on relaunch.
local instance = {}
do
	local env = (getgenv and getgenv()) or _G
	local prev = env.InfernoHub
	if prev then
		prev.active = false
		pcall(function()
			local w = prev.window
			if w then (w.Destroy or w.Close)(w) end
		end)
	end
	env.InfernoHub = instance
end
instance.active = true
-- Forward-declare WindUI so every callback defined before the library loads
-- captures the same upvalue rather than falling through to a nil global.
local WindUI
local player = Players.LocalPlayer
repeat task.wait() until player and player:FindFirstChild("PlayerGui")
local S = {
	boostPower = 72,
	maxBoost = 750,
	walkSpeed = 21,
	maxWalkSpeed = 500,
	gravityValue = 196,
	gravityMax = 300,
	noclipEnabled = false,
	potatoEnabled = false,
	pullVecEnabled = false,
	pullVecHeld = false,
	pullVecStrength = 120,
	pullVecSmooth = 0.15,
	cfMagsEnabled = false,
	orbMagsEnabled = false,
	magsHeld = false,
	glovesEnabled = false,
	gloveSize = 6,
	glovesInvisible = false,
	originalHandSizes = {},
	orbEnabled = false,
	orbRadius = 20,
	orbColor = Color3.fromRGB(0, 140, 255),
	orbTransparency = 0.6,
	orbPart = nil,
	cachedBall = nil,
	ballSearchTimer = 0,
	noclipTimer = 0,
	ballMagEnabled = false,
	ballRangeEnabled = false,
	ballMagRange = 50,
	ballSpeedRange = 25,
	ballBoostedSpeed = 999,
	ballDefaultSpeed = 95,
	ballPullStrength = 110,
	ballJitterAmp = 14,
	ballJitterFreq = 22,
	ballSnapDist = 1.5,
	footballSpeed = nil,
	stickyHeadEnabled = false,
	stickyHeadSize = 35,
	stickyHeadZones = {},
	stickyHeadNotifs = true,
	rotationSmoothness = 0.08,
	airControlSmoothing = 0.16,
	stickyPullStrength = 2.0,
	stickyStickiness = 2.0,
	rocketSpeed = 9999,
	rocketDuration = 0.5,
	rocketActive = false,
	rocketCooldown = false,
	divePower = 50,
	walkSpeedLock = true,
	headManipEnabled = false,
	headStrength = 2.0,
	jumpPullEnabled = false,
	jumpPullActive = false,
}

-- Forward-declare functions/state referenced before their definitions (e.g. in the
-- master Heartbeat) so early callbacks capture the shared upvalue, not a nil global.
local getHands, claimBallOwnership, catchBall, applyGloves, applyPixelFaces
local boostAmpEnabled, boostAmpMultiplier, lastYVelocity, boostAmpFired, pixelFacesEnabled
-- ─────────────────────────────────────────────────────────────────────────────
local char = player.Character or player.CharacterAdded:Wait()
local hrp  = char:WaitForChild("HumanoidRootPart")
local hum  = char:WaitForChild("Humanoid")
player.CharacterAdded:Connect(function(c)
char = c
hrp  = c:WaitForChild("HumanoidRootPart")
hum  = c:WaitForChild("Humanoid")
hum.WalkSpeed = S.walkSpeed
if S.noclipEnabled then
for _, p in pairs(c:GetDescendants()) do
if p:IsA("BasePart") then p.CanCollide = false end
end
end
end)
local originalProps = {}
local function applyPotato()
originalProps.QualityLevel             = settings().Rendering.QualityLevel
originalProps.Ambient                  = Lighting.Ambient
originalProps.Brightness               = Lighting.Brightness
originalProps.GlobalShadows            = Lighting.GlobalShadows
originalProps.FogEnd                   = Lighting.FogEnd
originalProps.FogStart                 = Lighting.FogStart
originalProps.ClockTime                = Lighting.ClockTime
originalProps.ShadowSoftness           = Lighting.ShadowSoftness
originalProps.EnvironmentDiffuseScale  = Lighting.EnvironmentDiffuseScale
originalProps.EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale
Lighting.Ambient                  = Color3.fromRGB(255, 255, 255)
	Lighting.Brightness               = 0.8
	Lighting.GlobalShadows            = false
	Lighting.FogEnd                   = 9e9
	Lighting.FogStart                 = 9e9
	Lighting.ShadowSoftness           = 0
	Lighting.ClockTime                = 14
	Lighting.EnvironmentDiffuseScale  = 0
	Lighting.EnvironmentSpecularScale = 0

	for _, effect in pairs(Lighting:GetChildren()) do
		if effect:IsA("Atmosphere") or effect:IsA("Sky")
			or effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect")
			or effect:IsA("ColorCorrectionEffect") or effect:IsA("DepthOfFieldEffect")
			or effect:IsA("BloomEffect") then
			effect:Destroy()
		end
	end

	settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

	for _, obj in pairs(Workspace:GetDescendants()) do
		local t = obj.ClassName
		if t == "ParticleEmitter" or t == "Trail" or t == "Beam"
			or t == "Fire" or t == "Smoke" or t == "Sparkles"
			or t == "Texture" then
			obj:Destroy()
		end
	end

	if char then
		for _, obj in pairs(char:GetDescendants()) do
			local t = obj.ClassName
			if t == "ParticleEmitter" or t == "Trail" or t == "Beam"
				or t == "Fire" or t == "Smoke" or t == "Sparkles" then
				obj:Destroy()
			end
		end
	end
end
local function removePotato()
if originalProps.Ambient then
settings().Rendering.QualityLevel    = originalProps.QualityLevel or Enum.QualityLevel.Automatic
Lighting.EnvironmentDiffuseScale      = originalProps.EnvironmentDiffuseScale  or 1
Lighting.EnvironmentSpecularScale     = originalProps.EnvironmentSpecularScale or 1
Lighting.Ambient                      = originalProps.Ambient
Lighting.Brightness                   = originalProps.Brightness
Lighting.GlobalShadows                = originalProps.GlobalShadows
Lighting.FogEnd                       = originalProps.FogEnd
Lighting.ShadowSoftness               = originalProps.ShadowSoftness or 0.5
Lighting.ClockTime                    = originalProps.ClockTime or 14
end
end
-- ── Sky Presets ───────────────────────────────────────────────────────────────
local originalLighting = {
Brightness           = Lighting.Brightness,
Ambient              = Lighting.Ambient,
OutdoorAmbient       = Lighting.OutdoorAmbient,
FogEnd               = Lighting.FogEnd,
FogColor             = Lighting.FogColor,
ClockTime            = Lighting.ClockTime,
ExposureCompensation = Lighting.ExposureCompensation,
}
local currentSkyPreset = "Default"
local function cleanSkyEffects()
for _, obj in pairs(Lighting:GetChildren()) do
if obj.Name == "Inferno_Sky" or obj.Name == "Inferno_Effect" then
obj:Destroy()
end
end
end
local SKY_BK = "http://www.roblox.com/asset/?id=2670643365"
local function makeSky(stars)
local sky = Instance.new("Sky")
sky.Name = "Inferno_Sky"
sky.SkyboxBk = SKY_BK; sky.SkyboxDn = SKY_BK; sky.SkyboxFt = SKY_BK
sky.SkyboxLf = SKY_BK; sky.SkyboxRt = SKY_BK; sky.SkyboxUp = SKY_BK
sky.StarCount = stars or 0
sky.Parent    = Lighting
return sky
end
local function makeCC(tint, brightness, saturation)
local cc = Instance.new("ColorCorrectionEffect")
cc.Name       = "Inferno_Effect"
cc.TintColor  = tint
cc.Brightness = brightness or 0
cc.Saturation = saturation or 0
cc.Parent     = Lighting
end
local function makeBloom(intensity, size, threshold)
local b = Instance.new("BloomEffect")
b.Name      = "Inferno_Effect"
b.Intensity = intensity
b.Size      = size
b.Threshold = threshold
b.Parent    = Lighting
end
local function makeSunRays(intensity, spread)
local s = Instance.new("SunRaysEffect")
s.Name      = "Inferno_Effect"
s.Intensity = intensity
s.Spread    = spread
s.Parent    = Lighting
end
local function ApplySky(preset)
currentSkyPreset = preset
cleanSkyEffects()
task.wait(0.05)
if preset == "Default" then
		Lighting.Brightness           = originalLighting.Brightness
		Lighting.Ambient              = originalLighting.Ambient
		Lighting.OutdoorAmbient       = originalLighting.OutdoorAmbient
		Lighting.FogEnd               = originalLighting.FogEnd
		Lighting.ClockTime            = originalLighting.ClockTime
		Lighting.ExposureCompensation = originalLighting.ExposureCompensation

	elseif preset == "Sunset Paradise" then
		Lighting.Brightness = 2.5; Lighting.ClockTime = 18.5; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(255, 140, 70); Lighting.OutdoorAmbient = Color3.fromRGB(255, 160, 100)
		makeSky(1000); makeSunRays(0.15, 0.6); makeBloom(0.6, 24, 0.8)

	elseif preset == "Golden Hour" then
		Lighting.Brightness = 3; Lighting.ClockTime = 17; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(255, 200, 120); Lighting.OutdoorAmbient = Color3.fromRGB(255, 180, 100)
		local sky = makeSky(0); sky.SunAngularSize = 18
		makeCC(Color3.fromRGB(255, 220, 180), 0.1, 0.2)

	elseif preset == "Warm Summer" then
		Lighting.Brightness = 2.8; Lighting.ClockTime = 14; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(255, 220, 180); Lighting.OutdoorAmbient = Color3.fromRGB(255, 200, 150)
		makeSky(0); makeSunRays(0.12, 0.5)

	elseif preset == "Pink Dream" then
		Lighting.Brightness = 2.5; Lighting.ClockTime = 17.5; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(255, 180, 220); Lighting.OutdoorAmbient = Color3.fromRGB(255, 150, 200)
		makeSky(2000); makeCC(Color3.fromRGB(255, 200, 220), 0.05, 0.2)

	elseif preset == "Orange Glow" then
		Lighting.Brightness = 2.6; Lighting.ClockTime = 18; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(255, 180, 100); Lighting.OutdoorAmbient = Color3.fromRGB(255, 160, 80)
		makeSky(0); makeBloom(0.5, 28, 0.7)

	elseif preset == "Coral Sunset" then
		Lighting.Brightness = 2.7; Lighting.ClockTime = 19; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(255, 140, 140); Lighting.OutdoorAmbient = Color3.fromRGB(255, 120, 120)
		makeSky(0); makeCC(Color3.fromRGB(255, 180, 180), 0.08, 0.25)

	elseif preset == "Clear Day" then
		Lighting.Brightness = 3; Lighting.ClockTime = 14; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(200, 200, 200); Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
		makeSunRays(0.1, 0.5)

	elseif preset == "Vaporwave Dream" then
		Lighting.Brightness = 2.2; Lighting.ClockTime = 16; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(255, 150, 255); Lighting.OutdoorAmbient = Color3.fromRGB(200, 120, 200)
		makeSky(3000); makeCC(Color3.fromRGB(255, 180, 255), 0.05, 0.4)

	elseif preset == "Midnight Blue" then
		Lighting.Brightness = 1.2; Lighting.ClockTime = 0; Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.fromRGB(80, 80, 140); Lighting.OutdoorAmbient = Color3.fromRGB(60, 60, 120)
		local sky = Instance.new("Sky")
		sky.Name = "Inferno_Sky"
		sky.SkyboxBk = "http://www.roblox.com/asset/?id=159454299"
		sky.SkyboxDn = "http://www.roblox.com/asset/?id=159454296"
		sky.SkyboxFt = "http://www.roblox.com/asset/?id=159454293"
		sky.SkyboxLf = "http://www.roblox.com/asset/?id=159454286"
		sky.SkyboxRt = "http://www.roblox.com/asset/?id=159454300"
		sky.SkyboxUp = "http://www.roblox.com/asset/?id=159454288"
		sky.StarCount = 5000; sky.Parent = Lighting
		makeBloom(0.8, 24, 0.8)
	end
end
local skyLoopEnabled = false
local skyLoopIndex   = 1
local SKY_LOOP_LIST  = {
"Sunset Paradise", "Golden Hour", "Warm Summer", "Pink Dream",
"Orange Glow", "Coral Sunset", "Clear Day", "Vaporwave Dream", "Midnight Blue",
}
-- Re-apply / cycle skies every second
task.spawn(function()
while task.wait(1) do
if not instance.active then break end
if skyLoopEnabled then
ApplySky(SKY_LOOP_LIST[skyLoopIndex])
skyLoopIndex = skyLoopIndex % #SKY_LOOP_LIST + 1
elseif currentSkyPreset ~= "Default" then
if not Lighting:FindFirstChild("Inferno_Sky") then
ApplySky(currentSkyPreset)
end
end
end
end)
-- ─────────────────────────────────────────────────────────────────────────────
local function clipEnhanceObj(obj)
if not S.potatoEnabled then return end
local t = obj.ClassName
if t == "ParticleEmitter" or t == "Trail" or t == "Beam"
or t == "Fire" or t == "Smoke" or t == "Sparkles"
or t == "Texture" then
obj:Destroy()
end
end
workspace.DescendantAdded:Connect(function(obj)
task.defer(function() clipEnhanceObj(obj) end)
end)
-- Scans workspace for the nearest Football — called at most every 0.3 s
local function refreshBallCache()
local nearest, nearestDist = nil, math.huge
if not hrp then return end
for _, obj in pairs(workspace:GetDescendants()) do
if obj.Name == "Football" and obj:IsA("BasePart") then
local dist = (obj.Position - hrp.Position).Magnitude
if dist < nearestDist then
nearest     = obj
nearestDist = dist
end
end
end
S.cachedBall = nearest
end
-- ── Ball Manipulation helpers ─────────────────────────────────────────────────
local function characterHasFootball(c, football)
if not c then return false end
for _, desc in ipairs(c:GetDescendants()) do
if desc:IsA("Weld") or desc:IsA("Motor6D") or desc:IsA("WeldConstraint") then
if desc.Part0 and desc.Part1 then
if desc.Part0.Name == "Football" or desc.Part1.Name == "Football" then
return true
end
end
end
end
for _, child in ipairs(c:GetChildren()) do
if child:IsA("Tool") then
local handle = child:FindFirstChild("Handle")
if handle and handle.Name == "Football" then return true end
end
end
if football then
for _, desc in ipairs(football:GetDescendants()) do
if desc:IsA("Weld") or desc:IsA("Motor6D") or desc:IsA("WeldConstraint") then
if desc.Part0 and desc.Part1 then
if desc.Part0.Parent == c or desc.Part1.Parent == c then
return true
end
end
end
end
end
return false
end
local function localHasFootball()
return characterHasFootball(char, S.cachedBall)
end
local function anyOtherHasFootball(football)
for _, plr in ipairs(Players:GetPlayers()) do
if plr ~= player then
local c = plr.Character
if c and characterHasFootball(c, football) then return true end
end
end
return false
end
local function findFootballSpeed()
for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
if v.Name == "FootballSpeed" and v:IsA("NumberValue") then
S.footballSpeed = v; return
end
end
end
findFootballSpeed()
ReplicatedStorage.DescendantAdded:Connect(function(v)
if not S.footballSpeed and v.Name == "FootballSpeed" and v:IsA("NumberValue") then
S.footballSpeed = v
end
end)
-- ─────────────────────────────────────────────────────────────────────────────
RunService.Stepped:Connect(function(_, dt)
if not instance.active then return end
-- Noclip: throttled to every 0.1 s — was running every physics step
if S.noclipEnabled and char then
S.noclipTimer = S.noclipTimer + dt
if S.noclipTimer >= 0.1 then
S.noclipTimer = 0
for _, p in pairs(char:GetDescendants()) do
if p:IsA("BasePart") then p.CanCollide = false end
end
end
end
-- Ball cache: only scan workspace when the ball is gone or every 0.3 s
	local needsBall = (S.pullVecEnabled and S.pullVecHeld) or S.orbEnabled
		or (S.cfMagsEnabled and S.magsHeld) or S.orbMagsEnabled
	if needsBall then
		if not S.cachedBall or not S.cachedBall.Parent then
			refreshBallCache()
			S.ballSearchTimer = 0.3
		else
			S.ballSearchTimer = S.ballSearchTimer - dt
			if S.ballSearchTimer <= 0 then
				refreshBallCache()
				S.ballSearchTimer = 0.3
			end
		end
	end

	local nearest     = S.cachedBall
	local nearestDist = (nearest and hrp) and (nearest.Position - hrp.Position).Magnitude or math.huge

	-- Frame-rate-independent lerp alpha (same feel at any FPS)
	local alpha = 1 - (1 - math.clamp(S.pullVecSmooth, 0.01, 0.99)) ^ (dt * 60)

	-- Pull Orb visuals + orb pull
	if S.orbEnabled and nearest then
		if not S.orbPart or not S.orbPart.Parent then
			S.orbPart              = Instance.new("Part")
			S.orbPart.Name         = "NexusOrb"
			S.orbPart.Shape        = Enum.PartType.Ball
			S.orbPart.Anchored     = true
			S.orbPart.CanCollide   = false
			S.orbPart.CastShadow   = false
			S.orbPart.Massless     = true
			S.orbPart.Color        = S.orbColor
			S.orbPart.Transparency = S.orbTransparency
			S.orbPart.Material     = Enum.Material.ForceField
			S.orbPart.Size         = Vector3.new(S.orbRadius * 2, S.orbRadius * 2, S.orbRadius * 2)
			S.orbPart.Parent       = workspace
		end
		S.orbPart.CFrame       = CFrame.new(nearest.Position)
		S.orbPart.Color        = S.orbColor
		S.orbPart.Transparency = S.orbTransparency
		S.orbPart.Size         = Vector3.new(S.orbRadius * 2, S.orbRadius * 2, S.orbRadius * 2)

		if hrp and nearestDist <= S.orbRadius then
			local headHeight  = 3
			local forwardBias = 15
			local ballVel = nearest.AssemblyLinearVelocity
			local flatVel = Vector3.new(ballVel.X, 0, ballVel.Z)
			local target
			if flatVel.Magnitude > 2 then
				target = nearest.Position + Vector3.new(0, -headHeight, 0) + flatVel.Unit * forwardBias
			else
				target = nearest.Position - Vector3.new(0, headHeight, 0)
			end
			hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity:Lerp(
				(target - hrp.Position).Unit * S.pullVecStrength, alpha)
		end
	elseif S.orbPart and S.orbPart.Parent then
		S.orbPart:Destroy()
		S.orbPart = nil
	end

	-- CFrame Mags (reuses cached ball — no extra scan)
	-- CFrame Mags — claim ownership every held frame so writes are authoritative
	if S.cfMagsEnabled and S.magsHeld and hrp and nearest then
		local head = char and char:FindFirstChild("Head")
		if head then
			claimBallOwnership(nearest)
			nearest.CFrame                  = CFrame.new(head.Position)
			nearest.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
			nearest.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			nearest.CanCollide              = false
		end
	end

	-- Orb Mags — same ownership treatment
	if S.orbMagsEnabled and S.orbEnabled and hrp and nearest then
		local head = char and char:FindFirstChild("Head")
		if nearestDist <= S.orbRadius and head then
			claimBallOwnership(nearest)
			nearest.CFrame                  = CFrame.new(head.Position)
			nearest.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
			nearest.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			nearest.CanCollide              = false
		end
	end

	-- Pull Vec
	if S.pullVecEnabled and S.pullVecHeld and hrp and nearest then
		local headHeight  = 3
		local forwardBias = 15
		local ballVel = nearest.AssemblyLinearVelocity
		local flatVel = Vector3.new(ballVel.X, 0, ballVel.Z)
		local target
		if flatVel.Magnitude > 2 then
			target = nearest.Position + Vector3.new(0, -headHeight, 0) + flatVel.Unit * forwardBias
		else
			target = nearest.Position - Vector3.new(0, headHeight, 0)
		end
		local toTarget = target - hrp.Position
		local dist     = toTarget.Magnitude
		if dist > 2 then
			hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity:Lerp(
				toTarget.Unit * S.pullVecStrength, alpha)
		else
			hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
		end
	end
end)
local function rocketBoost()
if S.rocketActive or S.rocketCooldown or not hum then return end
S.rocketActive   = true
S.rocketCooldown = true
local conn = RunService.RenderStepped:Connect(function()
if hum then hum.WalkSpeed = S.rocketSpeed end
end)
task.delay(S.rocketDuration, function()
conn:Disconnect()
if hum then hum.WalkSpeed = S.walkSpeed end
S.rocketActive = false
task.delay(0.25, function() S.rocketCooldown = false end)
end)
end
RunService.RenderStepped:Connect(function()
if not instance.active then return end
if hum and not S.rocketActive then
if S.walkSpeedLock and hum.WalkSpeed ~= S.walkSpeed then
hum.WalkSpeed = S.walkSpeed
end
end
end)
local followEnabled  = false
local followTarget   = nil
local ctrlFollow     = Enum.KeyCode.DPadRight
local followKey      = Enum.KeyCode.F
-- ── Sticky Head keybinds ──────────────────────────────────────────────────────
local ctrlStickyHead = Enum.KeyCode.ButtonR1
local stickyHeadKey  = Enum.KeyCode.Unknown
-- ─────────────────────────────────────────────────────────────────────────────
local function getNearestPlayer()
local nearest, nearestDist = nil, math.huge
for _, plr in pairs(Players:GetPlayers()) do
if plr == player then continue end
local c = plr.Character
local root = c and c:FindFirstChild("HumanoidRootPart")
if not root then continue end
local dist = (root.Position - hrp.Position).Magnitude
if dist < nearestDist then
nearest = plr
nearestDist = dist
end
end
return nearest
end
local function toggleFollow()
if followEnabled then
followEnabled = false
followTarget  = nil
if hum then hum:MoveTo(hrp.Position) end
WindUI:Notify({ Title = "Inferno Hub", Content = "Follow off", Duration = 2, Icon = "flame" })
else
followTarget = getNearestPlayer()
if followTarget then
followEnabled = true
WindUI:Notify({ Title = "Inferno Hub", Content = "Following: " .. followTarget.Name, Duration = 2, Icon = "flame" })
else
WindUI:Notify({ Title = "Inferno Hub", Content = "No players found", Duration = 2, Icon = "flame" })
end
end
end
-- ── Master Heartbeat ─────────────────────────────────────────────────────────
-- All per-frame logic in ONE connection — avoids firing 5 separate loops at 60fps
-- and computes isBeingBoosted() once, shared across all boost features.
local gloveRefreshTimer = 0
local greyPixelTimer    = 0
RunService.Heartbeat:Connect(function(dt)
if not instance.active then return end
-- ── Follow ──────────────────────────────────────────────────────────────
if followEnabled and followTarget and hrp and hum then
local c    = followTarget.Character
local root = c and c:FindFirstChild("HumanoidRootPart")
if not root then
followEnabled = false
followTarget  = nil
WindUI:Notify({ Title = "Inferno Hub", Content = "Follow target lost", Duration = 2, Icon = "user-x" })
else
hum:MoveTo(root.Position)
end
end
if not hrp then return end

	-- ── Boost Amp (delta-based, no player scan needed) ──────────────────────
	local currentY = hrp.AssemblyLinearVelocity.Y
	local delta    = currentY - lastYVelocity

	if boostAmpEnabled and delta > 10 and not boostAmpFired then
		boostAmpFired = true
		hrp.AssemblyLinearVelocity = Vector3.new(
			hrp.AssemblyLinearVelocity.X,
			currentY * boostAmpMultiplier,
			hrp.AssemblyLinearVelocity.Z)
		task.delay(0.3, function() boostAmpFired = false end)
	end

	lastYVelocity = currentY

	-- ── Gloves: enforce size every 0.5 s only ───────────────────────────────
	-- Catching is handled on RenderStepped (before physics) below
	if S.glovesEnabled then
		gloveRefreshTimer = gloveRefreshTimer + dt
		if gloveRefreshTimer >= 0.5 then
			gloveRefreshTimer = 0
			applyGloves()
		end
	end

	-- ── Pixel Faces: throttled to every 5 s ────────────────────────────────
	if pixelFacesEnabled then
		greyPixelTimer = greyPixelTimer + dt
		if greyPixelTimer >= 5 then
			greyPixelTimer = 0
			applyPixelFaces()
		end
	end

	-- ── Ball Manipulation ────────────────────────────────────────────────────
	if (S.ballMagEnabled or S.ballRangeEnabled) and hrp then
		local ball = S.cachedBall
		if ball and ball.Parent then
			local dist = (hrp.Position - ball.Position).Magnitude

			if S.ballRangeEnabled and S.footballSpeed then
				S.footballSpeed.Value = dist <= S.ballSpeedRange and S.ballBoostedSpeed or S.ballDefaultSpeed
			end

			if S.ballMagEnabled and not localHasFootball() and not anyOtherHasFootball(ball) then
				if dist <= S.ballMagRange then
					ball.CanCollide              = false
					ball.AssemblyAngularVelocity = Vector3.zero
					claimBallOwnership(ball)

					local targetHand, bestDist = nil, math.huge
					for _, name in ipairs({ "RightHand", "LeftHand", "Right Arm", "Left Arm" }) do
						local hand = char and char:FindFirstChild(name)
						if hand then
							local d = (ball.Position - hand.Position).Magnitude
							if d < bestDist then bestDist = d; targetHand = hand end
						end
					end

					local targetPos = targetHand
						and (targetHand.CFrame * CFrame.new(0, 0.35, -0.25)).Position
						or  (hrp.Position + hrp.CFrame.LookVector * 3 + Vector3.new(0, 2.5, 0))

					local toTarget = targetPos - ball.Position
					if toTarget.Magnitude < S.ballSnapDist then
						ball.CFrame                 = CFrame.new(targetPos)
						ball.AssemblyLinearVelocity = Vector3.zero
					else
						local t      = tick()
						local jitter = Vector3.new(
							math.sin(t * S.ballJitterFreq * 1.6) * S.ballJitterAmp * 0.2,
							math.sin(t * S.ballJitterFreq)       * S.ballJitterAmp,
							math.cos(t * S.ballJitterFreq * 1.3) * S.ballJitterAmp * 0.2
						)
						ball.AssemblyLinearVelocity = toTarget.Unit * S.ballPullStrength + jitter
					end
				end
			end
		end
	end

	-- ── Head Manipulation ────────────────────────────────────────────────────
	-- When falling from a high jump (Y crosses from > 12 down to ≤ 2),
	-- steer horizontally toward the nearest head within 25 studs
	if S.headManipEnabled and hrp then
		local curY = hrp.AssemblyLinearVelocity.Y
		if curY <= 2 and lastYVelocity > 12 then
			local nearestHead, shortestDist = nil, math.huge
			for _, other in ipairs(Players:GetPlayers()) do
				if other ~= player and other.Character then
					local h = other.Character:FindFirstChild("Head")
					if h then
						local dist = (hrp.Position - h.Position).Magnitude
						if dist < shortestDist and dist < 25 then
							shortestDist = dist; nearestHead = h
						end
					end
				end
			end
			if nearestHead then
				local targetPos = nearestHead.Position + Vector3.new(0, 2.5, 0)
				local dir       = (targetPos - hrp.Position).Unit
				local force     = dir * (S.headStrength * 65)
				hrp.AssemblyLinearVelocity = Vector3.new(
					hrp.AssemblyLinearVelocity.X * 0.4 + force.X,
					hrp.AssemblyLinearVelocity.Y,
					hrp.AssemblyLinearVelocity.Z * 0.4 + force.Z
				)
			end
		end
	end

	-- ── Jump Pull Vec ────────────────────────────────────────────────────────
	-- Auto-holds pull vec while the player is airborne and rising after a jump
	if S.jumpPullEnabled and S.pullVecEnabled and hrp and hum then
		local inAir = hum.FloorMaterial == Enum.Material.Air
		if inAir and hrp.AssemblyLinearVelocity.Y > 3 and not S.jumpPullActive then
			S.jumpPullActive = true
			S.pullVecHeld    = true
		elseif not inAir and S.jumpPullActive then
			S.jumpPullActive = false
			S.pullVecHeld    = false
		end
	end
end)
-- ─────────────────────────────────────────────────────────────────────────────
boostAmpEnabled    = false
boostAmpMultiplier = 2
lastYVelocity      = 0
boostAmpFired      = false
-- ── Fling / Auto Boost / Fling Up — Touched-event head detection ─────────────
local flingEnabled     = false
local flingPower       = 150
local autoBoostEnabled = false
local autoBoostFired   = false
local flingUpEnabled   = false
local flingUpFired     = false
local headConnections  = {}
local function connectHeadTouch(head)
if not head or not head:IsA("BasePart") then return end
if headConnections[head] then return end
local conn = head.Touched:Connect(function(hit)
		if not hrp or hit ~= hrp then return end
		if hrp.Position.Y <= head.Position.Y + 0.3 then return end

		-- Auto Boost: straight up using S.boostPower
		if autoBoostEnabled and not autoBoostFired then
			autoBoostFired = true
			hrp.AssemblyLinearVelocity = Vector3.new(
				hrp.AssemblyLinearVelocity.X, S.boostPower, hrp.AssemblyLinearVelocity.Z)
			task.delay(0.3, function() autoBoostFired = false end)
		end

		-- Fling: diagonal — upward + away from the head
		if flingEnabled then
			local flat = Vector3.new(
				hrp.Position.X - head.Position.X, 0, hrp.Position.Z - head.Position.Z)
			local dir = flat.Magnitude > 0 and flat.Unit or Vector3.new(1, 0, 0)
			hrp.AssemblyLinearVelocity = Vector3.new(
				dir.X * flingPower, flingPower * 0.8, dir.Z * flingPower)
		end

		-- Fling Up (Kickup): boost up + single fast spin
		if flingUpEnabled and not flingUpFired then
			flingUpFired = true
			hrp.AssemblyLinearVelocity = Vector3.new(
				hrp.AssemblyLinearVelocity.X, S.boostPower, hrp.AssemblyLinearVelocity.Z)
			local rotated = 0
			local spinConn
			spinConn = RunService.RenderStepped:Connect(function(dt2)
				if not hrp or rotated >= math.pi * 2 then
					spinConn:Disconnect()
					if hrp then hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0) end
					task.delay(0.3, function() flingUpFired = false end)
					return
				end
				local step = math.pi * 16 * dt2
				rotated    = rotated + step
				hrp.AssemblyAngularVelocity = Vector3.new(0, 200, 0)
				hrp.CFrame = hrp.CFrame * CFrame.Angles(0, step, 0)
			end)
		end
	end)

	headConnections[head] = conn
	head.AncestryChanged:Connect(function(_, parent)
		if not parent and headConnections[head] then
			headConnections[head]:Disconnect()
			headConnections[head] = nil
		end
	end)
end
local function setupHeadBoosts()
for _, plr in pairs(Players:GetPlayers()) do
if plr ~= player and plr.Character then
local head = plr.Character:FindFirstChild("Head")
if head then connectHeadTouch(head) end
plr.CharacterAdded:Connect(function(c)
task.wait(0.5)
local newHead = c:FindFirstChild("Head")
if newHead then connectHeadTouch(newHead) end
end)
end
end
end
setupHeadBoosts()
Players.PlayerAdded:Connect(function(plr)
plr.CharacterAdded:Connect(function()
task.wait(0.5)
setupHeadBoosts()
end)
end)
-- ─────────────────────────────────────────────────────────────────────────────
-- ── Gloves — RenderStepped catcher (runs BEFORE physics each frame) ───────────
-- Heartbeat fires after physics so fast balls skip past. RenderStepped catches
-- them before they move. Also does predictive interception for far/fast throws.
local PRE_CLAIM_RADIUS = 22   -- studs — start asserting ownership early
local SNAP_RADIUS_MULT = 1.2  -- multiplier on S.gloveSize for final snap
local PREDICT_SECS     = 0.35 -- how far ahead (seconds) to look for intercept
RunService.RenderStepped:Connect(function()
if not instance.active then return end
if not S.glovesEnabled or not char or not hrp then return end
local ball = S.cachedBall
if not ball or not ball.Parent then return end
local ballPos  = ball.Position
	local ballVel  = ball.AssemblyLinearVelocity
	local speed    = ballVel.Magnitude
	-- Faster balls get a bigger snap window
	local snapR    = S.gloveSize * SNAP_RADIUS_MULT + speed * 0.05
	local hands    = getHands(char)

	-- Find the closest hand once (used for steering)
	local closestHand, closestDist = nil, math.huge
	for _, hand in ipairs(hands) do
		if hand:IsA("BasePart") then
			local d = (ballPos - hand.Position).Magnitude
			if d < closestDist then closestHand = hand; closestDist = d end
		end
	end
	if not closestHand then return end

	-- Pre-claim zone: assert ownership, disable CanCollide,
	-- and gently steer + dampen the ball toward the hand
	if closestDist <= PRE_CLAIM_RADIUS then
		claimBallOwnership(ball)
		pcall(function() ball.CanCollide = false end)

		if closestDist > snapR and speed > 1 then
			local toHand   = (closestHand.Position - ballPos).Unit
			-- Blend velocity toward hand direction (15 % per frame) — subtle guide
			local steered  = ballVel:Lerp(toHand * speed, 0.15)
			-- Dampen speed slightly so there's more time to register the catch
			local damped   = steered * 0.97
			pcall(function() ball.AssemblyLinearVelocity = damped end)
		end
	end

	-- Current-position snap
	if closestDist <= snapR then
		catchBall(ball, closestHand)
		return
	end

	-- Predictive intercept along trajectory
	if speed > 2 then
		local toHand = closestHand.Position - ballPos
		local t      = math.clamp(toHand:Dot(ballVel) / (speed * speed), 0, PREDICT_SECS)
		local future = ballPos + ballVel * t
		if (future - closestHand.Position).Magnitude <= snapR * 1.4 then
			catchBall(ball, closestHand)
		end
	end
end)
-- ─────────────────────────────────────────────────────────────────────────────
local hitboxSize         = 2
local hitboxTransparency = 0.5
local originalHitboxes   = {}
local function applyHitbox(otherPlayer)
if not otherPlayer.Character then return end
local otherHRP = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
if not otherHRP then return end
if not originalHitboxes[otherPlayer.UserId] then
originalHitboxes[otherPlayer.UserId] = {
Size         = otherHRP.Size,
Transparency = otherHRP.Transparency,
}
end
otherHRP.Size         = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
otherHRP.Transparency = hitboxTransparency
end
local function restoreHitbox(otherPlayer)
if not otherPlayer.Character then return end
local otherHRP = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
if otherHRP and originalHitboxes[otherPlayer.UserId] then
local orig = originalHitboxes[otherPlayer.UserId]
otherHRP.Size         = orig.Size
otherHRP.Transparency = orig.Transparency
end
end
local function refreshAllHitboxes()
for _, plr in pairs(Players:GetPlayers()) do
if plr ~= player then
if hitboxEnabled then applyHitbox(plr) else restoreHitbox(plr) end
end
end
end
Players.PlayerAdded:Connect(function(plr)
plr.CharacterAdded:Connect(function()
task.wait(1)
if hitboxEnabled then applyHitbox(plr) end
end)
end)
for _, plr in pairs(Players:GetPlayers()) do
if plr ~= player then
plr.CharacterAdded:Connect(function()
task.wait(1)
if hitboxEnabled then applyHitbox(plr) end
end)
end
end
function getHands(c)
if c:FindFirstChild("RightHand") then
return { c.RightHand, c.LeftHand }
elseif c:FindFirstChild("Right Arm") then
return { c["Right Arm"], c["Left Arm"] }
end
return {}
end
local cachedPlayer = nil
local function setOwner(hand, player)
local ok = pcall(hand.SetNetworkOwner, hand, player)
if not ok then
pcall(hand.SetNetworkOwner, hand, nil)
end
end
-- ── Gloves — Network Ownership ───────────────────────────────────────────────
-- Claims physics authority over the ball so THIS client moves it, not the server.
-- Without ownership the CFrame writes race against the server and lose.
function claimBallOwnership(ball)
if not ball or not ball.Parent then return end
-- Try to take ownership; fall back to server-owned (nil) if the game blocks it
local ok = pcall(function() ball:SetNetworkOwner(player) end)
if not ok then pcall(function() ball:SetNetworkOwner(nil) end) end
end
function catchBall(ball, hand)
claimBallOwnership(ball)
task.defer(function()
if not ball or not ball.Parent then return end
-- Use head position if available — game registers catches via head contact
local head   = char and char:FindFirstChild("Head")
local target = head and head.Position or hand.Position
ball.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
ball.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
ball.CanCollide              = false
ball.CFrame                  = CFrame.new(target)
-- Re-assert ownership + position for 4 frames so the server can't take it back
for i = 1, 4 do
task.delay(i / 60, function()
if not ball or not ball.Parent then return end
claimBallOwnership(ball)
ball.CFrame                  = CFrame.new(target)
ball.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
ball.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
ball.CanCollide              = false
end)
end
end)
end
local gloveConnections = {}
local function disconnectGloveConnections()
for _, conn in pairs(gloveConnections) do pcall(conn.Disconnect, conn) end
gloveConnections = {}
end
local function connectGloveTouched(hand)
if gloveConnections[hand] then
pcall(gloveConnections[hand].Disconnect, gloveConnections[hand])
end
gloveConnections[hand] = hand.Touched:Connect(function(hit)
if not S.glovesEnabled then return end
if hit.Name == "Football" and hit:IsA("BasePart") then
catchBall(hit, hand)
end
end)
end
function applyGloves()
if not char then return end
for _, hand in ipairs(getHands(char)) do
if hand:IsA("BasePart") then
if not S.originalHandSizes[hand] then
S.originalHandSizes[hand] = {
Size         = hand.Size,
Material     = hand.Material,
Color        = hand.Color,
Transparency = hand.Transparency,
CanCollide   = hand.CanCollide,
Massless     = hand.Massless,
}
end
hand.Size         = Vector3.new(S.gloveSize, S.gloveSize, S.gloveSize)
hand.Material     = Enum.Material.ForceField
hand.Color        = Color3.fromRGB(255, 70, 70)
hand.Transparency = S.glovesInvisible and 1 or 0.4
hand.CanCollide   = false
hand.Massless     = true
hand.CanTouch     = true
-- Re-assert ownership of the hand every refresh
pcall(function() hand:SetNetworkOwner(player) end)
connectGloveTouched(hand)
end
end
end
Players.PlayerAdded:Connect(function(plr)
cachedPlayer = plr
plr.CharacterAdded:Connect(function(character)
for _, name in ipairs({ "LeftHand", "RightHand", "Left Arm", "Right Arm" }) do
local part = character:FindFirstChild(name)
if part then pcall(function() part:SetNetworkOwner(plr) end) end
end
end)
end)
local function removeGloves()
disconnectGloveConnections()
if not char then return end
for _, hand in ipairs(getHands(char)) do
if not hand:IsA("BasePart") then continue end
local original = S.originalHandSizes[hand]
if not original then continue end
hand.Size         = original.Size
hand.Material     = original.Material
hand.Color        = original.Color
hand.Transparency = original.Transparency
hand.CanCollide   = original.CanCollide
hand.Massless     = original.Massless
pcall(function() hand:SetNetworkOwner(nil) end)
end
end
-- ─────────────────────────────────────────────────────────────────────────────
player.CharacterAdded:Connect(function()
task.wait(1)
S.originalHandSizes = {}
if S.glovesEnabled then applyGloves() end
end)
local divePowerConn = nil
local function updateDivePower(power)
local gameId = player:FindFirstChild("Replicated") and player.Replicated:FindFirstChild("GameID")
if not gameId then return end
local gid = gameId.Value
for _, folderName in ipairs({ "Games", "MiniGames" }) do
local mainFolder = ReplicatedStorage:FindFirstChild(folderName)
if mainFolder then
local gameFolder = mainFolder:FindFirstChild(gid)
if gameFolder then
local gameParams = gameFolder:FindFirstChild("GameParams")
if gameParams then
local dp = gameParams:FindFirstChild("DivePower")
if dp and dp:IsA("NumberValue") then
dp.Value = power
if divePowerConn then divePowerConn:Disconnect() end
divePowerConn = dp:GetPropertyChangedSignal("Value"):Connect(function()
if dp.Value ~= power then dp.Value = power end
end)
end
end
end
end
end
end
local currentAnimTrack = nil
local EMOTES = {
{ name = "BBS",         id = "rbxassetid://83690407262789",  speed = 1.25 },
{ name = "BOP",         id = "rbxassetid://8028669437",      speed = 1    },
{ name = "Hackers",     id = "rbxassetid://10714364213",     speed = 1    },
{ name = "HD",          id = "rbxassetid://133666867152446", speed = 1    },
{ name = "TTL",         id = "rbxassetid://125578981255289", speed = 1    },
{ name = "NH",          id = "rbxassetid://83345430870757",  speed = 1    },
{ name = "CCL",         id = "rbxassetid://107875941017127", speed = 1    },
{ name = "Penguin",     id = "rbxassetid://5439075558",      speed = 1    },
{ name = "Worm",        id = "rbxassetid://133640711863790", speed = 1    },
{ name = "Griddy",      id = "rbxassetid://8028694339",      speed = 1    },
{ name = "Sam Slash",   id = "rbxassetid://15249657798",     speed = 1    },
{ name = "Dimension",   id = "rbxassetid://5618747341",      speed = 1    },
{ name = "Ballspin",    id = "rbxassetid://14215798544",     speed = 1    },
{ name = "Thug",        id = "rbxassetid://13550466835",     speed = 1    },
{ name = "Inner Child", id = "rbxassetid://14215788817",     speed = 1    },
{ name = "Sturdy",      id = "rbxassetid://14215791622",     speed = 1    },
{ name = "Smith Knicks",id = "rbxassetid://15312473847",     speed = 1    },
{ name = "Mop",         id = "rbxassetid://14215807283",     speed = 1    },
{ name = "MPG",         id = "rbxassetid://14138482621",     speed = 1    },
{ name = "Moon",        id = "rbxassetid://14216002323",     speed = 1    },
{ name = "Eagle Flap",  id = "rbxassetid://2293380203",      speed = 1    },
{ name = "PPJT",        id = "rbxassetid://5433555683",      speed = 1    },
{ name = "Headless",    id = "rbxassetid://5704065738",      speed = 1    },
{ name = "Druski",      id = "rbxassetid://14901504235",     speed = 1    },
{ name = "Keep it hot", id = "http://www.roblox.com/asset/?id=85267023718407", speed = 1 },
{ name = "Silencer",    id = "rbxassetid://15249654202",     speed = 1    },
{ name = "Reanimated",  id = "rbxassetid://2293388847",      speed = 1    },
{ name = "Money Hop Switch", id = "rbxassetid://132555082396072", speed = 1 },
{ name = "Turbulence",  id = "rbxassetid://13643188123",     speed = 1    },
}
local function stopEmote()
if currentAnimTrack then
currentAnimTrack:Stop()
currentAnimTrack:Destroy()
currentAnimTrack = nil
end
end
local function playEmote(id, speed)
stopEmote()
if not hum then return end
local anim = Instance.new("Animation")
anim.AnimationId = id
local ok, track = pcall(function() return hum:LoadAnimation(anim) end)
if ok and track then
currentAnimTrack = track
track.Looped = true
track:Play()
track:AdjustSpeed(speed or 1)
end
end
local equippedItems = {}
local ITEMS = {
Coldstare    = { mesh = "rbxassetid://5028704943",     texture = "rbxassetid://5047708728",     parent = "UpperTorso", scale = Vector3.new(1,1,1),          offset = CFrame.new(0,0.15,0.65)    * CFrame.Angles(0,math.rad(180),0) },
DesertVest   = { mesh = "rbxassetid://11755494017",    texture = "rbxassetid://11755494031",    parent = "UpperTorso", scale = Vector3.new(0.73,1.13,0.75),  offset = CFrame.new(0,0,-0.05) },
DRC          = { mesh = "rbxassetid://6541224713",     texture = "rbxassetid://7833727918",     parent = "Head",       scale = Vector3.new(1.01,1.01,1.01),  offset = CFrame.new(0,0.8,0.15)     * CFrame.Angles(0,math.rad(90),0)  },
DesignerKeff = { mesh = "rbxassetid://14156626934", texture = "rbxassetid://14156781317", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(-0.05,0.41,0.15) * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)) },
PinkScene    = { mesh = "rbxassetid://73581570515279", texture = "rbxassetid://86617487565011", parent = "Head",       scale = Vector3.new(0.95,0.95,0.95),  offset = CFrame.new(-0.1,0.1,0.2)   * CFrame.Angles(0,math.rad(180),0) },
SeeingStars  = { mesh = "rbxassetid://62139052",       texture = "rbxassetid://62139103",       parent = "Head",       scale = Vector3.new(1.05,1.05,1.05),  offset = CFrame.new(0,0.05,-0.45) },
SubarcticCommando = { mesh = "http://www.roblox.com/asset/?id=39200112", texture = "http://www.roblox.com/asset/?id=39200088", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0.15,0) },
TacticalVest = { mesh = "rbxassetid://11754584493",    texture = "rbxassetid://11754584535",    parent = "UpperTorso", scale = Vector3.new(0.73,1.13,0.75),  offset = CFrame.new(0,0,-0.05)      * CFrame.Angles(0,math.rad(180),0) },
WhiteTowel   = { mesh = "rbxassetid://6919149797",     texture = "rbxassetid://6923948446",     parent = "LowerTorso", scale = Vector3.new(1,1,1),           offset = CFrame.new(0.55,-0.65,-0.15)*CFrame.Angles(0,math.rad(90),0) },
LavaScene    = { mesh = "http://www.roblox.com/asset/?id=83490415", texture = "http://www.roblox.com/asset/?id=83491029", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(-0.1,0.1,0.2) },
KingCape     = { mesh = "rbxassetid://7547683590",     texture = "rbxassetid://7547692544",     parent = "UpperTorso", scale = Vector3.new(1,1,1),           offset = CFrame.new(0,-0.85,0.7) },
KingCrown    = { mesh = "rbxassetid://2180251969",     texture = "rbxassetid://2180251094",     parent = "Head",       scale = Vector3.new(1,1,1),           offset = CFrame.new(0,1,0) },
GravBeanie   = { mesh = "rbxassetid://14310737075",    texture = "rbxassetid://15591009630",    parent = "Head",       scale = Vector3.new(1,1,1),           offset = CFrame.new(0,0.6,0)        * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0.05)) },
LAchrome     = { mesh = "rbxassetid://15498987026",    texture = "rbxassetid://15498997319",    parent = "Head",       scale = Vector3.new(1,1,1),           offset = CFrame.new(0,0.6,-0.2) },
Ush          = { mesh = "rbxassetid://12710398184",    texture = "rbxassetid://12710399814",    parent = "Head",       scale = Vector3.new(1,1,1),           offset = CFrame.new(0,0.3,0)        * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)) },
RedCW        = { mesh = "http://www.roblox.com/asset/?id=1577360", texture = "rbxassetid://1143320126",  parent = "Head", scale = Vector3.new(1,1.3,1),      offset = CFrame.new(0,0.25,-0.19)   * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0.05)) },
BlackCW      = { mesh = "http://www.roblox.com/asset/?id=1577360", texture = "http://www.roblox.com/asset/?id=1577349", parent = "Head", scale = Vector3.new(1,1.3,1), offset = CFrame.new(0,0.25,-0.19) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0.05)) },
PurpleCW     = { mesh = "http://www.roblox.com/asset/?id=1577360", texture = "rbxassetid://14296191274", parent = "Head", scale = Vector3.new(1,1.3,1),      offset = CFrame.new(0,0.25,-0.19)   * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0.05)) },
PoliceVest = { mesh = "rbxassetid://10692364338", texture = "rbxassetid://10691986674", parent = "UpperTorso", scale = Vector3.new(0.8,1.1,0.8), offset = CFrame.new(0,-0.05,0) * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)) },
ArcTacVest = { mesh = "rbxassetid://10714316724", texture = "rbxassetid://10714600858", parent = "UpperTorso", scale = Vector3.new(0.7,1,0.8), offset = CFrame.new(0,0,-0.1) },
ArticCommando = { mesh = "http://www.roblox.com/asset/?id=38965549", texture = "http://www.roblox.com/asset/?id=38965529", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0,0) },
GreyEvil = { mesh = "rbxassetid://14470653457", texture = "rbxassetid://14473920427", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0.41,0.1) * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0)) },
PilgrimHat = { mesh = "http://www.roblox.com/asset/?id=1223118", texture = "http://www.roblox.com/asset/?id=5671898", parent = "Head", scale = Vector3.new(1.7,1.7,1.7), offset = CFrame.new(0,1,0) },
y2kbluebeanie = { mesh = "rbxassetid://13870642930", texture = "rbxassetid://13870661669", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0.9,0) },
MonochromeMilitary = { mesh = "http://www.roblox.com/asset/?id=192571937 ", texture = "http://www.roblox.com/asset/?id=192571951 ", parent = "Head", scale = Vector3.new(1.4,1.4,1.4), offset = CFrame.new(0,0.4,0) },
MidnightCommando = { mesh = "http://www.roblox.com/asset/?id=38965549", texture = "http://www.roblox.com/asset/?id=259417739", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0,0) },
GasMask = { mesh = "rbxassetid://8928474817", texture = "rbxassetid://8927755382", parent = "Head", scale = Vector3.new(1,1,1), offset = CFrame.new(0,0,0) },
Snorkel = { mesh = "http://www.roblox.com/asset/?id=10547596", texture = "http://www.roblox.com/asset/?id=10517820", parent = "Head", scale = Vector3.new(1.05,1.05,1.05), offset = CFrame.new(0,0.2,0) },
}
local function equipItem(name)
if equippedItems[name] then return end
local data = ITEMS[name]
if not data then return end
local c = char
local parentPart = c and c:FindFirstChild(data.parent)
if not parentPart then return end
local part = Instance.new("Part")
part.Name = name; part.Size = Vector3.new(1,1,1)
part.CanCollide = false; part.Massless = true; part.Parent = c
local mesh = Instance.new("SpecialMesh")
mesh.MeshType = Enum.MeshType.FileMesh
mesh.MeshId = data.mesh; mesh.TextureId = data.texture
mesh.Scale = data.scale; mesh.Parent = part
local weld = Instance.new("Motor6D")
weld.Part0 = parentPart; weld.Part1 = part
weld.C0 = data.offset; weld.Parent = parentPart
part.CFrame = parentPart.CFrame * data.offset
equippedItems[name] = part
end
local function unequipItem(name)
if equippedItems[name] then
equippedItems[name]:Destroy()
equippedItems[name] = nil
end
end
player.CharacterAdded:Connect(function(c)
task.wait(1)
for name in pairs(equippedItems) do
equippedItems[name] = nil
equipItem(name)
end
end)
local CLOTHES = {
{ name = "All Star Shirt",  type = "shirt", id = "rbxassetid://104603634169771" },
{ name = "All Star Shorts", type = "pants", id = "rbxassetid://73939866847703"  },
{ name = "Black World Tour Shirt", type = "shirt", id = "rbxassetid://15335037852" },
{ name = "Pink World Tour Shirt", type = "shirt", id = "rbxassetid://15334978300" },
{ name = "King Shirt", type = "shirt", id = "rbxassetid://6296265575" },
{ name = "King Pants", type = "pants", id = "rbxassetid://10725550576" },
{ name = "Grey Flare", type = "shirt", id = "rbxassetid://15345367906" },
{ name = "Black Flare", type = "shirt", id = "rbxassetid://15345348842" },
{ name = "Red Flare", type = "shirt", id = "rbxassetid://15345347397" },
{ name = "Acid Flare", type = "shirt", id = "rbxassetid://15345352095" },
{ name = "Pastel Flare", type = "shirt", id = "rbxassetid://15345355082" },
{ name = "Orange Flare", type = "shirt", id = "rbxassetid://15345357354" },
{ name = "White World Tour", type = "shirt", id = "rbxassetid://15334975460" },
{ name = "Hooded Jean Jacket", type = "shirt", id = "rbxassetid://15334917844" },
}
local originalShirtTemplate  = ""
local originalPantsTemplate2 = ""
local shirtWatchConn         = nil
local pantsWatchConn         = nil
local activeShirtId          = nil
local activePantsId          = nil
local templateCache = {}
local function resolveTemplate(rawId, clothType)
local idNum = tostring(rawId):match("%d+")
if not idNum then return nil end
local cacheKey = clothType .. ":" .. idNum
	if templateCache[cacheKey] then
		return templateCache[cacheKey]
	end

	local wanted = (clothType == "shirt") and "Shirt" or "Pants"

	local ok, objects = pcall(function()
		return game:GetObjects("rbxassetid://" .. idNum)
	end)

	local resolved = "rbxassetid://" .. idNum
	if ok and objects and objects[1] then
		local asset = objects[1]
		local obj = asset:IsA(wanted) and asset or asset:FindFirstChildWhichIsA(wanted, true)
		if obj then
			resolved = (clothType == "shirt") and obj.ShirtTemplate or obj.PantsTemplate
		end
	end

	templateCache[cacheKey] = resolved
	return resolved
end
local function getShirt()
local username = player.Name
local ok, shirt = pcall(function() return workspace[username].SHIRT_WhiteTShirt end)
if ok and shirt then return shirt end
return nil
end
local function getJeans()
local username = player.Name
local ok, pants = pcall(function() return workspace[username].PANTS_STARTERGrayJeans end)
if ok and pants then return pants end
return nil
end
local function applyCloth(clothType, assetId)
local template = resolveTemplate(assetId, clothType)
if not template then
WindUI:Notify({ Title = "Inferno Hub", Content = "Could not resolve template id", Duration = 3, Icon = "flame" })
return false
end
if clothType == "shirt" then
		local shirt = getShirt()
		if not shirt then
			WindUI:Notify({ Title = "Inferno Hub", Content = "Shirt object not found", Duration = 3, Icon = "flame" })
			return false
		end
		if originalShirtTemplate == "" then originalShirtTemplate = shirt.ShirtTemplate end
		shirt.ShirtTemplate = template
		activeShirtId = template
		if shirtWatchConn then shirtWatchConn:Disconnect() end
		shirtWatchConn = shirt:GetPropertyChangedSignal("ShirtTemplate"):Connect(function()
			if activeShirtId and shirt.ShirtTemplate ~= activeShirtId then
				shirt.ShirtTemplate = activeShirtId
			end
		end)
		return true

	elseif clothType == "pants" then
		local pants = getJeans()
		if not pants then
			WindUI:Notify({ Title = "Inferno Hub", Content = "Pants object not found", Duration = 3, Icon = "flame" })
			return false
		end
		if originalPantsTemplate2 == "" then originalPantsTemplate2 = pants.PantsTemplate end
		pants.PantsTemplate = template
		activePantsId = template
		if pantsWatchConn then pantsWatchConn:Disconnect() end
		pantsWatchConn = pants:GetPropertyChangedSignal("PantsTemplate"):Connect(function()
			if activePantsId and pants.PantsTemplate ~= activePantsId then
				pants.PantsTemplate = activePantsId
			end
		end)
		return true
	end
end
local function resetCloth(clothType)
if clothType == "shirt" then
activeShirtId = nil
if shirtWatchConn then shirtWatchConn:Disconnect(); shirtWatchConn = nil end
local shirt = getShirt()
if shirt and originalShirtTemplate ~= "" then shirt.ShirtTemplate = originalShirtTemplate end
originalShirtTemplate = ""
elseif clothType == "pants" then
activePantsId = nil
if pantsWatchConn then pantsWatchConn:Disconnect(); pantsWatchConn = nil end
local pants = getJeans()
if pants and originalPantsTemplate2 ~= "" then pants.PantsTemplate = originalPantsTemplate2 end
originalPantsTemplate2 = ""
end
end
player.CharacterAdded:Connect(function()
task.wait(2)
originalShirtTemplate = ""
originalPantsTemplate2 = ""
if activeShirtId then applyCloth("shirt", activeShirtId) end
if activePantsId then applyCloth("pants", activePantsId) end
end)
local BANNERS = {
{ name = "50M Banner", id = "rbxassetid://13200847176" },
{ name = "Global",     id = "rbxassetid://13223858189" },
{ name = "Twitch CC",  id = "rbxassetid://13284240977" },
{ name = "YT CC",      id = "rbxassetid://13181356130" },
{ name = "Staff",      id = "rbxassetid://13284239964" },
{ name = "CC",         id = "rbxassetid://14308515186" },
}
local activeBannerId  = nil
local bannerWatchConn = nil
local function getBannerImage()
local ok, bi = pcall(function() return workspace[player.Name].StreetTag.BaseImage end)
return (ok and bi) or nil
end
local function applyBanner(assetId)
activeBannerId = assetId
local baseImage = getBannerImage()
if not baseImage then
WindUI:Notify({ Title = "Inferno Hub", Content = "StreetTag not found", Duration = 3, Icon = "flame" })
return
end
pcall(function() baseImage.Texture = assetId end)
pcall(function() baseImage.Image   = assetId end)
pcall(function() baseImage.Value   = assetId end)
-- Watch for the game resetting the banner — throttled to every 2 s
	if bannerWatchConn then bannerWatchConn:Disconnect() end
	local bannerTimer = 0
	bannerWatchConn = RunService.Heartbeat:Connect(function(dt)
		if not activeBannerId then bannerWatchConn:Disconnect(); return end
		bannerTimer = bannerTimer + dt
		if bannerTimer < 2 then return end
		bannerTimer = 0
		local bi = getBannerImage()
		if not bi then return end
		local cur = ""; pcall(function() cur = bi.Texture end)
		if cur ~= activeBannerId then
			pcall(function() bi.Texture = activeBannerId end)
			pcall(function() bi.Image   = activeBannerId end)
			pcall(function() bi.Value   = activeBannerId end)
		end
	end)
end
local function removeBanner()
activeBannerId = nil
if bannerWatchConn then bannerWatchConn:Disconnect(); bannerWatchConn = nil end
local baseImage = getBannerImage()
if baseImage then
pcall(function() baseImage.Texture = "" end)
pcall(function() baseImage.Image   = "" end)
pcall(function() baseImage.Value   = "" end)
end
end
player.CharacterAdded:Connect(function()
task.wait(2)
if activeBannerId then applyBanner(activeBannerId) end
end)
local INF_BANDANA_ID        = "rbxassetid://13604810806"
local bandanaActive         = false
local bandanaWatchConn      = nil
local originalPantsTemplate = ""
local function getPants()
local username = player.Name
local ok, pants = pcall(function() return workspace[username].PANTS_STARTERGrayJeans end)
if ok and pants then return pants end
return nil
end
local function applyInfBandana()
local pants = getPants()
if not pants then
WindUI:Notify({ Title = "Inferno Hub", Content = "Pants not found", Duration = 3, Icon = "flame" })
return false
end
if originalPantsTemplate == "" then
originalPantsTemplate = pants.PantsTemplate
end
pants.PantsTemplate = INF_BANDANA_ID
if bandanaWatchConn then bandanaWatchConn:Disconnect() end
bandanaWatchConn = pants:GetPropertyChangedSignal("PantsTemplate"):Connect(function()
if bandanaActive and pants.PantsTemplate ~= INF_BANDANA_ID then
pants.PantsTemplate = INF_BANDANA_ID
end
end)
return true
end
local function removeInfBandana()
bandanaActive = false
if bandanaWatchConn then bandanaWatchConn:Disconnect(); bandanaWatchConn = nil end
local pants = getPants()
if pants and originalPantsTemplate ~= "" then
pants.PantsTemplate = originalPantsTemplate
end
originalPantsTemplate = ""
end
player.CharacterAdded:Connect(function()
task.wait(2)
originalPantsTemplate = ""
if bandanaActive then applyInfBandana() end
end)
local shaderObjects  = {}
local shaderSkyColor = Color3.fromRGB(180, 210, 255)
local function removeShaders()
for _, obj in ipairs(shaderObjects) do pcall(function() obj:Destroy() end) end
shaderObjects = {}
end
local function removeAllStickyZones() S.stickyHeadZones = {} end
-- ── Sticky Head (obi_stick v2) ────────────────────────────────────────────────
local function stickyClosestPlayer()
local nearest
local dist = S.stickyHeadSize
for _, p in pairs(Players:GetPlayers()) do
if p ~= player and p.Character then
local phrp = p.Character:FindFirstChild("HumanoidRootPart")
local phum = p.Character:FindFirstChild("Humanoid")
if phrp and phum and phum.Health > 0 then
local d = (phrp.Position - hrp.Position).Magnitude
if d < dist then dist = d; nearest = p end
end
end
end
return nearest
end
RunService.RenderStepped:Connect(function(dt)
if not instance.active then return end
pcall(function()
if not S.stickyHeadEnabled or not hrp or not hum then return end
local target = stickyClosestPlayer()
if not target or not target.Character then return end
local head = target.Character:FindFirstChild("Head")
if not head then return end
if hum.FloorMaterial == Enum.Material.Air then
		local headPos = head.Position + Vector3.new(0, 1.6, 0)
		local offset  = headPos - hrp.Position
		local dist    = offset.Magnitude
		local vel     = hrp.AssemblyLinearVelocity

		local flatTarget = Vector3.new(headPos.X, hrp.Position.Y, headPos.Z)
		local targetCF   = CFrame.lookAt(hrp.Position, flatTarget)
		local alpha      = math.clamp(S.rotationSmoothness * 60 * dt, 0, 1)
		hrp.CFrame       = hrp.CFrame:Lerp(targetCF, alpha)

		if dist > 2.5 then
			local multiplier     = S.stickyPullStrength * 18
			local desired        = offset.Unit * multiplier
			local targetVelocity = Vector3.new(desired.X, vel.Y, desired.Z)
			hrp.AssemblyLinearVelocity = vel:Lerp(targetVelocity, S.airControlSmoothing)
		end

		if dist <= 3 then
			local centerDir  = headPos - hrp.Position
			local horizontal = Vector3.new(centerDir.X, 0, centerDir.Z)
			if horizontal.Magnitude > 0 then
				local added = horizontal.Unit * (S.stickyStickiness * 5)
				hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity:Lerp(
					hrp.AssemblyLinearVelocity + added, 0.12)
			end
		end

		if dist <= 2 then
			local boostOffset = headPos - hrp.Position
			local boostVel = Vector3.new(
				boostOffset.X * (S.stickyStickiness * 5),
				hrp.AssemblyLinearVelocity.Y,
				boostOffset.Z * (S.stickyStickiness * 5)
			)
			hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity:Lerp(boostVel, 0.18)
		end

		if dist <= 1.2 then
			local lock = headPos - hrp.Position
			local lockVel = Vector3.new(
				lock.X * (S.stickyStickiness * 6),
				hrp.AssemblyLinearVelocity.Y,
				lock.Z * (S.stickyStickiness * 6)
			)
			hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity:Lerp(lockVel, 0.15)
		end
	end
end)
end)
-- Robust WindUI loader: HttpGet/loadstring can fail (executor can't follow the
-- GitHub release redirect, transient network, etc.), which used to leave WindUI nil
-- and crash later with "attempt to index nil with 'Gradient'".
local WINDUI_URLS = {
	"https://github.com/Footagesus/WindUI/releases/latest/download/main.lua",
	"https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua",
}
for attempt = 1, 4 do
	for _, url in ipairs(WINDUI_URLS) do
		local ok, res = pcall(function()
			local src = game:HttpGet(url)
			local chunk = loadstring(src)
			return chunk and chunk()
		end)
		if ok and type(res) == "table" then
			WindUI = res
			break
		end
	end
	if WindUI then break end
	task.wait(1)
end

if type(WindUI) ~= "table" then
	warn("[Inferno Hub] Failed to load WindUI — HttpGet/loadstring returned nil.")
	warn("[Inferno Hub] Your executor likely can't fetch the WindUI release (HttpGet unsupported or GitHub blocked). Aborting.")
	return
end

WindUI:AddTheme({
Name = "Nexus",
Background = WindUI:Gradient({ ["0"] = { Color = Color3.fromHex("#ffa500"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#dc2626"), Transparency = 0 } }, { Rotation = 135 }),
Section    = WindUI:Gradient({ ["0"] = { Color = Color3.fromHex("#991b1b"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#991b1b"), Transparency = 0 } }, { Rotation = 90  }),
Accent     = WindUI:Gradient({ ["0"] = { Color = Color3.fromHex("#ff3b30"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#ff6b35"), Transparency = 0 } }, { Rotation = 0   }),
Button     = WindUI:Gradient({ ["0"] = { Color = Color3.fromHex("#ef4444"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#f87171"), Transparency = 0 } }, { Rotation = 0   }),
Toggle     = WindUI:Gradient({ ["0"] = { Color = Color3.fromHex("#ff3b30"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#ff6b35"), Transparency = 0 } }, { Rotation = 0   }),
Text       = WindUI:Gradient({ ["0"] = { Color = Color3.fromHex("#ffffff"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#ffffff"), Transparency = 0 } }, { Rotation = 0   }),
Icon       = WindUI:Gradient({ ["0"] = { Color = Color3.fromHex("#ffffff"), Transparency = 0 }, ["100"] = { Color = Color3.fromHex("#ffffff"), Transparency = 0 } }, { Rotation = 0   }),
})
local Window = WindUI:CreateWindow({
Title       = "Inferno Hub",
Icon        = "flame",
Author      = "Football Universe",
Folder      = "NexusHub",
Size        = UDim2.fromOffset(580, 460),
Transparent = true,
Theme       = "Nexus",
User        = { Enabled = true, Anonymous = false },
})
instance.window = Window
Window:Tag({
Title  = "v1.3.0",
Icon   = "flame",
Color  = Color3.fromHex("#60a5fa"),
Radius = 4,
})
local ConfigManager = Window.ConfigManager
local cfg = ConfigManager:CreateConfig("nexus_config")
UIS.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.RightShift then Window:Toggle() end
end)
local boostKey   = Enum.KeyCode.LeftShift
local pullVecKey = Enum.KeyCode.Unknown
local magsKey    = Enum.KeyCode.Unknown
local ctrlBoost   = Enum.KeyCode.ButtonL1
local ctrlRocket  = Enum.KeyCode.DPadLeft
local ctrlPullVec = Enum.KeyCode.ButtonR2
local ctrlMags    = Enum.KeyCode.ButtonL2
local CTRL_BUTTONS = {
"ButtonA", "ButtonB", "ButtonX", "ButtonY",
"ButtonL1", "ButtonR1", "ButtonL2", "ButtonR2",
"DPadUp", "DPadDown", "DPadLeft", "DPadRight",
"ButtonSelect", "ButtonStart",
}
local function toKeyCode(str)
local ok, kc = pcall(function() return Enum.KeyCode[str] end)
return (ok and kc) or Enum.KeyCode.Unknown
end
local Tabs = {
Movement = Window:Tab({ Title = "Movement", Icon = "person-standing"    }),
Boost    = Window:Tab({ Title = "Boost",    Icon = "rocket"             }),
Catching = Window:Tab({ Title = "Catching", Icon = "target"             }),
Hitbox   = Window:Tab({ Title = "Hitbox",   Icon = "box"                }),
Wager    = Window:Tab({ Title = "Wager",    Icon = "trophy"             }),
Emotes   = Window:Tab({ Title = "Emotes",   Icon = "music"              }),
Items    = Window:Tab({ Title = "Items",    Icon = "shirt"              }),
Clothes  = Window:Tab({ Title = "Clothes",  Icon = "shopping-bag"       }),
Shaders  = Window:Tab({ Title = "Shaders",  Icon = "sparkles"           }),
Graphics = Window:Tab({ Title = "Graphics", Icon = "monitor"            }),
Keybinds = Window:Tab({ Title = "Keybinds", Icon = "keyboard"           }),
Namelock = Window:Tab({ Title = "Name Lock",Icon = "lock"               }),
Settings = Window:Tab({ Title = "Settings", Icon = "sliders-horizontal" }),
}
Tabs.Movement:Select()
Tabs.Movement:Section({ Title = "Speed" })
Tabs.Movement:Slider({
Title = "WalkSpeed", Flag = "WalkSpeed",
Step = 1, Value = { Min = 1, Max = S.maxWalkSpeed, Default = S.walkSpeed },
Callback = function(v) S.walkSpeed = v; if hum and not S.rocketActive then hum.WalkSpeed = S.walkSpeed end end,
})
Tabs.Movement:Toggle({
Title = "WalkSpeed Lock",
Flag = "WalkSpeedLock", Value = true,
Callback = function(v)
S.walkSpeedLock = v
if v and hum and not S.rocketActive then hum.WalkSpeed = S.walkSpeed end
WindUI:Notify({ Title = "Inferno Hub", Content = v and "WalkSpeed locked" or "WalkSpeed unlocked", Duration = 2, Icon = v and "lock" or "unlock" })
end,
})
Tabs.Movement:Section({ Title = "Physics" })
Tabs.Movement:Slider({
Title = "Gravity", Flag = "Gravity",
Step = 1, Value = { Min = 10, Max = S.gravityMax, Default = S.gravityValue },
Callback = function(v) S.gravityValue = v; Workspace.Gravity = S.gravityValue end,
})
Tabs.Boost:Slider({
Title = "Boost Power", Flag = "BoostPower",
Step = 1, Value = { Min = 1, Max = S.maxBoost, Default = S.boostPower },
Callback = function(v) S.boostPower = v end,
})
Tabs.Movement:Slider({
Title = "Dive Power", Flag = "DivePower",
Step = 1, Value = { Min = 10, Max = 200, Default = S.divePower },
Callback = function(v) S.divePower = v; updateDivePower(v) end,
})
Tabs.Movement:Section({ Title = "Actions" })
Tabs.Boost:Button({
Title = "Rocket Boost", Desc = "DPad ← by default  |  Instant burst of speed",
Callback = function()
rocketBoost()
WindUI:Notify({ Title = "Inferno Hub", Content = "Rocket Boost!", Duration = 1 })
end,
})
Tabs.Movement:Section({ Title = "Follow" })
Tabs.Movement:Button({
Title = "Toggle Follow", Desc = "Follows the nearest player — press F or DPad → to toggle",
Callback = function() toggleFollow() end,
})
Tabs.Movement:Dropdown({
Title = "Follow Controller Button",
Values = CTRL_BUTTONS, Value = "DPadRight",
Callback = function(v) ctrlFollow = toKeyCode(v) end,
})
Tabs.Movement:Section({ Title = "Boost Amplifier" })
Tabs.Boost:Toggle({
Title = "TTB Amplifier",
Flag = "BoostAmp", Value = false,
Callback = function(v)
boostAmpEnabled = v
WindUI:Notify({ Title = "Inferno Hub", Content = v and "TTB Amplifier on" or "TTB Amplifier off", Duration = 2 })
end,
})
Tabs.Boost:Slider({
Title = "TTB Multiplier",
Flag = "BoostAmpMult", Step = 0.5,
Value = { Min = 1.5, Max = 10, Default = 2 },
Callback = function(v) boostAmpMultiplier = v end,
})
Tabs.Boost:Section({ Title = "Fling" })
Tabs.Boost:Toggle({
Title = "Fling",
Flag = "Fling", Value = false,
Callback = function(v)
flingEnabled = v
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Fling on" or "Fling off", Duration = 2 })
end,
})
Tabs.Boost:Slider({
Title = "Fling Power",
Flag = "FlingPower", Step = 5, Value = { Min = 50, Max = 500, Default = flingPower },
Callback = function(v) flingPower = v end,
})
Tabs.Boost:Section({ Title = "Auto Boost" })
Tabs.Boost:Toggle({
Title = "Auto Boost",
Flag = "AutoBoost", Value = false,
Callback = function(v)
autoBoostEnabled = v
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Auto Boost on" or "Auto Boost off", Duration = 2 })
end,
})
Tabs.Boost:Section({ Title = "Fling Up Boost" })
Tabs.Boost:Toggle({
Title = "Fling Up Boost",
Flag = "FlingUpBoost", Value = false,
Callback = function(v)
flingUpEnabled = v
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Fling Up Boost on" or "Fling Up Boost off", Duration = 2 })
end,
})
Tabs.Catching:Section({ Title = "Pull Vector" })
Tabs.Catching:Toggle({
Title = "Pull Vec",
Flag = "PullVec", Value = false,
Callback = function(v)
S.pullVecEnabled = v
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Pull Vec on — hold RT / RMB" or "Pull Vec off", Duration = 2 })
end,
})
Tabs.Catching:Section({ Title = "Tuning" })
Tabs.Catching:Slider({
Title = "Pull Speed", Flag = "PullSpeed",
Step = 0.1, Value = { Min = 10, Max = 500, Default = S.pullVecStrength },
Callback = function(v) S.pullVecStrength = v end,
})
Tabs.Catching:Slider({
Title = "Pull Smoothness", Flag = "PullSmooth",
Step = 0.1, Value = { Min = 0.1, Max = 0.9, Default = S.pullVecSmooth },
Callback = function(v) S.pullVecSmooth = v end,
})
Tabs.Catching:Section({ Title = "Mags" })
Tabs.Catching:Toggle({
Title = "CFrame Mags",
Flag = "CfMags", Value = false,
Callback = function(v)
S.cfMagsEnabled = v
WindUI:Notify({ Title = "Inferno Hub", Content = v and "CFrame Mags on — hold LMB" or "CFrame Mags off", Duration = 2 })
end,
})
Tabs.Catching:Toggle({
Title = "Orb Mags",
Flag = "OrbMags", Value = false,
Callback = function(v)
S.orbMagsEnabled = v
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Orb Mags on" or "Orb Mags off", Duration = 2 })
end,
})
Tabs.Catching:Section({ Title = "Pull Orb" })
Tabs.Catching:Toggle({
Title = "Enable Pull Orb",
Flag = "OrbEnabled", Value = false,
Callback = function(v)
S.orbEnabled = v
if not v and S.orbPart and S.orbPart.Parent then S.orbPart:Destroy(); S.orbPart = nil end
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Pull Orb active" or "Pull Orb off", Duration = 2 })
end,
})
Tabs.Catching:Slider({
Title = "Orb Radius", Flag = "OrbRadius",
Step = 1, Value = { Min = 5, Max = 100, Default = S.orbRadius },
Callback = function(v) S.orbRadius = v end,
})
Tabs.Catching:Colorpicker({
Title = "Orb Colour", Default = S.orbColor,
Callback = function(color) S.orbColor = color; if S.orbPart then S.orbPart.Default = color end end,
})
Tabs.Catching:Slider({
Title = "Orb Transparency", Flag = "OrbTransparency",
Step = 1, Value = { Min = 0, Max = 10, Default = math.floor(S.orbTransparency * 10) },
Callback = function(v) S.orbTransparency = v / 10; if S.orbPart then S.orbPart.Transparency = S.orbTransparency end end,
})
-- ── Wager Tab ─────────────────────────────────────────────────────────────────
Tabs.Wager:Section({ Title = "Head Manipulation" })
Tabs.Wager:Toggle({
Title = "Head Manipulation", Desc = "Steers you horizontally toward nearest head when descending from a jump",
Flag = "HeadManip", Value = false,
Callback = function(v)
S.headManipEnabled = v
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Head Manip on" or "Head Manip off", Duration = 2, Icon = "user" })
end,
})
Tabs.Wager:Slider({
Title = "Head Strength", Desc = "How hard you get steered toward the head",
Flag = "HeadStrength", Step = 0.1, Value = { Min = 0.5, Max = 6, Default = S.headStrength },
Callback = function(v) S.headStrength = v end,
})
Tabs.Wager:Section({ Title = "Jump Pull Vec" })
Tabs.Wager:Toggle({
Title = "Jump Pull Vec", Desc = "Auto-holds pull vec while you are airborne — no button needed",
Flag = "JumpPull", Value = false,
Callback = function(v)
S.jumpPullEnabled = v
if not v then S.jumpPullActive = false; S.pullVecHeld = false end
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Jump Pull on" or "Jump Pull off", Duration = 2, Icon = "arrow-up" })
end,
})
Tabs.Wager:Paragraph({
Title   = "Jump Pull Vec note",
Content = "Pull Vec must also be enabled in the Catching tab. This just removes the need to hold the button — it activates automatically when you leave the ground.",
})
Tabs.Wager:Section({ Title = "Ball Manipulation" })
Tabs.Wager:Toggle({
Title = "Ball Magnet", Desc = "Pulls the ball toward your hand with jitter effect",
Flag = "BallMag", Value = false,
Callback = function(v)
S.ballMagEnabled = v
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Ball Magnet on" or "Ball Magnet off", Duration = 2, Icon = "magnet" })
end,
})
Tabs.Wager:Toggle({
Title = "Range Boost", Desc = "Boosts ball speed when you are within range",
Flag = "BallRangeBoost", Value = false,
Callback = function(v)
S.ballRangeEnabled = v
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Range Boost on" or "Range Boost off", Duration = 2, Icon = "zap" })
end,
})
Tabs.Wager:Slider({
Title = "Magnet Range", Desc = "Max distance to activate the magnet",
Flag = "BallMagRange", Step = 1, Value = { Min = 5, Max = 200, Default = S.ballMagRange },
Callback = function(v) S.ballMagRange = v end,
})
Tabs.Wager:Slider({
Title = "Speed Range", Desc = "Distance within which ball gets boosted speed",
Flag = "BallSpeedRange", Step = 1, Value = { Min = 5, Max = 200, Default = S.ballSpeedRange },
Callback = function(v) S.ballSpeedRange = v end,
})
Tabs.Wager:Slider({
Title = "Boosted Speed", Desc = "Ball speed when inside range",
Flag = "BallBoostedSpeed", Step = 1, Value = { Min = 1, Max = 9999, Default = S.ballBoostedSpeed },
Callback = function(v) S.ballBoostedSpeed = v end,
})
Tabs.Wager:Slider({
Title = "Pull Strength", Desc = "How hard the ball flies toward your hand",
Flag = "BallPullStr", Step = 1, Value = { Min = 10, Max = 500, Default = S.ballPullStrength },
Callback = function(v) S.ballPullStrength = v end,
})
Tabs.Wager:Slider({
Title = "Jitter Amplitude", Desc = "How wild the shake is while pulling",
Flag = "BallJitterAmp", Step = 1, Value = { Min = 0, Max = 50, Default = S.ballJitterAmp },
Callback = function(v) S.ballJitterAmp = v end,
})
Tabs.Wager:Slider({
Title = "Jitter Frequency", Desc = "How frantic the oscillations are",
Flag = "BallJitterFreq", Step = 1, Value = { Min = 1, Max = 60, Default = S.ballJitterFreq },
Callback = function(v) S.ballJitterFreq = v end,
})
Tabs.Wager:Slider({
Title = "Snap Distance", Desc = "Studs from hand at which ball locks cleanly",
Flag = "BallSnapDist", Step = 0.1, Value = { Min = 0.5, Max = 5, Default = S.ballSnapDist },
Callback = function(v) S.ballSnapDist = v end,
})
-- ─────────────────────────────────────────────────────────────────────────────
Tabs.Hitbox:Section({ Title = "Navigation" })
Tabs.Catching:Button({
Title = "Teleport to Ball", Desc = "Instantly moves you to the football",
Callback = function()
if not hrp then return end
local nearest, nearestDist = nil, math.huge
for _, obj in pairs(workspace:GetDescendants()) do
if obj.Title == "Football" and obj:IsA("BasePart") then
local dist = (obj.Position - hrp.Position).Magnitude
if dist < nearestDist then nearest = obj; nearestDist = dist end
end
end
if nearest then
hrp.CFrame = CFrame.new(nearest.Position + Vector3.new(0, 5, 0))
WindUI:Notify({ Title = "Inferno Hub", Content = "Teleported to ball", Duration = 2 })
else
WindUI:Notify({ Title = "Inferno Hub", Content = "No ball found", Duration = 2, Icon = "flame" })
end
end,
})
Tabs.Hitbox:Toggle({
Title = "Noclip", Flag = "Noclip", Value = false,
Callback = function(v)
S.noclipEnabled = v
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Noclip on" or "Noclip off", Duration = 2 })
end,
})
Tabs.Hitbox:Section({ Title = "Hitbox" })
Tabs.Hitbox:Toggle({
Title = "Expand Player Hitboxes",
Flag = "Hitbox", Value = false,
Callback = function(v) hitboxEnabled = v; refreshAllHitboxes(); WindUI:Notify({ Title = "Inferno Hub", Content = v and "Hitboxes expanded" or "Hitboxes restored", Duration = 2 }) end,
})
Tabs.Hitbox:Slider({
Title = "Hitbox Size", Flag = "HitboxSize",
Step = 0.5, Value = { Min = 1, Max = 10, Default = hitboxSize },
Callback = function(v) hitboxSize = v; if hitboxEnabled then refreshAllHitboxes() end end,
})
Tabs.Hitbox:Slider({
Title = "Hitbox Transparency", Flag = "HitboxTransp",
Step = 0.1, Value = { Min = 0, Max = 1, Default = hitboxTransparency },
Callback = function(v) hitboxTransparency = v; if hitboxEnabled then refreshAllHitboxes() end end,
})
Tabs.Catching:Section({ Title = "Gloves / Ball tp" })
Tabs.Catching:Toggle({
Title = "Gloves V2",
Flag = "Gloves", Value = false,
Callback = function(v)
S.glovesEnabled = v
if v then applyGloves() else removeGloves() end
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Gloves on" or "Gloves off", Duration = 2 })
end,
})
Tabs.Catching:Slider({
Title = "Glove Size", Flag = "GloveSize",
Step = 0.5, Value = { Min = 2, Max = 12, Default = S.gloveSize },
Callback = function(v) S.gloveSize = v; if S.glovesEnabled then applyGloves() end end,
})
Tabs.Catching:Toggle({
Title = "Invisible Gloves",
Flag = "GlovesInvis", Value = false,
Callback = function(v) S.glovesInvisible = v; if S.glovesEnabled then applyGloves() end end,
})
Tabs.Hitbox:Section({ Title = "Sticky Head" })
Tabs.Hitbox:Toggle({
Title = "Sticky Head",
Flag = "StickyHead", Value = false,
Callback = function(v)
S.stickyHeadEnabled = v
if not v then removeAllStickyZones() end
if S.stickyHeadNotifs then
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Sticky Head on" or "Sticky Head off", Duration = 2 })
end
end,
})
Tabs.Hitbox:Toggle({
Title = "Sticky Head Notifications",
Flag = "StickyHeadNotifs", Value = true,
Callback = function(v) S.stickyHeadNotifs = v end,
})
Tabs.Hitbox:Slider({
Title = "Sticky Search Range",
Flag = "StickyHeadSize", Step = 1, Value = { Min = 5, Max = 80, Default = S.stickyHeadSize },
Callback = function(v) S.stickyHeadSize = v end,
})
Tabs.Hitbox:Slider({
Title = "Pull Strength",
Flag = "StickyPull", Step = 1, Value = { Min = 10, Max = 40, Default = math.floor(S.stickyPullStrength * 10) },
Callback = function(v) S.stickyPullStrength = v / 10 end,
})
Tabs.Hitbox:Slider({
Title = "Stickiness",
Flag = "StickyStick", Step = 1, Value = { Min = 10, Max = 40, Default = math.floor(S.stickyStickiness * 10) },
Callback = function(v) S.stickyStickiness = v / 10 end,
})
Tabs.Hitbox:Slider({
Title = "Rotation Smoothness",
Flag = "StickyRotSmooth", Step = 1, Value = { Min = 1, Max = 20, Default = math.floor(S.rotationSmoothness * 100) },
Callback = function(v) S.rotationSmoothness = v / 100 end,
})
Tabs.Hitbox:Slider({
Title = "Air Control Smoothing",
Flag = "StickyAirSmooth", Step = 1, Value = { Min = 1, Max = 30, Default = math.floor(S.airControlSmoothing * 100) },
Callback = function(v) S.airControlSmoothing = v / 100 end,
})
Tabs.Hitbox:Section({ Title = "Performance" })
Tabs.Hitbox:Paragraph({
Title   = "Graphics moved",
Content = "Potato Graphics and other visual options are now in the Graphics tab.",
})
local greyPlayersEnabled   = false
pixelFacesEnabled    = false
local originalFaceIds      = {}
function applyPixelFaces()
pcall(function() settings():GetService("Studio") end)
pcall(function() UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel01 end)
pcall(function() game:GetService("ContentProvider"):SetThreadPool(1) end)
for _, plr in pairs(Players:GetPlayers()) do
local c = plr.Character
if not c then continue end
local head = c:FindFirstChild("Head")
if not head then continue end
local face = head:FindFirstChild("face")
if face and face:IsA("Decal") then
if not originalFaceIds[plr.UserId] then originalFaceIds[plr.UserId] = face.Texture end
local stored = face.Texture
face.Texture = ""
task.defer(function() if face and face.Parent then face.Texture = stored end end)
end
end
pcall(function() game:GetService("RenderSettings").QualityLevel = Enum.QualityLevel.Level01 end)
end
local function removePixelFaces()
for _, plr in pairs(Players:GetPlayers()) do
local c = plr.Character
if not c or not originalFaceIds[plr.UserId] then continue end
local head = c:FindFirstChild("Head")
if not head then continue end
local face = head:FindFirstChild("face")
if face and originalFaceIds[plr.UserId] ~= "NONE" then face.Texture = originalFaceIds[plr.UserId] end
end
originalFaceIds = {}
end
local function applyFFlags(flags)
for name, value in pairs(flags) do
pcall(function() game:GetService("RbxAnalyticsService"):SetRBXEventStream(name, tostring(value)) end)
pcall(function() settings()[name] = value end)
end
end
local FFLAG_PRESETS = {
["Max FPS Boost"] = {
FFlagDebugDisableTelemetry = true,
DFIntTaskSchedulerTargetFps = 9999,
FFlagRenderGrassMotion = false,
FFlagRenderShadowIntensity = false,
},
["Low Quality Rendering"] = {
FFlagCommitToGraphicsQualityFix = true,
FFlagFixGraphicsQuality = true,
DFIntDebugFRMQualityLevelOverride = 1,
},
["Disable Shadows"] = {
FFlagDebugForceFastGBuffer = false,
DFFlagDebugRenderForceTechnologyVoxel = true,
},
}
Players.PlayerAdded:Connect(function(plr)
plr.CharacterAdded:Connect(function()
task.wait(1)
if pixelFacesEnabled then applyPixelFaces() end
end)
end)
Tabs.Graphics:Section({ Title = "Player Visuals" })
Tabs.Graphics:Toggle({
Title = "Pixel Faces",
Flag = "PixelFaces", Value = false,
Callback = function(v)
pixelFacesEnabled = v
if v then applyPixelFaces() else removePixelFaces() end
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Pixel Faces on" or "Pixel Faces off", Duration = 2 })
end,
})
Tabs.Graphics:Section({ Title = "FastFlag Launcher" })
Tabs.Graphics:Paragraph({
Title   = "Presets",
Content = "Click a preset to apply it instantly.",
})
local presetNames = {}
for name in pairs(FFLAG_PRESETS) do table.insert(presetNames, name) end
table.sort(presetNames)
for _, name in ipairs(presetNames) do
Tabs.Graphics:Button({
Title = name,
Callback = function()
applyFFlags(FFLAG_PRESETS[name])
WindUI:Notify({ Title = "Inferno Hub", Content = "Applied: " .. name, Duration = 2 })
end,
})
end
local fflagInput = ""
Tabs.Graphics:Input({
Title = "Custom FFlags", Desc = 'Paste JSON e.g. {"FFlagName":true,"DFIntName":1}',
Placeholder = '{"FFlagExample":true}', Callback = function(v) fflagInput = v end,
})
Tabs.Graphics:Button({
Title = "Apply Custom FFlags",
Callback = function()
if fflagInput == "" then
WindUI:Notify({ Title = "Inferno Hub", Content = "Paste flags first", Duration = 2 })
return
end
local ok, flags = pcall(function()
return game:GetService("HttpService"):JSONDecode(fflagInput)
end)
if not ok or type(flags) ~= "table" then
WindUI:Notify({ Title = "Inferno Hub", Content = "Invalid JSON", Duration = 2, Icon = "flame" })
return
end
applyFFlags(flags)
WindUI:Notify({ Title = "Inferno Hub", Content = "FFlags applied", Duration = 2, Icon = "flame" })
end,
})
Tabs.Graphics:Section({ Title = "Performance" })
Tabs.Graphics:Toggle({
Title = "Potato Graphics",
Flag = "PotatoGraphics2", Value = false,
Callback = function(v)
S.potatoEnabled = v
if v then applyPotato() else removePotato() end
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Potato Graphics on" or "Potato Graphics off", Duration = 2, Icon = v and "cpu" or "monitor" })
end,
})
Tabs.Emotes:Section({ Title = "Search" })
Tabs.Emotes:Input({
Title = "Search & Play", Desc = "Type an emote name and press Enter to play it",
Placeholder = "e.g. BBS", Callback = function(v)
if not v or v == "" then return end
local query = v:lower():gsub("%s+", "")
for _, emote in ipairs(EMOTES) do
if emote.name:lower():gsub("%s+",""):find(query, 1, true) then
playEmote(emote.id, emote.speed)
WindUI:Notify({ Title = "Inferno Hub", Content = "Playing: " .. emote.name, Duration = 2 })
return
end
end
WindUI:Notify({ Title = "Inferno Hub", Content = "No emote found: " .. v, Duration = 2, Icon = "flame" })
end,
})
Tabs.Emotes:Section({ Title = "Emotes" })
for _, emote in ipairs(EMOTES) do
Tabs.Emotes:Button({
Title = emote.name,
Callback = function()
playEmote(emote.id, emote.speed)
WindUI:Notify({ Title = "Inferno Hub", Content = "Playing: " .. emote.name, Duration = 2 })
end,
})
end
Tabs.Emotes:Section({ Title = "Playback" })
Tabs.Emotes:Slider({
Title = "Emote Speed",
Step = 1, Value = { Min = 1, Max = 30, Default = 10 },
Callback = function(v)
local speed = v / 10
if currentAnimTrack then currentAnimTrack:AdjustSpeed(speed) end
end,
})
Tabs.Emotes:Button({
Title = "Stop Emote", Desc = "Stop the currently playing emote",
Callback = function()
stopEmote()
WindUI:Notify({ Title = "Inferno Hub", Content = "Emote stopped", Duration = 2 })
end,
})
Tabs.Emotes:Section({ Title = "Custom" })
local customAnimId = ""
Tabs.Emotes:Input({
Title = "Animation ID", Desc = "Enter a numeric Roblox animation ID",
Placeholder = "e.g. 10714364213", Callback = function(v) customAnimId = v end,
})
Tabs.Emotes:Button({
Title = "Play Custom",
Callback = function()
if customAnimId == "" then
WindUI:Notify({ Title = "Inferno Hub", Content = "Enter an animation ID first", Duration = 2 })
return
end
playEmote("rbxassetid://" .. customAnimId, 1)
WindUI:Notify({ Title = "Inferno Hub", Content = "Playing custom animation", Duration = 2, Icon = "flame" })
end,
})
Tabs.Items:Section({ Title = "Accessories" })
local sortedItemNames = {}
for k in pairs(ITEMS) do table.insert(sortedItemNames, k) end
table.sort(sortedItemNames)
for _, itemName in ipairs(sortedItemNames) do
Tabs.Items:Toggle({
Title = itemName, Value = false,
Callback = function(v)
if v then
equipItem(itemName)
WindUI:Notify({ Title = "Inferno Hub", Content = "Equipped: " .. itemName, Duration = 2 })
else
unequipItem(itemName)
WindUI:Notify({ Title = "Inferno Hub", Content = "Unequipped: " .. itemName, Duration = 2, Icon = "flame" })
end
end,
})
end
Tabs.Items:Button({
Title = "Unequip All", Desc = "Remove every equipped accessory",
Callback = function()
for name in pairs(ITEMS) do unequipItem(name) end
WindUI:Notify({ Title = "Inferno Hub", Content = "All items removed", Duration = 2 })
end,
})
Tabs.Items:Section({ Title = "Banners" })
for _, banner in ipairs(BANNERS) do
Tabs.Items:Button({
Title = banner.name,
Callback = function()
applyBanner(banner.id)
WindUI:Notify({ Title = "Inferno Hub", Content = "Banner: " .. banner.name, Duration = 2 })
end,
})
end
Tabs.Items:Button({
Title = "Clear Banner", Desc = "Removes your current banner",
Callback = function()
removeBanner()
WindUI:Notify({ Title = "Inferno Hub", Content = "Banner cleared", Duration = 2 })
end,
})
Tabs.Clothes:Section({ Title = "Outfits" })
for _, cloth in ipairs(CLOTHES) do
Tabs.Clothes:Button({
Title = cloth.name,
Callback = function()
local success = applyCloth(cloth.type, cloth.id)
if success then
WindUI:Notify({ Title = "Inferno Hub", Content = "Wearing: " .. cloth.name, Duration = 2 })
end
end,
})
end
Tabs.Clothes:Button({
Title = "Reset Shirt", Desc = "Restore original shirt",
Callback = function()
resetCloth("shirt")
WindUI:Notify({ Title = "Inferno Hub", Content = "Shirt reset", Duration = 2 })
end,
})
Tabs.Clothes:Button({
Title = "Reset Shorts", Desc = "Restore original pants",
Callback = function()
resetCloth("pants")
WindUI:Notify({ Title = "Inferno Hub", Content = "Pants reset", Duration = 2 })
end,
})
Tabs.Clothes:Section({ Title = "Cosmetics" })
Tabs.Clothes:Toggle({
Title = "Inf Bandana",
Flag = "InfBandana", Value = false,
Callback = function(v)
bandanaActive = v
if v then
local success = applyInfBandana()
if success then
WindUI:Notify({ Title = "Inferno Hub", Content = "Inf Bandana on", Duration = 2 })
else
bandanaActive = false
end
else
removeInfBandana()
WindUI:Notify({ Title = "Inferno Hub", Content = "Inf Bandana off", Duration = 2, Icon = "flame" })
end
end,
})
Tabs.Shaders:Section({ Title = "Sky Presets" })
Tabs.Shaders:Paragraph({
Title   = "Sky Presets",
Content = "Pick a preset or enable Loop to cycle through all skies every second.",
})
Tabs.Shaders:Toggle({
Title = "Loop Skies", Desc = "Automatically cycles through every preset every 1 second",
Flag = "SkyLoop", Value = false,
Callback = function(v)
skyLoopEnabled = v
if not v then skyLoopIndex = 1 end
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Sky loop on" or "Sky loop off", Duration = 2, Icon = "sparkles" })
end,
})
local SKY_PRESETS = {
"Default", "Sunset Paradise", "Golden Hour", "Warm Summer",
"Pink Dream", "Orange Glow", "Coral Sunset", "Clear Day",
"Vaporwave Dream", "Midnight Blue",
}
for _, preset in ipairs(SKY_PRESETS) do
Tabs.Shaders:Button({
Title = preset,
Callback = function()
ApplySky(preset)
WindUI:Notify({ Title = "Inferno Hub", Content = "Sky: " .. preset, Duration = 2, Icon = "cloud" })
end,
})
end
Tabs.Shaders:Section({ Title = "Sky Colour" })
Tabs.Shaders:Colorpicker({
Title = "Sky Colour",
Default = shaderSkyColor,
Callback = function(color)
shaderSkyColor = color
local cc   = Lighting:FindFirstChild("NexusCC")
local atmo = Lighting:FindFirstChild("NexusAtmo")
if cc   then cc.TintColor = color end
if atmo then atmo.Default = color end
if not atmo then
local a = Instance.new("Atmosphere")
a.Title = "NexusAtmo"; a.Default = color; a.Density = 0.35
a.Offset = 0.1; a.Haze = 1.5; a.Glare = 0.2; a.Parent = Lighting
table.insert(shaderObjects, a)
end
if not cc then
local c2 = Instance.new("ColorCorrectionEffect")
c2.Title = "NexusCC"; c2.TintColor = color; c2.Parent = Lighting
table.insert(shaderObjects, c2)
end
WindUI:Notify({ Title = "Inferno Hub", Content = "Sky colour updated", Duration = 2 })
end,
})
Tabs.Shaders:Section({ Title = "Shadows" })
Tabs.Shaders:Toggle({
Title = "Global Shadows",
Value = Lighting.GlobalShadows,
Callback = function(v)
Lighting.GlobalShadows = v
WindUI:Notify({ Title = "Inferno Hub", Content = v and "Shadows on" or "Shadows off", Duration = 2 })
end,
})
Tabs.Shaders:Slider({
Title = "Shadow Softness",
Step = 1, Value = { Min = 0, Max = 10, Default = math.floor(Lighting.ShadowSoftness * 10) },
Callback = function(v) Lighting.ShadowSoftness = v / 10 end,
})
Tabs.Keybinds:Section({ Title = "Keyboard" })
Tabs.Keybinds:Keybind({
Title = "Boost Jump",
Flag = "BoostKey", Value = "LeftShift",
Callback = function(v) boostKey = toKeyCode(v) end,
})
Tabs.Keybinds:Keybind({
Title = "Pull Vec Hold",
Flag = "PullVecKey", Value = "E",
Callback = function(v) pullVecKey = toKeyCode(v) end,
})
Tabs.Keybinds:Keybind({
Title = "CFrame Mags Hold", Desc = "Hold to activate mags (keyboard only)",
Flag = "MagsKey", Value = "Unknown",
Callback = function(v) magsKey = toKeyCode(v) end,
})
Tabs.Keybinds:Keybind({
Title = "Sticky Head Toggle",
Flag = "StickyHeadKey", Value = "Unknown",
Callback = function(v) stickyHeadKey = toKeyCode(v) end,
})
Tabs.Keybinds:Keybind({
Title = "Toggle UI",
Value = "RightShift",
Callback = function(v)
local ok, kc = pcall(function() return Enum.KeyCode[v] end)
if ok and kc then Window:SetToggleKey(kc) end
end,
})
Tabs.Keybinds:Section({ Title = "Controller" })
Tabs.Keybinds:Paragraph({
Title   = "Controller Support",
Content = "WindUI doesn't detect gamepad inputs for keybinds so remapping is done with dropdowns below.",
})
Tabs.Keybinds:Dropdown({
Title = "Boost Button",
Values = CTRL_BUTTONS, Value = "ButtonL1",
Callback = function(v) ctrlBoost = toKeyCode(v); WindUI:Notify({ Title = "Inferno Hub", Content = "Boost → " .. v, Duration = 2 }) end,
})
Tabs.Keybinds:Dropdown({
Title = "Rocket Boost Button",
Values = CTRL_BUTTONS, Value = "DPadLeft",
Callback = function(v) ctrlRocket = toKeyCode(v); WindUI:Notify({ Title = "Inferno Hub", Content = "Rocket → " .. v, Duration = 2 }) end,
})
Tabs.Keybinds:Dropdown({
Title = "Pull Vec Button",
Values = CTRL_BUTTONS, Value = "ButtonR2",
Callback = function(v) ctrlPullVec = toKeyCode(v); WindUI:Notify({ Title = "Inferno Hub", Content = "Pull Vec → " .. v, Duration = 2 }) end,
})
Tabs.Keybinds:Dropdown({
Title = "Sticky Head Button",
Values = CTRL_BUTTONS, Value = "ButtonR1",
Callback = function(v)
ctrlStickyHead = toKeyCode(v)
WindUI:Notify({ Title = "Inferno Hub", Content = "Sticky Head → " .. v, Duration = 2 })
end,
})
Tabs.Keybinds:Dropdown({
Title = "CFrame Mags Button", Desc = "Hold this controller button to activate mags",
Values = CTRL_BUTTONS, Value = "ButtonL2",
Callback = function(v)
ctrlMags = toKeyCode(v)
WindUI:Notify({ Title = "Inferno Hub", Content = "Mags → " .. v, Duration = 2 })
end,
})
local nlLatched    = nil
local nlLatchType  = nil
local nlLockConn   = nil
local nlWatchConn  = nil
local nlAddedConns = {}
local nlIsLocked   = false
local nlFakeName   = ""
local nlRealInput  = ""
local nlFakeInput  = ""
local function nlEnforce()
if not nlLatched or nlFakeName == "" then return end
if nlLatchType == "Text" then
if nlLatched.Text ~= nlFakeName then nlLatched.Text = nlFakeName end
else
if nlLatched.Value ~= nlFakeName then nlLatched.Value = nlFakeName end
end
end
-- Hooks property-changed on a specific object; safe to call multiple times
local function nlRelatch(obj, latchType)
nlLatched   = obj
nlLatchType = latchType
if nlLockConn then nlLockConn:Disconnect() end
local prop = latchType == "Text" and "Text" or "Value"
nlLockConn = obj:GetPropertyChangedSignal(prop):Connect(function()
if nlIsLocked then nlEnforce() end
end)
nlEnforce()
end
-- Scans workspace + PlayerGui for an object still showing nlRealInput
local function nlScanAndRelatch()
for _, root in ipairs({ workspace, player.PlayerGui }) do
for _, obj in ipairs(root:GetDescendants()) do
if (obj:IsA("TextLabel") or obj:IsA("TextBox")) and obj.Text == nlRealInput then
nlRelatch(obj, "Text"); return
elseif obj:IsA("StringValue") and obj.Value == nlRealInput then
nlRelatch(obj, "Value"); return
end
end
end
end
local function nlAttach(fakeName)
nlFakeName = fakeName
-- Hook the current target
	nlRelatch(nlLatched, nlLatchType)

	-- Heartbeat: enforce every 0.5 s (property-changed signal handles instant re-lock);
	-- if target dies, re-scan every 0.5 s
	if nlWatchConn then nlWatchConn:Disconnect() end
	local scanTimer    = 0
	local enforceTimer = 0
	nlWatchConn = RunService.Heartbeat:Connect(function(dt)
		if not nlIsLocked then return end
		if nlLatched and nlLatched.Parent then
			enforceTimer = enforceTimer + dt
			if enforceTimer >= 0.5 then
				enforceTimer = 0
				nlEnforce()
			end
		else
			scanTimer = scanTimer - dt
			if scanTimer <= 0 then
				nlScanAndRelatch()
				scanTimer = 0.5
			end
		end
	end)

	-- DescendantAdded watchers — fire the moment a matching object is created
	for _, c in ipairs(nlAddedConns) do c:Disconnect() end
	nlAddedConns = {}
	local function onAdded(obj)
		if not nlIsLocked then return end
		if nlLatched and nlLatched.Parent then return end
		if (obj:IsA("TextLabel") or obj:IsA("TextBox")) and obj.Text == nlRealInput then
			nlRelatch(obj, "Text")
		elseif obj:IsA("StringValue") and obj.Value == nlRealInput then
			nlRelatch(obj, "Value")
		end
	end
	table.insert(nlAddedConns, workspace.DescendantAdded:Connect(onAdded))
	table.insert(nlAddedConns, player.PlayerGui.DescendantAdded:Connect(onAdded))

	nlIsLocked = true
	WindUI:Notify({ Title = "Inferno Hub", Content = "Locked: " .. nlLatched.Name, Duration = 3, Icon = "flame" })
end
local function nlFindAndLatch(realName, fakeName)
for _, root in ipairs({ workspace, player.PlayerGui }) do
for _, obj in ipairs(root:GetDescendants()) do
if (obj:IsA("TextLabel") or obj:IsA("TextBox")) and obj.Text == realName then
nlLatched = obj; nlLatchType = "Text"; break
elseif obj:IsA("StringValue") and obj.Value == realName then
nlLatched = obj; nlLatchType = "Value"; break
end
end
if nlLatched then break end
end
if nlLatched then nlEnforce(); nlAttach(fakeName); return true end
return false
end
-- Start watching even before the object exists — nlAttach's DescendantAdded
-- handles re-latching once found, so this just seeds the state
local function nlStartWatching(realName, fakeName)
nlFakeName  = fakeName
nlIsLocked  = true
for _, c in ipairs(nlAddedConns) do c:Disconnect() end
nlAddedConns = {}
local function onAdded(obj)
if not nlIsLocked then return end
if nlLatched and nlLatched.Parent then return end
if (obj:IsA("TextLabel") or obj:IsA("TextBox")) and obj.Text == realName then
nlLatched = obj; nlLatchType = "Text"
elseif obj:IsA("StringValue") and obj.Value == realName then
nlLatched = obj; nlLatchType = "Value"
end
if nlLatched then nlAttach(fakeName) end
end
table.insert(nlAddedConns, workspace.DescendantAdded:Connect(onAdded))
table.insert(nlAddedConns, player.PlayerGui.DescendantAdded:Connect(onAdded))
end
Tabs.Namelock:Input({ Title = "Real Username", Desc = "The exact name shown in-game", Placeholder = "e.g. PlayerName123", Callback = function(v) nlRealInput = v end })
Tabs.Namelock:Input({ Title = "Fake Name", Desc = "What you want it to show instead", Placeholder = "e.g. Anonymous", Callback = function(v) nlFakeInput = v end })
Tabs.Namelock:Button({ Title = "Lock Name", Desc = "Searches and latches — watches if not found yet",
Callback = function()
if nlIsLocked then WindUI:Notify({ Title = "Inferno Hub", Content = "Already locked", Duration = 3 }); return end
if nlRealInput == "" or nlFakeInput == "" then WindUI:Notify({ Title = "Inferno Hub", Content = "Fill both fields first", Duration = 3, Icon = "flame" }); return end
local found = nlFindAndLatch(nlRealInput, nlFakeInput)
if not found then
WindUI:Notify({ Title = "Inferno Hub", Content = "Watching for it...", Duration = 3, Icon = "flame" })
nlStartWatching(nlRealInput, nlFakeInput)
end
end,
})
Tabs.Namelock:Button({ Title = "Unlock",
Callback = function()
if nlLockConn  then nlLockConn:Disconnect()  end
if nlWatchConn then nlWatchConn:Disconnect() end
for _, c in ipairs(nlAddedConns) do c:Disconnect() end
nlAddedConns = {}
nlLatched = nil; nlLatchType = nil; nlIsLocked = false; nlFakeName = ""
WindUI:Notify({ Title = "Inferno Hub", Content = "Name lock released", Duration = 2 })
end,
})
Tabs.Namelock:Section({ Title = "Banners" })
for _, banner in ipairs(BANNERS) do
Tabs.Namelock:Button({
Title = banner.name,
Callback = function()
applyBanner(banner.id)
WindUI:Notify({ Title = "Inferno Hub", Content = "Banner: " .. banner.name, Duration = 2 })
end,
})
end
Tabs.Namelock:Button({
Title = "Clear Banner", Desc = "Removes your current banner",
Callback = function()
removeBanner()
WindUI:Notify({ Title = "Inferno Hub", Content = "Banner cleared", Duration = 2, Icon = "flame" })
end,
})
Tabs.Settings:Section({ Title = "Config" })
local saveName        = "nexus_config"
local selectedConfig  = nil
local configDropdown  = nil

Tabs.Settings:Input({
Title = "Config Name", Desc = "Name used when you press Save",
Placeholder = "nexus_config",
Callback = function(v) if v and v ~= "" then saveName = v end end,
})
Tabs.Settings:Button({
Title = "Save Config", Desc = "Save all current settings under the name above",
Callback = function()
local target = ConfigManager:GetConfig(saveName) or ConfigManager:CreateConfig(saveName)
local ok, err = pcall(function() return target:Save() end)
if ok then
WindUI:Notify({ Title = "Inferno Hub", Content = "Saved config: " .. saveName, Duration = 2, Icon = "flame" })
if configDropdown then configDropdown:Refresh(ConfigManager:AllConfigs()) end
else
WindUI:Notify({ Title = "Inferno Hub", Content = "Save failed: " .. tostring(err), Duration = 4, Icon = "flame" })
end
end,
})

Tabs.Settings:Section({ Title = "Load Config" })
configDropdown = Tabs.Settings:Dropdown({
Title = "Saved Configs", Desc = "Pick one of your saved configs",
Values = ConfigManager:AllConfigs(),
Value = ConfigManager:AllConfigs()[1],
Callback = function(v) selectedConfig = v end,
})
Tabs.Settings:Button({
Title = "Refresh List", Desc = "Rescan saved config files",
Callback = function()
configDropdown:Refresh(ConfigManager:AllConfigs())
WindUI:Notify({ Title = "Inferno Hub", Content = "Config list refreshed", Duration = 2, Icon = "refresh-cw" })
end,
})
Tabs.Settings:Button({
Title = "Load Selected Config", Desc = "Apply the selected saved config",
Callback = function()
if not selectedConfig or selectedConfig == "" then
WindUI:Notify({ Title = "Inferno Hub", Content = "Select a config first", Duration = 3, Icon = "flame" })
return
end
local target = ConfigManager:GetConfig(selectedConfig) or ConfigManager:CreateConfig(selectedConfig)
local ok, err = pcall(function() return target:Load() end)
WindUI:Notify({
Title = "Inferno Hub",
Content = ok and ("Loaded config: " .. selectedConfig) or ("Load failed: " .. tostring(err)),
Duration = 3, Icon = "flame",
})
end,
})
UIS.InputBegan:Connect(function(input, processed)
if processed then return end
if input.UserInputType == Enum.UserInputType.MouseButton2 then S.pullVecHeld = true end
if input.UserInputType == Enum.UserInputType.MouseButton1 then S.magsHeld = true end
if input.UserInputType == Enum.UserInputType.Gamepad1 then
if input.KeyCode == ctrlPullVec then S.pullVecHeld = true end
if input.KeyCode == ctrlMags    then S.magsHeld    = true end
end
if S.pullVecEnabled and pullVecKey ~= Enum.KeyCode.Unknown and input.KeyCode == pullVecKey then
S.pullVecHeld = true
end
if magsKey ~= Enum.KeyCode.Unknown and input.KeyCode == magsKey then
S.magsHeld = true
end
end)
UIS.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton2 then S.pullVecHeld = false end
if input.UserInputType == Enum.UserInputType.MouseButton1 then S.magsHeld = false end
if input.UserInputType == Enum.UserInputType.Gamepad1 then
if input.KeyCode == ctrlPullVec then S.pullVecHeld = false end
if input.KeyCode == ctrlMags    then S.magsHeld    = false end
end
if pullVecKey ~= Enum.KeyCode.Unknown and input.KeyCode == pullVecKey then S.pullVecHeld = false end
if magsKey    ~= Enum.KeyCode.Unknown and input.KeyCode == magsKey    then S.magsHeld    = false end
end)
UIS.InputBegan:Connect(function(input, processed)
if processed then return end
if input.UserInputType == Enum.UserInputType.Keyboard then
if input.KeyCode == boostKey and hrp then
hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, S.boostPower, hrp.AssemblyLinearVelocity.Z)
elseif input.KeyCode == followKey then
toggleFollow()
elseif stickyHeadKey ~= Enum.KeyCode.Unknown and input.KeyCode == stickyHeadKey then
S.stickyHeadEnabled = not S.stickyHeadEnabled
if not S.stickyHeadEnabled then removeAllStickyZones() end
if S.stickyHeadNotifs then
WindUI:Notify({ Title = "Inferno Hub", Content = S.stickyHeadEnabled and "Sticky Head on" or "Sticky Head off", Duration = 2, Icon = "flame" })
end
end
end
if input.UserInputType == Enum.UserInputType.Gamepad1 then
if input.KeyCode == ctrlBoost and hrp then
hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, S.boostPower, hrp.AssemblyLinearVelocity.Z)
elseif input.KeyCode == ctrlRocket then
rocketBoost()
elseif input.KeyCode == ctrlFollow then
toggleFollow()
elseif input.KeyCode == ctrlStickyHead then
S.stickyHeadEnabled = not S.stickyHeadEnabled
if not S.stickyHeadEnabled then removeAllStickyZones() end
if S.stickyHeadNotifs then
WindUI:Notify({ Title = "Inferno Hub", Content = S.stickyHeadEnabled and "Sticky Head on" or "Sticky Head off", Duration = 2, Icon = "flame" })
end
end
end
end)
WindUI:Notify({
Title = "Inferno Hub", Content = "Loaded  —  Universe Football",
Duration = 4,
})
]==])

setSource("Kalihub Updated", [==[
--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local UserInputService = game:GetService("UserInputService")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

if isMobile then
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")
    local plr = Players.LocalPlayer

    getgenv().SecureMode = true

    local mechMod = ReplicatedStorage:FindFirstChild("Assets") 
        and ReplicatedStorage.Assets:FindFirstChild("Modules") 
        and ReplicatedStorage.Assets.Modules:FindFirstChild("Client") 
        and ReplicatedStorage.Assets.Modules.Client:FindFirstChild("Mechanics")
    
    if mechMod then
        mechMod = require(mechMod)
    end

    local ConnectionManager = {}
    ConnectionManager.connections = {}

    function ConnectionManager:Add(name, connection)
        if self.connections[name] then
            self.connections[name]:Disconnect()
        end
        self.connections[name] = connection
    end

    function ConnectionManager:Remove(name)
        if self.connections[name] then
            self.connections[name]:Disconnect()
            self.connections[name] = nil
        end
    end

    function ConnectionManager:CleanupAll()
        for name, conn in pairs(self.connections) do
            if conn then
                conn:Disconnect()
            end
        end
        self.connections = {}
    end

    local pullVectorEnabled = false
    local smoothPullEnabled = false
    local isPullingBall = false
    local isSmoothPulling = false
    local walkSpeedEnabled = false
    local jumpPowerEnabled = false
    local bigheadEnabled = false
    local tackleReachEnabled = false
    local playerHitboxEnabled = false
    local jumpBoostEnabled = false
    local jumpBoostTradeMode = false
    local diveBoostEnabled = false
    local autoFollowBallCarrierEnabled = false
    local pullButtonActive = false
    local legPullButtonActive = false
    local dragButtonsEnabled = false
    local CanDiveBoost = true
    local CanBoost = true
    local isSprinting = false
    

    local offsetDistance = 15
    local magnetSmoothness = 0.20
    local customWalkSpeed = 25
    local customJumpPower = 50
    local bigheadSize = 1
    local bigheadTransparency = 0.5
    local tackleReachDistance = 5
    local playerHitboxSize = 5
    local maxPullDistance = 35
    local autoFollowBlatancy = 0.5
    local BOOST_FORCE_Y = 32
    local BALL_DETECTION_RADIUS = 10
    local BOOST_COOLDOWN = 1
    local DIVE_BOOST_POWER = 15
    local DIVE_BOOST_COOLDOWN = 2

    local jumpConnection = nil
    local bigheadConnection = nil
    local tackleReachConnection = nil
    local playerHitboxConnection = nil
    local walkSpeedConnection = nil
    local autoFollowConnection = nil
    local mobileInputMethod = "Buttons" 
    local isParkMatch = Workspace:FindFirstChild("ParkMatchMap") ~= nil

    local character = plr.Character or plr.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local head = character:WaitForChild("Head")
    local defaultHeadSize = head.Size
    local defaultHeadTransparency = head.Transparency

    local function onCharacterAdded(char)
        character = char
        humanoidRootPart = char:WaitForChild("HumanoidRootPart")
        humanoid = char:WaitForChild("Humanoid")
        head = char:WaitForChild("Head")
        defaultHeadSize = head.Size
        defaultHeadTransparency = head.Transparency
    end

    ConnectionManager:Add("CharacterAdded", plr.CharacterAdded:Connect(onCharacterAdded))

    local function getFootball()
        local parkMap = Workspace:FindFirstChild("ParkMap")
        if parkMap and parkMap:FindFirstChild("Replicated") then
            local fields = parkMap.Replicated:FindFirstChild("Fields")
            if fields then
                local parkFields = {
                    fields:FindFirstChild("LeftField"),
                    fields:FindFirstChild("RightField"),
                    fields:FindFirstChild("BLeftField"),
                    fields:FindFirstChild("BRightField"),
                    fields:FindFirstChild("HighField"),
                    fields:FindFirstChild("TLeftField"),
                    fields:FindFirstChild("TRightField")
                }
                
                for _, field in ipairs(parkFields) do
                    if field and field:FindFirstChild("Replicated") then
                        local football = field.Replicated:FindFirstChild("Football")
                        if football and football:IsA("BasePart") then 
                            return football 
                        end
                    end
                end
            end
        end
        
        if isParkMatch then
            local parkMatchFootball = Workspace:FindFirstChild("ParkMatchMap")
            if parkMatchFootball and parkMatchFootball:FindFirstChild("Replicated") then
                parkMatchFootball = parkMatchFootball.Replicated:FindFirstChild("Fields")
                if parkMatchFootball and parkMatchFootball:FindFirstChild("MatchField") then
                    parkMatchFootball = parkMatchFootball.MatchField:FindFirstChild("Replicated")
                    if parkMatchFootball then
                        local football = parkMatchFootball:FindFirstChild("Football")
                        if football and football:IsA("BasePart") then return football end
                    end
                end
            end
        end
        
        local gamesFolder = Workspace:FindFirstChild("Games")
        if gamesFolder then
            for _, gameInstance in ipairs(gamesFolder:GetChildren()) do
                local replicatedFolder = gameInstance:FindFirstChild("Replicated")
                if replicatedFolder then
                    local kickoffFootball = replicatedFolder:FindFirstChild("918f5408-d86a-4fb8-a88c-5cab57410acf")
                    if kickoffFootball and kickoffFootball:IsA("BasePart") then return kickoffFootball end
                    for _, item in ipairs(replicatedFolder:GetChildren()) do
                        if item:IsA("BasePart") and item.Name == "Football" then return item end
                    end
                end
            end
        end
        return nil
    end

    local function getBallCarrier()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= plr and player.Character then
                local football = player.Character:FindFirstChild("Football")
                if football then
                    return player
                end
            end
        end
        return nil
    end

    local function teleportToBall()
        local ball = getFootball()
        if ball and humanoidRootPart then
            if Workspace:FindFirstChild("ParkMap") then
                local distance = (ball.Position - humanoidRootPart.Position).Magnitude
                
                if distance > maxPullDistance then
                    return
                end
            end
            
            local ballVelocity = ball.Velocity
            local ballPosition = ball.Position
            local direction = ballVelocity.Unit
            local targetPosition = ballPosition + (direction * 12) - Vector3.new(0, 1.5, 0) + Vector3.new(0, 5.197499752044678 / 6, 0)
            local lookDirection = (ballPosition - humanoidRootPart.Position).Unit
            humanoidRootPart.CFrame = CFrame.new(targetPosition, targetPosition + lookDirection)
        end
    end

    local function smoothTeleportToBall()
        local ball = getFootball()
        if ball and humanoidRootPart then
            if Workspace:FindFirstChild("ParkMap") then
                local distance = (ball.Position - humanoidRootPart.Position).Magnitude
                if distance > maxPullDistance then return end
            end
            
            local ballVelocity = ball.Velocity
            local ballSpeed = ballVelocity.Magnitude
            local offset = (ballSpeed > 0) and (ballVelocity.Unit * offsetDistance) or Vector3.new(0, 0, 0)
            local targetPosition = ball.Position + offset + Vector3.new(0, 3, 0)
            local lookDirection = (ball.Position - humanoidRootPart.Position).Unit
            humanoidRootPart.CFrame = humanoidRootPart.CFrame:Lerp(CFrame.new(targetPosition, targetPosition + lookDirection), magnetSmoothness)
        end
    end

    local function applyJumpBoost(rootPart)
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, BOOST_FORCE_Y, 0)
        bv.MaxForce = Vector3.new(0, math.huge, 0)
        bv.P = 5000
        bv.Parent = rootPart
        game:GetService("Debris"):AddItem(bv, 0.2)
    end


    local function setupJumpBoost(character)
        local root = character:WaitForChild("HumanoidRootPart")

        ConnectionManager:Add("JumpBoostTouch", root.Touched:Connect(function(hit)
            if not jumpBoostEnabled or not CanBoost then return end
            if root.Velocity.Y >= -2 then return end

            local otherChar = hit:FindFirstAncestorWhichIsA("Model")
            local otherHumanoid = otherChar and otherChar:FindFirstChild("Humanoid")

            if otherChar and otherChar ~= character and otherHumanoid then
                if jumpBoostTradeMode then
                    CanBoost = false
                    applyJumpBoost(root)
                    task.delay(BOOST_COOLDOWN, function()
                        CanBoost = true
                    end)
                else
                    local football = getFootball()
                    if football then
                        local distance = (football.Position - root.Position).Magnitude
                        if distance <= BALL_DETECTION_RADIUS then
                            CanBoost = false
                            applyJumpBoost(root)
                            task.delay(BOOST_COOLDOWN, function()
                                CanBoost = true
                            end)
                        end
                    end
                end
            end
        end))
    end

    local function updateDivePower()
        if not diveBoostEnabled then return end
        
        local gameId = plr:FindFirstChild("Replicated") and plr.Replicated:FindFirstChild("GameID")
        if not gameId then return end
        
        local gid = gameId.Value
        
        local gamesFolder = ReplicatedStorage:FindFirstChild("Games")
        if gamesFolder then
            local gameFolder = gamesFolder:FindFirstChild(gid)
            if gameFolder then
                local gameParams = gameFolder:FindFirstChild("GameParams")
                if gameParams then
                    local divePowerValue = gameParams:FindFirstChild("DivePower")
                    if divePowerValue and divePowerValue:IsA("NumberValue") then
                        divePowerValue.Value = diveBoostPower
                    end
                end
            end
        end
        
        local miniGamesFolder = ReplicatedStorage:FindFirstChild("MiniGames")
        if miniGamesFolder then
            local gameFolder = miniGamesFolder:FindFirstChild(gid)
            if gameFolder then
                local gameParams = gameFolder:FindFirstChild("GameParams")
                if gameParams then
                    local divePowerValue = gameParams:FindFirstChild("DivePower")
                    if divePowerValue and divePowerValue:IsA("NumberValue") then
                        divePowerValue.Value = diveBoostPower
                    end
                end
            end
        end
    end

    local pullButtonGui = Instance.new("ScreenGui")
    pullButtonGui.Name = "PullButtonGui"
    pullButtonGui.ResetOnSpawn = false
    pullButtonGui.Parent = plr:WaitForChild("PlayerGui")
    
    local pullContainer = Instance.new("Frame")
    pullContainer.Name = "PullContainer"
    pullContainer.Size = UDim2.new(0, 100, 0, 100)
    pullContainer.Position = UDim2.new(0.85, 0, 0.7, 0)
    pullContainer.BackgroundTransparency = 1
    pullContainer.Active = true
    pullContainer.Draggable = false
    pullContainer.Parent = pullButtonGui
    
    local pullButton = Instance.new("TextButton")
    pullButton.Size = UDim2.new(0, 70, 0, 70)
    pullButton.Position = UDim2.new(0, 15, 0, 15)
    pullButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    pullButton.BorderSizePixel = 0
    pullButton.Text = "Pull"
    pullButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    pullButton.Font = Enum.Font.GothamBold
    pullButton.TextSize = 16
    pullButton.Parent = pullContainer
    
    local pullCorner = Instance.new("UICorner")
    pullCorner.CornerRadius = UDim.new(1, 0)
    pullCorner.Parent = pullButton
    
    local legPullContainer = Instance.new("Frame")
    legPullContainer.Size = UDim2.new(0, 100, 0, 100)
    legPullContainer.Position = UDim2.new(0.85, 0, 0.55, 0)
    legPullContainer.BackgroundTransparency = 1
    legPullContainer.Active = true
    legPullContainer.Draggable = false
    legPullContainer.Parent = pullButtonGui
    
    local legPullButton = Instance.new("TextButton")
    legPullButton.Size = UDim2.new(0, 70, 0, 70)
    legPullButton.Position = UDim2.new(0, 15, 0, 15)
    legPullButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    legPullButton.BorderSizePixel = 0
    legPullButton.Text = "Legit"
    legPullButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    legPullButton.Font = Enum.Font.GothamBold
    legPullButton.TextSize = 16
    legPullButton.Parent = legPullContainer
    
    local legPullCorner = Instance.new("UICorner")
    legPullCorner.CornerRadius = UDim.new(1, 0)
    legPullCorner.Parent = legPullButton
    
    pullButton.MouseButton1Down:Connect(function()
        if pullVectorEnabled then
            isPullingBall = true
            pullButtonActive = true
            pullButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            spawn(function()
                while isPullingBall and pullVectorEnabled do
                    teleportToBall()
                    wait(0.05)
                end
            end)
        end
    end)
    
    pullButton.MouseButton1Up:Connect(function()
        isPullingBall = false
        pullButtonActive = false
        pullButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)
    
    legPullButton.MouseButton1Down:Connect(function()
        if smoothPullEnabled then
            isSmoothPulling = true
            legPullButtonActive = true
            legPullButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            spawn(function()
                while legPullButtonActive and smoothPullEnabled do
                    smoothTeleportToBall()
                    wait(0.01)
                end
            end)
        end
    end)
    
    legPullButton.MouseButton1Up:Connect(function()
        isSmoothPulling = false
        legPullButtonActive = false
        legPullButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)
    
    UserInputService.TouchEnded:Connect(function(touch, gameProcessed)
        if pullButtonActive then
            isPullingBall = false
            pullButtonActive = false
            pullButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
        if legPullButtonActive then
            isSmoothPulling = false
            legPullButtonActive = false
            legPullButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        if pullVectorEnabled then
            pullButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            pullButton.Text = "Pull ✓"
        elseif not pullButtonActive then
            pullButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            pullButton.Text = "Pull"
        end
        
        if smoothPullEnabled then
            legPullButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            legPullButton.Text = "Legit ✓"
        elseif not legPullButtonActive then
            legPullButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            legPullButton.Text = "Legit"
        end
        
        if mobileInputMethod == "Tapping" then
            pullButton.Visible = false
            legPullButton.Visible = false
        elseif mobileInputMethod == "Buttons" or mobileInputMethod == "Both" then
            pullButton.Visible = pullVectorEnabled
            legPullButton.Visible = smoothPullEnabled
        end
    end)
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonR2 then
            if pullVectorEnabled then
                isPullingBall = true
                pullButtonActive = true
                pullButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
                spawn(function()
                    while isPullingBall and pullVectorEnabled do
                        teleportToBall()
                        wait(0.05)
                    end
                end)
            end
            if smoothPullEnabled then
                isSmoothPulling = true
                legPullButtonActive = true
                legPullButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
                spawn(function()
                    while legPullButtonActive and smoothPullEnabled do
                        smoothTeleportToBall()
                        wait(0.01)
                    end
                end)
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonR2 then
            if pullButtonActive then
                isPullingBall = false
                pullButtonActive = false
                pullButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            end
            if legPullButtonActive then
                isSmoothPulling = false
                legPullButtonActive = false
                legPullButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            end
        end
    end)
    
    local function getPlayerTeam(player)
        local menuGui = plr:FindFirstChild("PlayerGui") -- Use local player's GUI
        if menuGui then
            local menu = menuGui:FindFirstChild("Menu")
            if menu then
                local basis = menu:FindFirstChild("Basis")
                if basis then
                    local window = basis:FindFirstChild("Window")
                    if window then
                        local addFriends = window:FindFirstChild("AddFriends")
                        if addFriends then
                            local frame = addFriends:FindFirstChild("Basis")
                            if frame then
                                frame = frame:FindFirstChild("Frame")
                                if frame then
                                    local homeTeam = frame:FindFirstChild("HomeTeam")
                                    local awayTeam = frame:FindFirstChild("AwayTeam")
                                    
                                    -- Check if the player is in HomeTeam
                                    if homeTeam and homeTeam:FindFirstChild("Frame") then
                                        if homeTeam.Frame:FindFirstChild(player.Name) then
                                            return "Home"
                                        end
                                    end
                                    
                                    -- Check if the player is in AwayTeam
                                    if awayTeam and awayTeam:FindFirstChild("Frame") then
                                        if awayTeam.Frame:FindFirstChild(player.Name) then
                                            return "Away"
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        return nil
    end

    local Window = Rayfield:CreateWindow({
        Name = "Eclipse | NFL Universe [Mobile]",
        LoadingTitle = "Loading NFL Universe Script",
        LoadingSubtitle = "by Eclipse",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "NFLUniverse",
            FileName = "Eclipse"
        }
    })
    
    local MainTab = Window:CreateTab("⚡ Main", nil)
    
    local ButtonSection = MainTab:CreateSection("Button Controls")
    
    local DragButtonsToggle = MainTab:CreateToggle({
        Name = "Draggable Buttons",
        CurrentValue = false,
        Flag = "DragButtons",
        Callback = function(Value)
            dragButtonsEnabled = Value
            
            pullContainer.Draggable = Value
            legPullContainer.Draggable = Value
            
            if Value then
                pullContainer.BackgroundTransparency = 0.8
                pullContainer.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                legPullContainer.BackgroundTransparency = 0.8
                legPullContainer.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            else
                pullContainer.BackgroundTransparency = 1
                legPullContainer.BackgroundTransparency = 1
            end
        end,
    })
    
    local InputMethodDropdown = MainTab:CreateDropdown({
        Name = "Mobile Input Method",
        Options = {"Buttons", "Tapping", "Both"},
        CurrentOption = {"Buttons"},
        MultipleOptions = false,
        Flag = "InputMethod",
        Callback = function(Option)
            mobileInputMethod = Option[1]
            
            if mobileInputMethod == "Tapping" then
                pullButton.Visible = false
                legPullButton.Visible = false
            elseif mobileInputMethod == "Buttons" then
                pullButton.Visible = pullVectorEnabled
                legPullButton.Visible = smoothPullEnabled
            elseif mobileInputMethod == "Both" then
                pullButton.Visible = pullVectorEnabled
                legPullButton.Visible = smoothPullEnabled
            end
        end,
    })
    
if string.split(identifyexecutor() or "None", " ")[1] ~= "Xeno" then

            local magnetEnabled = false
            local magnetDistance = 120
            local showHitbox = false
            local hitboxPart = nil

            local plr = game.Players.LocalPlayer
            local char = plr.Character or plr.CharacterAdded:Wait()
            local hrp = char:WaitForChild('HumanoidRootPart')

            local og1 = CFrame.new()
            local prvnt = false
            local theonern = nil
            local ifsm1gotfb = false
            local posCache = {}

            local validNames = {
                ['Football'] = true,
                ['Football MeshPart'] = true
            }

            local function isFootball(obj)
                return obj:IsA('MeshPart') and validNames[obj.Name]
            end

            local function createHitbox()
                if hitboxPart then
                    hitboxPart:Destroy()
                end
                
                hitboxPart = Instance.new("Part")
                hitboxPart.Name = "MagnetHitbox"
                hitboxPart.Size = Vector3.new(magnetDistance * 2, magnetDistance * 2, magnetDistance * 2)
                hitboxPart.Anchored = true
                hitboxPart.CanCollide = false
                hitboxPart.Transparency = 0.7
                hitboxPart.Material = Enum.Material.ForceField
                hitboxPart.Color = Color3.fromRGB(138, 43, 226)
                hitboxPart.CastShadow = false
                hitboxPart.Shape = Enum.PartType.Ball
                hitboxPart.Parent = workspace
                
                return hitboxPart
            end

            local function removeHitbox()
                if hitboxPart then
                    hitboxPart:Destroy()
                    hitboxPart = nil
                end
            end

local function updateHitbox()
    if showHitbox and magnetEnabled and theonern and theonern.Parent then
        if not hitboxPart then
            createHitbox()
        end
        hitboxPart.CFrame = theonern.CFrame
        hitboxPart.Size = Vector3.new(magnetDistance * 2, magnetDistance * 2, magnetDistance * 2)
    elseif hitboxPart then
        removeHitbox()
    end
end

            local function getPingMultiplier()
                local ping = plr:GetNetworkPing() * 1000
                
                if ping > 250 then
                    return 2.5
                elseif ping > 200 then
                    return 2.0
                elseif ping > 150 then
                    return 1.7
                elseif ping > 100 then
                    return 1.4
                elseif ping > 50 then
                    return 1.2
                else
                    return 1.0
                end
            end

            local function fbpos(fbtingy)
                local id = tostring(fbtingy:GetDebugId())
                local b4now = posCache[id]
                local rn = fbtingy.Position
                posCache[id] = rn
                return rn, b4now or rn
            end

            local function ifsm1gotit()
                if theonern and theonern.Parent then
                    local parent = theonern.Parent
                    if parent:IsA('Model') and game.Players:GetPlayerFromCharacter(parent) then
                        return true
                    end
                    for _, player in next, game.Players:GetPlayers() do
                        if player.Character and theonern:IsDescendantOf(player.Character) then
                            return true
                        end
                    end
                end
                return false
            end

            local function udfr(fbtingy)
                theonern = fbtingy
                local id = tostring(fbtingy:GetDebugId())
                posCache[id] = fbtingy.Position
            end

            workspace.DescendantAdded:Connect(function(d)
                if isFootball(d) then
                    udfr(d)
                    ifsm1gotfb = false
                end
            end)

            workspace.DescendantAdded:Connect(function(d)
                if isFootball(d) then
                    d.AncestryChanged:Connect(function()
                        if d.Parent and d.Parent:IsA('Model') and game.Players:GetPlayerFromCharacter(d.Parent) then
                            ifsm1gotfb = true
                        elseif d.Parent == workspace or d.Parent == nil then
                            ifsm1gotfb = false
                        end
                    end)
                end
            end)

            workspace.DescendantRemoving:Connect(function(d)
                if d == theonern then
                    theonern = nil
                    ifsm1gotfb = false
                end
            end)

            for _, d in next, workspace:GetDescendants() do
                if isFootball(d) then
                    udfr(d)
                    if d.Parent and d.Parent:IsA('Model') and game.Players:GetPlayerFromCharacter(d.Parent) then
                        ifsm1gotfb = true
                    end
                end
            end

            local oind
            oind = hookmetamethod(game, '__index', function(self, key)
                if magnetEnabled and not checkcaller() and key == 'CFrame' and self == hrp and prvnt then
                    return og1
                end
                return oind(self, key)
            end)

            game:GetService('RunService').Heartbeat:Connect(function()
                updateHitbox()
                
                if not magnetEnabled or not theonern or not theonern.Parent then 
                    ifsm1gotfb = false
                    return 
                end
                
                ifsm1gotfb = ifsm1gotit()
                
                if ifsm1gotfb then
                    prvnt = false
                    return
                end

                local pos, old = fbpos(theonern)
                local d0 = (hrp.Position - pos).Magnitude
                if d0 > magnetDistance then return end

                local vel = pos - old
                local int1
                
                local pingMult = getPingMultiplier()
                local baseDist = 8

                if vel.Magnitude > 0.1 then
                    int1 = pos + (vel.Unit * baseDist * pingMult)
                else
                    int1 = pos + Vector3.new(5, 0, 5) * pingMult
                end

                int1 = Vector3.new(int1.X, math.max(int1.Y, pos.Y), int1.Z)

                og1 = hrp.CFrame
                prvnt = true
                hrp.CFrame = CFrame.new(int1)
                game:GetService('RunService').RenderStepped:Wait()
                hrp.CFrame = og1
                prvnt = false
            end)

            plr.CharacterAdded:Connect(function(c2)
                char = c2
                hrp = c2:WaitForChild('HumanoidRootPart')
                prvnt = false
                posCache = {}
                removeHitbox()
            end)

                local MagnetSection = MainTab:CreateSection("Magnets")

            local MagnetToggle = MainTab:CreateToggle({
                Name = "Desync Mags",
                CurrentValue = false,
                Flag = "FootballMagnet",
                Callback = function(Value)
                    magnetEnabled = Value
                    if not Value then
                        prvnt = false
                        removeHitbox()
                    end
                end,
            })
            
            local MagnetDistSlider = MainTab:CreateSlider({
                Name = "Magnet Distance",
                Range = {0, 120},
                Increment = 1,
                CurrentValue = 120,
                Flag = "FootballDistance",
                Callback = function(Value)
                    magnetDistance = Value
                end,
            })
            
            local ShowHitboxToggle = MainTab:CreateToggle({
                Name = "Show Hitbox",
                CurrentValue = false,
                Flag = "ShowHitbox",
                Callback = function(Value)
                    showHitbox = Value
                    if not Value then
                        removeHitbox()
                    end
                end,
            })
        end

    local LegitSection = MainTab:CreateSection("Legit Pull Vector")
    
    local LegitPullToggle = MainTab:CreateToggle({
        Name = "Legit Pull Vector",
        CurrentValue = false,
        Flag = "LegitPull",
        Callback = function(Value)
            smoothPullEnabled = Value
            
            if mobileInputMethod == "Buttons" or mobileInputMethod == "Both" then
                legPullButton.Visible = Value
            end
        end,
    })
    
    local SmoothSlider = MainTab:CreateSlider({
        Name = "Vector Smoothing",
        Range = {0.01, 1},
        Increment = 0.01,
        CurrentValue = 0.20,
        Flag = "Smoothness",
        Callback = function(Value)
            magnetSmoothness = Value
        end,
    })
    
    local PullSection = MainTab:CreateSection("Pull Vector")
    
    local PullToggle = MainTab:CreateToggle({
        Name = "Pull Vector",
        CurrentValue = false,
        Flag = "PullVector",
        Callback = function(Value)
            pullVectorEnabled = Value
            
            if mobileInputMethod == "Buttons" or mobileInputMethod == "Both" then
                pullButton.Visible = Value
            end
        end,
    })
    
    local OffsetSlider = MainTab:CreateSlider({
        Name = "Offset Distance",
        Range = {0, 30},
        Increment = 1,
        CurrentValue = 15,
        Flag = "Offset",
        Callback = function(Value)
            offsetDistance = Value
        end,
    })
    
    local MaxDistSlider = MainTab:CreateSlider({
        Name = "Max Pull Distance",
        Range = {1, 100},
        Increment = 1,
        CurrentValue = 35,
        Flag = "MaxDist",
        Callback = function(Value)
            maxPullDistance = Value
        end,
    })
    
    local function getSprintingValue()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        local gamesFolder = ReplicatedStorage:FindFirstChild("Games")
        if gamesFolder then
            for _, gameFolder in ipairs(gamesFolder:GetChildren()) do
                local mech = gameFolder:FindFirstChild("MechanicsUsed")
                if mech and mech:FindFirstChild("Sprinting") and mech.Sprinting:IsA("BoolValue") then
                    return mech.Sprinting
                end
            end
        end

        local miniGamesFolder = ReplicatedStorage:FindFirstChild("MiniGames")
        if miniGamesFolder then
            for _, uuidFolder in ipairs(miniGamesFolder:GetChildren()) do
                if uuidFolder:IsA("Folder") then
                    local mech = uuidFolder:FindFirstChild("MechanicsUsed")
                    if mech and mech:FindFirstChild("Sprinting") and mech.Sprinting:IsA("BoolValue") then
                        return mech.Sprinting
                    end
                end
            end
        end

        return nil
    end

    local PlayerTab = Window:CreateTab("👤 Player", nil)
    
    local StaminaSection = PlayerTab:CreateSection("Stamina")

local StaminaDepletion = PlayerTab:CreateToggle({
Name = "Infinite Stamina",
CurrentValue = false,
Flag = "StaminaDepletion",
Callback = function(enabled)
    staminaDepletionEnabled = enabled
    
    if enabled then
        spawn(function()
            while staminaDepletionEnabled do
                task.wait()
                if mechMod then
                    mechMod.Stamina = 100
                end
            end
        end)
    end
end,
})

    local SpeedSection = PlayerTab:CreateSection("WalkSpeed")
    
    local WalkSpeedToggle = PlayerTab:CreateToggle({
        Name = "WalkSpeed",
        CurrentValue = false,
        Flag = "WalkSpeed",
        Callback = function(value)
            walkSpeedEnabled = value
            
            if walkSpeedConnection then
                walkSpeedConnection:Disconnect()
                walkSpeedConnection = nil
            end
            
            local function setSpeed()
                local humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = walkSpeedEnabled and customWalkSpeed or 16
                end
            end
            
            if value then
                setSpeed()
                local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    walkSpeedConnection = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(setSpeed)
                end
            else
                setSpeed()
            end
        end,
    })
    
    local WalkSpeedSlider = PlayerTab:CreateSlider({
        Name = "Custom WalkSpeed",
        Range = {16, 35},
        Increment = 1,
        CurrentValue = 25,
        Flag = "WSValue",
        Callback = function(Value)
            customWalkSpeed = Value
            if walkSpeedEnabled then
                local humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = Value
                end
            end
        end,
    })
    
    local JumpSection = PlayerTab:CreateSection("JumpPower")
    
    local JumpToggle = PlayerTab:CreateToggle({
        Name = "JumpPower",
        CurrentValue = false,
        Flag = "JumpPower",
        Callback = function(value)
            jumpPowerEnabled = value
            if value then
                if jumpConnection then jumpConnection:Disconnect() end
                jumpConnection = humanoid.Jumping:Connect(function()
                    if jumpPowerEnabled and humanoidRootPart then
                        local jumpVelocity = Vector3.new(0, customJumpPower, 0)
                        humanoidRootPart.Velocity = Vector3.new(humanoidRootPart.Velocity.X, 0, humanoidRootPart.Velocity.Z) + jumpVelocity
                    end
                end)
            else
                if jumpConnection then jumpConnection:Disconnect() end
                jumpConnection = nil
            end
        end,
    })
    
    local JumpSlider = PlayerTab:CreateSlider({
        Name = "Custom JumpPower",
        Range = {10, 200},
        Increment = 5,
        CurrentValue = 50,
        Flag = "JPValue",
        Callback = function(Value)
            customJumpPower = Value
        end,
    })
    
    local BoostSection = PlayerTab:CreateSection("Jump Boost")
    
    local JumpBoostToggle = PlayerTab:CreateToggle({
        Name = "Jump Boost",
        CurrentValue = false,
        Flag = "JumpBoost",
        Callback = function(value)
            jumpBoostEnabled = value
            if value then
                if plr.Character then
                    setupJumpBoost(plr.Character)
                end
            else
                ConnectionManager:Remove("JumpBoostTouch")
            end
        end
    })
    
    local JumpBoostModeToggle = PlayerTab:CreateToggle({
        Name = "Always Boost Mode",
        CurrentValue = false,
        Flag = "BoostMode",
        Callback = function(Value)
            jumpBoostTradeMode = Value
        end
    })
    
    local BoostForceSlider = PlayerTab:CreateSlider({
        Name = "Boost Force",
        Range = {10, 100},
        Increment = 2,
        CurrentValue = 32,
        Flag = "BoostForce",
        Callback = function(Value)
            BOOST_FORCE_Y = Value
        end,
    })
    
    local DiveSection = PlayerTab:CreateSection("Dive Boost")
    
    local DiveBoostToggle = PlayerTab:CreateToggle({
        Name = "Dive Boost",
        CurrentValue = false,
        Flag = "DiveBoost",
        Callback = function(value)
            diveBoostEnabled = value
            
            if value then
                updateDivePower()
            else
                local gameId = plr:FindFirstChild("Replicated") and plr.Replicated:FindFirstChild("GameID")
                if gameId then
                    local gid = gameId.Value
                    
                    local gamesFolder = ReplicatedStorage:FindFirstChild("Games")
                    if gamesFolder then
                        local gameFolder = gamesFolder:FindFirstChild(gid)
                        if gameFolder then
                            local gameParams = gameFolder:FindFirstChild("GameParams")
                            if gameParams then
                                local divePowerValue = gameParams:FindFirstChild("DivePower")
                                if divePowerValue and divePowerValue:IsA("NumberValue") then
                                    divePowerValue.Value = 2.2
                                end
                            end
                        end
                    end
                    
                    local miniGamesFolder = ReplicatedStorage:FindFirstChild("MiniGames")
                    if miniGamesFolder then
                        local gameFolder = miniGamesFolder:FindFirstChild(gid)
                        if gameFolder then
                            local gameParams = gameFolder:FindFirstChild("GameParams")
                            if gameParams then
                                local divePowerValue = gameParams:FindFirstChild("DivePower")
                                if divePowerValue and divePowerValue:IsA("NumberValue") then
                                    divePowerValue.Value = 2.2
                                end
                            end
                        end
                    end
                end
            end
        end,
    })
    
    local DivePowerSlider = PlayerTab:CreateSlider({
        Name = "Dive Boost Power",
        Range = {2.2, 10},
        Increment = 0.1,
        CurrentValue = 2,
        Flag = "DivePower",
        Callback = function(Value)
            diveBoostPower = Value
        end,
    })
    
    local AutoSection = PlayerTab:CreateSection("Auto Rush")
    
    local AutoFollowToggle = PlayerTab:CreateToggle({
        Name = "Auto Follow Ball Carrier",
        CurrentValue = false,
        Flag = "AutoFollow",
        Callback = function(enabled)
            autoFollowBallCarrierEnabled = enabled

            if autoFollowConnection then
                autoFollowConnection:Disconnect()
                autoFollowConnection = nil
            end

            if enabled then
                autoFollowConnection = RunService.Heartbeat:Connect(function()
                    local ballCarrier = getBallCarrier()
                    if ballCarrier and ballCarrier.Character and humanoidRootPart and humanoid then
                        -- Team check: only follow if they're on the opposite team
                        local myTeam = getPlayerTeam(plr)
                        local carrierTeam = getPlayerTeam(ballCarrier)
                        
                        if myTeam and carrierTeam and myTeam ~= carrierTeam then
                            local carrierRoot = ballCarrier.Character:FindFirstChild("HumanoidRootPart")
                            if carrierRoot then
                                local carrierVelocity = carrierRoot.Velocity
                                local distance = (carrierRoot.Position - humanoidRootPart.Position).Magnitude
                                local timeToReach = distance / (humanoid.WalkSpeed or 16)
                                local predictedPosition = carrierRoot.Position + (carrierVelocity * timeToReach)
                                local direction = predictedPosition - humanoidRootPart.Position
                                humanoid:MoveTo(humanoidRootPart.Position + direction * math.clamp(autoFollowBlatancy, 0, 1))
                            end
                        end
                    end
                end)
            end
        end,
    })
    
    local BlatancySlider = PlayerTab:CreateSlider({
        Name = "Follow Blatancy",
        Range = {0, 1},
        Increment = 0.05,
        CurrentValue = 0.5,
        Flag = "Blatancy",
        Callback = function(Value)
            autoFollowBlatancy = Value
        end,
    })
    
    local HitboxTab = Window:CreateTab("📦 Hitbox", nil)
    
    local BigheadSection = HitboxTab:CreateSection("BigHead")
    
    local BigheadToggle = HitboxTab:CreateToggle({
        Name = "Bighead Collision",
        CurrentValue = false,
        Flag = "Bighead",
        Callback = function(value)
            bigheadEnabled = value
    
            if value then
                if bigheadConnection then bigheadConnection:Disconnect() end
                bigheadConnection = RunService.RenderStepped:Connect(function()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= plr then
                            local character = player.Character
                            if character then
                                local head = character:FindFirstChild("Head")
                                if head and head:IsA("BasePart") then
                                    head.Size = Vector3.new(bigheadSize, bigheadSize, bigheadSize)
                                    head.Transparency = bigheadTransparency
                                    head.CanCollide = true
                                    local face = head:FindFirstChild("face")
                                    if face then face:Destroy() end
                                end
                            end
                        end
                    end
                end)
            else
                if bigheadConnection then bigheadConnection:Disconnect() bigheadConnection = nil end
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= plr then
                        local character = player.Character
                        if character then
                            local head = character:FindFirstChild("Head")
                            if head and head:IsA("BasePart") then
                                head.Size = defaultHeadSize
                                head.Transparency = defaultHeadTransparency
                                head.CanCollide = false
                            end
                        end
                    end
                end
            end
        end,
    })
    
    local HeadSizeSlider = HitboxTab:CreateSlider({
        Name = "Head Size",
        Range = {1, 10},
        Increment = 1,
        CurrentValue = 1,
        Flag = "HeadSize",
        Callback = function(Value)
            bigheadSize = Value
        end,
    })
    
    local TackleSection = HitboxTab:CreateSection("Tackle Reach")
    
    local TackleToggle = HitboxTab:CreateToggle({
        Name = "Tackle Reach",
        CurrentValue = false,
        Flag = "TackleReach",
        Callback = function(enabled)
            tackleReachEnabled = enabled
    
            if tackleReachConnection then
                tackleReachConnection:Disconnect()
            end
    
            if enabled then
                tackleReachConnection = RunService.Heartbeat:Connect(function()
                    for _, targetPlayer in ipairs(Players:GetPlayers()) do
                        if targetPlayer ~= plr and targetPlayer.Character then
                            for _, desc in ipairs(targetPlayer.Character:GetDescendants()) do
                                if desc.Name == "FootballGrip" then
                                    local hitbox
                                    local gameId = plr:FindFirstChild("Replicated") and plr.Replicated:FindFirstChild("GameID") and plr.Replicated.GameID.Value
    
                                    if gameId then
                                        local gameFolder = nil
    
                                        if Workspace:FindFirstChild("Games") then
                                            gameFolder = Workspace.Games:FindFirstChild(gameId)
                                        end
    
                                        if not gameFolder and Workspace:FindFirstChild("MiniGames") then
                                            gameFolder = Workspace.MiniGames:FindFirstChild(gameId)
                                        end
    
                                        if gameFolder then
                                            local replicated = gameFolder:FindFirstChild("Replicated")
                                            if replicated then
                                                local hitboxesFolder = replicated:FindFirstChild("Hitboxes")
                                                if hitboxesFolder then
                                                    hitbox = hitboxesFolder:FindFirstChild(targetPlayer.Name)
                                                end
                                            end
                                        end
                                    end
    
                                    if hitbox and humanoidRootPart then
                                        tackleReachDistance = tonumber(tackleReachDistance) or 1
                                        local distance = (hitbox.Position - humanoidRootPart.Position).Magnitude
                                        if distance <= tackleReachDistance then
                                            hitbox.Position = humanoidRootPart.Position
                                            task.wait(0.1)
                                            hitbox.Position = targetPlayer.Character:FindFirstChild("HumanoidRootPart").Position
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end,
    })
    
    local TackleSlider = HitboxTab:CreateSlider({
        Name = "Reach Distance",
        Range = {1, 10},
        Increment = 1,
        CurrentValue = 5,
        Flag = "TackleDistance",
        Callback = function(Value)
            tackleReachDistance = Value
        end,
    })
    
    local PlayerHitboxSection = HitboxTab:CreateSection("Player Hitbox")
    
    local PlayerHitboxToggle = HitboxTab:CreateToggle({
        Name = "Player Hitbox Expander",
        CurrentValue = false,
        Flag = "PlayerHitbox",
        Callback = function(enabled)
            playerHitboxEnabled = enabled

            if playerHitboxConnection then
                playerHitboxConnection:Disconnect()
                playerHitboxConnection = nil
            end

            if enabled then
                playerHitboxConnection = RunService.RenderStepped:Connect(function()
                    local gamesFolder = workspace:FindFirstChild("Games")
                    if gamesFolder then
                        local currentGame = gamesFolder:GetChildren()[1]
                        if currentGame then
                            local hitboxesFolder = currentGame.Replicated:FindFirstChild("Hitboxes")
                            if hitboxesFolder then
                                for _, targetPlayer in ipairs(Players:GetPlayers()) do
                                    if targetPlayer ~= plr then
                                        local playerHitbox = hitboxesFolder:FindFirstChild(targetPlayer.Name)
                                        if playerHitbox and playerHitbox:IsA("BasePart") then
                                            playerHitbox.Size = Vector3.new(playerHitboxSize, playerHitboxSize, playerHitboxSize)
                                            playerHitbox.Transparency = playerHitboxTransparency
                                            playerHitbox.CanCollide = false
                                            playerHitbox.Material = Enum.Material.Neon
                                            playerHitbox.Color = Color3.fromRGB(255, 0, 0)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            else
                local gamesFolder = workspace:FindFirstChild("Games")
                if gamesFolder then
                    local currentGame = gamesFolder:GetChildren()[1]
                    if currentGame then
                        local hitboxesFolder = currentGame.Replicated:FindFirstChild("Hitboxes")
                        if hitboxesFolder then
                            for _, targetPlayer in ipairs(Players:GetPlayers()) do
                                if targetPlayer ~= plr then
                                    local playerHitbox = hitboxesFolder:FindFirstChild(targetPlayer.Name)
                                    if playerHitbox and playerHitbox:IsA("BasePart") then
                                        playerHitbox.Size = Vector3.new(2, 2, 1)
                                        playerHitbox.Transparency = 1
                                        playerHitbox.CanCollide = false
                                        playerHitbox.Material = Enum.Material.Plastic
                                        playerHitbox.Color = Color3.fromRGB(255, 255, 255)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end,
    })

    local HitboxSizeSlider = HitboxTab:CreateSlider({
        Name = "Hitbox Size",
        Range = {2, 50},
        Increment = 1,
        CurrentValue = 5,
        Flag = "HitboxSize",
        Callback = function(Value)
            playerHitboxSize = Value
        end,
    })

    local HitboxTransparencySlider = HitboxTab:CreateSlider({
        Name = "Hitbox Transparency",
        Range = {0, 1},
        Increment = 0.1,
        CurrentValue = 0.7,
        Flag = "HitboxTransparency",
        Callback = function(Value)
            playerHitboxTransparency = Value
        end,
    })
    
    local Auto = Window:CreateTab("🤖 Automation", nil) 
    local AutoSack = Auto:CreateToggle({
        Name = "Auto Sack",
        CurrentValue = false,
        Flag = "AutoSacker", 
        Callback = function(Value)
            getgenv().AutoSack = Value
        end,
    })
    
    local AntiBlocker = Auto:CreateToggle({
        Name = "Anti Block",
        CurrentValue = false,
        Flag = "AntiBlocker", 
        Callback = function(Value)
            getgenv().AntiBlock = Value
        end,
    })


    local AntiAFKToggle = Auto:CreateToggle({
        Name = "Anti AFK",
        CurrentValue = false,
        Flag = "AntiAFK",
        Callback = function(enabled)
            if enabled then
                local VirtualUser = game:GetService("VirtualUser")
                game:GetService("Players").LocalPlayer.Idled:Connect(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
            end
        end,
    })        

    local MiscTab = Window:CreateTab("🔧 Misc", nil)

    local FPSBoostToggle = MiscTab:CreateToggle({
        Name = "Potato Graphics Mode",
        CurrentValue = false,
        Flag = "PotatoMode",
        Callback = function(Value)
            if Value then
                -- Store original settings
                _G.OriginalSettings = {
                    lighting = game:GetService("Lighting"),
                    terrain = workspace.Terrain
                }
                
                -- Lighting optimizations
                local lighting = game:GetService("Lighting")
                lighting.GlobalShadows = false
                lighting.FogEnd = 9e9
                lighting.Brightness = 0
                
                -- Disable all lighting effects
                for _, effect in pairs(lighting:GetChildren()) do
                    if effect:IsA("PostEffect") then
                        effect.Enabled = false
                    end
                end
                
                -- Terrain optimizations
                local terrain = workspace.Terrain
                terrain.WaterWaveSize = 0
                terrain.WaterWaveSpeed = 0
                terrain.WaterReflectance = 0
                terrain.WaterTransparency = 0
                
                -- Reduce part quality
                settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                
                -- Disable unnecessary visual effects
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                        obj.Enabled = false
                    elseif obj:IsA("Explosion") then
                        obj.BlastPressure = 1
                        obj.BlastRadius = 1
                    elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                        obj.Enabled = false
                    elseif obj:IsA("MeshPart") then
                        obj.Material = Enum.Material.SmoothPlastic
                        obj.Reflectance = 0
                    elseif obj:IsA("Part") then
                        obj.Material = Enum.Material.SmoothPlastic
                        obj.Reflectance = 0
                    end
                end
                
                -- Remove skybox
                if lighting:FindFirstChildOfClass("Sky") then
                    lighting:FindFirstChildOfClass("Sky"):Destroy()
                end
                
                Rayfield:Notify({
                    Title = "FPS Booster",
                    Content = "Potato graphics enabled! 🥔",
                    Duration = 3,
                    Image = 4483362458,
                })
            else
                -- Restore settings
                settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
                
                local lighting = game:GetService("Lighting")
                lighting.GlobalShadows = true
                lighting.Brightness = 2
                
                for _, effect in pairs(lighting:GetChildren()) do
                    if effect:IsA("PostEffect") then
                        effect.Enabled = true
                    end
                end
                
                Rayfield:Notify({
                    Title = "FPS Booster",
                    Content = "Graphics restored to normal",
                    Duration = 3,
                    Image = 4483362458,
                })
            end
        end,
    })

    MiscTab:CreateButton({
        Name = "Remove Textures",
        Callback = function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Decal") or obj:IsA("Texture") then
                    obj.Transparency = 1
                elseif obj:IsA("BasePart") then
                    obj.Material = Enum.Material.SmoothPlastic
                end
            end
            
            Rayfield:Notify({
                Title = "FPS Booster",
                Content = "All textures removed!",
                Duration = 3,
                Image = 4483362458,
            })
        end,
    })

    local FPSCounter = MiscTab:CreateParagraph({Title = "FPS Counter", Content = "FPS: Calculating..."})

    -- FPS Counter
    task.spawn(function()
        local fps = 0
        local lastUpdate = tick()
        
        game:GetService("RunService").RenderStepped:Connect(function()
            fps = fps + 1
            
            if tick() - lastUpdate >= 1 then
                FPSCounter:Set({Title = "FPS Counter", Content = "Current FPS: " .. fps})
                fps = 0
                lastUpdate = tick()
            end
        end)
    end)

    do
        local SrnyxaState = { AutoCatch = false, CatchRange = 50, VisualsEnabled = false, SpeedEnabled = false, SpeedValue = 1.0, InfJump = false }
        local srnyxaBall = nil
        local fovVisual = nil

        local function makeVisual()
            if fovVisual then fovVisual:Destroy() end
            fovVisual = Instance.new("Part")
            fovVisual.Anchored = true
            fovVisual.CanCollide = false
            fovVisual.Material = Enum.Material.ForceField
            fovVisual.Shape = Enum.PartType.Ball
            fovVisual.Transparency = 0.7
            fovVisual.Parent = workspace
        end

        MainTab:CreateSection("SRNYXA")

        MainTab:CreateToggle({
            Name = "Force Catch",
            CurrentValue = false,
            Flag = "SrnyxaForceCatch",
            Callback = function(v) SrnyxaState.AutoCatch = v end,
        })
        MainTab:CreateToggle({
            Name = "Catch Zone Visual",
            CurrentValue = false,
            Flag = "SrnyxaVisual",
            Callback = function(v) SrnyxaState.VisualsEnabled = v end,
        })
        MainTab:CreateToggle({
            Name = "Blatant Speed",
            CurrentValue = false,
            Flag = "SrnyxaSpeed",
            Callback = function(v) SrnyxaState.SpeedEnabled = v end,
        })
        MainTab:CreateToggle({
            Name = "Infinite Jump",
            CurrentValue = false,
            Flag = "SrnyxaInfJump",
            Callback = function(v) SrnyxaState.InfJump = v end,
        })

        ConnectionManager:Add("SrnyxaInfJump", UserInputService.JumpRequest:Connect(function()
            if not SrnyxaState.InfJump then return end
            local c = plr.Character
            local root = c and c:FindFirstChild("HumanoidRootPart")
            if root then
                root.Velocity = Vector3.new(root.Velocity.X, 55, root.Velocity.Z)
            end
        end))
        MainTab:CreateSlider({
            Name = "Catch Range",
            Range = {5, 150},
            Increment = 1,
            CurrentValue = 50,
            Flag = "SrnyxaCatchRange",
            Callback = function(v) SrnyxaState.CatchRange = v end,
        })
        MainTab:CreateSlider({
            Name = "Speed Value",
            Range = {0.1, 5},
            Increment = 0.1,
            CurrentValue = 1,
            Flag = "SrnyxaSpeedValue",
            Callback = function(v) SrnyxaState.SpeedValue = v end,
        })

        ConnectionManager:Add("SrnyxaBallScan", RunService.Heartbeat:Connect(function()
            if not (SrnyxaState.AutoCatch or SrnyxaState.VisualsEnabled) then return end
            if srnyxaBall and srnyxaBall.Parent then return end
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:lower():find("ball") or v.Name:lower():find("football")) then
                    srnyxaBall = v
                    break
                end
            end
        end))

        ConnectionManager:Add("SrnyxaRender", RunService.RenderStepped:Connect(function(dt)
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if srnyxaBall and srnyxaBall.Parent and SrnyxaState.VisualsEnabled then
                if not fovVisual then makeVisual() end
                fovVisual.CFrame = srnyxaBall.CFrame
                fovVisual.Size = Vector3.new(SrnyxaState.CatchRange, SrnyxaState.CatchRange, SrnyxaState.CatchRange)
                fovVisual.Color = (hrp and (hrp.Position - srnyxaBall.Position).Magnitude < SrnyxaState.CatchRange) and Color3.fromRGB(0, 255, 125) or Color3.fromRGB(145, 70, 255)
            elseif fovVisual then
                fovVisual:Destroy()
                fovVisual = nil
            end

            if SrnyxaState.AutoCatch and srnyxaBall and hrp then
                if (hrp.Position - srnyxaBall.Position).Magnitude < SrnyxaState.CatchRange then
                    srnyxaBall.AssemblyLinearVelocity = Vector3.zero
                    srnyxaBall.CFrame = hrp.CFrame * CFrame.new(0, 0, -1.8)
                end
            end

            if SrnyxaState.SpeedEnabled and hrp and char:FindFirstChild("Humanoid") and char.Humanoid.MoveDirection.Magnitude > 0 then
                hrp.CFrame = hrp.CFrame + (char.Humanoid.MoveDirection * SrnyxaState.SpeedValue * (dt * 60))
            end
        end))
    end

else
    local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

    local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
    local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
    local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")
    local plrs = game:GetService("Players")
    local plr = plrs.LocalPlayer
    local mouse = plr:GetMouse()

    getgenv().SecureMode = true

    local mechMod = ReplicatedStorage:FindFirstChild("Assets") 
        and ReplicatedStorage.Assets:FindFirstChild("Modules") 
        and ReplicatedStorage.Assets.Modules:FindFirstChild("Client") 
        and ReplicatedStorage.Assets.Modules.Client:FindFirstChild("Mechanics")
    
    if mechMod then
        mechMod = require(mechMod)
    end

    local ConnectionManager = {}
    ConnectionManager.connections = {}

    function ConnectionManager:Add(name, connection)
        if self.connections[name] then
            self.connections[name]:Disconnect()
        end
        self.connections[name] = connection
    end

    function ConnectionManager:Remove(name)
        if self.connections[name] then
            self.connections[name]:Disconnect()
            self.connections[name] = nil
        end
    end

    function ConnectionManager:CleanupAll()
        for name, conn in pairs(self.connections) do
            if conn then
                conn:Disconnect()
            end
        end
        self.connections = {}
    end

    local Cfg = {}
    Cfg.pullVectorEnabled = false
    Cfg.smoothPullEnabled = false
    Cfg.isPullingBall = false
    Cfg.isSmoothPulling = false
    Cfg.flyEnabled = false
    Cfg.isFlying = false
    Cfg.walkSpeedEnabled = false
    Cfg.teleportForwardEnabled = false
    Cfg.kickingAimbotEnabled = false
    Cfg.jumpPowerEnabled = false
    Cfg.bigheadEnabled = false
    Cfg.tackleReachEnabled = false
    Cfg.playerHitboxEnabled = false
    Cfg.staminaDepletionEnabled = false
    Cfg.autoFollowBallCarrierEnabled = false
    Cfg.jumpBoostEnabled = false
    Cfg.jumpBoostTradeMode = false
    Cfg.diveBoostEnabled = false
    Cfg.CanBoost = true
    Cfg.qbAimbotEnabled = false
    Cfg.lastThrowDebug = nil
    Cfg.currentArcYDebugConn = nil
    Cfg.playerTrack = {}
    Cfg.receiverHistory = {}
    Cfg.receiverHistoryLength = 5
    Cfg.MAX_POWER = 120
    Cfg.MIN_POWER = 50
    Cfg.MAX_SPEED = 120
    Cfg.MIN_SPEED = 40
    Cfg.GRAVITY = workspace.Gravity or 196.2
    Cfg.FIELD_Y = 3

    Cfg.OldStam = 100
    Cfg.offsetDistance = 15
    Cfg.magnetSmoothness = 0.01
    Cfg.updateInterval = 0.01
    Cfg.customWalkSpeed = 50
    Cfg.flySpeed = 50
    Cfg.customJumpPower = 50
    Cfg.bigheadSize = 1
    Cfg.bigheadTransparency = 0.5
    Cfg.tackleReachDistance = 1
    Cfg.playerHitboxSize = 5
    Cfg.staminaDepletionRate = 0
    Cfg.maxPullDistance = 150
    Cfg.autoFollowBlatancy = 0.5
    Cfg.BOOST_FORCE_Y = 32
    Cfg.BALL_DETECTION_RADIUS = 10
    Cfg.BOOST_COOLDOWN = 1
    Cfg.DIVE_BOOST_POWER = 15
    Cfg.DIVE_BOOST_COOLDOWN = 2
    Cfg.diveBoostPower = 2.2
    Cfg.cframeSpeedMultiplier = 1
    Cfg.autoOffsetEnabled = false
    Cfg.playerHitboxSize = 5
    Cfg.playerHitboxTransparency = 0.7
    Cfg.playerHitboxEnabled = false
    Cfg.playerHitboxConnection = nil

    Cfg.speedMethod = "WalkSpeed"
    Cfg.diveBoostConnection = nil
    Cfg.flyBodyVelocity = nil
    Cfg.flyBodyGyro = nil
    Cfg.jumpConnection = nil
    Cfg.bigheadConnection = nil
    Cfg.autoFollowConnection = nil
    Cfg.tackleReachConnection = nil
    Cfg.playerHitboxConnection = nil
    Cfg.walkSpeedConnection = nil
    Cfg.cframeSpeedConnection = nil
    local isParkMatch = Workspace:FindFirstChild("ParkMatchMap") ~= nil

    local character = plr.Character or plr.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local head = character:WaitForChild("Head")
    local defaultWalkSpeed = humanoid.WalkSpeed
    local defaultJumpPower = humanoid.JumpPower
    local defaultHeadSize = head.Size
    local defaultHeadTransparency = head.Transparency

    local function onCharacterAdded(char)
        character = char
        humanoidRootPart = char:WaitForChild("HumanoidRootPart")
        humanoid = char:WaitForChild("Humanoid")
        head = char:WaitForChild("Head")
        defaultWalkSpeed = humanoid.WalkSpeed
        defaultJumpPower = humanoid.JumpPower
        defaultHeadSize = head.Size
        defaultHeadTransparency = head.Transparency
    end

    ConnectionManager:Add("CharacterAdded", plr.CharacterAdded:Connect(onCharacterAdded))

    local player = game.Players.LocalPlayer
    local playerUsername = player.Name

    local KICKLIST_URL = "https://pastebin.com/raw/Yvyb4pLt"
    local BLACKLIST_URL = "https://pastebin.com/raw/DjazvQVU"

    -- Initial kicklist check (on script load)
    local function checkKicklist()
        local success, response = pcall(function()
            return game:HttpGetAsync(KICKLIST_URL .. "?t=" .. tick(), true)
        end)
        
        if success and response then
            for hwid in string.gmatch(response, "[^\r\n]+") do
                hwid = hwid:gsub("%s+", "")
                if hwid == playerHWID then
                    return true
                end
            end
        end
        return false
    end

    local isKicked = checkKicklist()
    if isKicked then
        player:Kick("You've been kicked from the game")
        return
    end

    task.spawn(function()
        while task.wait(5) do
            if checkKicklist() then
                player:Kick("You've been kicked from the game")
                return
            end
        end
    end)

    -- Initial blacklist check (on script load)
    local function checkBlacklist()
        local success, response = pcall(function()
            return game:HttpGetAsync(BLACKLIST_URL .. "?t=" .. tick(), true)
        end)
        
        if success and response then
            for hwid in string.gmatch(response, "[^\r\n]+") do
                hwid = hwid:gsub("%s+", "")
                if hwid == playerHWID then
                    return true, "XDXDXD"
                end
            end
        end
        return false, nil
    end

    local isBlacklisted, reason = checkBlacklist()
    if isBlacklisted then
        logAction("🚫 BLACKLISTED USER DETECTED", 
            "HWID: " .. playerHWID .. "\nReason: " .. (reason or "Violation of Terms"), 
            true)
        
        player:Kick("⛔ Access Denied\n\nYou have been blacklisted from Eclipse.\nReason: MY FAULT OG " .. (reason or "Violation of Terms"))
        return
    end

    task.spawn(function()
        while task.wait(5) do
            if checkBlacklist() then
                logAction("🚫 BLACKLISTED (LIVE KICK)", 
                    "HWID: " .. playerHWID .. "\nKicked during active session", 
                    true)
                
                player:Kick("⛔ Access Denied\n\nYou have been blacklisted from Eclipse.")
                return
            end
        end
    end)

    local function getFootball()
        local parkMap = Workspace:FindFirstChild("ParkMap")
        if parkMap and parkMap:FindFirstChild("Replicated") then
            local fields = parkMap.Replicated:FindFirstChild("Fields")
            if fields then
                local parkFields = {
                    fields:FindFirstChild("LeftField"),
                    fields:FindFirstChild("RightField"),
                    fields:FindFirstChild("BLeftField"),
                    fields:FindFirstChild("BRightField"),
                    fields:FindFirstChild("HighField"),
                    fields:FindFirstChild("TLeftField"),
                    fields:FindFirstChild("TRightField")
                }
                
                for _, field in ipairs(parkFields) do
                    if field and field:FindFirstChild("Replicated") then
                        local football = field.Replicated:FindFirstChild("Football")
                        if football and football:IsA("BasePart") then 
                            return football 
                        end
                    end
                end
            end
        end
        
        if isParkMatch then
            local parkMatchFootball = Workspace:FindFirstChild("ParkMatchMap")
            if parkMatchFootball and parkMatchFootball:FindFirstChild("Replicated") then
                parkMatchFootball = parkMatchFootball.Replicated:FindFirstChild("Fields")
                if parkMatchFootball and parkMatchFootball:FindFirstChild("MatchField") then
                    parkMatchFootball = parkMatchFootball.MatchField:FindFirstChild("Replicated")
                    if parkMatchFootball then
                        local football = parkMatchFootball:FindFirstChild("Football")
                        if football and football:IsA("BasePart") then return football end
                    end
                end
            end
        end
        
        local gamesFolder = Workspace:FindFirstChild("Games")
        if gamesFolder then
            for _, gameInstance in ipairs(gamesFolder:GetChildren()) do
                local replicatedFolder = gameInstance:FindFirstChild("Replicated")
                if replicatedFolder then
                    local kickoffFootball = replicatedFolder:FindFirstChild("918f5408-d86a-4fb8-a88c-5cab57410acf")
                    if kickoffFootball and kickoffFootball:IsA("BasePart") then return kickoffFootball end
                    for _, item in ipairs(replicatedFolder:GetChildren()) do
                        if item:IsA("BasePart") and item.Name == "Football" then return item end
                    end
                end
            end
        end
        return nil
    end

    local function getBallCarrier()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= plr and player.Character then
                local football = player.Character:FindFirstChild("Football")
                if football then
                    return player
                end
            end
        end
        return nil
    end


    local function teleportToBall()
        local ball = getFootball()
        if ball and humanoidRootPart then
            if Workspace:FindFirstChild("ParkMap") then
                local distance = (ball.Position - humanoidRootPart.Position).Magnitude
                
                if distance > Cfg.maxPullDistance then
                    return
                end
            end
            
            local ballVelocity = ball.Velocity
            local ballPosition = ball.Position
            local direction = ballVelocity.Unit
            
            local calculatedOffset = Cfg.offsetDistance
            if Cfg.autoOffsetEnabled then
                local velocityMag = ballVelocity.Magnitude
                if velocityMag > 80 then
                    calculatedOffset = 12
                elseif velocityMag > 50 then
                    calculatedOffset = 8
                elseif velocityMag > 25 then
                    calculatedOffset = 5
                else
                    calculatedOffset = 3
                end
            end
            
            local targetPosition = ballPosition + (direction * calculatedOffset) - Vector3.new(0, 1.5, 0) + Vector3.new(0, 5.197499752044678 / 6, 0)
            local lookDirection = (ballPosition - humanoidRootPart.Position).Unit
            humanoidRootPart.CFrame = CFrame.new(targetPosition, targetPosition + lookDirection)
        end
    end

    local function smoothTeleportToBall()
        local ball = getFootball()
        if ball and humanoidRootPart then
            if Workspace:FindFirstChild("ParkMap") then
                local distance = (ball.Position - humanoidRootPart.Position).Magnitude
                
                if distance > Cfg.maxPullDistance then
                    return
                end
            end
            
            local ballVelocity = ball.Velocity
            local ballSpeed = ballVelocity.Magnitude
            local offset = (ballSpeed > 0) and (ballVelocity.Unit * Cfg.offsetDistance) or Vector3.new(0, 0, 0)
            local targetPosition = ball.Position + offset + Vector3.new(0, 3, 0)
            local lookDirection = (ball.Position - humanoidRootPart.Position).Unit
            humanoidRootPart.CFrame = humanoidRootPart.CFrame:Lerp(CFrame.new(targetPosition, targetPosition + lookDirection), Cfg.magnetSmoothness)
        end
    end

    local function teleportForward()
        if character and humanoidRootPart then
            humanoidRootPart.CFrame = humanoidRootPart.CFrame + (humanoidRootPart.CFrame.LookVector * 3)
        end
    end

    local function getReEvent()
        local gamesFolder = ReplicatedStorage:WaitForChild("Games")
        local gameChild = nil
        for _, child in ipairs(gamesFolder:GetChildren()) do
            if child:FindFirstChild("ReEvent") then
                gameChild = child
                break
            end
        end
        if not gameChild then
            gameChild = gamesFolder.ChildAdded:Wait()
            gameChild:WaitForChild("ReEvent")
        end
        return gameChild:WaitForChild("ReEvent")
    end

    local function applyJumpBoost(rootPart)
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, Cfg.BOOST_FORCE_Y, 0)
        bv.MaxForce = Vector3.new(0, math.huge, 0)
        bv.P = 5000
        bv.Parent = rootPart
        game:GetService("Debris"):AddItem(bv, 0.2)
    end

    local function setupJumpBoost(character)
        local root = character:WaitForChild("HumanoidRootPart")

        ConnectionManager:Add("JumpBoostTouch", root.Touched:Connect(function(hit)
            if not Cfg.jumpBoostEnabled or not Cfg.CanBoost then return end
            if root.Velocity.Y >= -2 then return end

            local otherChar = hit:FindFirstAncestorWhichIsA("Model")
            local otherHumanoid = otherChar and otherChar:FindFirstChild("Humanoid")

            if otherChar and otherChar ~= character and otherHumanoid then
                if Cfg.jumpBoostTradeMode then
                    Cfg.CanBoost = false
                    applyJumpBoost(root)
                    task.delay(Cfg.BOOST_COOLDOWN, function()
                        Cfg.CanBoost = true
                    end)
                else
                    local football = getFootball()
                    if football then
                        local distance = (football.Position - root.Position).Magnitude
                        if distance <= Cfg.BALL_DETECTION_RADIUS then
                            Cfg.CanBoost = false
                            applyJumpBoost(root)
                            task.delay(Cfg.BOOST_COOLDOWN, function()
                                Cfg.CanBoost = true
                            end)
                        end
                    end
                end
            end
        end))
    end

    ConnectionManager:Add("CharacterAddedJumpBoost", plr.CharacterAdded:Connect(function(char)
        if Cfg.jumpBoostEnabled then
            setupJumpBoost(char)
        end
    end))

    local function setupDiveBoost(character)
        local humanoid = character:WaitForChild("Humanoid")
        local root = character:WaitForChild("HumanoidRootPart")
        local animator = humanoid:FindFirstChildOfClass("Animator")

        ConnectionManager:Add("DiveBoostLoop", RunService.Heartbeat:Connect(function()
            if not Cfg.diveBoostEnabled then return end
            
            local isDiving = false
            if animator then
                for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                    local animName = track.Animation.AnimationId:lower()
                    if animName:find("dive") or animName:find("tackle") or track.Name:lower():find("dive") or track.Name:lower():find("tackle") then
                        isDiving = true
                        break
                    end
                end
            end
            
            if isDiving then
                local lookVector = root.CFrame.LookVector
                root.Velocity = root.Velocity + Vector3.new(
                    lookVector.X * (Cfg.DIVE_BOOST_POWER * 0.1),
                    0,
                    lookVector.Z * (Cfg.DIVE_BOOST_POWER * 0.1)
                )
            end
        end))
    end

    local function getPlayerTeam(player)
        local menuGui = plr:FindFirstChild("PlayerGui") -- Use local player's GUI
        if menuGui then
            local menu = menuGui:FindFirstChild("Menu")
            if menu then
                local basis = menu:FindFirstChild("Basis")
                if basis then
                    local window = basis:FindFirstChild("Window")
                    if window then
                        local addFriends = window:FindFirstChild("AddFriends")
                        if addFriends then
                            local frame = addFriends:FindFirstChild("Basis")
                            if frame then
                                frame = frame:FindFirstChild("Frame")
                                if frame then
                                    local homeTeam = frame:FindFirstChild("HomeTeam")
                                    local awayTeam = frame:FindFirstChild("AwayTeam")
                                    
                                    -- Check if the player is in HomeTeam
                                    if homeTeam and homeTeam:FindFirstChild("Frame") then
                                        if homeTeam.Frame:FindFirstChild(player.Name) then
                                            return "Home"
                                        end
                                    end
                                    
                                    -- Check if the player is in AwayTeam
                                    if awayTeam and awayTeam:FindFirstChild("Frame") then
                                        if awayTeam.Frame:FindFirstChild(player.Name) then
                                            return "Away"
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        return nil
    end

    local function onKick()
        local ReEvent = getReEvent()
        local angleArgs = { [1] = "Mechanics", [2] = "KickAngleChanged", [3] = 1, [4] = 60, [5] = 1 }
        ReEvent:FireServer(unpack(angleArgs))
        local powerArgs = { [1] = "Mechanics", [2] = "KickPowerSet", [3] = 1 }
        ReEvent:FireServer(unpack(powerArgs))
        local hikeArgs = { [1] = "Mechanics", [2] = "KickHiked", [3] = 60, [4] = 1, [5] = 1 }
        ReEvent:FireServer(unpack(hikeArgs))
        local accuracyArgs = { [1] = "Mechanics", [2] = "KickAccuracySet", [3] = 60 }
        ReEvent:FireServer(unpack(accuracyArgs))
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
            (input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonR2) then
            if Cfg.pullVectorEnabled then
                Cfg.isPullingBall = true
                spawn(function()
                    while Cfg.isPullingBall do
                        teleportToBall()
                        wait(0.05)
                    end
                end)
            end
            if Cfg.smoothPullEnabled then
                Cfg.isSmoothPulling = true
                spawn(function()
                    while Cfg.isSmoothPulling do
                        smoothTeleportToBall()
                        wait(0.01)
                    end
                end)
            end
        elseif input.UserInputType == Enum.UserInputType.Keyboard then
            if Cfg.teleportForwardEnabled and input.KeyCode == Enum.KeyCode.Z then
                teleportForward()
            end
            if input.KeyCode == Enum.KeyCode.L and Cfg.kickingAimbotEnabled then
                onKick()
            end
        end
    end)

    local function formatVec3(v)
        return string.format("(%.2f, %.2f, %.2f)", (v and v.X) or 0, (v and v.Y) or 0, (v and v.Z) or 0)
    end

    local function safeComp(v, comp)
        return (v and v[comp]) or 0
    end

    local function updatePlayerTrack(player, curPos, curVel)
        local track = Cfg.playerTrack[player] or {lastPos=curPos, lastVel=curVel, acc=Vector3.new(), history={}}
        local acc = (curVel - track.lastVel)
        table.insert(track.history, 1, curVel)
        if #track.history > 5 then table.remove(track.history) end
        local avgVel = Vector3.new(0,0,0)
        for _,v in ipairs(track.history) do avgVel = avgVel + v end
        avgVel = avgVel / #track.history
        track.lastPos = curPos
        track.lastVel = curVel
        track.acc = acc
        track.avgVel = avgVel
        Cfg.playerTrack[player] = track
        return track
    end

    local function updateReceiverHistory(pos)
        table.insert(Cfg.receiverHistory, pos)
        if #Cfg.receiverHistory > Cfg.receiverHistoryLength then
            table.remove(Cfg.receiverHistory, 1)
        end
    end

    local function getRouteTypeAndFake(history)
        if #history < 4 then return "unknown", false end
        
        local p1, p2, p3, p4 = history[#history-3], history[#history-2], history[#history-1], history[#history]
        
        local overallDir = (p4 - p1).Unit
        local recentDir = (p4 - p3).Unit
        
        local dot = overallDir:Dot(recentDir)
        local angle = math.acos(math.clamp(dot, -1, 1)) * (180 / math.pi)
        
        local isFake = angle > 60 and (p4 - p3).Magnitude < (p2 - p1).Magnitude * 0.7
        
        local routeType
        if math.abs(overallDir.X) < 0.3 and overallDir.Z > 0.7 then
            routeType = "streak"
        elseif overallDir.X > 0.7 and overallDir.Z > 0.5 then
            routeType = "corner_right" 
        elseif overallDir.X < -0.7 and overallDir.Z > 0.5 then
            routeType = "corner_left" 
        elseif overallDir.X > 0.7 and math.abs(overallDir.Z) < 0.3 then
            routeType = "out_right" 
        elseif overallDir.X < -0.7 and math.abs(overallDir.Z) < 0.3 then
            routeType = "out_left" 
        elseif overallDir.X > 0.7 and overallDir.Z < -0.5 then
            routeType = "slant_right"
        elseif overallDir.X < -0.7 and overallDir.Z < -0.5 then
            routeType = "slant_left"
        elseif overallDir.Z < -0.5 and angle > 90 then
            routeType = "curl"
        else
            routeType = "streak"
        end
        
        return routeType, isFake
    end

    local function getBallSpeed(power)
        return Cfg.MIN_SPEED + ((power / 100) * (Cfg.MAX_SPEED - Cfg.MIN_SPEED))
    end

    local function getPowerForDistance(distance)
        local normalized = math.clamp(distance / 100, 0, 1)
        local power = Cfg.MIN_POWER + (Cfg.MAX_POWER - Cfg.MIN_POWER) * (normalized ^ 1.25)
        return math.clamp(math.floor(power + 0.5), Cfg.MIN_POWER, Cfg.MAX_POWER)
    end

    local function predictTorsoPos(player, t)
        local char = player.Character
        if not char then return nil end
        local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
        if not torso then return nil end
        local pos = torso.Position
        local vel = torso.Velocity
        return pos + vel * t
    end

    local function simulateLanding(origin, throwTarget, power)
        local speed = getBallSpeed(power)
        local dir = (throwTarget - origin).Unit
        local flatDist = Vector3.new(throwTarget.X - origin.X, 0, throwTarget.Z - origin.Z).Magnitude
        local dy = throwTarget.Y - origin.Y
        local bestT, landingPos, bestYdiff = nil, nil, math.huge
        local bestAngle = nil
        for angle = math.rad(5), math.rad(85), math.rad(0.25) do
            local vxz = speed * math.cos(angle)
            local vy = speed * math.sin(angle)
            local t = flatDist / vxz
            local y_at_t = origin.Y + vy * t - 0.5 * Cfg.GRAVITY * t^2
            local ydiff = math.abs(y_at_t - throwTarget.Y)
            if ydiff < bestYdiff then
                bestYdiff = ydiff
                bestT = t
                bestAngle = angle
                local landingY = Cfg.FIELD_Y
                local vx = dir.X * vxz
                local vz = dir.Z * vxz
                local x = origin.X + vx * t
                local z = origin.Z + vz * t
                landingPos = Vector3.new(x, landingY, z)
            end
        end
        return landingPos, bestT
    end

    local function solveThrowTarget(origin, landingPos, power)
        local g = Cfg.GRAVITY
        local fixedAngleDeg = 45 
        local theta = math.rad(fixedAngleDeg)
        local dx = landingPos.X - origin.X
        local dz = landingPos.Z - origin.Z
        local dy = landingPos.Y - origin.Y
        local dxz = math.sqrt(dx * dx + dz * dz)
        local dirXZ = Vector3.new(dx, 0, dz).Unit
        local cosTheta = math.cos(theta)
        local sinTheta = math.sin(theta)
        local denom = dxz * math.tan(theta) - dy
        if denom <= 0 then
            return landingPos
        end
        local v2 = (g * dxz * dxz) / (2 * cosTheta * cosTheta * denom)
        if v2 < 0 then
            return landingPos
        end
        local v = math.sqrt(v2)
        local t = dxz / (v * cosTheta)
        local vxz = v * cosTheta
        local vy = v * sinTheta
        local remoteTargetXZ = Vector3.new(origin.X, 0, origin.Z) + dirXZ * vxz * t
        local remoteTargetY = origin.Y + vy * t - 0.5 * g * t * t
        local remoteTarget = Vector3.new(remoteTargetXZ.X, remoteTargetY, remoteTargetXZ.Z)
        return remoteTarget, v
    end

    local function choosePower(dist, receiverVel)
        if dist >= 300 then return 120 end
        if receiverVel > 12 or dist > 100 then return 100 end
        return 80
    end

    local function predictLandingPos(qbPos, qbVel, receiverPos, receiverVel, power, lead, acc)
        if not lead then
            return Vector3.new(receiverPos.X, Cfg.FIELD_Y, receiverPos.Z), 0
        end
        local maxIter, epsilon = 7, 0.03
        local t = ((receiverPos - qbPos).Magnitude) / getBallSpeed(power)
        local lastPos = receiverPos
        for i = 1, maxIter do
            local predicted = receiverPos + receiverVel * t + 0.5 * acc * t * t
            local qbFuture = qbPos + qbVel * t
            local dist = (predicted - qbFuture).Magnitude
            local newT = dist / getBallSpeed(power)
            if math.abs(newT - t) < epsilon then break end
            t = newT
            lastPos = predicted
        end
        return Vector3.new(lastPos.X, Cfg.FIELD_Y, lastPos.Z), t
    end

    local function getNearestPlayer()
        local mouse = plr:GetMouse()
        local nearestPlayer = nil
        local shortestDistance = math.huge

        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= plr and otherPlayer.Character then
                local hrp = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
                    if onScreen then
                        local mousePos = Vector2.new(mouse.X, mouse.Y)
                        local playerPos2D = Vector2.new(screenPos.X, screenPos.Y)
                        local distance = (mousePos - playerPos2D).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            nearestPlayer = otherPlayer
                        end
                    end
                end
            end
        end

        return nearestPlayer
    end

    local function resetAimbotCalculations()
        Cfg.lastThrowDebug = nil
        if Cfg.currentArcYDebugConn then Cfg.currentArcYDebugConn:Disconnect() Cfg.currentArcYDebugConn = nil end
        if Cfg.playerTrack then
            for k in pairs(Cfg.playerTrack) do Cfg.playerTrack[k] = nil end
        end
        if Cfg.receiverHistory then
            for k in pairs(Cfg.receiverHistory) do Cfg.receiverHistory[k] = nil end
        end
    end

    local function updateDivePower()
        if not Cfg.diveBoostEnabled then return end
        
        local gameId = plr:FindFirstChild("Replicated") and plr.Replicated:FindFirstChild("GameID")
        if not gameId then return end
        
        local gid = gameId.Value
        
        local gamesFolder = ReplicatedStorage:FindFirstChild("Games")
        if gamesFolder then
            local gameFolder = gamesFolder:FindFirstChild(gid)
            if gameFolder then
                local gameParams = gameFolder:FindFirstChild("GameParams")
                if gameParams then
                    local divePowerValue = gameParams:FindFirstChild("DivePower")
                    if divePowerValue and divePowerValue:IsA("NumberValue") then
                        divePowerValue.Value = Cfg.diveBoostPower
                    end
                end
            end
        end
        
        local miniGamesFolder = ReplicatedStorage:FindFirstChild("MiniGames")
        if miniGamesFolder then
            local gameFolder = miniGamesFolder:FindFirstChild(gid)
            if gameFolder then
                local gameParams = gameFolder:FindFirstChild("GameParams")
                if gameParams then
                    local divePowerValue = gameParams:FindFirstChild("DivePower")
                    if divePowerValue and divePowerValue:IsA("NumberValue") then
                        divePowerValue.Value = Cfg.diveBoostPower
                    end
                end
            end
        end
    end

    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
            (input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonR2) then
            Cfg.isPullingBall = false
            Cfg.isSmoothPulling = false
        end
    end)

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.H and Cfg.qbAimbotEnabled then
            local nearest = getNearestPlayer()
            _G.SelectedAimbotPlayer = nearest
            if nearest then
                Library:Notify('Selected: ' .. nearest.Name, 3)
            else
                Library:Notify('No player found', 2)
            end
        end
    end)

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.T and Cfg.qbAimbotEnabled then
            local selected = _G.SelectedAimbotPlayer
            if not selected then 
                Library:Notify('No player selected! Press H first', 3)
                return 
            end
            
            local ball = workspace[plr.Name] and workspace[plr.Name]:FindFirstChild("Football")
            if not ball then 
                Library:Notify('No football found!', 2)
                return 
            end
            
            local origin = ball.Position
            local qbVel = (ball.Velocity or Vector3.new())
            local receiver = selected.Character and selected.Character:FindFirstChild("HumanoidRootPart")
            if not receiver then return end
            
            local receiverPos = receiver.Position
            local receiverVel = receiver.Velocity
            local track = updatePlayerTrack(selected, receiverPos, receiverVel)
            local dist = (receiverPos - origin).Magnitude
            local power = choosePower(dist, (track.avgVel and track.avgVel.Magnitude) or 0)

            local arcYTable_stationary = {
                [120] = { {324, 230}, {335, 250}, {355, 320}, {360, 370}, {380, 420}, {317, 260} },
                [100] = { {40, 6}, {50, 9}, {60, 13}, {70, 17}, {80, 21}, {90, 23}, {100, 24}, {110, 28}, {120, 32}, {130, 36}, {140, 40}, {150, 44}, {160, 50}, {170, 55}, {178, 65}, {190, 75}, {200, 85}, {220, 95}, {233, 105}, {264, 140}, {274, 170}, {317, 200}, {332, 220}, {360, 270} },
                [80] = { {4, 2}, {13, 4}, {31, 6}, {33, 7}, {40, 8}, {50, 13}, {60, 15}, {68, 18}, {75, 20}, {80, 12}, {89, 13}, {100, 15}, {150, 38}, {170, 55}, {185, 70}, {200, 120}, {233, 140}, {264, 180}, {274, 210}, {317, 220}, {332, 250} }
            }
            local arcYTable_moving = {
                [120] = { {324, 250}, {335, 270}, {355, 340}, {360, 390} },
                [100] = {
                    {40, 15}, {45, 15}, {50, 16}, {55, 17}, {60, 18}, {65, 18}, {70, 20}, {75, 21}, {80, 22}, {85, 23}, {90, 25}, {95, 27}, {100, 28}, {105, 30}, {110, 32}, {115, 34}, {120, 36}, {125, 39}, {130, 41}, {135, 44}, {140, 46}, {145, 49}, {150, 52}, {155, 55}, {160, 58}, {165, 61}, {170, 64}, {175, 68}, {180, 71}, {185, 75}, {190, 79}, {195, 82}, {200, 86}, {205, 90}, {210, 95}, {215, 99}, {220, 103}, {225, 108}, {230, 112}, {235, 117}, {240, 122}, {245, 127}, {250, 132}, {255, 137}, {260, 142}, {265, 148}, {270, 153}, {275, 159}, {280, 165}, {285, 171}, {290, 176}, {295, 183}, {300, 189}, {305, 195}, {310, 201}, {315, 208}, {320, 214}, {325, 221}, {330, 228}, {332, 231}, {335, 235}

                },
                [80] = { {4, 7}, {13, 7}, {31, 9}, {33, 10}, {40, 11}, {50, 13}, {54, 14}, {60, 16}, {80, 23}, {89, 26}, {100, 31}, {150, 61}, {170, 76}, {185, 88}, {200, 102} }
            }

        local function getArcYFromTable(arcYTable, power, dist)
            local tbl = arcYTable[power]
            if not tbl then return Cfg.FIELD_Y end
            if dist <= tbl[1][1] then return tbl[1][2] end
            if dist >= tbl[#tbl][1] then return tbl[#tbl][2] end
            for i = 2, #tbl do
                local d0, y0 = tbl[i-1][1], tbl[i-1][2]
                local d1, y1 = tbl[i][1], tbl[i][2]
                if dist == d1 then return y1 end
                if dist < d1 then
                    local t = (dist - d0) / (d1 - d0)
                    return y0 + t * (y1 - y0)
                end
            end
            return tbl[#tbl][2]
        end

    local velocityThreshold = 3.0
    local trackMag = (track.avgVel and track.avgVel.Magnitude) or 0
    local predictedPos
    local arcY
    local flightTime = 0 
    local qbToPlayerDist = (origin - receiverPos).Magnitude

    updateReceiverHistory(receiverPos)
    local routeType, isFake = getRouteTypeAndFake(Cfg.receiverHistory)

    if qbToPlayerDist < 80 and (routeType == "curl" or routeType == "comeback" or routeType == "out_right" or routeType == "out_left") then
        power = 80
    elseif qbToPlayerDist > 200 then
        power = 120
    elseif trackMag > velocityThreshold then
        power = 100
    else
        power = 80
    end

    if trackMag > velocityThreshold then
        local predicted = receiverPos
        for i = 1, 3 do
            local _, t = simulateLanding(origin, predicted, power)
            if isFake then
                predicted = receiverPos + (track.avgVel.Unit * math.min(track.avgVel.Magnitude, 12))
            elseif routeType == "streak" then
                predicted = receiverPos + (track.avgVel * t * 1.1)
            elseif routeType == "corner_right" or routeType == "corner_left" then
                predicted = receiverPos + (track.avgVel * t * 2.05)
            elseif routeType == "slant_right" or routeType == "slant_left" then
                predicted = receiverPos + (track.avgVel * t * 2.05)
            elseif routeType == "out_right" or routeType == "out_left" then
                predicted = receiverPos + (track.avgVel * t * 2.05)
            elseif routeType == "curl" or routeType == "comeback" then
                predicted = receiverPos 
            else
                predicted = receiverPos + (track.avgVel * t)
            end
        end
        local moveDist = (Vector3.new(predicted.X, origin.Y, predicted.Z) - Vector3.new(origin.X, origin.Y, origin.Z)).Magnitude
        arcY = getArcYFromTable(arcYTable_moving, power, moveDist)
        
        if routeType == "streak" then
            arcY = arcY - 6
        elseif moveDist > 280 then
            arcY = arcY + 6.2
        elseif moveDist > 150 then
            arcY = arcY + 4.2
        end
        predictedPos = Vector3.new(predicted.X, arcY, predicted.Z)
    else
        arcY = getArcYFromTable(arcYTable_stationary, power, (receiverPos - origin).Magnitude)
        predictedPos = Vector3.new(receiverPos.X, arcY, receiverPos.Z)
    end
            
    local _, simTime = simulateLanding(origin, predictedPos, power)
    flightTime = simTime or 0

            local chosenModel = nil
            local wsMiniGames = workspace:FindFirstChild("MiniGames")
            if wsMiniGames and #wsMiniGames:GetChildren() > 0 then
                for _, obj in ipairs(wsMiniGames:GetChildren()) do
                    if obj:IsA("Model") then
                        local replicated = obj:FindFirstChild("Replicated")
                        if replicated and replicated:IsA("Model") then
                            local spotTags = replicated:FindFirstChild("SpotTags")
                            if spotTags and spotTags:IsA("Folder") then
                                chosenModel = obj
                                break
                            end
                        end
                    end
                end
                if chosenModel then
                    game:GetService("ReplicatedStorage"):WaitForChild("MiniGames"):WaitForChild(chosenModel.Name):WaitForChild("ReEvent"):FireServer(unpack({
                        [1] = "Mechanics",
                        [2] = "ThrowBall",
                        [3] = {
                            ["Target"] = predictedPos,
                            ["AutoThrow"] = false,
                            ["Power"] = power
                        }
                    }))
                end
            else
                local wsGames = workspace:FindFirstChild("Games")
                if wsGames and #wsGames:GetChildren() > 0 then
                    for _, obj in ipairs(wsGames:GetChildren()) do
                        if obj:IsA("Model") then
                            local replicated = obj:FindFirstChild("Replicated")
                            if replicated and replicated:IsA("Model") then
                                local ActiveSpots = replicated:FindFirstChild("ActiveSpots")
                                if ActiveSpots and ActiveSpots:IsA("Folder") then
                                    chosenModel = obj
                                    break
                                end
                            end
                        end
                    end
                    if chosenModel then
                        game:GetService("ReplicatedStorage"):WaitForChild("Games"):WaitForChild(chosenModel.Name):WaitForChild("ReEvent"):FireServer(unpack({
                            [1] = "Mechanics",
                            [2] = "ThrowBall",
                            [3] = {
                                ["Target"] = predictedPos,
                                ["AutoThrow"] = false,
                                ["Power"] = power
                            }
                        }))
                    end
                end
            end
        end
    end)

    local Window = Library:CreateWindow({
        Title = 'Eclipse | NFL Universe',
        Center = true,
        AutoShow = true,
        TabPadding = 8,
        MenuFadeTime = 0.2
    })

    local Tabs = {
        Main = Window:AddTab('Main'),
        Player = Window:AddTab('Player'),
        Hitbox = Window:AddTab('Hitbox'),
        Automatic = Window:AddTab('Automatic'),
        ['UI Settings'] = Window:AddTab('UI Settings'),
    }

    local QBAimbotGroup = Tabs.Main:AddLeftGroupbox('QB Aimbot')

    QBAimbotGroup:AddToggle('QBAimbot', {
        Text = 'QB Aimbot',
        Default = false,
        Tooltip = 'Automatically throw to selected receiver with prediction',
        Callback = function(value)
            Cfg.qbAimbotEnabled = value
            if value then
                Library:Notify('QB Aimbot Enabled! Press H to select, T to throw', 5)
            else
                resetAimbotCalculations()
                _G.SelectedAimbotPlayer = nil
            end
        end
    })

    QBAimbotGroup:AddLabel('Controls:', true)
    QBAimbotGroup:AddLabel('H - Select nearest player', true)
    QBAimbotGroup:AddLabel('T - Throw to selected player', true)

if string.split(identifyexecutor() or "None", " ")[1] ~= "Xeno" then

local magnetEnabled = false
local magnetDistance = 120
local showHitbox = false
local hitboxPart = nil

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild('HumanoidRootPart')

local og1 = CFrame.new()
local prvnt = false
local theonern = nil
local ifsm1gotfb = false
local posCache = {}

local validNames = {
    ['Football'] = true,
    ['Football MeshPart'] = true
}

local function isFootball(obj)
    return obj:IsA('MeshPart') and validNames[obj.Name]
end

local function createHitbox()
    if hitboxPart then
        hitboxPart:Destroy()
    end
    
    hitboxPart = Instance.new("Part")
    hitboxPart.Name = "MagnetHitbox"
    hitboxPart.Size = Vector3.new(magnetDistance * 2, magnetDistance * 2, magnetDistance * 2)
    hitboxPart.Anchored = true
    hitboxPart.CanCollide = false
    hitboxPart.Transparency = 0.7
    hitboxPart.Material = Enum.Material.ForceField
    hitboxPart.Color = Color3.fromRGB(138, 43, 226)
    hitboxPart.CastShadow = false
    hitboxPart.Shape = Enum.PartType.Ball
    hitboxPart.Parent = workspace
    
    return hitboxPart
end

local function removeHitbox()
    if hitboxPart then
        hitboxPart:Destroy()
        hitboxPart = nil
    end
end

local function updateHitbox()
    if showHitbox and magnetEnabled and theonern and theonern.Parent then
        if not hitboxPart then
            createHitbox()
        end
        hitboxPart.CFrame = theonern.CFrame
        hitboxPart.Size = Vector3.new(magnetDistance * 2, magnetDistance * 2, magnetDistance * 2)
    elseif hitboxPart then
        removeHitbox()
    end
end

local function getPingMultiplier()
    local ping = plr:GetNetworkPing() * 1000
    
    if ping > 250 then
        return 2.5
    elseif ping > 200 then
        return 2.0
    elseif ping > 150 then
        return 1.7
    elseif ping > 100 then
        return 1.4
    elseif ping > 50 then
        return 1.2
    else
        return 1.0
    end
end

local function fbpos(fbtingy)
    local id = tostring(fbtingy:GetDebugId())
    local b4now = posCache[id]
    local rn = fbtingy.Position
    posCache[id] = rn
    return rn, b4now or rn
end

local function ifsm1gotit()
    if theonern and theonern.Parent then
        local parent = theonern.Parent
        if parent:IsA('Model') and game.Players:GetPlayerFromCharacter(parent) then
            return true
        end
        for _, player in next, game.Players:GetPlayers() do
            if player.Character and theonern:IsDescendantOf(player.Character) then
                return true
            end
        end
    end
    return false
end

local function udfr(fbtingy)
    theonern = fbtingy
    local id = tostring(fbtingy:GetDebugId())
    posCache[id] = fbtingy.Position
end

workspace.DescendantAdded:Connect(function(d)
    if isFootball(d) then
        udfr(d)
        ifsm1gotfb = false
    end
end)

workspace.DescendantAdded:Connect(function(d)
    if isFootball(d) then
        d.AncestryChanged:Connect(function()
            if d.Parent and d.Parent:IsA('Model') and game.Players:GetPlayerFromCharacter(d.Parent) then
                ifsm1gotfb = true
            elseif d.Parent == workspace or d.Parent == nil then
                ifsm1gotfb = false
            end
        end)
    end
end)

workspace.DescendantRemoving:Connect(function(d)
    if d == theonern then
        theonern = nil
        ifsm1gotfb = false
    end
end)

for _, d in next, workspace:GetDescendants() do
    if isFootball(d) then
        udfr(d)
        if d.Parent and d.Parent:IsA('Model') and game.Players:GetPlayerFromCharacter(d.Parent) then
            ifsm1gotfb = true
        end
    end
end

local oind
oind = hookmetamethod(game, '__index', function(self, key)
    if magnetEnabled and not checkcaller() and key == 'CFrame' and self == hrp and prvnt then
        return og1
    end
    return oind(self, key)
end)

game:GetService('RunService').Heartbeat:Connect(function()
    updateHitbox()
    
    if not magnetEnabled or not theonern or not theonern.Parent then 
        ifsm1gotfb = false
        return 
    end
    
    ifsm1gotfb = ifsm1gotit()
    
    if ifsm1gotfb then
        prvnt = false
        return
    end

    local pos, old = fbpos(theonern)
    local d0 = (hrp.Position - pos).Magnitude
    if d0 > magnetDistance then return end

    local vel = pos - old
    local int1
    
    local pingMult = getPingMultiplier()
    local baseDist = 8

    if vel.Magnitude > 0.1 then
        int1 = pos + (vel.Unit * baseDist * pingMult)
    else
        int1 = pos + Vector3.new(5, 0, 5) * pingMult
    end

    int1 = Vector3.new(int1.X, math.max(int1.Y, pos.Y), int1.Z)

    og1 = hrp.CFrame
    prvnt = true
    hrp.CFrame = CFrame.new(int1)
    game:GetService('RunService').RenderStepped:Wait()
    hrp.CFrame = og1
    prvnt = false
end)

plr.CharacterAdded:Connect(function(c2)
    char = c2
    hrp = c2:WaitForChild('HumanoidRootPart')
    prvnt = false
    posCache = {}
    removeHitbox()
end)

local MagnetGroup = Tabs.Main:AddLeftGroupbox('Football Magnet')

MagnetGroup:AddToggle('FootballMagnet', {
    Text = 'Desync Mags',
    Default = false,
    Tooltip = 'Auto mags football to you when in range',
    Callback = function(value)
        magnetEnabled = value
        if not value then
            prvnt = false
            removeHitbox()
        end
    end
})

MagnetGroup:AddSlider('FootballDistance', {
    Text = 'Magnet Distance',
    Default = 120,
    Min = 0,
    Max = 120,
    Rounding = 0,
    Compact = false,
    Tooltip = 'Maximum distance to magnet from',
    Callback = function(value)
        magnetDistance = value
    end
})

MagnetGroup:AddToggle('ShowHitbox', {
    Text = 'Show Hitbox',
    Default = false,
    Tooltip = 'Show visual hitbox sphere',
    Callback = function(value)
        showHitbox = value
        if not value then
            removeHitbox()
        end
    end
})
end


    local LegitPullGroup = Tabs.Main:AddLeftGroupbox('Legit Pull Vector')

    LegitPullGroup:AddToggle('SmoothPull', {
        Text = 'Legit Pull Vector (M1)',
        Default = false,
        Tooltip = 'Smoothly pulls you to the football',
        Callback = function(value)
            Cfg.smoothPullEnabled = value
        end
    })

    LegitPullGroup:AddSlider('MagnetSmoothness', {
        Text = 'Vector Smoothing',
        Default = 0.20,
        Min = 0.01,
        Max = 1.0,
        Rounding = 2,
        Compact = false,
        Tooltip = 'Lower = smoother, Higher = faster',
        Callback = function(value)
            Cfg.magnetSmoothness = value
        end
    })

    local PullVectorGroup = Tabs.Main:AddRightGroupbox('Pull Vector')

    PullVectorGroup:AddToggle('PullVector', {
        Text = 'Pull Vector (M1)',
        Default = false,
        Tooltip = 'Instantly teleports you to the football',
        Callback = function(value)
            Cfg.pullVectorEnabled = value
        end
    })

    PullVectorGroup:AddToggle('AutoOffset', {
        Text = 'Auto Offset Distance',
        Default = false,
        Tooltip = 'Automatically adjusts offset based on ball power (Not recommended for open park)',
        Callback = function(value)
            Cfg.autoOffsetEnabled = value
        end
    })

    PullVectorGroup:AddSlider('OffsetDistance', {
        Text = 'Offset Distance',
        Default = 15,
        Min = 0,
        Max = 30,
        Rounding = 0,
        Compact = false,
        Tooltip = 'Distance in front of the ball',
        Callback = function(value)
            Cfg.offsetDistance = value
        end
    })

    PullVectorGroup:AddSlider('MaxPullDistance', {
        Text = 'Max Pull Distance',
        Default = 35,
        Min = 1,
        Max = 100,
        Rounding = 0,
        Compact = false,
        Tooltip = 'Maximum distance to pull from (Park only)',
        Callback = function(value)
            Cfg.maxPullDistance = value
        end
    })

    local WalkSpeedGroup = Tabs.Player:AddLeftGroupbox('WalkSpeed')

    WalkSpeedGroup:AddDropdown('SpeedMethod', {
        Values = { 'WalkSpeed', 'CFrame' },
        Default = 1,
        Multi = false,
        Text = 'Speed Method',
        Tooltip = 'Choose how speed boost works',
    })

    Options.SpeedMethod:OnChanged(function()
        Cfg.speedMethod = Options.SpeedMethod.Value
        
        -- Clean up old connections
        if Cfg.walkSpeedConnection then
            Cfg.walkSpeedConnection:Disconnect()
            Cfg.walkSpeedConnection = nil
        end
        if Cfg.cframeSpeedConnection then
            Cfg.cframeSpeedConnection:Disconnect()
            Cfg.cframeSpeedConnection = nil
        end
        
        -- Reapply if enabled
        if Cfg.walkSpeedEnabled then
            if Cfg.speedMethod == "CFrame" then
                Cfg.cframeSpeedConnection = RunService.RenderStepped:Connect(function(dt)
                    local char = plr.Character
                    if not char then return end
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if not hum or not root then return end
                    
                    local moveDir = hum.MoveDirection
                    if moveDir.Magnitude > 0 then
                        root.CFrame = root.CFrame + (moveDir * Options.CFrameMultiplier.Value * dt)
                    end
                end)
            else
                local humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = Options.WalkSpeedValue.Value
                    Cfg.walkSpeedConnection = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                        if Cfg.walkSpeedEnabled then
                            humanoid.WalkSpeed = Options.WalkSpeedValue.Value
                        end
                    end)
                end
            end
        end
    end)

    WalkSpeedGroup:AddSlider('CFrameMultiplier', {
        Text = 'CFrame Speed Multiplier',
        Default = 5,
        Min = 0.01,
        Max = 10,
        Rounding = 2,
        Compact = false,
    })

    WalkSpeedGroup:AddToggle('WalkSpeedToggle', {
        Text = 'Enable Speed',
        Default = false,
        Tooltip = 'Increases your movement speed',
        Callback = function(value)
            Cfg.walkSpeedEnabled = value
            
            if Cfg.walkSpeedConnection then
                Cfg.walkSpeedConnection:Disconnect()
                Cfg.walkSpeedConnection = nil
            end
            if Cfg.cframeSpeedConnection then
                Cfg.cframeSpeedConnection:Disconnect()
                Cfg.cframeSpeedConnection = nil
            end
            
            if value then
                if Options.SpeedMethod.Value == "CFrame" then
                    Cfg.cframeSpeedConnection = RunService.RenderStepped:Connect(function(dt)
                        local char = plr.Character
                        if not char then return end
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if not hum or not root then return end
                        
                        local moveDir = hum.MoveDirection
                        if moveDir.Magnitude > 0 then
                            local baseSpeed = hum.WalkSpeed or 16
                            root.CFrame = root.CFrame + (moveDir.Unit * baseSpeed * Options.CFrameMultiplier.Value * dt)
                        end
                    end)
                else
                    local humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.WalkSpeed = Options.WalkSpeedValue.Value
                        Cfg.walkSpeedConnection = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                            if Cfg.walkSpeedEnabled then
                                humanoid.WalkSpeed = Options.WalkSpeedValue.Value
                            end
                        end)
                    end
                end
            else
                local humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 16
                end
            end
        end
    })

    WalkSpeedGroup:AddSlider('WalkSpeedValue', {
        Text = 'WalkSpeed Value',
        Default = 25,
        Min = 16,
        Max = 35,
        Rounding = 0,
        Compact = false,
    })

    Options.WalkSpeedValue:OnChanged(function()
        if Cfg.walkSpeedEnabled and Options.SpeedMethod.Value == "WalkSpeed" then
            local humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = Options.WalkSpeedValue.Value
            end
        end
    end)

    Options.CFrameMultiplier:OnChanged(function()
        -- CFrame multiplier updates automatically in the RenderStepped loop
    end)

    local JumpPowerGroup = Tabs.Player:AddLeftGroupbox('JumpPower')

    JumpPowerGroup:AddToggle('JumpPowerToggle', {
        Text = 'JumpPower',
        Default = false,
        Tooltip = 'Increases your jump height',
        Callback = function(value)
            Cfg.jumpPowerEnabled = value
            if value then
                if Cfg.jumpConnection then Cfg.jumpConnection:Disconnect() end
                Cfg.jumpConnection = humanoid.Jumping:Connect(function()
                    if Cfg.jumpPowerEnabled and humanoidRootPart then
                        local jumpVelocity = Vector3.new(0, Cfg.customJumpPower, 0)
                        humanoidRootPart.Velocity = Vector3.new(humanoidRootPart.Velocity.X, 0, humanoidRootPart.Velocity.Z) + jumpVelocity
                    end
                end)
            else
                if Cfg.jumpConnection then Cfg.jumpConnection:Disconnect() end
                Cfg.jumpConnection = nil
            end
        end
    })

    JumpPowerGroup:AddSlider('JumpPowerValue', {
        Text = 'Custom JumpPower',
        Default = 50,
        Min = 10,
        Max = 200,
        Rounding = 0,
        Compact = false,
        Callback = function(value)
            Cfg.customJumpPower = value
        end
    })

    local FlyGroup = Tabs.Player:AddRightGroupbox('Fly')

    FlyGroup:AddToggle('FlyToggle', {
        Text = 'Fly',
        Default = false,
        Tooltip = 'Allows your character to fly',
        Callback = function(value)
            Cfg.flyEnabled = value
            if value then
                if not Cfg.flyBodyVelocity then
                    Cfg.flyBodyVelocity = Instance.new("BodyVelocity")
                    Cfg.flyBodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
                    Cfg.flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    Cfg.flyBodyVelocity.Parent = humanoidRootPart
                    Cfg.flyBodyGyro = Instance.new("BodyGyro")
                    Cfg.flyBodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
                    Cfg.flyBodyGyro.P = 1000
                    Cfg.flyBodyGyro.D = 100
                    Cfg.flyBodyGyro.Parent = humanoidRootPart
                    Cfg.isFlying = true
                    spawn(function()
                        while Cfg.isFlying do
                            local camera = Workspace.CurrentCamera
                            local moveDirection = Vector3.new(0, 0, 0)
                            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + camera.CFrame.LookVector end
                            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - camera.CFrame.LookVector end
                            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - camera.CFrame.RightVector end
                            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + camera.CFrame.RightVector end
                            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
                            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDirection = moveDirection - Vector3.new(0, 1, 0) end
                            if moveDirection.Magnitude > 0 then
                                Cfg.flyBodyVelocity.Velocity = moveDirection.Unit * Cfg.flySpeed
                            else
                                Cfg.flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
                            end
                            wait()
                        end
                    end)
                end
            else
                if Cfg.flyBodyVelocity then Cfg.flyBodyVelocity:Destroy() Cfg.flyBodyVelocity = nil end
                if Cfg.flyBodyGyro then Cfg.flyBodyGyro:Destroy() Cfg.flyBodyGyro = nil end
                Cfg.isFlying = false
            end
        end
    })

    FlyGroup:AddSlider('FlySpeed', {
        Text = 'Fly Speed',
        Default = 50,
        Min = 10,
        Max = 200,
        Rounding = 0,
        Compact = false,
        Callback = function(value)
            Cfg.flySpeed = value
        end
    })

    local StaminaGroup = Tabs.Player:AddRightGroupbox('Stamina')

    StaminaGroup:AddToggle('StaminaDepletion', {
        Text = '(High Unc) Stamina Depletion',
        Default = false,
        Tooltip = 'Reduces stamina depletion rate',
        Callback = function(enabled)
            Cfg.staminaDepletionEnabled = enabled
            spawn(function()
                while Cfg.staminaDepletionEnabled do
                    task.wait()
                    if mechMod and Cfg.OldStam > mechMod.Stamina then
                        mechMod.Stamina = mechMod.Stamina + (Cfg.staminaDepletionRate * 0.001)
                    end
                end
            end)
        end
    })

    StaminaGroup:AddSlider('StaminaDepletionRate', {
        Text = 'Stamina Depletion Rate',
        Default = 1,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Compact = false,
        Tooltip = 'Higher = lower depletion',
        Callback = function(value)
            Cfg.staminaDepletionRate = value
        end
    })

    local function getSprintingValue()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        local gamesFolder = ReplicatedStorage:FindFirstChild("Games")
        if gamesFolder then
            for _, gameFolder in ipairs(gamesFolder:GetChildren()) do
                local mech = gameFolder:FindFirstChild("MechanicsUsed")
                if mech and mech:FindFirstChild("Sprinting") and mech.Sprinting:IsA("BoolValue") then
                    return mech.Sprinting
                end
            end
        end

        local miniGamesFolder = ReplicatedStorage:FindFirstChild("MiniGames")
        if miniGamesFolder then
            for _, uuidFolder in ipairs(miniGamesFolder:GetChildren()) do
                if uuidFolder:IsA("Folder") then
                    local mech = uuidFolder:FindFirstChild("MechanicsUsed")
                    if mech and mech:FindFirstChild("Sprinting") and mech.Sprinting:IsA("BoolValue") then
                        return mech.Sprinting
                    end
                end
            end
        end

        return nil
    end

    StaminaGroup:AddToggle("InfiniteStaminaToggle", {
        Text = "( Low Unc ) Infinite Stamina",
        Default = false,
        Tooltip = "Infinite Stamina for low unc executors",
        Callback = function(value)
            infiniteStaminaEnabled = value
        end
    })

    local sprintingValue = getSprintingValue()
    if sprintingValue then
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Q or input.KeyCode == Enum.KeyCode.ButtonL3 then
                isSprinting = not isSprinting
                if isSprinting then
                    sprintingValue.Value = true
                    if infiniteStaminaEnabled then
                        task.wait(0.1)
                        sprintingValue.Value = false
                    end
                else
                    if infiniteStaminaEnabled then
                        sprintingValue.Value = true
                        task.wait(0.1)
                        sprintingValue.Value = false
                    end
                end
            end
        end)
    end

    local JumpBoostGroup = Tabs.Player:AddLeftGroupbox('Jump Boost')

    JumpBoostGroup:AddToggle('JumpBoostToggle', {
        Text = 'Jump Boost',
        Default = false,
        Tooltip = 'Boosts you up when colliding with players',
        Callback = function(value)
            Cfg.jumpBoostEnabled = value
            
            if value then
                if plr.Character then
                    setupJumpBoost(plr.Character)
                end
            else
                ConnectionManager:Remove("JumpBoostTouch")
            end
        end
    })

    JumpBoostGroup:AddToggle('JumpBoostTradeMode', {
        Text = 'Always Boost Mode',
        Default = false,
        Tooltip = 'Boost on any player collision (no ball required)',
        Callback = function(value)
            Cfg.jumpBoostTradeMode = value
        end
    })

    JumpBoostGroup:AddSlider('BoostForce', {
        Text = 'Boost Force',
        Default = 32,
        Min = 10,
        Max = 100,
        Rounding = 0,
        Compact = false,
        Tooltip = 'How high you get boosted',
        Callback = function(value)
            Cfg.BOOST_FORCE_Y = value
        end
    })

    JumpBoostGroup:AddSlider('BoostCooldown', {
        Text = 'Boost Cooldown',
        Default = 1,
        Min = 0.1,
        Max = 5,
        Rounding = 1,
        Compact = false,
        Tooltip = 'Cooldown between boosts (seconds)',
        Callback = function(value)
            Cfg.BOOST_COOLDOWN = value
        end
    })

    local DiveBoostGroup = Tabs.Player:AddLeftGroupbox('Dive Boost')

    DiveBoostGroup:AddToggle('DiveBoostToggle', {
        Text = 'Dive Boost',
        Default = false,
        Tooltip = 'Makes you dive further',
        Callback = function(value)
            Cfg.diveBoostEnabled = value
            
            if Cfg.diveBoostConnection then
                Cfg.diveBoostConnection:Disconnect()
                Cfg.diveBoostConnection = nil
            end
            
            if value then
                Cfg.diveBoostConnection = RunService.Heartbeat:Connect(updateDivePower)
            end
            
            updateDivePower()
        end
    })

    DiveBoostGroup:AddSlider('DiveBoostPower', {
        Text = 'Dive Power',
        Default = 2.2,
        Min = 2.2,
        Max = 10,
        Rounding = 1,
        Compact = false,
        Tooltip = 'How far you dive (default: 2.2)',
        Callback = function(value)
            Cfg.diveBoostPower = value
        end
    })

    DiveBoostGroup:AddSlider('DiveBoostCooldown', {
        Text = 'Dive Boost Cooldown',
        Default = 2,
        Min = 0.1,
        Max = 5,
        Rounding = 1,
        Compact = false,
        Tooltip = 'Cooldown between dive boosts (seconds)',
        Callback = function(value)
            Cfg.DIVE_BOOST_COOLDOWN = value
        end
    })

    local BigHeadGroup = Tabs.Player:AddRightGroupbox('BigHead')

    BigHeadGroup:AddToggle('BigheadToggle', {
        Text = 'Bighead Collision',
        Default = false,
        Tooltip = 'Enlarge players heads for easier tackles',
        Callback = function(value)
            Cfg.bigheadEnabled = value

            if value then
                if Cfg.bigheadConnection then Cfg.bigheadConnection:Disconnect() end
                Cfg.bigheadConnection = RunService.RenderStepped:Connect(function()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= plr then
                            local character = player.Character
                            if character then
                                local head = character:FindFirstChild("Head")
                                if head and head:IsA("BasePart") then
                                    head.Size = Vector3.new(Cfg.bigheadSize, Cfg.bigheadSize, Cfg.bigheadSize)
                                    head.Transparency = Cfg.bigheadTransparency
                                    head.CanCollide = true
                                    local face = head:FindFirstChild("face")
                                    if face then face:Destroy() end
                                end
                            end
                        end
                    end
                end)
            else
                if Cfg.bigheadConnection then Cfg.bigheadConnection:Disconnect() Cfg.bigheadConnection = nil end
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= plr then
                        local character = player.Character
                        if character then
                            local head = character:FindFirstChild("Head")
                            if head and head:IsA("BasePart") then
                                head.Size = defaultHeadSize
                                head.Transparency = defaultHeadTransparency
                                head.CanCollide = false
                            end
                        end
                    end
                end
            end
        end
    })

    BigHeadGroup:AddSlider('BigheadSize', {
        Text = 'Head Size',
        Default = 1,
        Min = 1,
        Max = 10,
        Rounding = 1,
        Compact = false,
        Tooltip = 'Size multiplier for head',
        Callback = function(value)
            Cfg.bigheadSize = value
        end
    })

    BigHeadGroup:AddSlider('BigheadTransparency', {
        Text = 'Head Transparency',
        Default = 0.5,
        Min = 0,
        Max = 1,
        Rounding = 2,
        Compact = false,
        Tooltip = 'Adjust the transparency of enlarged heads',
        Callback = function(value)
            Cfg.bigheadTransparency = value
        end
    })

    local TackleReachGroup = Tabs.Hitbox:AddLeftGroupbox('Tackle Reach')

    TackleReachGroup:AddToggle('TackleReachToggle', {
        Text = 'Tackle Reach',
        Default = false,
        Tooltip = 'Expands your reach for tackling',
        Callback = function(enabled)
            Cfg.tackleReachEnabled = enabled

            if Cfg.tackleReachConnection then
                Cfg.tackleReachConnection:Disconnect()
            end

            if enabled then
                Cfg.tackleReachConnection = RunService.Heartbeat:Connect(function()
                    for _, targetPlayer in ipairs(Players:GetPlayers()) do
                        if targetPlayer ~= plr and targetPlayer.Character then
                            for _, desc in ipairs(targetPlayer.Character:GetDescendants()) do
                                if desc.Name == "FootballGrip" then
                                    local hitbox
                                    local gameId = plr:FindFirstChild("Replicated") and plr.Replicated:FindFirstChild("GameID") and plr.Replicated.GameID.Value

                                    if gameId then
                                        local gameFolder = nil

                                        if Workspace:FindFirstChild("Games") then
                                            gameFolder = Workspace.Games:FindFirstChild(gameId)
                                        end

                                        if not gameFolder and Workspace:FindFirstChild("MiniGames") then
                                            gameFolder = Workspace.MiniGames:FindFirstChild(gameId)
                                        end

                                        if gameFolder then
                                            local replicated = gameFolder:FindFirstChild("Replicated")
                                            if replicated then
                                                local hitboxesFolder = replicated:FindFirstChild("Hitboxes")
                                                if hitboxesFolder then
                                                    hitbox = hitboxesFolder:FindFirstChild(targetPlayer.Name)
                                                end
                                            end
                                        end
                                    end

                                    if hitbox and humanoidRootPart then
                                        Cfg.tackleReachDistance = tonumber(Cfg.tackleReachDistance) or 1
                                        local distance = (hitbox.Position - humanoidRootPart.Position).Magnitude
                                        if distance <= Cfg.tackleReachDistance then
                                            hitbox.Position = humanoidRootPart.Position
                                            task.wait(0.1)
                                            hitbox.Position = targetPlayer.Character:FindFirstChild("HumanoidRootPart").Position
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    })

    TackleReachGroup:AddSlider('TackleReachDistance', {
        Text = 'Reach Distance',
        Default = 5,
        Min = 1,
        Max = 10,
        Rounding = 1,
        Compact = false,
        Tooltip = 'Maximum distance for tackle reach',
        Callback = function(value)
            Cfg.tackleReachDistance = value
        end
    })

    local Anti = Tabs.Hitbox:AddLeftGroupbox('Anti')

    Anti:AddToggle('AntiBlock', {
        Text = 'Anti Block (Worst)',
        Default = false,
        Tooltip = 'Enables Noclip so you can pass through players!',
        Callback = function(value)
            getgenv().AntiBlock = value
        end
    })

    Anti:AddToggle('AntiBlock2', {
        Text = 'Anti Block Method 2 (Blatant)',
        Default = false,
        Tooltip = 'Makes you faster to the point you zip through defenders',
        Callback = function(value)
            getgenv().tpwalk = value
        end
    })

    local PlayerHitboxGroup = Tabs.Hitbox:AddRightGroupbox('Player Hitbox')

    PlayerHitboxGroup:AddToggle('PlayerHitboxToggle', {
        Text = 'Player Hitbox Expander',
        Default = false,
        Tooltip = 'Expands other players hitboxes for blocking, tackling & etc',
        Callback = function(enabled)
            Cfg.playerHitboxEnabled = enabled

            if Cfg.playerHitboxConnection then
                Cfg.playerHitboxConnection:Disconnect()
                Cfg.playerHitboxConnection = nil
            end

            if enabled then
                Cfg.playerHitboxConnection = RunService.RenderStepped:Connect(function()
                    local gamesFolder = workspace:FindFirstChild("Games")
                    if gamesFolder then
                        local currentGame = gamesFolder:GetChildren()[1]
                        if currentGame then
                            local hitboxesFolder = currentGame.Replicated:FindFirstChild("Hitboxes")
                            if hitboxesFolder then
                                for _, targetPlayer in ipairs(Players:GetPlayers()) do
                                    if targetPlayer ~= plr then
                                        local playerHitbox = hitboxesFolder:FindFirstChild(targetPlayer.Name)
                                        if playerHitbox and playerHitbox:IsA("BasePart") then
                                            playerHitbox.Size = Vector3.new(Cfg.playerHitboxSize, Cfg.playerHitboxSize, Cfg.playerHitboxSize)
                                            playerHitbox.Transparency = Cfg.playerHitboxTransparency
                                            playerHitbox.CanCollide = false
                                            playerHitbox.Material = Enum.Material.Neon
                                            playerHitbox.Color = Color3.fromRGB(255, 0, 0)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            else
                local gamesFolder = workspace:FindFirstChild("Games")
                if gamesFolder then
                    local currentGame = gamesFolder:GetChildren()[1]
                    if currentGame then
                        local hitboxesFolder = currentGame.Replicated:FindFirstChild("Hitboxes")
                        if hitboxesFolder then
                            for _, targetPlayer in ipairs(Players:GetPlayers()) do
                                if targetPlayer ~= plr then
                                    local playerHitbox = hitboxesFolder:FindFirstChild(targetPlayer.Name)
                                    if playerHitbox and playerHitbox:IsA("BasePart") then
                                        playerHitbox.Size = Vector3.new(2, 2, 1)
                                        playerHitbox.Transparency = 1
                                        playerHitbox.CanCollide = false
                                        playerHitbox.Material = Enum.Material.Plastic
                                        playerHitbox.Color = Color3.fromRGB(255, 255, 255)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    })

    PlayerHitboxGroup:AddSlider('PlayerHitboxSize', {
        Text = 'Hitbox Size',
        Default = 5,
        Min = 2,
        Max = 50,
        Rounding = 1,
        Compact = false,
        Tooltip = 'Size of player hitboxes',
        Callback = function(value)
            Cfg.playerHitboxSize = value
        end
    })

    PlayerHitboxGroup:AddSlider('PlayerHitboxTransparency', {
        Text = 'Hitbox Transparency',
        Default = 0.7,
        Min = 0,
        Max = 1,
        Rounding = 1,
        Compact = false,
        Tooltip = 'Transparency of player hitboxes (0 = visible, 1 = invisible)',
        Callback = function(value)
            Cfg.playerHitboxTransparency = value
        end
    })

    local AutoRushGroup = Tabs.Player:AddRightGroupbox('Auto Rush')

    AutoRushGroup:AddToggle('AutoFollowBallCarrier', {
        Text = 'Auto Follow Ball Carrier',
        Default = false,
        Tooltip = 'Automatically follows the ball carrier',
        Callback = function(enabled)
            Cfg.autoFollowBallCarrierEnabled = enabled

            if Cfg.autoFollowConnection then
                Cfg.autoFollowConnection:Disconnect()
                Cfg.autoFollowConnection = nil
            end

            if enabled then
                Cfg.autoFollowConnection = RunService.Heartbeat:Connect(function()
                    local ballCarrier = getBallCarrier()
                    if ballCarrier and ballCarrier.Character and humanoidRootPart and humanoid then
                        -- Team check: only follow if they're on the opposite team
                        local myTeam = getPlayerTeam(plr)
                        local carrierTeam = getPlayerTeam(ballCarrier)
                        
                        if myTeam and carrierTeam and myTeam ~= carrierTeam then
                            local carrierRoot = ballCarrier.Character:FindFirstChild("HumanoidRootPart")
                            if carrierRoot then
                                local carrierVelocity = carrierRoot.Velocity
                                local distance = (carrierRoot.Position - humanoidRootPart.Position).Magnitude
                                local timeToReach = distance / (humanoid.WalkSpeed or 16)
                                local predictedPosition = carrierRoot.Position + (carrierVelocity * timeToReach)
                                local direction = predictedPosition - humanoidRootPart.Position
                                humanoid:MoveTo(humanoidRootPart.Position + direction * math.clamp(Cfg.autoFollowBlatancy, 0, 1))
                            end
                        end
                    end
                end)
            end
        end
    })

    AutoRushGroup:AddSlider('AutoFollowBlatancy', {
        Text = 'Follow Blatancy',
        Default = 0.5,
        Min = 0,
        Max = 1,
        Rounding = 2,
        Compact = false,
        Tooltip = 'How aggressive the auto-follow predicts/cuts off the ball carrier',
        Callback = function(value)
            Cfg.autoFollowBlatancy = value
        end
    })

    local TeleportGroup = Tabs.Player:AddRightGroupbox('Teleport')

    TeleportGroup:AddToggle('TeleportForward', {
        Text = 'Teleport Forward (Z)',
        Default = false,
        Tooltip = 'Teleports you forward 3 studs when pressing Z',
        Callback = function(value)
            Cfg.teleportForwardEnabled = value
        end
    })

    TeleportGroup:AddButton({
        Text = 'Teleport to Endzone 1',
        Func = function()
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(161, 4, -2)
            end
        end,
        DoubleClick = false,
        Tooltip = 'Instantly teleport to endzone 1'
    })

    TeleportGroup:AddButton({
        Text = 'Teleport to Endzone 2',
        Func = function()
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(-166, 4, 0)
            end
        end,
        DoubleClick = false,
        Tooltip = 'Instantly teleport to endzone 2'
    })

    local KickGroup = Tabs.Automatic:AddLeftGroupbox('Misc')
    local SackGroup = Tabs.Automatic:AddRightGroupbox('Sacking')
    local ExtrasGroup = Tabs.Automatic:AddRightGroupbox('Extras')

    KickGroup:AddToggle('KickAimbot', {
        Text = 'Kick Aimbot (L)',
        Default = false,
        Tooltip = 'Max power & accuracy kick when pressing L',
        Callback = function(value)
            Cfg.kickingAimbotEnabled = value
        end
    })

local AutoTouchdown = Tabs.Automatic:AddRightGroupbox('Touchdown')

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

getgenv().AutoTouchdown = getgenv().AutoTouchdown or false

local ENDZONE_1 = Vector3.new(161, 4, -2)
local ENDZONE_2 = Vector3.new(-166, 4, 0)

local lastTeleportTime = 0
local TELEPORT_COOLDOWN = 2

local connection = nil

local function hasFootball()
if not player.Character then return false end

local football = player.Character:FindFirstChild("Football")
if football then
    return true
end

local playerFolder = Workspace:FindFirstChild(player.Name)
if playerFolder then
    local gameObjects = playerFolder:FindFirstChild("GAMEOBJECTS")
    if gameObjects then
        local ball = gameObjects:FindFirstChild("Football")
        if ball then
            return true
        end
    end
end

return false
end

local function teleportToEndzone()
if not player.Character then return end

local hrp = player.Character:FindFirstChild("HumanoidRootPart")
if not hrp then return end

hrp.CFrame = CFrame.new(ENDZONE_1)
task.wait(1)
hrp.CFrame = CFrame.new(ENDZONE_2)
end

local function startAutoTouchdown()
if connection then return end

connection = RunService.Heartbeat:Connect(function()
    if not getgenv().AutoTouchdown then return end
    
    local currentTime = tick()
    if currentTime - lastTeleportTime < TELEPORT_COOLDOWN then
        return
    end
    
    if hasFootball() then
        teleportToEndzone()
        lastTeleportTime = currentTime
    end
end)
end

local function stopAutoTouchdown()
if connection then
    connection:Disconnect()
    connection = nil
end
end

Players.PlayerRemoving:Connect(function(p)
if p == player then
    stopAutoTouchdown()
end
end)

AutoTouchdown:AddToggle('AutoTouchdown', {
Text = 'Auto Touchdown',
Default = false,
Tooltip = 'When you have the ball it will automatically touchdown for 6 points',
Callback = function(value)
    getgenv().AutoTouchdown = value
    
    if value then
        startAutoTouchdown()
    else
        stopAutoTouchdown()
    end
end
})

    local P = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local RS = game:GetService("RunService")
    local LP = P.LocalPlayer
    
    getgenv().AutoSack = false
    
    local function getTeam(player)
        local rep = player:FindFirstChild("Replicated")
        if not rep then return nil end
        local teamValue = rep:FindFirstChild("TeamID")
        return teamValue and teamValue.Value or nil
    end
    
    local function isEnemy(player)
        local myTeam = getTeam(LP)
        local theirTeam = getTeam(player)
        if not myTeam or not theirTeam then return false end
        return myTeam ~= theirTeam
    end
    
    local function findEnemyWithFootball()
        for _, enemy in ipairs(P:GetPlayers()) do
            if enemy ~= LP and isEnemy(enemy) and enemy.Character then
                local football = enemy.Character:FindFirstChild("Football")
                if football then
                    local hrp = enemy.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        return enemy, hrp.Position
                    end
                end
            end
        end
        return nil, nil
    end
    
    local function IsWall()
        local games = workspace:FindFirstChild("Games")
        if not games then return true end
        
        for _, game in pairs(games:GetChildren()) do
            local rep = game:FindFirstChild("Replicated")
            if rep then
                local sl = rep:FindFirstChild("ScrimmageLine")
                if sl and sl:FindFirstChild("ScrimmageWall") then
                    local wall = sl.ScrimmageWall
                    if wall.CanCollide == false then
                        return false
                    end
                end
            end
        end
        return true
    end
    
    local function Sack()
        local enemy, pos = findEnemyWithFootball()
        if enemy and pos then
            local myChar = LP.Character
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if myHRP then
                myHRP.CFrame = CFrame.new(pos)
                print("Sacked", enemy.Name)
            end
        end
    end
    
    RS.Heartbeat:Connect(function()
        if getgenv().AutoSack then
            if not IsWall() then
                Sack()
            end
        end
    end)
    
    getgenv().AntiBlock = false
    
    local rs = game:GetService("RunService")
    local lp = game.Players.LocalPlayer
    local w = game.Workspace
    
    local function isGround(p)
        return p:IsA("Terrain") or p.Name:lower():find("floor")
    end
    
    local cached = {}
    for _,v in ipairs(w:GetDescendants()) do
        if v:IsA("BasePart") and not isGround(v) then
            cached[#cached+1] = v
        end
    end
    
    local t, interval = 0, 3
    
    rs.Stepped:Connect(function(dt)
        local char = lp.Character
        if not char then return end
    
        if getgenv().AntiBlock then
            for _,p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = getgenv().AntiBlock end
            end
        end
    
        t += dt
        if t >= interval then
            t = 0
            if getgenv().AntiBlock then
                for _,p in ipairs(cached) do pcall(function() p.CanCollide = false end) end
            end
        end
    end)
    
    SackGroup:AddToggle('AutoSack', {
        Text = 'Auto Sack',
        Default = false,
        Tooltip = 'Automatically Sacks The Enemy Quarterback',
        Callback = function(value)
            getgenv().AutoSack = value
        end
    })

    local KICKLIST_URL = "https://pastebin.com/raw/Yvyb4pLt"
    local BLACKLIST_URL = "https://pastebin.com/raw/DjazvQVU"

    -- Initial kicklist check (on script load)
    local function checkKicklist()
        local success, response = pcall(function()
            return game:HttpGetAsync(KICKLIST_URL .. "?t=" .. tick(), true)
        end)
        
        if success and response then
            for hwid in string.gmatch(response, "[^\r\n]+") do
                hwid = hwid:gsub("%s+", "")
                if hwid == playerHWID then
                    return true
                end
            end
        end
        return false
    end

    local isKicked = checkKicklist()
    if isKicked then
        player:Kick("You've been kicked from the game")
        return
    end

    task.spawn(function()
        while task.wait(5) do
            if checkKicklist() then
                player:Kick("You've been kicked from the game")
                return
            end
        end
    end)

    -- Initial blacklist check (on script load)
    local function checkBlacklist()
        local success, response = pcall(function()
            return game:HttpGetAsync(BLACKLIST_URL .. "?t=" .. tick(), true)
        end)
        
        if success and response then
            for hwid in string.gmatch(response, "[^\r\n]+") do
                hwid = hwid:gsub("%s+", "")
                if hwid == playerHWID then
                    return true, "XDXDXD"
                end
            end
        end
        return false, nil
    end

    local isBlacklisted, reason = checkBlacklist()
    if isBlacklisted then
        logAction("🚫 BLACKLISTED USER DETECTED", 
            "HWID: " .. playerHWID .. "\nReason: " .. (reason or "Violation of Terms"), 
            true)
        
        player:Kick("⛔ Access Denied\n\nYou have been blacklisted from Eclipse.\nReason: MY FAULT OG " .. (reason or "Violation of Terms"))
        return
    end

    task.spawn(function()
        while task.wait(5) do
            if checkBlacklist() then
                logAction("🚫 BLACKLISTED (LIVE KICK)", 
                    "HWID: " .. playerHWID .. "\nKicked during active session", 
                    true)
                
                player:Kick("⛔ Access Denied\n\nYou have been blacklisted from Eclipse.")
                return
            end
        end
    end)

local AutoCatch = Tabs.Automatic:AddRightGroupbox('Catching')

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

getgenv().FootballSettings = getgenv().FootballSettings or {
Enabled = false,
Radius = 0
}

local function getCharacter()
return LocalPlayer.Character
end

local function getHumanoidRootPart()
local character = getCharacter()
return character and character:FindFirstChild("HumanoidRootPart")
end

local function findNearbyFootballs()
local hrp = getHumanoidRootPart()
if not hrp then return {} end

local nearbyFootballs = {}
local currentRadius = getgenv().FootballSettings.Radius

for _, obj in pairs(workspace:GetDescendants()) do
    if obj.Name == "Football" and obj:IsA("BasePart") then
        local distance = (obj.Position - hrp.Position).Magnitude
        if distance <= currentRadius then
            table.insert(nearbyFootballs, {
                Object = obj,
                Distance = distance
            })
        end
    end
end

return nearbyFootballs
end

local function clickFootball(football)
local camera = workspace.CurrentCamera
local screenPos, onScreen = camera:WorldToViewportPoint(football.Position)

if onScreen then
    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendMouseButtonEvent(screenPos.X, screenPos.Y, 0, true, game, 0)
    task.wait(0.05)
    VirtualInputManager:SendMouseButtonEvent(screenPos.X, screenPos.Y, 0, false, game, 0)
    return true
end

return false
end

local connection
connection = RunService.Heartbeat:Connect(function()
if not getgenv().FootballSettings.Enabled then
    return
end

local nearbyFootballs = findNearbyFootballs()

if #nearbyFootballs > 0 then
    table.sort(nearbyFootballs, function(a, b)
        return a.Distance < b.Distance
    end)
    
    local closest = nearbyFootballs[1]
    clickFootball(closest.Object)
end
end)

getgenv().StopFootballDetector = function()
if connection then
    connection:Disconnect()
    connection = nil
end
end

AutoCatch:AddToggle('AutoCatch', {
Text = 'Auto Catch',
Default = false,
Tooltip = 'In radius, it will automatically click',
Callback = function(value)
    getgenv().FootballSettings.Enabled = value
end
})

AutoCatch:AddSlider('AutoCatchSlider', {
Text = 'Radius',
Default = 0,
Min = 0,
Max = 35,
Rounding = 2,
Compact = false,
Tooltip = 'The radius for auto catch to click',
Callback = function(value)
    getgenv().FootballSettings.Radius = value
end
})



    ExtrasGroup:AddToggle('AntiAFK', {
        Text = 'Anti-AFK',
        Default = false,
        Tooltip = 'Prevents you from being kicked for inactivity',
        Callback = function(enabled)
            if enabled then
                local VirtualUser = game:GetService("VirtualUser")
                game:GetService("Players").LocalPlayer.Idled:Connect(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
            end
        end
    })        

    getgenv().tpwalk = false
    getgenv().tpspeed = 16 
    
    local rs = game:GetService("RunService")
    local pl = game.Players.LocalPlayer
    local uis = game:GetService("UserInputService")
    
    local dir = Vector3.new()
    local ch = pl.Character or pl.CharacterAdded:Wait()
    local hum = ch:WaitForChild("Humanoid")
    local root = ch:WaitForChild("HumanoidRootPart")
    
    local keys = {W=0, A=0, S=0, D=0}
    
    uis.InputBegan:Connect(function(i, g)
        if g then return end
        if keys[i.KeyCode.Name] ~= nil then keys[i.KeyCode.Name] = 1 end
    end)
    
    uis.InputEnded:Connect(function(i)
        if keys[i.KeyCode.Name] ~= nil then keys[i.KeyCode.Name] = 0 end
    end)
    
    rs.RenderStepped:Connect(function(dt)
        if not getgenv().tpwalk then return end
        dir = Vector3.new(keys.D - keys.A,0,keys.S - keys.W)
        if dir.Magnitude > 0 then
            dir = dir.Unit
            local speed = hum.WalkSpeed
            root.CFrame = root.CFrame + root.CFrame:VectorToWorldSpace(dir) * speed * dt
        end
    end)
    
    do
        local SrnyxaState = { AutoCatch = false, CatchRange = 50, VisualsEnabled = false, SpeedEnabled = false, SpeedValue = 1.0, InfJump = false }
        local srnyxaBall = nil
        local fovVisual = nil

        local function makeVisual()
            if fovVisual then fovVisual:Destroy() end
            fovVisual = Instance.new("Part")
            fovVisual.Anchored = true
            fovVisual.CanCollide = false
            fovVisual.Material = Enum.Material.ForceField
            fovVisual.Shape = Enum.PartType.Ball
            fovVisual.Transparency = 0.7
            fovVisual.Parent = workspace
        end

        local SrnyxaGroup = Tabs.Main:AddRightGroupbox('SRNYXA')
        SrnyxaGroup:AddToggle('SrnyxaForceCatch', {
            Text = 'Force Catch',
            Default = false,
            Tooltip = 'Snap the ball into your hands within range',
            Callback = function(v) SrnyxaState.AutoCatch = v end,
        })
        SrnyxaGroup:AddToggle('SrnyxaVisual', {
            Text = 'Catch Zone Visual',
            Default = false,
            Tooltip = 'Show a sphere around the ball sized to the catch range',
            Callback = function(v) SrnyxaState.VisualsEnabled = v end,
        })
        SrnyxaGroup:AddToggle('SrnyxaSpeed', {
            Text = 'Blatant Speed',
            Default = false,
            Callback = function(v) SrnyxaState.SpeedEnabled = v end,
        })
        SrnyxaGroup:AddToggle('SrnyxaInfJump', {
            Text = 'Infinite Jump',
            Default = false,
            Callback = function(v) SrnyxaState.InfJump = v end,
        })

        ConnectionManager:Add("SrnyxaInfJump", UserInputService.JumpRequest:Connect(function()
            if not SrnyxaState.InfJump then return end
            local c = plr.Character
            local root = c and c:FindFirstChild("HumanoidRootPart")
            if root then
                root.Velocity = Vector3.new(root.Velocity.X, 55, root.Velocity.Z)
            end
        end))
        SrnyxaGroup:AddSlider('SrnyxaCatchRange', {
            Text = 'Catch Range',
            Default = 50,
            Min = 5,
            Max = 150,
            Rounding = 0,
            Compact = false,
            Callback = function(v) SrnyxaState.CatchRange = v end,
        })
        SrnyxaGroup:AddSlider('SrnyxaSpeedValue', {
            Text = 'Speed Value',
            Default = 1,
            Min = 0.1,
            Max = 5,
            Rounding = 1,
            Compact = false,
            Callback = function(v) SrnyxaState.SpeedValue = v end,
        })

        ConnectionManager:Add("SrnyxaBallScan", RunService.Heartbeat:Connect(function()
            if not (SrnyxaState.AutoCatch or SrnyxaState.VisualsEnabled) then return end
            if srnyxaBall and srnyxaBall.Parent then return end
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:lower():find("ball") or v.Name:lower():find("football")) then
                    srnyxaBall = v
                    break
                end
            end
        end))

        ConnectionManager:Add("SrnyxaRender", RunService.RenderStepped:Connect(function(dt)
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if srnyxaBall and srnyxaBall.Parent and SrnyxaState.VisualsEnabled then
                if not fovVisual then makeVisual() end
                fovVisual.CFrame = srnyxaBall.CFrame
                fovVisual.Size = Vector3.new(SrnyxaState.CatchRange, SrnyxaState.CatchRange, SrnyxaState.CatchRange)
                fovVisual.Color = (hrp and (hrp.Position - srnyxaBall.Position).Magnitude < SrnyxaState.CatchRange) and Color3.fromRGB(0, 255, 125) or Color3.fromRGB(145, 70, 255)
            elseif fovVisual then
                fovVisual:Destroy()
                fovVisual = nil
            end

            if SrnyxaState.AutoCatch and srnyxaBall and hrp then
                if (hrp.Position - srnyxaBall.Position).Magnitude < SrnyxaState.CatchRange then
                    srnyxaBall.AssemblyLinearVelocity = Vector3.zero
                    srnyxaBall.CFrame = hrp.CFrame * CFrame.new(0, 0, -1.8)
                end
            end

            if SrnyxaState.SpeedEnabled and hrp and char:FindFirstChild("Humanoid") and char.Humanoid.MoveDirection.Magnitude > 0 then
                hrp.CFrame = hrp.CFrame + (char.Humanoid.MoveDirection * SrnyxaState.SpeedValue * (dt * 60))
            end
        end))
    end

    local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
    MenuGroup:AddButton('Unload', function() Library:Unload() end)
    MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'LeftControl', NoUI = true, Text = 'Menu keybind' })

    Library.ToggleKeybind = Options.MenuKeybind

    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)

    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

    ThemeManager:SetFolder('NFLUniverse')
    SaveManager:SetFolder('NFLUniverse/Eclipse')

    SaveManager:BuildConfigSection(Tabs['UI Settings'])
    ThemeManager:ApplyToTab(Tabs['UI Settings'])

    SaveManager:LoadAutoloadConfig()

    Library:Notify('Eclipse loaded successfully!', 5)

    game.Players.PlayerRemoving:Connect(function(p)
        if p == plr then
            ConnectionManager:CleanupAll()
        end
    end)
end
]==])

-- Key system
local ACCESS_KEY = "YOUAREALARP"
local KEY_VALID_FOR = 24 * 60 * 60 -- seconds the key stays saved for
local KEY_FILE = "eclipse_loader_key.txt"

-- Global use counter (shared by everyone who runs the loader)
local COUNTER_NAMESPACE = "midnightloader"
local COUNTER_KEY = "uses"

local LOADER_VERSION = "v1.0"

-- Header artwork
-- Option A: upload the image to Roblox as a Decal and paste its id here
local BANNER_IMAGE = "" -- e.g. "rbxassetid://1234567890"
-- Option B: a direct link to the .png/.jpg - downloaded once and loaded via getcustomasset
local BANNER_IMAGE_URL = "https://raw.githubusercontent.com/Maruxas2/DUPE/devin/1785312511-eclipse-loader/assets/eclipse_banner.png"
local BANNER_FILE = "eclipse_loader_banner.png"


local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local COLORS = {
    bg = Color3.fromRGB(16, 16, 22),
    card = Color3.fromRGB(26, 26, 35),
    cardHover = Color3.fromRGB(38, 38, 52),
    text = Color3.fromRGB(238, 238, 248),
    subtext = Color3.fromRGB(138, 138, 160),
    accentA = Color3.fromRGB(126, 87, 255),
    accentB = Color3.fromRGB(72, 160, 255),
    good = Color3.fromRGB(96, 220, 150),
    bad = Color3.fromRGB(255, 104, 122),
    bannerFallback = Color3.fromRGB(22, 26, 42),
}

local function httpGet(url)
    local getters = {
        function()
            return game:HttpGet(url, true)
        end,
        function()
            return game:GetService("HttpService"):GetAsync(url)
        end,
    }
    for _, getter in ipairs(getters) do
        local ok, body = pcall(getter)
        if ok and type(body) == "string" then
            return body
        end
    end
    return nil
end

local function notify(text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Eclipse Loader",
            Text = text,
            Duration = 4,
        })
    end)
end

-- key persistence (uses executor file functions when available)
local function saveKey()
    if not (writefile and type(writefile) == "function") then
        return
    end
    pcall(writefile, KEY_FILE, ACCESS_KEY .. "|" .. tostring(os.time()))
end

local function keyStillValid()
    if not (readfile and type(readfile) == "function") then
        return false
    end
    if isfile and type(isfile) == "function" then
        local ok, exists = pcall(isfile, KEY_FILE)
        if not ok or not exists then
            return false
        end
    end

    local ok, data = pcall(readfile, KEY_FILE)
    if not ok or type(data) ~= "string" then
        return false
    end

    local savedKey, savedAt = data:match("^(.-)|(%d+)$")
    if savedKey ~= ACCESS_KEY or not savedAt then
        return false
    end

    local age = os.time() - tonumber(savedAt)
    if age < 0 or age > KEY_VALID_FOR then
        if delfile and type(delfile) == "function" then
            pcall(delfile, KEY_FILE)
        end
        return false
    end
    return true, KEY_VALID_FOR - age
end

local function formatDuration(seconds)
    seconds = math.max(0, math.floor(seconds))
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    if hours > 0 then
        return hours .. "h " .. minutes .. "m"
    end
    return minutes .. "m"
end

local function comma(n)
    local s = tostring(n)
    local out = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
    return (out:gsub("^,", ""))
end

local function runScript(entry)
    local code = entry.source
    if not code or code == "" then
        if not entry.url or entry.url == "" then
            return false, "no source set yet"
        end
        code = httpGet(entry.url)
        if not code then
            return false, "download failed"
        end
    end

    local fn, err = loadstring(code)
    if not fn then
        return false, tostring(err)
    end
    local ok, runErr = pcall(fn)
    if not ok then
        return false, tostring(runErr)
    end
    return true
end

-- UI ---------------------------------------------------------------------

-- Banner image resolution: prefer a Roblox asset id, else download the URL and
-- expose it through the executor's getcustomasset.
local function resolveBannerImage()
    if BANNER_IMAGE and BANNER_IMAGE ~= "" then
        return BANNER_IMAGE
    end
    if BANNER_IMAGE_URL and BANNER_IMAGE_URL ~= "" then
        local custom = getcustomasset or getsynasset
        if custom and writefile then
            local data = httpGet(BANNER_IMAGE_URL)
            if data and #data > 0 then
                local ok, asset = pcall(function()
                    writefile(BANNER_FILE, data)
                    return custom(BANNER_FILE)
                end)
                if ok and asset then
                    return asset
                end
            end
        end
    end
    return nil
end

local parentGui = (gethui and gethui()) or game:GetService("CoreGui")
local existing = parentGui:FindFirstChild("EclipseLoader")
if existing then
    existing:Destroy()
end

local function corner(inst, radius)
    local c = Instance.new("UICorner", inst)
    c.CornerRadius = UDim.new(0, radius)
    return c
end

local function makeShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5554236805"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.4
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    shadow.Size = UDim2.new(1, 40, 1, 40)
    shadow.Position = UDim2.fromOffset(-20, -16)
    shadow.ZIndex = -1
    shadow.Parent = parent
    return shadow
end

local function gradientStroke(parent, thickness)
    local stroke = Instance.new("UIStroke", parent)
    stroke.Thickness = thickness or 1.4
    stroke.Transparency = 0.25
    local gradient = Instance.new("UIGradient", stroke)
    gradient.Color = ColorSequence.new(COLORS.accentA, COLORS.accentB)
    gradient.Rotation = 45
    return stroke
end

-- Builds the artwork strip used by both the key window and the loader
local function makeBanner(parent, height, radius)
    local banner = Instance.new("Frame")
    banner.Name = "Banner"
    banner.Size = UDim2.new(1, 0, 0, height)
    banner.BackgroundColor3 = COLORS.bannerFallback
    banner.BorderSizePixel = 0
    banner.ClipsDescendants = true
    banner.Parent = parent
    corner(banner, radius)

    -- square off the bottom corners so it blends into the window body
    local cover = Instance.new("Frame")
    cover.Size = UDim2.new(1, 0, 0, radius)
    cover.Position = UDim2.new(0, 0, 1, -radius)
    cover.BackgroundColor3 = COLORS.bannerFallback
    cover.BorderSizePixel = 0
    cover.ZIndex = 0
    cover.Parent = banner

    local fallbackGradient = Instance.new("UIGradient", banner)
    fallbackGradient.Rotation = 90
    fallbackGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLORS.accentA),
        ColorSequenceKeypoint.new(0.55, COLORS.bannerFallback),
        ColorSequenceKeypoint.new(1, COLORS.bg),
    })

    local image = Instance.new("ImageLabel")
    image.Name = "Art"
    image.Size = UDim2.fromScale(1, 1)
    image.BackgroundTransparency = 1
    image.ScaleType = Enum.ScaleType.Crop
    image.ImageTransparency = 1
    image.ZIndex = 1
    image.Parent = banner

    -- bottom fade so text stays readable over the art
    local fade = Instance.new("Frame")
    fade.Size = UDim2.fromScale(1, 1)
    fade.BackgroundColor3 = COLORS.bg
    fade.BorderSizePixel = 0
    fade.ZIndex = 2
    fade.Parent = banner

    local fadeGradient = Instance.new("UIGradient", fade)
    fadeGradient.Rotation = 90
    fadeGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.45, 0.75),
        NumberSequenceKeypoint.new(1, 0.05),
    })

    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 2)
    line.Position = UDim2.new(0, 0, 1, -2)
    line.BackgroundColor3 = Color3.new(1, 1, 1)
    line.BorderSizePixel = 0
    line.ZIndex = 3
    line.Parent = banner

    local lineGradient = Instance.new("UIGradient", line)
    lineGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLORS.accentA),
        ColorSequenceKeypoint.new(0.5, COLORS.accentB),
        ColorSequenceKeypoint.new(1, COLORS.accentA),
    })

    task.spawn(function()
        local asset = resolveBannerImage()
        if asset and image.Parent then
            image.Image = asset
            TweenService:Create(image, TweenInfo.new(0.5), { ImageTransparency = 0 }):Play()
        end
    end)

    return banner
end

local gui = Instance.new("ScreenGui")
gui.Name = "EclipseLoader"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = parentGui

local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.5)
main.Size = UDim2.fromOffset(400, 556)
main.BackgroundColor3 = COLORS.bg
main.BorderSizePixel = 0
main.Visible = false
main.Parent = gui
corner(main, 16)
gradientStroke(main)
makeShadow(main)

local scale = Instance.new("UIScale", main)
scale.Scale = 0.85

-- header art
local header = makeBanner(main, 130, 16)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -120, 0, 22)
title.Position = UDim2.fromOffset(18, 78)
title.BackgroundTransparency = 1
title.Text = "ECLIPSE LOADER"
title.TextColor3 = COLORS.text
title.Font = Enum.Font.GothamBlack
title.TextSize = 19
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 4
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -120, 0, 14)
subtitle.Position = UDim2.fromOffset(18, 102)
subtitle.BackgroundTransparency = 1
subtitle.Text = #SCRIPTS .. " scripts available"
subtitle.TextColor3 = COLORS.subtext
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 12
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.ZIndex = 4
subtitle.Parent = header

local function makeHeaderButton(text, offsetX, hoverColor)
    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(28, 28)
    button.Position = UDim2.new(1, offsetX, 0, 12)
    button.BackgroundColor3 = COLORS.card
    button.BackgroundTransparency = 0.15
    button.AutoButtonColor = false
    button.Text = text
    button.TextColor3 = COLORS.text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.BorderSizePixel = 0
    button.ZIndex = 5
    button.Parent = header
    corner(button, 9)

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = hoverColor,
            BackgroundTransparency = 0,
        }):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = COLORS.card,
            BackgroundTransparency = 0.15,
        }):Play()
    end)
    return button
end

local closeButton = makeHeaderButton("✕", -40, COLORS.bad)
local minimizeButton = makeHeaderButton("—", -76, COLORS.cardHover)

-- body
local list = Instance.new("ScrollingFrame")
list.Name = "List"
list.Size = UDim2.new(1, -28, 1, -344)
list.Position = UDim2.fromOffset(14, 140)
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
list.ScrollBarThickness = 3
list.ScrollBarImageColor3 = COLORS.accentA
list.CanvasSize = UDim2.new()
list.AutomaticCanvasSize = Enum.AutomaticSize.Y
list.Parent = main

local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0, 9)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -28, 0, 16)
status.Position = UDim2.new(0, 14, 1, -60)
status.BackgroundTransparency = 1
status.Text = "Pick a script to execute"
status.TextColor3 = COLORS.subtext
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left
status.TextTruncate = Enum.TextTruncate.AtEnd
status.Parent = main

local function setStatus(text, color)
    status.Text = text
    status.TextColor3 = color or COLORS.subtext
end

-- footer
local footer = Instance.new("Frame")
footer.Name = "Footer"
footer.Size = UDim2.new(1, 0, 0, 42)
footer.Position = UDim2.new(0, 0, 1, -42)
footer.BackgroundTransparency = 1
footer.Parent = main

local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, -28, 0, 1)
divider.Position = UDim2.fromOffset(14, 0)
divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
divider.BackgroundTransparency = 0.9
divider.BorderSizePixel = 0
divider.Parent = footer

local usesDot = Instance.new("Frame")
usesDot.Size = UDim2.fromOffset(6, 6)
usesDot.Position = UDim2.fromOffset(16, 19)
usesDot.BackgroundColor3 = COLORS.accentB
usesDot.BorderSizePixel = 0
usesDot.Parent = footer
corner(usesDot, 3)

local usesLabel = Instance.new("TextLabel")
usesLabel.Size = UDim2.new(1, -100, 1, -1)
usesLabel.Position = UDim2.fromOffset(28, 1)
usesLabel.BackgroundTransparency = 1
usesLabel.Text = "Global uses: loading..."
usesLabel.TextColor3 = COLORS.subtext
usesLabel.Font = Enum.Font.GothamMedium
usesLabel.TextSize = 12
usesLabel.TextXAlignment = Enum.TextXAlignment.Left
usesLabel.TextTruncate = Enum.TextTruncate.AtEnd
usesLabel.Parent = footer

local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.fromOffset(70, 41)
versionLabel.Position = UDim2.new(1, -84, 0, 1)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = LOADER_VERSION
versionLabel.TextColor3 = COLORS.subtext
versionLabel.Font = Enum.Font.Gotham
versionLabel.TextSize = 12
versionLabel.TextXAlignment = Enum.TextXAlignment.Right
versionLabel.Parent = footer

-- script cards
local nameLabels = {}
for i, entry in ipairs(SCRIPTS) do
    local card = Instance.new("TextButton")
    card.Name = entry.name
    card.Size = UDim2.new(1, 0, 0, 54)
    card.BackgroundColor3 = COLORS.card
    card.AutoButtonColor = false
    card.Text = ""
    card.BorderSizePixel = 0
    card.LayoutOrder = i
    card.ClipsDescendants = true
    card.Parent = list
    corner(card, 11)

    local cardStroke = Instance.new("UIStroke", card)
    cardStroke.Color = COLORS.cardHover
    cardStroke.Thickness = 1
    cardStroke.Transparency = 0.4

    local badge = Instance.new("Frame")
    badge.Size = UDim2.fromOffset(34, 34)
    badge.Position = UDim2.fromOffset(10, 10)
    badge.BackgroundColor3 = Color3.new(1, 1, 1)
    badge.BorderSizePixel = 0
    badge.Parent = card
    corner(badge, 10)

    local badgeGradient = Instance.new("UIGradient", badge)
    badgeGradient.Rotation = 45
    badgeGradient.Color = ColorSequence.new(COLORS.accentA, COLORS.accentB)

    local badgeText = Instance.new("TextLabel")
    badgeText.Size = UDim2.fromScale(1, 1)
    badgeText.BackgroundTransparency = 1
    badgeText.Text = tostring(i)
    badgeText.TextColor3 = Color3.new(1, 1, 1)
    badgeText.Font = Enum.Font.GothamBold
    badgeText.TextSize = 15
    badgeText.Parent = badge

    local hasDesc = (entry.desc or "") ~= ""

    local name = Instance.new("TextLabel")
    name.Size = UDim2.new(1, -100, 0, 17)
    name.Position = UDim2.fromOffset(56, hasDesc and 11 or 18)
    name.BackgroundTransparency = 1
    name.Text = entry.name
    name.TextColor3 = COLORS.text
    name.Font = Enum.Font.GothamBold
    name.TextSize = 14
    name.TextXAlignment = Enum.TextXAlignment.Left
    name.Parent = card
    nameLabels[entry] = name

    if hasDesc then
        local desc = Instance.new("TextLabel")
        desc.Size = UDim2.new(1, -100, 0, 14)
        desc.Position = UDim2.fromOffset(56, 29)
        desc.BackgroundTransparency = 1
        desc.Text = entry.desc
        desc.TextColor3 = COLORS.subtext
        desc.Font = Enum.Font.Gotham
        desc.TextSize = 11
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.TextTruncate = Enum.TextTruncate.AtEnd
        desc.Parent = card
    end

    local action = Instance.new("TextLabel")
    action.Size = UDim2.fromOffset(60, 54)
    action.Position = UDim2.new(1, -66, 0, 0)
    action.BackgroundTransparency = 1
    action.Text = "RUN  ›"
    action.TextColor3 = COLORS.subtext
    action.Font = Enum.Font.GothamBold
    action.TextSize = 12
    action.TextXAlignment = Enum.TextXAlignment.Right
    action.Parent = card

    local glow = Instance.new("Frame")
    glow.Size = UDim2.new(0, 0, 1, 0)
    glow.BackgroundColor3 = COLORS.accentA
    glow.BackgroundTransparency = 0.88
    glow.BorderSizePixel = 0
    glow.ZIndex = 0
    glow.Parent = card

    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.15), { BackgroundColor3 = COLORS.cardHover }):Play()
        TweenService:Create(cardStroke, TweenInfo.new(0.15), {
            Color = COLORS.accentA,
            Transparency = 0.1,
        }):Play()
        TweenService:Create(glow, TweenInfo.new(0.25), { Size = UDim2.fromScale(1, 1) }):Play()
        action.TextColor3 = COLORS.text
    end)
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.15), { BackgroundColor3 = COLORS.card }):Play()
        TweenService:Create(cardStroke, TweenInfo.new(0.15), {
            Color = COLORS.cardHover,
            Transparency = 0.4,
        }):Play()
        TweenService:Create(glow, TweenInfo.new(0.25), { Size = UDim2.new(0, 0, 1, 0) }):Play()
        action.TextColor3 = COLORS.subtext
    end)

    card.MouseButton1Click:Connect(function()
        setStatus("Loading " .. entry.name .. "...")
        action.Text = "..."
        task.spawn(function()
            local ok, err = runScript(entry)
            action.Text = "RUN  ›"
            if ok then
                setStatus(entry.name .. " loaded", COLORS.good)
                notify(entry.name .. " loaded")
            else
                setStatus(entry.name .. ": " .. tostring(err), COLORS.bad)
                notify("Failed: " .. tostring(err))
            end
        end)
    end)
end

-- rename panel: pick a script, retitle it, then run it
-- (renames live in memory only, so every execute starts from the original names)
local renamePanel
do
    local selected = nil
    local expanded = false

    local panel = Instance.new("Frame")
    panel.Name = "RenamePanel"
    panel.Size = UDim2.new(1, -28, 0, 128)
    panel.Position = UDim2.new(0, 14, 1, -194)
    panel.BackgroundTransparency = 1
    panel.Parent = main

    local heading = Instance.new("TextLabel")
    heading.Size = UDim2.new(1, 0, 0, 14)
    heading.BackgroundTransparency = 1
    heading.Text = "RENAME & RUN"
    heading.TextColor3 = COLORS.subtext
    heading.Font = Enum.Font.GothamBold
    heading.TextSize = 11
    heading.TextXAlignment = Enum.TextXAlignment.Left
    heading.Parent = panel

    local picker = Instance.new("TextButton")
    picker.Size = UDim2.new(1, 0, 0, 34)
    picker.Position = UDim2.fromOffset(0, 18)
    picker.BackgroundColor3 = COLORS.card
    picker.AutoButtonColor = false
    picker.Text = ""
    picker.BorderSizePixel = 0
    picker.Parent = panel
    corner(picker, 9)

    local pickerStroke = Instance.new("UIStroke", picker)
    pickerStroke.Color = COLORS.cardHover
    pickerStroke.Thickness = 1

    local pickerText = Instance.new("TextLabel")
    pickerText.Size = UDim2.new(1, -46, 1, 0)
    pickerText.Position = UDim2.fromOffset(13, 0)
    pickerText.BackgroundTransparency = 1
    pickerText.Text = "Select a script..."
    pickerText.TextColor3 = COLORS.subtext
    pickerText.Font = Enum.Font.GothamMedium
    pickerText.TextSize = 13
    pickerText.TextXAlignment = Enum.TextXAlignment.Left
    pickerText.TextTruncate = Enum.TextTruncate.AtEnd
    pickerText.Parent = picker

    local chevron = Instance.new("TextLabel")
    chevron.Size = UDim2.fromOffset(30, 34)
    chevron.Position = UDim2.new(1, -34, 0, 0)
    chevron.BackgroundTransparency = 1
    chevron.Text = "▾"
    chevron.TextColor3 = COLORS.subtext
    chevron.Font = Enum.Font.GothamBold
    chevron.TextSize = 14
    chevron.Parent = picker

    local optionHeight = 30
    local options = Instance.new("Frame")
    options.Size = UDim2.new(1, 0, 0, 0)
    options.Position = UDim2.fromOffset(0, 54)
    options.BackgroundColor3 = COLORS.card
    options.BorderSizePixel = 0
    options.ClipsDescendants = true
    options.Visible = false
    options.ZIndex = 20
    options.Parent = panel
    corner(options, 9)

    local optionsStroke = Instance.new("UIStroke", options)
    optionsStroke.Color = COLORS.accentA
    optionsStroke.Thickness = 1
    optionsStroke.Transparency = 0.4

    local optionsLayout = Instance.new("UIListLayout", options)
    optionsLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local nameBox

    local function collapse()
        expanded = false
        chevron.Text = "▾"
        TweenService:Create(options, TweenInfo.new(0.18), { Size = UDim2.new(1, 0, 0, 0) }):Play()
        task.delay(0.18, function()
            if not expanded then
                options.Visible = false
            end
        end)
    end

    local function selectEntry(entry)
        selected = entry
        pickerText.Text = entry.name
        pickerText.TextColor3 = COLORS.text
        nameBox.Text = entry.name
        collapse()
    end

    for i, entry in ipairs(SCRIPTS) do
        local option = Instance.new("TextButton")
        option.Size = UDim2.new(1, 0, 0, optionHeight)
        option.BackgroundTransparency = 1
        option.AutoButtonColor = false
        option.Text = "    " .. entry.name
        option.TextColor3 = COLORS.subtext
        option.Font = Enum.Font.GothamMedium
        option.TextSize = 12
        option.TextXAlignment = Enum.TextXAlignment.Left
        option.LayoutOrder = i
        option.ZIndex = 21
        option.Parent = options

        option.MouseEnter:Connect(function()
            option.BackgroundTransparency = 0.85
            option.BackgroundColor3 = COLORS.accentA
            option.TextColor3 = COLORS.text
        end)
        option.MouseLeave:Connect(function()
            option.BackgroundTransparency = 1
            option.TextColor3 = COLORS.subtext
        end)
        option.MouseButton1Click:Connect(function()
            selectEntry(entry)
        end)

        -- keep the dropdown label in sync with renames
        nameLabels[entry]:GetPropertyChangedSignal("Text"):Connect(function()
            option.Text = "    " .. nameLabels[entry].Text
        end)
    end

    picker.MouseButton1Click:Connect(function()
        expanded = not expanded
        if expanded then
            chevron.Text = "▴"
            options.Visible = true
            TweenService
                :Create(options, TweenInfo.new(0.18), {
                    Size = UDim2.new(1, 0, 0, optionHeight * #SCRIPTS),
                })
                :Play()
        else
            collapse()
        end
    end)

    local boxHolder = Instance.new("Frame")
    boxHolder.Size = UDim2.new(1, -104, 0, 34)
    boxHolder.Position = UDim2.fromOffset(0, 58)
    boxHolder.BackgroundColor3 = COLORS.card
    boxHolder.BorderSizePixel = 0
    boxHolder.Parent = panel
    corner(boxHolder, 9)

    local boxStroke = Instance.new("UIStroke", boxHolder)
    boxStroke.Color = COLORS.cardHover
    boxStroke.Thickness = 1

    nameBox = Instance.new("TextBox")
    nameBox.Size = UDim2.new(1, -26, 1, 0)
    nameBox.Position = UDim2.fromOffset(13, 0)
    nameBox.BackgroundTransparency = 1
    nameBox.ClearTextOnFocus = false
    nameBox.Text = ""
    nameBox.PlaceholderText = "New name..."
    nameBox.PlaceholderColor3 = COLORS.subtext
    nameBox.TextColor3 = COLORS.text
    nameBox.Font = Enum.Font.GothamMedium
    nameBox.TextSize = 13
    nameBox.TextXAlignment = Enum.TextXAlignment.Left
    nameBox.Parent = boxHolder

    nameBox.Focused:Connect(function()
        TweenService:Create(boxStroke, TweenInfo.new(0.15), { Color = COLORS.accentA }):Play()
    end)
    nameBox.FocusLost:Connect(function()
        TweenService:Create(boxStroke, TweenInfo.new(0.15), { Color = COLORS.cardHover }):Play()
    end)

    local function makePanelButton(text, position, size)
        local button = Instance.new("TextButton")
        button.Size = size
        button.Position = position
        button.BackgroundColor3 = Color3.new(1, 1, 1)
        button.AutoButtonColor = false
        button.Text = text
        button.TextColor3 = Color3.new(1, 1, 1)
        button.Font = Enum.Font.GothamBold
        button.TextSize = 12
        button.BorderSizePixel = 0
        button.Parent = panel
        corner(button, 9)

        local gradient = Instance.new("UIGradient", button)
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, COLORS.accentA),
            ColorSequenceKeypoint.new(1, COLORS.accentB),
        })

        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.15), { TextTransparency = 0.2 }):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.15), { TextTransparency = 0 }):Play()
        end)
        return button
    end

    local renameButton = makePanelButton("RENAME", UDim2.new(1, -96, 0, 58), UDim2.fromOffset(96, 34))
    local loadButton = makePanelButton("LOAD SELECTED", UDim2.fromOffset(0, 98), UDim2.new(1, 0, 0, 30))

    local function applyRename()
        if not selected then
            setStatus("Select a script first", COLORS.bad)
            return
        end
        local newName = (nameBox.Text or ""):gsub("^%s+", ""):gsub("%s+$", "")
        if newName == "" then
            setStatus("Enter a new name first", COLORS.bad)
            return
        end
        local previous = selected.name
        selected.name = newName
        nameLabels[selected].Text = newName
        pickerText.Text = newName
        setStatus('Renamed "' .. previous .. '" to "' .. newName .. '"', COLORS.good)
    end

    renameButton.MouseButton1Click:Connect(applyRename)
    nameBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            applyRename()
        end
    end)

    loadButton.MouseButton1Click:Connect(function()
        if not selected then
            setStatus("Select a script first", COLORS.bad)
            return
        end
        local entry = selected
        setStatus("Loading " .. entry.name .. "...")
        loadButton.Text = "LOADING..."
        task.spawn(function()
            local ok, err = runScript(entry)
            loadButton.Text = "LOAD SELECTED"
            if ok then
                setStatus(entry.name .. " loaded", COLORS.good)
                notify(entry.name .. " loaded")
            else
                setStatus(entry.name .. ": " .. tostring(err), COLORS.bad)
                notify("Failed: " .. tostring(err))
            end
        end)
    end)

    renamePanel = panel
end

-- dragging
local function makeDraggable(window, handle)
    local dragging, dragStart, startPos = false, nil, nil

    handle.InputBegan:Connect(function(input)
        if
            input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
        then
            dragging = true
            dragStart = input.Position
            startPos = window.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if
            dragging
            and (
                input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch
            )
        then
            local delta = input.Position - dragStart
            window.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if
            input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
        then
            dragging = false
        end
    end)
end

makeDraggable(main, header)

-- window controls
local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    list.Visible = not minimized
    footer.Visible = not minimized
    status.Visible = not minimized
    renamePanel.Visible = not minimized
    minimizeButton.Text = minimized and "+" or "—"
    TweenService
        :Create(main, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = minimized and UDim2.fromOffset(400, 130) or UDim2.fromOffset(400, 556),
        })
        :Play()
end)

closeButton.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(
        scale,
        TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
        { Scale = 0.85 }
    )
    tween:Play()
    tween.Completed:Wait()
    gui:Destroy()
end)

-- top-of-screen credit banner, shown while the loader is open
local function showCreditBanner()
    local banner = Instance.new("Frame")
    banner.Name = "CreditBanner"
    banner.AnchorPoint = Vector2.new(0.5, 0)
    banner.Position = UDim2.new(0.5, 0, 0, -40)
    banner.Size = UDim2.fromOffset(196, 30)
    banner.BackgroundColor3 = COLORS.bg
    banner.BackgroundTransparency = 0.1
    banner.BorderSizePixel = 0
    banner.Parent = gui
    corner(banner, 15)
    gradientStroke(banner, 1.2)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.fromOffset(6, 6)
    dot.Position = UDim2.fromOffset(14, 12)
    dot.BackgroundColor3 = COLORS.good
    dot.BorderSizePixel = 0
    dot.Parent = banner
    corner(dot, 3)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -30, 1, 0)
    label.Position = UDim2.fromOffset(26, 0)
    label.BackgroundTransparency = 1
    label.Text = "coded by elcipse"
    label.TextColor3 = COLORS.text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.Parent = banner

    local labelGradient = Instance.new("UIGradient", label)
    labelGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLORS.accentA),
        ColorSequenceKeypoint.new(0.5, COLORS.text),
        ColorSequenceKeypoint.new(1, COLORS.accentB),
    })

    TweenService
        :Create(banner, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0, 12),
        })
        :Play()

    task.spawn(function()
        while banner.Parent do
            TweenService:Create(dot, TweenInfo.new(0.9), { BackgroundTransparency = 0.65 }):Play()
            task.wait(0.9)
            TweenService:Create(dot, TweenInfo.new(0.9), { BackgroundTransparency = 0 }):Play()
            task.wait(0.9)
        end
    end)
end

-- reveal the loader (called once the key is accepted)
local function openLoader(remaining)
    main.Visible = true
    scale.Scale = 0.85
    showCreditBanner()
    TweenService
        :Create(scale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 })
        :Play()

    if remaining then
        subtitle.Text = #SCRIPTS .. " scripts  •  key expires in " .. formatDuration(remaining)
    end

    task.spawn(function()
        local url = ("https://api.counterapi.dev/v1/%s/%s/up"):format(COUNTER_NAMESPACE, COUNTER_KEY)
        local body = httpGet(url)
        local count = body and body:match('"count"%s*:%s*(%d+)')
        if count then
            usesLabel.Text = "Global uses: " .. comma(count)
        else
            usesLabel.Text = "Global uses: unavailable"
        end
    end)

    notify("Loaded for " .. LocalPlayer.Name)
end

-- key window ------------------------------------------------------------

local function showKeyWindow()
    local keyWindow = Instance.new("Frame")
    keyWindow.Name = "KeyWindow"
    keyWindow.AnchorPoint = Vector2.new(0.5, 0.5)
    keyWindow.Position = UDim2.fromScale(0.5, 0.5)
    keyWindow.Size = UDim2.fromOffset(360, 320)
    keyWindow.BackgroundColor3 = COLORS.bg
    keyWindow.BorderSizePixel = 0
    keyWindow.Parent = gui
    corner(keyWindow, 16)
    gradientStroke(keyWindow)
    makeShadow(keyWindow)

    local keyScale = Instance.new("UIScale", keyWindow)
    keyScale.Scale = 0.85

    local keyBanner = makeBanner(keyWindow, 110, 16)
    makeDraggable(keyWindow, keyBanner)

    local keyTitle = Instance.new("TextLabel")
    keyTitle.Size = UDim2.new(1, -36, 0, 20)
    keyTitle.Position = UDim2.fromOffset(18, 62)
    keyTitle.BackgroundTransparency = 1
    keyTitle.Text = "ECLIPSE LOADER"
    keyTitle.TextColor3 = COLORS.text
    keyTitle.Font = Enum.Font.GothamBlack
    keyTitle.TextSize = 18
    keyTitle.TextXAlignment = Enum.TextXAlignment.Left
    keyTitle.ZIndex = 4
    keyTitle.Parent = keyBanner

    local keySubtitle = Instance.new("TextLabel")
    keySubtitle.Size = UDim2.new(1, -36, 0, 14)
    keySubtitle.Position = UDim2.fromOffset(18, 84)
    keySubtitle.BackgroundTransparency = 1
    keySubtitle.Text = "🔒  key required"
    keySubtitle.TextColor3 = COLORS.subtext
    keySubtitle.Font = Enum.Font.GothamMedium
    keySubtitle.TextSize = 12
    keySubtitle.TextXAlignment = Enum.TextXAlignment.Left
    keySubtitle.ZIndex = 4
    keySubtitle.Parent = keyBanner

    local keyClose = Instance.new("TextButton")
    keyClose.Size = UDim2.fromOffset(28, 28)
    keyClose.Position = UDim2.new(1, -40, 0, 12)
    keyClose.BackgroundColor3 = COLORS.card
    keyClose.BackgroundTransparency = 0.15
    keyClose.AutoButtonColor = false
    keyClose.Text = "✕"
    keyClose.TextColor3 = COLORS.text
    keyClose.Font = Enum.Font.GothamBold
    keyClose.TextSize = 14
    keyClose.BorderSizePixel = 0
    keyClose.ZIndex = 5
    keyClose.Parent = keyBanner
    corner(keyClose, 9)
    keyClose.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    local prompt = Instance.new("TextLabel")
    prompt.Size = UDim2.new(1, -36, 0, 16)
    prompt.Position = UDim2.fromOffset(18, 126)
    prompt.BackgroundTransparency = 1
    prompt.Text = "Enter your key to unlock the hub"
    prompt.TextColor3 = COLORS.subtext
    prompt.Font = Enum.Font.Gotham
    prompt.TextSize = 12
    prompt.TextXAlignment = Enum.TextXAlignment.Left
    prompt.Parent = keyWindow

    local inputHolder = Instance.new("Frame")
    inputHolder.Size = UDim2.new(1, -36, 0, 40)
    inputHolder.Position = UDim2.fromOffset(18, 150)
    inputHolder.BackgroundColor3 = COLORS.card
    inputHolder.BorderSizePixel = 0
    inputHolder.Parent = keyWindow
    corner(inputHolder, 10)

    local inputStroke = Instance.new("UIStroke", inputHolder)
    inputStroke.Color = COLORS.cardHover
    inputStroke.Thickness = 1

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -26, 1, 0)
    input.Position = UDim2.fromOffset(13, 0)
    input.BackgroundTransparency = 1
    input.ClearTextOnFocus = false
    input.Text = ""
    input.PlaceholderText = "Paste key here..."
    input.PlaceholderColor3 = COLORS.subtext
    input.TextColor3 = COLORS.text
    input.Font = Enum.Font.GothamMedium
    input.TextSize = 13
    input.TextXAlignment = Enum.TextXAlignment.Left
    input.Parent = inputHolder

    input.Focused:Connect(function()
        TweenService:Create(inputStroke, TweenInfo.new(0.15), { Color = COLORS.accentA }):Play()
    end)
    input.FocusLost:Connect(function()
        TweenService:Create(inputStroke, TweenInfo.new(0.15), { Color = COLORS.cardHover }):Play()
    end)

    local submit = Instance.new("TextButton")
    submit.Size = UDim2.new(1, -36, 0, 40)
    submit.Position = UDim2.fromOffset(18, 202)
    submit.BackgroundColor3 = Color3.new(1, 1, 1)
    submit.AutoButtonColor = false
    submit.Text = "UNLOCK"
    submit.TextColor3 = Color3.new(1, 1, 1)
    submit.Font = Enum.Font.GothamBold
    submit.TextSize = 13
    submit.BorderSizePixel = 0
    submit.Parent = keyWindow
    corner(submit, 10)

    local submitGradient = Instance.new("UIGradient", submit)
    submitGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLORS.accentA),
        ColorSequenceKeypoint.new(1, COLORS.accentB),
    })

    local keyStatus = Instance.new("TextLabel")
    keyStatus.Size = UDim2.new(1, -36, 0, 16)
    keyStatus.Position = UDim2.fromOffset(18, 250)
    keyStatus.BackgroundTransparency = 1
    keyStatus.Text = ""
    keyStatus.TextColor3 = COLORS.bad
    keyStatus.Font = Enum.Font.Gotham
    keyStatus.TextSize = 11
    keyStatus.TextXAlignment = Enum.TextXAlignment.Left
    keyStatus.Parent = keyWindow

    local credit = Instance.new("TextLabel")
    credit.Size = UDim2.new(1, -36, 0, 14)
    credit.Position = UDim2.new(0, 18, 1, -28)
    credit.BackgroundTransparency = 1
    credit.Text = "coded by elcipse"
    credit.TextColor3 = COLORS.subtext
    credit.Font = Enum.Font.GothamMedium
    credit.TextSize = 11
    credit.TextXAlignment = Enum.TextXAlignment.Right
    credit.Parent = keyWindow

    TweenService
        :Create(keyScale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 })
        :Play()

    local attempts = 0
    local checking = false

    local function check()
        if checking then
            return
        end
        checking = true

        local entered = (input.Text or ""):gsub("^%s+", ""):gsub("%s+$", "")
        if entered == ACCESS_KEY then
            keyStatus.TextColor3 = COLORS.good
            keyStatus.Text = "Key accepted - saved for 24 hours"
            saveKey()
            notify("Key accepted")
            task.wait(0.4)
            local out = TweenService:Create(
                keyScale,
                TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                { Scale = 0.85 }
            )
            out:Play()
            out.Completed:Wait()
            keyWindow:Destroy()
            openLoader(KEY_VALID_FOR)
            return
        end

        attempts = attempts + 1
        keyStatus.TextColor3 = COLORS.bad
        keyStatus.Text = entered == "" and "Enter a key first" or ("Invalid key (attempt " .. attempts .. ")")

        local origin = keyWindow.Position
        for _, offset in ipairs({ -8, 8, -5, 5, 0 }) do
            keyWindow.Position = origin + UDim2.fromOffset(offset, 0)
            task.wait(0.03)
        end
        keyWindow.Position = origin
        checking = false
    end

    submit.MouseEnter:Connect(function()
        TweenService:Create(submit, TweenInfo.new(0.15), { TextTransparency = 0.15 }):Play()
    end)
    submit.MouseLeave:Connect(function()
        TweenService:Create(submit, TweenInfo.new(0.15), { TextTransparency = 0 }):Play()
    end)

    submit.MouseButton1Click:Connect(function()
        task.spawn(check)
    end)
    input.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            task.spawn(check)
        end
    end)
end

local saved, remaining = keyStillValid()
if saved then
    openLoader(remaining)
else
    showKeyWindow()
end
