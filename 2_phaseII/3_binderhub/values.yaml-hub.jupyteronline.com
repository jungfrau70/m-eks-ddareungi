rbac:
  enabled: true

service:
  type: ClusterIP
  labels: {}
  annotations:
    prometheus.io/scrape: 'true'

#storage:
  #capacity: 2G

# registry here is only used to create docker config.json
registry:
  url: "https://docker.jupyteronline.com"
  username: "admin"
  password: "2020@alpha"

config:
  BinderHub:
    use_registry: true
    image_prefix: docker.jupyteronline.com/
    hub_url: https://hub.jupyteronline.com
    log_level: 10
    auth_enabled: true # server folked like jupyter-jih-xxxxx
  DockerRegistry:
    url: "https://docker.jupyteronline.com" # the actual v2 registry url
    token_url: https://keycloak.jupyteronline.com/auth/realms/master/protocol/openid-connect/token

jupyterhub:
  cull:
    enabled: true
    timeout: 600
    every: 660
    maxAge: 21600
    users: False
  custom:
    binderauth_enabled: false
  rbac:
    enabled: true
  proxy:
    secretToken: 53a338a0aee98f74c2b431cac2ff7cc0e59d52be13aeea07a0145750529e050e
    nginx:
      proxBodySize: 512m
  storage:
    capacity: 2G
  hub:
    #allowNamedServers: true
    #namedServerLimitPerUser: 10
    redirectToServer: false
    services:
      binder:
        admin: true
        apiToken: "94f0ae1c2ffd8bfba513f971cb3aa92d9a0b9bb0f402668cbe6f71c231016e49"
        oauth_redirect_uri: "https://binder.jupyteronline.com/oauth_callback"
        oauth_client_id: "jhub"
    cookieSecret: "5eb53f6818f742d8c62b535f0a6df54880e7039be0a9ae255436d95f4c661c29"
    extraEnv:
      OAUTH2_AUTHORIZE_URL: https://keycloak.jupyteronline.com/auth/realms/master/protocol/openid-connect/auth
      OAUTH2_TOKEN_URL: https://keycloak.jupyteronline.com/auth/realms/master/protocol/openid-connect/token
      OAUTH_CALLBACK_URL: https://hub.jupyteronline.com/hub/oauth_callback
    db:
      type: postgres
      upgrade: true
      password: "@postgres"
      url: "postgresql+psycopg2://jupyterhub@hub-postgres-postgresql/jupyterhub"
      pvc:
        storageClassName: nfs-client
    extraConfig:
      jupyterlab: |
        c.Authenticator.auto_login = True
        c.Spawner.default_url ='/lab'
        c.Spawner.cmd = ['jupyter-labhub']
      hub: |
        c.JupyterHub.tornado_settings = {
          'headers': {
            'Content-Security-Policy': "base-uri 'self'"
          },
        }
      hub_extra: |
        c.JupyterHub.redirect_to_server = False
      spawner: >-
        c.Spawner.args = ["--NotebookApp.tornado_settings={ \
          'headers':{                                    \
            'Content-Security-Policy': \"base-uri 'self' \", \
          }, \
        }"]
      myConfig:  |
        c.KubeSpawner.pod_name_template = 'jupyter-{username}{servername}'
        #c.KubeSpawner.pod_name_template = 'jupyter-{username}'
      binder: |
        from kubespawner import KubeSpawner
        class BinderSpawner(KubeSpawner):
          def start(self):
              if 'image' in self.user_options:
                # binder service sets the image spec via user options
                self.image = self.user_options['image']
              return super().start()
        c.JupyterHub.spawner_class = BinderSpawner

  auth:
    type: custom
    custom:
      className: oauthenticator.generic.GenericOAuthenticator
      config:
        login_service: "keycloak"
        client_id: "jhub"
        client_secret: "a8004a7e-3917-41ae-b342-aac9be4632dd"
        token_url: https://keycloak.jupyteronline.com/auth/realms/master/protocol/openid-connect/token
        userdata_url: https://keycloak.jupyteronline.com/auth/realms/master/protocol/openid-connect/userinfo
        groupdata_url: https://keycloak.jupyteronline.com/auth/realms/master/protocol/openid-connect/groupinfo
        userdata_method: GET
        userdata_params: {'state': 'state'}
        username_key: preferred_username
  
  singleuser:
    cmd: jupyterhub-singleuser
    cpu:
      limit: 8
      guarantee: 4
    memory:
      limit: 8G
      guarantee: 4G
    storage:
      type: dynamic
      capacity: 1Gi
      dynamic:
        storageClass: nfs-client
      extraVolumes:
        - name: jupyterhub-shared
          persistentVolumeClaim:
            claimName: jupyterhub-shared-pvc
      extraVolumeMounts:
        - name: jupyterhub-shared
          mountPath: /home/jovyan/shared
    image:
      name: nielsbohr/tensorflow-notebook
      tag: latest
    profileList:
      - display_name: "Tensorflow_2 environment"
        description: "If you want the additional bells and whistles: Tensorflow and Keras machine learning libraries."
        default: true
      - display_name: "Welcome_to_Jupyter"
        description: "If you want the additional bells and whistles: Python, R, and Julia."
        kubespawner_override:
          lifecycle_hooks:
            postStart:
              exec:
                command: ["sh","-c","rm -rf Welcome_to_Jupyter && git clone https://github.com/jupyteronline/Welcome_to_Jupyter.git"]
      - display_name: "Teaching environment"
        description: "Lab, Classroom, or Business"
        kubespawner_override:
          image: pupster90/io:v3.0.7
          lifecycle_hooks:
            postStart:
              exec:
                command: ["sh","-c","rm -rf Welcome_to_io_Hub && git clone https://github.com/jupyteronline/Welcome_to_io_Hub.git"]
      - display_name: "Pyspark environment"
        description: "The Jupyter Stacks spark image!"
        kubespawner_override:
          image: jupyter/pyspark-notebook:678ada768ab1
      - display_name: "Spark Cluster"
        description: "Enterprise-gateway to Cluster"
        kubespawner_override:
          image: elyra/kernel-spark-py:2.1.0
          #image: elyra/enterprise-gateway:2.1.0
          extraEnv:
            KG_URL: https://egw.jupyteronline.com
            KG_HTTP_USER: jovyan
            KERNEL_USERNAME: jovyan
            KG_REQUEST_TIMEOUT: 60
