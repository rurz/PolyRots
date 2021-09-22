### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ ebaa6c3c-7bf6-4024-a911-a712710aabd3
using DelimitedFiles

# ╔═╡ 513901a0-beaa-4273-b5dd-eb209ea38369
begin
	using PyPlot
	ion()
	rc("text", usetex = true)
end

# ╔═╡ fd586005-190f-4b16-9a45-104054a9a617
using LaTeXStrings

# ╔═╡ ec324c2b-71f8-428a-b722-050ebd534c44
imgrot = readdlm("data/data_target/bwmono22x22_r.dat");

# ╔═╡ 15289083-fdbe-4992-b601-948d7c19973f
dim = size(imgrot)[1];

# ╔═╡ c2014133-8f45-44df-ab06-6d5339064e4d
sitec = range(1, stop = 22, step = 1);

# ╔═╡ e27fc8bc-5114-4e97-b274-f71fca80b316
imgrot_d = [imgrot[i, i] for i in 1:dim]

# ╔═╡ 891c5c56-12fd-4745-8bcb-aeb25422c82f
imgrot_ad = [imgrot[i, dim - i + 1] for i in 1:dim]

# ╔═╡ db1f0fce-9bb6-4cbb-96c3-b1084f8618cd
begin
	fig_01 = figure(figsize = (10,6))
	ax_01 = gca()
	ax_01.plot(sitec, imgrot_d, "b--", lw = 3)
	
	ax_01.set_title(L"\textrm{Diagonal elements}", fontsize = 20)
	ax_01.set_xlabel(L"\textrm{Elements} $[i,i]$", fontsize = 16)
	#ax_01.set_ylabel(L"\textrm{Amplitude}", fontsize = 16)
	
	ax_01.set_xticks([0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22]) 
	
	#setp(ax_01.get_xticklabels(), fontsize = 14)
	#setp(ax_01.get_yticklabels(), fontsize = 14)
	
	ax_01.annotate(L"\sigma = 3", size = 16,
            xy = (-2.04, 0.130),
            xytext = (-0.7, 0.4),
			arrowprops = Dict("arrowstyle" => "-|>",
                            "connectionstyle" => "arc3, rad = -0.5"),
			bbox = Dict("boxstyle" => "round4", "fc" => "w")
		)
	
	tight_layout()
	
	#savefig("diag.png", dpi = 300, transparent = false)
end

# ╔═╡ 401bf0d7-0b86-4ebc-b44a-33ec7c319fec
begin
	fig_02 = figure(figsize = (10,6))
	ax_02 = gca()
	ax_02.plot(sitec, reverse(imgrot_ad), "b--", lw = 3)
	
	ax_02.set_title(L"\textrm{Antidiagonal elements}", fontsize = 20)
	ax_02.set_xlabel(L"\textrm{Elements} $[i,N - i + 1]$", fontsize = 16)
	#ax_01.set_ylabel(L"\textrm{Amplitude}", fontsize = 16)
	
	ax_02.set_xticks([0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22]) 
	
	#setp(ax_01.get_xticklabels(), fontsize = 14)
	#setp(ax_01.get_yticklabels(), fontsize = 14)
	
	ax_02.annotate(L"\sigma = 3", size = 16,
            xy = (-2.04, 0.130),
            xytext = (-0.7, 0.4),
			arrowprops = Dict("arrowstyle" => "-|>",
                            "connectionstyle" => "arc3, rad = -0.5"),
			bbox = Dict("boxstyle" => "round4", "fc" => "w")
		)
	
	tight_layout()
	
	#savefig("adiag.png", dpi = 300, transparent = false)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DelimitedFiles = "8bb1440f-4735-579b-a4ab-409b98df4dab"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
PyPlot = "d330b81b-6aea-500a-939a-2ce795aea3ee"

[compat]
LaTeXStrings = "~1.2.1"
PyPlot = "~2.10.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[Conda]]
deps = ["JSON", "VersionParsing"]
git-tree-sha1 = "299304989a5e6473d985212c28928899c74e9421"
uuid = "8f4d0f93-b110-5947-807f-2305c1781a2d"
version = "1.5.2"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[LaTeXStrings]]
git-tree-sha1 = "c7f1c695e06c01b95a67f0cd1d34994f3e7db104"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.2.1"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "5a5bc6bf062f0f95e62d0fe0a2d99699fed82dd9"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.8"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "438d35d2d95ae2c5e8780b330592b6de8494e779"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.0.3"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[PyCall]]
deps = ["Conda", "Dates", "Libdl", "LinearAlgebra", "MacroTools", "Serialization", "VersionParsing"]
git-tree-sha1 = "169bb8ea6b1b143c5cf57df6d34d022a7b60c6db"
uuid = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
version = "1.92.3"

[[PyPlot]]
deps = ["Colors", "LaTeXStrings", "PyCall", "Sockets", "Test", "VersionParsing"]
git-tree-sha1 = "14c1b795b9d764e1784713941e787e1384268103"
uuid = "d330b81b-6aea-500a-939a-2ce795aea3ee"
version = "2.10.0"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[VersionParsing]]
git-tree-sha1 = "80229be1f670524750d905f8fc8148e5a8c4537f"
uuid = "81def892-9a0e-5fdd-b105-ffc91e053289"
version = "1.2.0"
"""

# ╔═╡ Cell order:
# ╠═ebaa6c3c-7bf6-4024-a911-a712710aabd3
# ╠═ec324c2b-71f8-428a-b722-050ebd534c44
# ╠═15289083-fdbe-4992-b601-948d7c19973f
# ╠═513901a0-beaa-4273-b5dd-eb209ea38369
# ╠═fd586005-190f-4b16-9a45-104054a9a617
# ╠═c2014133-8f45-44df-ab06-6d5339064e4d
# ╠═e27fc8bc-5114-4e97-b274-f71fca80b316
# ╠═891c5c56-12fd-4745-8bcb-aeb25422c82f
# ╠═db1f0fce-9bb6-4cbb-96c3-b1084f8618cd
# ╠═401bf0d7-0b86-4ebc-b44a-33ec7c319fec
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
