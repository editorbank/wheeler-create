docker run -it --rm --name wheeler-create -w /wd -v .:/wd editorbank/executor:0.0.1 bash download.sh requirements
docker run -it --rm --name wheeler-create -w /wd -v .:/wd editorbank/executor:0.0.1 bash make_links_log.sh
docker run -it --rm --name wheeler-create -w /wd -v .:/wd editorbank/executor:0.0.1 bash make_index_html.sh
