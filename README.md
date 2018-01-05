<img width=150 src="https://user-images.githubusercontent.com/1423657/34592690-3a8b12e0-f1c6-11e7-8b40-669934b53007.gif">

# Kibana for [Elassandra](github.com/strapdata/elassandra)
#### Dockerized Kibana 5.5.0 on Plugin Steroids, Optimized for [Elassandra](github.com/strapdata/elassandra)

[![Codefresh build status]( https://g.codefresh.io/api/badges/build?repoOwner=lmangani&repoName=kibana-elassandra&branch=master&pipelineName=kibana-elassandra&accountName=lmangani&type=cf-1)]( https://g.codefresh.io/repositories/lmangani/kibana-elassandra/builds?filter=trigger:build;branch:master;service:5a47b81ef19c2200011010f3~kibana-elassandra)

##### Requires:
<img src="https://img.shields.io/badge/Elassandra- 5.5.0.9+-blue.svg"/>
  
##### Provides:

<img src="https://img.shields.io/badge/Kibana-5.5.0-blue.svg"/> <img src="https://img.shields.io/badge/theme-Elassandra-blue.svg"/> <img src="https://img.shields.io/badge/app-Sentinl-yellow.svg"/> <img src="https://img.shields.io/badge/vis-Network-orange.svg"/> <img src="https://img.shields.io/badge/vis-Sankey-orange.svg"/> <img src="https://img.shields.io/badge/vis-Swimlane-orange.svg"/> <img src="https://img.shields.io/badge/vis-Timeline-orange.svg"/> <img src="https://img.shields.io/badge/vis-Mapster-orange.svg"/> <img src="https://img.shields.io/badge/vis-Vega-orange.svg"/> <img src="https://img.shields.io/badge/plugin-Search%20Tables-green.svg"/> <img src="https://img.shields.io/badge/plugin-Computed%20Columns-green.svg"/> <img src="https://img.shields.io/badge/plugin-Time%20Select-green.svg"/> <img src="https://img.shields.io/badge/plugin-Enhanced%20Tilemap-green.svg"/> <img src="https://img.shields.io/badge/plugin-Metric%20Percent-green.svg"/> <img src="https://img.shields.io/badge/plugin-Markdown%20Doc-green.svg"/> <img src="https://img.shields.io/badge/plugin-Metric%20Percent-green.svg"/> <img src="https://img.shields.io/badge/api-Kibana%20API-red.svg"/> <img src="https://img.shields.io/badge/api-Auth%20Plugin%20LDAP-purple.svg"/> 

##### Usage (compose)
```
docker-compose up -d
```
##### Usage (manual)
```
docker run -d -e "ELASTICSEARCH_URL=http://elassandra:9200" -p 5061:5061 qxip/kibana-elassandra:master
```

 ----------- 

### Style
 <img src="https://user-images.githubusercontent.com/1423657/33861617-ff9a65e0-dede-11e7-8943-b7fb62dd857f.gif" width="300" />

### Sentinl
<img src="https://i.imgur.com/V9wDZak.gif" width="600" />

### Visualization
<img src="https://user-images.githubusercontent.com/1423657/34632842-283420ca-f278-11e7-8fda-c4713faeb8ab.png" width="600" />


##### Acknowledgement
Apache Cassandra, Apache Lucene, Apache, Lucene, Solr, TinkerPop, and Cassandra are trademarks of the Apache Software Foundation or its subsidiaries in Canada, the United States and/or other countries.

Elasticsearch and Kibana are trademarks of Elasticsearch BV, registered in the U.S. and in other countries.

Elassandra is a trademark of Strapdata SAS.

Sentinl is a trademark of QXIP BV and Siren Solutions.

All rights reserved by their respective owners. 
