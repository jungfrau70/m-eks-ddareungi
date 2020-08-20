def _flow_for_request(self):
    """
    Build a flow with the correct absolute callback URL for this request.
    :return:
    """
    flow = copy(self.flow)
    redirect_uri = current_app.config['OVERWRITE_REDIRECT_URI']
    if not redirect_uri:
        flow.redirect_uri = url_for('_oidc_callback', _external=True)
    else:
        flow.redirect_uri = redirect_uri
    return flow
