// renderer.h
#pragma once

#include "imgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_vulkan.h"
#include <stdio.h>          // printf, fprintf
#include <stdlib.h>         // abort
#define GLFW_INCLUDE_NONE
#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>

// Volk headers
#ifdef IMGUI_IMPL_VULKAN_USE_VOLK
#define VOLK_IMPLEMENTATION
#include <volk.h>
#endif

#if defined(_MSC_VER) && (_MSC_VER >= 1900) && !defined(IMGUI_DISABLE_WIN32_FUNCTIONS)
#pragma comment(lib, "legacy_stdio_definitions")
#endif

//#define APP_USE_UNLIMITED_FRAME_RATE
#ifdef _DEBUG
#define APP_USE_VULKAN_DEBUG_REPORT
VkDebugReportCallbackEXT g_DebugReport = VK_NULL_HANDLE;
#endif

// Data
extern VkAllocationCallbacks*   g_Allocator;
extern VkInstance               g_Instance;
extern VkPhysicalDevice         g_PhysicalDevice;
extern VkDevice                 g_Device;
extern uint32_t                 g_QueueFamily;
extern VkQueue                  g_Queue;
extern VkPipelineCache          g_PipelineCache;
extern VkDescriptorPool         g_DescriptorPool;

extern ImGui_ImplVulkanH_Window g_MainWindowData;
extern uint32_t                 g_MinImageCount;
extern bool                     g_SwapChainRebuild;

void glfw_error_callback(int error, const char* description);

void check_vk_result(VkResult err);

#ifdef APP_USE_VULKAN_DEBUG_REPORT
VKAPI_ATTR VkBool32 VKAPI_CALL debug_report(VkDebugReportFlagsEXT flags, VkDebugReportObjectTypeEXT objectType, uint64_t object, size_t location, int32_t messageCode, const char* pLayerPrefix, const char* pMessage, void* pUserData)
{
    (void)flags; (void)object; (void)location; (void)messageCode; (void)pUserData; (void)pLayerPrefix; // Unused arguments
    fprintf(stderr, "[vulkan] Debug report from ObjectType: %i\nMessage: %s\n\n", objectType, pMessage);
    return VK_FALSE;
}
#endif // APP_USE_VULKAN_DEBUG_REPORT

bool IsExtensionAvailable(const ImVector<VkExtensionProperties>& properties, const char* extension);

void SetupVulkan(ImVector<const char*> instance_extensions);

void SetupVulkanWindow(ImGui_ImplVulkanH_Window* wd, VkSurfaceKHR surface, int width, int height);

void CleanupVulkan();

void CleanupVulkanWindow();

void FrameRender(ImGui_ImplVulkanH_Window* wd, ImDrawData* draw_data);

void FramePresent(ImGui_ImplVulkanH_Window* wd);




