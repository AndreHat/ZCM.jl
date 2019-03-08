using BinaryProvider # requires BinaryProvider 0.3.0 or later


for (root, dirs, files) in walkdir(".")
    println("Directories in $root")
    for dir in dirs
        println(joinpath(root, dir)) # path to directories
    end
    println("Files in $root")
    for file in files
        println(joinpath(root, file)) # path to files
    end
end


# Parse some basic command-line arguments
const verbose = "--verbose" in ARGS
const prefix = Prefix(get([a for a in ARGS if a != "--verbose"], 1, joinpath(@__DIR__, "usr")))
products = [
    LibraryProduct(Prefix(prefix.path*"/usr/local"), ["libzcm"], :libzcm),
    LibraryProduct(Prefix(prefix.path*"/usr/local"), ["libzcmjulia"], :libzcmjulia),
    LibraryProduct(prefix, ["libzmq"], :libzmq),
]

# Download binaries from hosted location
bin_prefix = "https://github.com/Affie/ZCMBuilder/releases/download/v0.1.0"

# Listing of files generated by BinaryBuilder:
download_info = Dict(
    Linux(:aarch64, libc=:glibc) => ("$bin_prefix/ZCMBuilder.v0.1.0.aarch64-linux-gnu.tar.gz", "2ac713aa98c2716f1e351d1600e2a803b92814d5db52a5613048980438fe848f"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf) => ("$bin_prefix/ZCMBuilder.v0.1.0.arm-linux-gnueabihf.tar.gz", "072db64a872a6ed648b7c6e558385726984f11d4b5ebfd8ae70446ebd41f478f"),
    Linux(:i686, libc=:glibc) => ("$bin_prefix/ZCMBuilder.v0.1.0.i686-linux-gnu.tar.gz", "3920475a5283e5928e643e2dd4c84d56403817cfd963583bcc6b0b4f030582d9"),
    Linux(:powerpc64le, libc=:glibc) => ("$bin_prefix/ZCMBuilder.v0.1.0.powerpc64le-linux-gnu.tar.gz", "c122b3c102e78cd27c5fdaeb65a6b7a0c57014507caa6fbdbfae13b0e6616d06"),
    Linux(:x86_64, libc=:glibc) => ("$bin_prefix/ZCMBuilder.v0.1.0.x86_64-linux-gnu.tar.gz", "e087c6c4764f82c4caa51f43154d65fee632114b9ebaa5da04b1257f85614e70"),
)

# Install unsatisfied or updated dependencies:
unsatisfied = any(!satisfied(p; verbose=verbose) for p in products)
dl_info = choose_download(download_info, platform_key_abi())
if dl_info === nothing && unsatisfied
    # If we don't have a compatible .tar.gz to download, complain.
    # Alternatively, you could attempt to install from a separate provider,
    # build from source or something even more ambitious here.
    error("Your platform (\"$(Sys.MACHINE)\", parsed as \"$(triplet(platform_key_abi()))\") is not supported by this package!")
end

# If we have a download, and we are unsatisfied (or the version we're
# trying to install is not itself installed) then load it up!
if unsatisfied || !isinstalled(dl_info...; prefix=prefix)
    # Download and install binaries
    install(dl_info...; prefix=prefix, force=true, verbose=verbose)
end

# Write out a deps.jl file that will contain mappings for our products
write_deps_file(joinpath(@__DIR__, "deps.jl"), products, verbose=verbose)
