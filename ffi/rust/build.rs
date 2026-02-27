use std::path::PathBuf;

fn main() {
    let manifest_dir =
        PathBuf::from(std::env::var("CARGO_MANIFEST_DIR").expect("CARGO_MANIFEST_DIR not set"));
    let mcl_root = manifest_dir.join("../..").canonicalize().unwrap();

    let mut config = cmake::Config::new(&mcl_root);

    config
        .define("MCL_FP_BIT", "256")
        .define("MCL_FR_BIT", "256")
        .define("MCL_STANDALONE", "ON")
        .define("MCL_BUILD_TESTING", "OFF")
        .define("MCL_BUILD_SAMPLE", "OFF");

    // mcl requires clang++ for compiling .ll files on non-x86_64-Linux platforms.
    // On macOS the default compiler is already clang++.
    // On Linux ARM64 (and other non-x86_64 arches) we need to set it explicitly.
    if cfg!(target_os = "linux") && !cfg!(target_arch = "x86_64") {
        config.define("CMAKE_CXX_COMPILER", "clang++");
    }

    let dst = config.build_target("mcl_st").build();

    println!("cargo:rustc-link-search=native={}/build/lib", dst.display());
    println!("cargo:rustc-link-lib=static=mcl");

    // Link C++ standard library (needed by mcl's C++ code)
    if cfg!(target_os = "macos") {
        println!("cargo:rustc-link-lib=c++");
    } else if cfg!(target_os = "linux") {
        println!("cargo:rustc-link-lib=stdc++");
    }
}
