"""
$(TYPEDEF)
$(TYPEDFIELDS)

The `m`-th instance of an edge connecting `src` and `dst`.
"""
struct SingleMultiEdge{T<:Integer} <: AbstractSimpleEdge{T}
    "The source node"
    src::T
    "The destination node"
    dst::T
    "The multiplicity of the edge"
    m::T
end

multiplicity(e::SingleMultiEdge) = e.m

SingleMultiEdge(t::Tuple{T,T}) where T<:Integer = SingleMultiEdge(t[1], t[2], 1)
SingleMultiEdge(t::Tuple{T,T,T}) where T<:Integer = SingleMultiEdge(t[1], t[2], t[3])
SingleMultiEdge(p::Pair) = SingleMultiEdge(p.first, p.second, 1)
SingleMultiEdge(s::T,d::T) where {T<:Integer} = SingleMultiEdge(T(s), T(d), 1)
SingleMultiEdge{T}(p::Pair) where T<:Integer = SingleMultiEdge(T(p.first), T(p.second), T(1))
SingleMultiEdge{T}(t::Tuple{R,R}) where {T<:Integer,R} = SingleMultiEdge(T(t[1]), T(t[2]), 1)
SingleMultiEdge{T}(t::Tuple{R,R,R}) where {T<:Integer,R} = SingleMultiEdge(T(t[1]), T(t[2]), T(t[3]))
SingleMultiEdge{T}(s,d) where {T<:Integer} = SingleMultiEdge(T(s), T(d), 1)

SimpleEdge(sme::SingleMultiEdge) = SimpleEdge(src(sme), dst(sme))


# I/O
show(io::IO, e::SingleMultiEdge) = print(io, "$(e.m)-th Edge $(e.src) => $(e.dst)")

# Conversions
Tuple(e::SingleMultiEdge) = (src(e), dst(e), multiplicity(e))

SingleMultiEdge(e::E) where {T<:Integer, E<:AbstractSimpleEdge{T}} = SingleMultiEdge{T}(T(e.src), T(e.dst), 1)
SingleMultiEdge{T}(e::E) where {T<:Integer, E<:AbstractSimpleEdge{T}} = SingleMultiEdge{T}(T(e.src), T(e.dst), 1)
SingleMultiEdge(e::E, m::T) where {T<:Integer, E<:AbstractSimpleEdge{T}}  = SingleMultiEdge{T}(T(e.src), T(e.dst), m)
SingleMultiEdge{T}(e::E, m::T) where {T<:Integer, E<:AbstractSimpleEdge{T}}  = SingleMultiEdge{T}(T(e.src), T(e.dst), m)

# Convenience functions
reverse(e::T) where T<:SingleMultiEdge = T(dst(e), src(e), multiplicity(e))
==(e1::SingleMultiEdge, e2::SingleMultiEdge) = (src(e1) == src(e2) && dst(e1) == dst(e2) && multiplicity(e1) == multiplicity(e2))
hash(e::SingleMultiEdge, h::UInt) = hash(src(e), hash(dst(e), hash(multiplicity(e), h)))

