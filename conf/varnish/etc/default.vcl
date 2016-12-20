#
# This is an example VCL file for Varnish.
#
# It does not do anything by default, delegating control to the
# builtin VCL. The builtin VCL is called when there is no explicit
# return statement.
#
# See the VCL chapters in the Users Guide at https://www.varnish-cache.org/docs/
# and https://www.varnish-cache.org/trac/wiki/VCLExamples for more examples.
#
# See the all built in subroutines available in official documentation:
# https://varnish-cache.org/docs/trunk/users-guide/vcl-built-in-subs.html

# Marker to tell the VCL compiler that this VCL has been adapted to the
# new 4.0 format.
vcl 4.0;

# Default backend definition. Set this to point to your content server.
backend nginx {
    .host = "backend";
    .port = "80";
}

sub vcl_recv {
    # Happens before we check if we have this in cache already.
    #
    # Typically you clean up the request here, removing cookies you don't need,
    # rewriting the request, etc.

    return(hash);
}

sub vcl_backend_response {
    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.

    # Cache is set to 5 minutes by default.
    set beresp.ttl = 5m;
}

sub vcl_backend_error {

}

sub vcl_backend_fetch {

}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.

    if (obj.hits > 0) {
        set resp.http.X-Cache  = "HIT";
    } else {
        set resp.http.X-Cache  = "MISS";
    }

    return(deliver);
}


sub vcl_pass {

}

sub vcl_fini {

}

sub vcl_hash {

}

sub vcl_hit {

}

sub vcl_miss {

}

sub vcl_init {

}

sub vcl_pipe {

}

sub vcl_purge {

}

sub vcl_synth {

}
