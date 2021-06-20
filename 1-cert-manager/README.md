# Clinic: cert-manager

Primera sesión "Clinic": Configuración de cert-manager en un cluster de "kind"
[Vídeo de la sesión](https://youtu.be/ctZsrXj8_gI)

## Materiales

- Una [instancia cloud en Hetzner](https://www.hetzner.com/cloud-es) de tipo CPX21: 3 vCPU, 4 GB de RAM, 80 GB de disco, 1 IP pública, sistema base "Ubuntu 20.04.2"

## Prerequisitos

1. Instalar en la instancia los siguientes paquetes de software:

    - [Docker](https://www.docker.com/) v20.10.2
    - [Kubernetes - Kind](https://kind.sigs.k8s.io/) v0.11.0
    - [kubectl](https://kubernetes.io/es/docs/tasks/tools/install-kubectl/) v1.21.1
    - [helm](https://helm.sh/) v3.6.0

2. Asegurar que los puertos 80 y 443 están abiertos.
3. Apuntar el dominio "clinic-cert-manager.kairosds.com" a la IP pública de la instancia
4. Crear el cluster "kind"

    ```console
    root@clinic-cert-manager:~/clinic-lab# 0-base/kind/kind_start.sh 
    Creating cluster "clinic" ...
    ✓ Ensuring node image (kindest/node:v1.21.1) 🖼 
    ✓ Preparing nodes 📦  
    ✓ Writing configuration 📜 
    ✓ Starting control-plane 🕹️ 
    ✓ Installing CNI 🔌 
    ✓ Installing StorageClass 💾 
    Set kubectl context to "kind-clinic"
    You can now use your cluster with:

    kubectl cluster-info --context kind-clinic

    Not sure what to do next? 😅  Check out https://kind.sigs.k8s.io/docs/user/quick-start/
    Kubernetes control plane is running at https://127.0.0.1:36295
    CoreDNS is running at https://127.0.0.1:36295/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

    To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

    ```

## Pasos a seguir

1. Instalar Traefik

    ```console
    root@clinic-cert-manager:~/clinic-lab# helm repo add traefik https://helm.traefik.io/traefik
    "traefik" has been added to your repositories
    root@clinic-cert-manager:~/clinic-lab# helm repo update
    Hang tight while we grab the latest from your chart repositories...
    ...Successfully got an update from the "traefik" chart repository
    Update Complete. ⎈Happy Helming!⎈
    root@clinic-cert-manager:~/clinic-lab# kubectl create namespace traefik
    namespace/traefik created
    root@clinic-cert-manager:~/clinic-lab# helm install --namespace traefik traefik traefik/traefik --values 1-cert-manager/1-traefik/values.yaml
    W0619 12:16:23.620979 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.638441 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.652476 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.674338 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.684336 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.702315 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.720085 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.741602 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.755270 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.759061 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.761686 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.766799 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.785672 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.788341 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.791105 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    W0619 12:16:23.793692 2353317 warnings.go:70] apiextensions.k8s.io/v1beta1 CustomResourceDefinition is deprecated in v1.16+, unavailable in v1.22+; use apiextensions.k8s.io/v1 CustomResourceDefinition
    NAME: traefik
    LAST DEPLOYED: Sat Jun 19 12:16:23 2021
    NAMESPACE: traefik
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    root@clinic-cert-manager:~/clinic-lab# kubectl get all -n traefik
    NAME                         READY   STATUS    RESTARTS   AGE
    pod/traefik-7cc97cdb-6sjdb   1/1     Running   0          10m

    NAME              TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
    service/traefik   LoadBalancer   10.96.183.154   <pending>     80:30180/TCP,443:31514/TCP   10m

    NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/traefik   1/1     1            1           10m

    NAME                               DESIRED   CURRENT   READY   AGE
    replicaset.apps/traefik-7cc97cdb   1         1         1       10m
    ```

2. Instalar cert-manager

    ```console
    root@clinic-cert-manager:~/clinic-lab# helm repo add jetstack https://charts.jetstack.io
    "jetstack" has been added to your repositories
    root@clinic-cert-manager:~/clinic-lab# helm repo update
    Hang tight while we grab the latest from your chart repositories...
    ...Successfully got an update from the "jetstack" chart repository
    ...Successfully got an update from the "traefik" chart repository
    Update Complete. ⎈Happy Helming!⎈
    root@clinic-cert-manager:~/clinic-lab# kubectl create namespace cert-manager
    namespace/cert-manager created
    root@clinic-cert-manager:~/clinic-lab# helm install cert-manager jetstack/cert-manager --namespace cert-manager --values=1-cert-manager/2-cert-manager/values.yaml --version v1.3.1
    NAME: cert-manager
    LAST DEPLOYED: Sat Jun 19 12:23:09 2021
    NAMESPACE: cert-manager
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    NOTES:
    cert-manager has been deployed successfully!

    In order to begin issuing certificates, you will need to set up a ClusterIssuer
    or Issuer resource (for example, by creating a 'letsencrypt-staging' issuer).

    More information on the different types of issuers and how to configure them
    can be found in our documentation:

    https://cert-manager.io/docs/configuration/

    For information on how to configure cert-manager to automatically provision
    Certificates for Ingress resources, take a look at the `ingress-shim`
    documentation:

    https://cert-manager.io/docs/usage/ingress/
    root@clinic-cert-manager:~/clinic-lab# kubectl get all -n cert-manager 
    NAME                                           READY   STATUS    RESTARTS   AGE
    pod/cert-manager-54b86cf788-n2swv              1/1     Running   0          3m42s
    pod/cert-manager-cainjector-794bd99c79-5nnvf   1/1     Running   0          3m42s
    pod/cert-manager-webhook-748f84b694-r86qf      1/1     Running   0          3m42s

    NAME                           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
    service/cert-manager           ClusterIP   10.96.97.145    <none>        9402/TCP   3m42s
    service/cert-manager-webhook   ClusterIP   10.96.118.212   <none>        443/TCP    3m42s

    NAME                                      READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/cert-manager              1/1     1            1           3m42s
    deployment.apps/cert-manager-cainjector   1/1     1            1           3m42s
    deployment.apps/cert-manager-webhook      1/1     1            1           3m42s

    NAME                                                 DESIRED   CURRENT   READY   AGE
    replicaset.apps/cert-manager-54b86cf788              1         1         1       3m42s
    replicaset.apps/cert-manager-cainjector-794bd99c79   1         1         1       3m42s
    replicaset.apps/cert-manager-webhook-748f84b694      1         1         1       3m42s
    ```

3. Configurar aplicación de ejemplo

    ```console
    root@clinic-cert-manager:~/clinic-lab# kubectl create namespace nginx
    namespace/nginx created
    root@clinic-cert-manager:~/clinic-lab# kubectl apply -f 1-cert-manager/3-nginx/templates.yaml -n nginx
    deployment.apps/nginx created
    service/nginx created
    configmap/nginx-index-html created
    root@clinic-cert-manager:~/clinic-lab# kubectl apply -f 1-cert-manager/3-nginx/ingress-traefik.yaml
    middleware.traefik.containo.us/https-only created
    ingressroute.traefik.containo.us/nginx-ingress-https created
    ingressroute.traefik.containo.us/nginx-ingress-http created
    root@clinic-cert-manager:~/clinic-lab# kubectl get all -n nginx
    NAME                         READY   STATUS    RESTARTS   AGE
    pod/nginx-77cccc64c9-88467   1/1     Running   0          76s

    NAME            TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
    service/nginx   ClusterIP   10.96.52.98   <none>        80/TCP    76s

    NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/nginx   1/1     1            1           76s

    NAME                               DESIRED   CURRENT   READY   AGE
    replicaset.apps/nginx-77cccc64c9   1         1         1       76s
    ```

4. Configurar issuer de let's encrypt

```console
root@clinic-cert-manager:~/clinic-lab# kubectl apply -f 1-cert-manager/4-lets-encrypt/cluster-issuer-prod.yaml
clusterissuer.cert-manager.io/letsencrypt-prod created
root@clinic-cert-manager:~/clinic-lab# k get clusterissuers.cert-manager.io 
NAME               READY   AGE
letsencrypt-prod   True    43s
root@clinic-cert-manager:~/clinic-lab# kubectl apply -f 1-cert-manager/4-lets-encrypt/prod-certificate.yaml
certificate.cert-manager.io/nginx-cert created
root@clinic-cert-manager:~/clinic-lab# kubectl get certificate -n nginx
NAME         READY   SECRET       AGE
nginx-cert   True    nginx-cert   94s
```

Llegados a este punto:

- El sitio está accesible en <https://clinic-cert-manager.kairosds.com>
- Tenemos un certificado válido de Let's Encrypt, gestionado por cert-manager
