helm-install:
	git pull
	helm upgrade --install $(component) . -f values.yaml -f values/$(component).yml --set image_tag=$(image_tag)
