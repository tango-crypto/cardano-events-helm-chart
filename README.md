Cardano events helm chart

### Install the Helm chart in the default namespace
`helm install cardano-events .`

### Uninstall any previous failed release
`helm uninstall cardano-events`

Create `secrets.yaml`with the values
```
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
