import json
import logging

from flask import Flask, g
from flask_oidc import OpenIDConnect
from itsdangerous import TimedJSONWebSignatureSerializer
#from constants import SECRET_KEY
import requests

logging.basicConfig(level=logging.DEBUG)

app = Flask(__name__)
app.config.update({
    'SECRET_KEY': 'SomethingNotEntirelySecret',
    'TESTING': True,
    'DEBUG': True,
    'OIDC_CLIENT_SECRETS': 'client_secrets.json',
    'OIDC_ID_TOKEN_COOKIE_SECURE': True,
    'OIDC_REQUIRE_VERIFIED_EMAIL': False,
    'OIDC_USER_INFO_ENABLED': True,
    'OIDC_OPENID_REALM': 'master',
    'OIDC_SCOPES': ['openid', 'email', 'profile'],
    'OIDC_SCOPES': ['openid'],
    'OIDC_INTROSPECTION_AUTH_METHOD': 'client_secret_post',
    'OIDC_RESOURCE_CHECK_AUD': True, #Audience
    'OIDC_CLOCK_SKEW': 560, #iat must be > time.time() - OIDC_CLOCK_SKEW
    'OVERWRITE_REDIRECT_URI': 'https://www.jupyteronline.com/oidc_callback'
})
#from OpenSSL import SSL
#context = SSL.Context(SSL.PROTOCOL_TLSv1_2)

oidc = OpenIDConnect(app)

@app.route('/')
def hello_world():
    if oidc.user_loggedin:
        return ('Hello, %s, <a href="/private">See private</a> '
                '<a href="/logout">Log out</a>') % \
            oidc.user_getfield('preferred_username')
    else:
        return 'Welcome anonymous, <a href="/private">Log in</a>'


@app.route('/private')
@oidc.require_login
def hello_me():
    """Example for protected endpoint that extracts private information from the OpenID Connect id_token.
       Uses the accompanied access_token to access a backend service.
    """

    info = oidc.user_getinfo(['preferred_username', 'email', 'sub'])

    username = info.get('preferred_username')
    email = info.get('email')
    user_id = info.get('sub')

    greeting = '';

    if user_id in oidc.credentials_store:
        try:
            from oauth2client.client import OAuth2Credentials
            access_token = OAuth2Credentials.from_json(oidc.credentials_store[user_id]).access_token
            print ( 'access_token=<%s>' % access_token )
            headers = {'Authorization': 'Bearer %s' % (access_token)}
            # YOLO
            greeting = requests.get('https://www.jupyteronline.com/greeting', headers=headers).text
        except:
            print ( "Could not access greeting-service" )
            greeting = "Hello %s" % username


    return ("""%s your email is %s and your user_id is %s!
               <ul>
                 <li><a href="/">Home</a></li>
                 <li><a href="https//kyecloak.jupyteronline.com/auth/realms/master/account?referrer=flask-app&referrer_uri=https://www.jupyteronline.com/private&">Account</a></li>
                </ul>""" %
            (greeting, email, user_id))

@app.route('/api', methods=['POST'])
@oidc.accept_token(require_token=True, scopes_required=['openid'])
def hello_api():
    """OAuth 2.0 protected API endpoint accessible via AccessToken"""

    return json.dumps({'hello': 'Welcome %s' % g.oidc_token_info['sub']})

@app.route('/logout')
def logout():
    """Performs local logout by removing the session cookie."""

    oidc.logout()
    redirect_uri = urllib.parse.quote_plus('https://www.jupyteronline.com')
    return redirect('https://keycloak.jupyteronline.com/auth/realms/master/protocol/openid-connect/logout?redirect_uri=%s' % redirect_uri)
    return 'Hi, you have been logged out! <a href="/">Return</a>'

@app.route('/')
def hello():
    return redirect("https://www.jupyteronline.com/oidc_callback", code=302)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
    #app.run(host='0.0.0.0', port=5000, ssl_context=context, debug=True)
