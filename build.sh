# First we have to build the controller image.
# From what I can tell this is the the one that does the work...
make docker-build docker-push IMG="ghcr.io/turnbros/opnsense-operator/opnsense-operator-controller:v0.0.1" &&\

# Next we generate the bundle and pass in the controller image as IMG.
# This creates a bundle directory and a bundle.Dockerfile. 
make bundle IMG="ghcr.io/turnbros/opnsense-operator/opnsense-operator-controller:v0.0.1" &&\

# In this step we build and push the bundle assets.
# The bundle gets it's own image name because it bootstraps the controller image at runtime.
make bundle-build bundle-push BUNDLE_IMG="ghcr.io/turnbros/opnsense-operator/opnsense-operator-bundle:v0.0.1" 
