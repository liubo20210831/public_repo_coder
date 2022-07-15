```sh
squid -k parse
squid -k reconfigure

```

```sh
aws ecs describe-tasks \
    --cluster DevClusterFARGATE  \
    --tasks 5afae34b73324f7083e462c3a600d0bb

```

```sh
aws ecs update-service \
    --cluster DevClusterFARGATE \
    --enable-execute-command \
    --service squid_service \
    --desired-count 1



aws ecs execute-command --cluster DevClusterFARGATE  \
    --task 825afd0c9b824b8284df4255d0925d9e \
    --container squid \
    --interactive \
    --command "/bin/sh"

# 安装session-manager-working-with-install-plugin
# https://docs.aws.amazon.com/zh_cn/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html#install-plugin-linux

aws ecs execute-command --cluster DevClusterFARGATE    --task b5f88981d02140e58204710508bb2201   --container squid   --interactive   --command "/bin/sh"

# aws ecs update-service     --cluster DevClusterFARGATE     --enable-execute-command     --service squid_service     --desired-count 0

```
