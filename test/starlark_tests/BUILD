load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load(":apple_bundle_version_tests.bzl", "apple_bundle_version_test_suite")
load(":apple_core_data_model_tests.bzl", "apple_core_data_model_test_suite")
load(":dtrace_compile_tests.bzl", "dtrace_compile_test_suite")
load(":ios_application_resources_test.bzl", "ios_application_resources_test_suite")
load(":ios_application_tests.bzl", "ios_application_test_suite")
load(":ios_app_clip_tests.bzl", "ios_app_clip_test_suite")
load(":ios_extension_tests.bzl", "ios_extension_test_suite")
load(":ios_framework_tests.bzl", "ios_framework_test_suite")
load(":ios_dynamic_framework_tests.bzl", "ios_dynamic_framework_test_suite")
load(":ios_imessage_application_tests.bzl", "ios_imessage_application_test_suite")
load(":ios_static_framework_tests.bzl", "ios_static_framework_test_suite")
load(":ios_sticker_pack_extension_tests.bzl", "ios_sticker_pack_extension_test_suite")
load(":ios_ui_test_tests.bzl", "ios_ui_test_test_suite")
load(":ios_unit_test_tests.bzl", "ios_unit_test_test_suite")
load(":macos_application_resources_tests.bzl", "macos_application_resources_test_suite")
load(":macos_application_tests.bzl", "macos_application_test_suite")
load(":macos_bundle_tests.bzl", "macos_bundle_test_suite")
load(":macos_command_line_application_tests.bzl", "macos_command_line_application_test_suite")
load(":macos_dylib_tests.bzl", "macos_dylib_test_suite")
load(":macos_extension_tests.bzl", "macos_extension_test_suite")
load(":macos_kernel_extension_tests.bzl", "macos_kernel_extension_test_suite")
load(":macos_quick_look_plugin_tests.bzl", "macos_quick_look_plugin_test_suite")
load(":macos_ui_test_tests.bzl", "macos_ui_test_test_suite")
load(":macos_unit_test_tests.bzl", "macos_unit_test_test_suite")
load(":tvos_application_swift_tests.bzl", "tvos_application_swift_test_suite")
load(":tvos_application_tests.bzl", "tvos_application_test_suite")
load(":tvos_dynamic_framework_tests.bzl", "tvos_dynamic_framework_test_suite")
load(":tvos_extension_tests.bzl", "tvos_extension_test_suite")
load(":tvos_framework_tests.bzl", "tvos_framework_test_suite")
load(":tvos_static_framework_tests.bzl", "tvos_static_framework_test_suite")
load(":tvos_ui_test_tests.bzl", "tvos_ui_test_test_suite")
load(":tvos_unit_test_tests.bzl", "tvos_unit_test_test_suite")
load(":watchos_application_swift_tests.bzl", "watchos_application_swift_test_suite")
load(":watchos_application_tests.bzl", "watchos_application_test_suite")
load(":watchos_dynamic_framework_tests.bzl", "watchos_dynamic_framework_test_suite")
load(":watchos_extension_tests.bzl", "watchos_extension_test_suite")
load(":watchos_static_framework_tests.bzl", "watchos_static_framework_test_suite")
load(":watchos_ui_test_tests.bzl", "watchos_ui_test_test_suite")
load(":watchos_unit_test_tests.bzl", "watchos_unit_test_test_suite")

licenses(["notice"])

apple_bundle_version_test_suite()

apple_core_data_model_test_suite()

dtrace_compile_test_suite()

ios_application_resources_test_suite()

ios_application_test_suite()

ios_app_clip_test_suite()

ios_extension_test_suite()

ios_framework_test_suite()

ios_dynamic_framework_test_suite()

ios_imessage_application_test_suite()

ios_static_framework_test_suite()

ios_sticker_pack_extension_test_suite()

ios_ui_test_test_suite()

ios_unit_test_test_suite()

macos_application_resources_test_suite()

macos_application_test_suite()

macos_bundle_test_suite()

macos_command_line_application_test_suite()

macos_dylib_test_suite()

macos_extension_test_suite()

macos_kernel_extension_test_suite()

macos_quick_look_plugin_test_suite()

macos_ui_test_test_suite()

macos_unit_test_test_suite()

tvos_application_swift_test_suite()

tvos_application_test_suite()

tvos_extension_test_suite()

tvos_dynamic_framework_test_suite()

tvos_framework_test_suite()

tvos_static_framework_test_suite()

tvos_ui_test_test_suite()

tvos_unit_test_test_suite()

watchos_application_swift_test_suite()

watchos_application_test_suite()

watchos_dynamic_framework_test_suite()

watchos_extension_test_suite()

watchos_static_framework_test_suite()

watchos_ui_test_test_suite()

watchos_unit_test_test_suite()

test_suite(
    name = "all_tests",
)

bzl_library(
    name = "starlark_tests_bzls",
    srcs = glob(["**/*.bzl"]),
    deps = [
        "//apple:providers",
        "//apple/internal:apple_product_type",
        "@bazel_skylib//lib:dicts",
        "@bazel_skylib//lib:new_sets",
        "@bazel_skylib//lib:paths",
        "@bazel_skylib//lib:unittest",
    ],
)

exports_files(glob(["verifier_scripts/*"]))
