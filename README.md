## Cardano-events Helm chart

## Build docker images

Here we are going to build the Docker image for Cardano-api (https://github.com/tango-crypto/cardano-events)

### Build the Docker image
```bash 
$ cd cardano-api
$ docker build -t javiertc86/cardano-events:latest .
```
### Push the Docker image to the repository
```bash
$ docker push javiertc86/cardano-events:latest
```

The next step is to install Helm. Helm is a package manager for Kubernetes that simplifies the deployment and management of applications on Kubernetes clusters.

To Install Helm on Mac and Linux follow the instructions below:

**MacOS:**

Install using Homebrew:
```bash
brew install helm
```
**Linux:**

Download the Helm binary:
```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```
For more details, refer to the official <a href="https://helm.sh/docs/intro/install/" target="_blank" rel="noopener noreferrer">Helm Installation Guide</a>.


## Secrets encoding
Kubernetes requires secret data to be base64 encoded to ensure that it can handle arbitrary binary data in a text-based format. This encoding ensures data integrity during transport and storage.

```bash
echo -n 'your-secret-value' | base64
```

Example:
```bash
echo -n 'v8hlDV0yMAHHlIurYupj' | base64
# Output: djhoblRWMHlNQUhIbEl1cll1cGo=
```

Create `secrets.yaml`with the encoded values:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: cardano-events-secret
  annotations:
    meta.helm.sh/release-name: cardano-events
    meta.helm.sh/release-namespace: default
  labels:
    app.kubernetes.io/managed-by: Helm
type: Opaque
data:
  DB_USER: XXX
  DB_PWD: XXX
  OGMIOS_HOST: XXX
  KAFKA_HOST: XXX
  REDIS_HOST: XXX
  SCYLLA_CONTACT_POINTS: XXX
  DB_HOST: XXX
```
To view secrets:   
```bash
$ kubectl get secrets
```
    
To describe secret:
```bash
$ kubectl describe secret
```
    
To view the values of the secret:
```bash
$ kubectl get secret cardano-events-secret -o yaml
```

## Installing Helm Chart

### Install the Helm chart in the default namespace
```bash
git clone https://github.com/tango-crypto/cardano-events-helm-chart.git
cd cardano-events-helm-chart
$ helm install cardano-events .
``````

### Uninstall any previous failed release
```bash
$ helm uninstall cardano-events
```

List running pods:
```bash
$ kubectl get pods
NAME                                                  READY   STATUS    RESTARTS   AGE
cardano-events-cardano-events-helm-chart-fd99f75bb-98cb9    1/1     Running   0          9m47s
``````

Get logs:
```bash
$ kubectl logs -f cardano-events-cardano-events-helm-chart-fd99f75bb-98cb9 
```
Should show the following: 
```
[4:12:12 AM] Starting compilation in watch mode...

DeprecationWarning: 'getMutableClone' has been deprecated since v4.0.0. Use an appropriate `factory.update...` method instead, use `setCommentRange` or `setSourceMapRange`, and avoid setting `parent`.
DeprecationWarning: 'createLiteral' has been deprecated since v4.0.0. Use `factory.createStringLiteral`, `factory.createStringLiteralFromNode`, `factory.createNumericLiteral`, `factory.createBigIntLiteral`, `factory.createTrue`, `factory.createFalse`, or the factory supplied by your transformation context instead.
[4:12:16 AM] Found 0 errors. Watching for file changes.

[Nest] 30  - 07/27/2024, 4:12:16 AM     LOG [NestFactory] Starting Nest application...
[Nest] 30  - 07/27/2024, 4:12:16 AM     LOG [InstanceLoader] ConfigHostModule dependencies initialized +35ms
[Nest] 30  - 07/27/2024, 4:12:16 AM     LOG [InstanceLoader] ConfigModule dependencies initialized +0ms
[Nest] 30  - 07/27/2024, 4:12:16 AM     LOG [InstanceLoader] ConfigModule dependencies initialized +0ms
[Nest] 30  - 07/27/2024, 4:12:16 AM     LOG [InstanceLoader] ClientsModule dependencies initialized +38ms
[Nest] 30  - 07/27/2024, 4:12:16 AM     LOG [InstanceLoader] AppModule dependencies initialized +0ms
Connection: { host: '135.181.203.83', port: 1337, tls: false }
Network: testnet
Starting notifications from: chain tip
Acquiere point: undefined
Query state not connected yet, so connect first
Conection with options: null
Chain sync starting at: {
  intersection: {
    slot: 66370300,
    id: '72e6f284c0ce2eb0f2e2837b6745719976b31457319a1e90bea19e7f07ca98c3'
  },
  tip: {
    slot: 66370300,
    id: '72e6f284c0ce2eb0f2e2837b6745719976b31457319a1e90bea19e7f07ca98c3',
    height: 2516619
  }
}
Rollback tip: {"slot":66370300,"id":"72e6f284c0ce2eb0f2e2837b6745719976b31457319a1e90bea19e7f07ca98c3","height":2516619}, point: {"slot":66370300,"id":"72e6f284c0ce2eb0f2e2837b6745719976b31457319a1e90bea19e7f07ca98c3"}
network: testnet
Chain extended, new tip: {"slot":66370361,"id":"b252c7fdb854b18ff9078949c661cf6b9026b137c41e9a6885105bf419e847b3","height":2516620}
[Nest] 30  - 07/27/2024, 4:12:41 AM     LOG [ClientKafka] INFO [Consumer] Starting {"timestamp":"2024-07-27T04:12:41.649Z","logger":"kafkajs","groupId":"stream-event-consumer-client"}
[Nest] 30  - 07/27/2024, 4:12:45 AM     LOG [ClientKafka] INFO [ConsumerGroup] Consumer has joined the group {"timestamp":"2024-07-27T04:12:45.521Z","logger":"kafkajs","groupId":"stream-event-consumer-client","memberId":"stream-event-client-64f8ad9c-1a69-400f-8c8e-3fc804fe524f","leaderId":"stream-event-client-64f8ad9c-1a69-400f-8c8e-3fc804fe524f","isLeader":true,"memberAssignment":{},"groupProtocol":"NestReplyPartitionAssigner","duration":3728}
[Nest] 30  - 07/27/2024, 4:12:45 AM    WARN [ClientKafka] WARN [undefined] KafkaJS v2.0.0 switched default partitioner. To retain the same partitioning behavior as in previous versions, create the producer with the option "createPartitioner: Partitioners.LegacyPartitioner". See the migration guide at https://kafka.js.org/docs/migration-guide-v2.0.0#producer-new-default-partitioner for details. Silence this warning by setting the environment variable "KAFKAJS_NO_PARTITIONER_WARNING=1" {"timestamp":"2024-07-27T04:12:45.523Z","logger":"kafkajs"}
network: testnet
Chain extended, new tip: {"slot":66370388,"id":"3adb3aad944bcc4c5650f810552f05e6d5a7dc71b887721a21fbed9984ec5467","height":2516621}
network: testnet
Chain extended, new tip: {"slot":66370391,"id":"484fa84ed101fef50a6df811dcb41e7d2218ead26bcc020ba31599ca59bb13bc","height":2516622}
```
