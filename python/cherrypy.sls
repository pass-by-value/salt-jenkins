include:
  - python.pip

cherrypy:
  pip.installed:
    - require:
      - cmd: python-pip
