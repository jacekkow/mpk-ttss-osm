from mapproxy.wsgiapp import make_wsgi_app
application = make_wsgi_app('data/mapproxy.yaml', reloader=True)
