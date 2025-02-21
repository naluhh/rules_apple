# Copyright 2019 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Bazel rules for creating tvOS applications and bundles."""

load(
    "@build_bazel_rules_apple//apple/internal/testing:apple_test_assembler.bzl",
    "apple_test_assembler",
)
load(
    "@build_bazel_rules_apple//apple/internal/testing:build_test_rules.bzl",
    "apple_build_test_rule",
)
load(
    "@build_bazel_rules_apple//apple/internal/testing:tvos_rules.bzl",
    _tvos_internal_ui_test_bundle = "tvos_internal_ui_test_bundle",
    _tvos_internal_unit_test_bundle = "tvos_internal_unit_test_bundle",
    _tvos_ui_test = "tvos_ui_test",
    _tvos_unit_test = "tvos_unit_test",
)
load(
    "@build_bazel_rules_apple//apple/internal:apple_product_type.bzl",
    "apple_product_type",
)
load(
    "@build_bazel_rules_apple//apple/internal:binary_support.bzl",
    "binary_support",
)
load(
    "@build_bazel_rules_apple//apple/internal:tvos_rules.bzl",
    _tvos_application = "tvos_application",
    _tvos_dynamic_framework = "tvos_dynamic_framework",
    _tvos_extension = "tvos_extension",
    _tvos_framework = "tvos_framework",
    _tvos_static_framework = "tvos_static_framework",
)

def tvos_application(name, **kwargs):
    """Builds and bundles a tvOS application."""
    bundling_args = binary_support.add_entitlements(
        name,
        platform_type = str(apple_common.platform_type.tvos),
        product_type = apple_product_type.application,
        **kwargs
    )

    _tvos_application(
        name = name,
        dylibs = kwargs.get("frameworks", []),
        **bundling_args
    )

def tvos_extension(name, **kwargs):
    """Builds and bundles a tvOS extension."""
    bundling_args = binary_support.add_entitlements(
        name,
        platform_type = str(apple_common.platform_type.tvos),
        product_type = apple_product_type.app_extension,
        **kwargs
    )

    _tvos_extension(
        name = name,
        dylibs = kwargs.get("frameworks", []),
        **bundling_args
    )

def tvos_framework(name, **kwargs):
    # buildifier: disable=function-docstring-args
    """Builds and bundles a tvOS dynamic framework."""
    binary_args = dict(kwargs)

    # TODO(b/120861201): The linkopts macro additions here only exist because the Starlark linking
    # API does not accept extra linkopts and link inputs. With those, it will be possible to merge
    # these workarounds into the rule implementations.
    bundle_name = binary_args.get("bundle_name", name)
    binary_args["linkopts"] = binary_args.pop("linkopts", []) + [
        "-install_name,@rpath/%s.framework/%s" % (bundle_name, bundle_name),
    ]

    bundling_args = binary_support.add_entitlements(
        name,
        platform_type = str(apple_common.platform_type.tvos),
        product_type = apple_product_type.framework,
        **binary_args
    )

    # Remove any kwargs that shouldn't be passed to the underlying rule.
    bundling_args.pop("entitlements", None)

    _tvos_framework(
        name = name,
        dylibs = binary_args.get("frameworks", []),
        **bundling_args
    )

def tvos_static_framework(name, **kwargs):
    # buildifier: disable=function-docstring-args
    """Builds and bundles a tvOS static framework for third-party distribution."""
    avoid_deps = kwargs.get("avoid_deps")
    deps = kwargs.get("deps")
    apple_static_library_name = "%s.apple_static_library" % name

    native.apple_static_library(
        name = apple_static_library_name,
        deps = deps,
        avoid_deps = avoid_deps,
        minimum_os_version = kwargs.get("minimum_os_version"),
        platform_type = str(apple_common.platform_type.tvos),
        tags = kwargs.get("tags"),
        testonly = kwargs.get("testonly"),
        visibility = kwargs.get("visibility"),
    )

    passthrough_args = kwargs
    passthrough_args.pop("avoid_deps", None)
    passthrough_args.pop("deps", None)

    _tvos_static_framework(
        name = name,
        deps = [apple_static_library_name],
        avoid_deps = [apple_static_library_name],
        **passthrough_args
    )

_DEFAULT_TEST_RUNNER = "@build_bazel_rules_apple//apple/testing/default_runner:tvos_default_runner"

def tvos_unit_test(name, **kwargs):
    runner = kwargs.pop("runner", _DEFAULT_TEST_RUNNER)
    apple_test_assembler.assemble(
        name = name,
        bundle_rule = _tvos_internal_unit_test_bundle,
        test_rule = _tvos_unit_test,
        runner = runner,
        bundle_loader = kwargs.get("test_host"),
        dylibs = kwargs.get("frameworks"),
        **kwargs
    )

def tvos_ui_test(name, **kwargs):
    runner = kwargs.pop("runner", _DEFAULT_TEST_RUNNER)
    apple_test_assembler.assemble(
        name = name,
        bundle_rule = _tvos_internal_ui_test_bundle,
        test_rule = _tvos_ui_test,
        runner = runner,
        **kwargs
    )

def tvos_dynamic_framework(name, **kwargs):
    # buildifier: disable=function-docstring-args
    """Builds and bundles a tvOS dynamic framework that is consumable by Xcode."""

    binary_args = dict(kwargs)

    # TODO(b/120861201): The linkopts macro additions here only exist because the Starlark linking
    # API does not accept extra linkopts and link inputs. With those, it will be possible to merge
    # these workarounds into the rule implementations.
    bundle_name = binary_args.get("bundle_name", name)
    binary_args["linkopts"] = binary_args.pop("linkopts", []) + [
        "-install_name",
        "@rpath/%s.framework/%s" % (bundle_name, bundle_name),
    ]
    bundling_args = binary_support.add_entitlements(
        name,
        include_entitlements = False,
        platform_type = str(apple_common.platform_type.watchos),
        product_type = apple_product_type.framework,
        exported_symbols_lists = binary_args.pop("exported_symbols_lists", None),
        **binary_args
    )

    # Remove any kwargs that shouldn't be passed to the underlying rule.
    bundling_args.pop("entitlements", None)

    _tvos_dynamic_framework(
        name = name,
        extension_safe = kwargs.get("extension_safe"),
        **bundling_args
    )

tvos_build_test = apple_build_test_rule(
    doc = """\
Test rule to check that the given library targets (Swift, Objective-C, C++)
build for tvOS.

Typical usage:

```starlark
tvos_build_test(
    name = "my_build_test",
    minimum_os_version = "12.0",
    targets = [
        "//some/package:my_library",
    ],
)
```
""",
    platform_type = "tvos",
)
