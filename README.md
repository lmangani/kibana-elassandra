# Kibana for [Elassandra](github.com/strapdata/elassandra)
#### Dockerized Kibana 5.5. on Steroids, Optimized for [Elassandra](github.com/strapdata/elassandra)

[![Codefresh build status]( https://g.codefresh.io/api/badges/build?repoOwner=lmangani&repoName=kibana-elassandra&branch=master&pipelineName=kibana-elassandra&accountName=lmangani&type=cf-1)]( https://g.codefresh.io/repositories/lmangani/kibana-elassandra/builds?filter=trigger:build;branch:master;service:5a47b81ef19c2200011010f3~kibana-elassandra)

##### Usage (compose)
```
docker-compose up -d
```
##### Usage (manual)
```
docker run -d -e "ELASTICSEARCH_URL=http://elassandra:9200" -p 5061:5061 qxip/kibana-elassandra:master
```
##### Requires:
  * **Elassandra** 5.5.0.9 or higher
##### Includes:
  * **Kibana** 5.5.0
     * **SENTINL** App for Alerting
    * Network Vis
    * Sankey Vis
    * Swimlane Vis
    * Search Tables Plugin
    * Computed Columns Plugin
    * Time Plugin
    * Timeline Plugin
    * Mapster Plugin
    * Kibana API  
    * Custom Elassandra Theme
    * _and more!_
  
 ----------- 

### Style
 <img src="https://user-images.githubusercontent.com/1423657/33861617-ff9a65e0-dede-11e7-8943-b7fb62dd857f.gif" width="300" />

### Sentinl
<img src="https://i.imgur.com/V9wDZak.gif" width="600" />

### Vis
<img src="https://user-images.githubusercontent.com/1423657/33936248-3551d51c-dfff-11e7-84f6-083ee32480f3.png" width="600" />


##### Acknowledgement
Apache Cassandra, Apache Lucene, Apache, Lucene, Solr, TinkerPop, and Cassandra are trademarks of the Apache Software Foundation or its subsidiaries in Canada, the United States and/or other countries.

Elasticsearch and Kibana are trademarks of Elasticsearch BV, registered in the U.S. and in other countries.

Elassandra is a trademark of Strapdata SAS.

Sentinl is a trademark of QXIP BV and Siren Solutions.
